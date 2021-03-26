shader_type canvas_item;
// Using code from

// Martijn Steinrucken for the  Megaparsecs shader
// https://www.shadertoy.com/view/WsyBDz
// Ported to Godot and customized for FragmentForge by Db0

// License Creative Commons Attribution-NonCommercial-ShareAlike 3.0 Unported License.


uniform bool is_card = true;
uniform float iTime;
uniform sampler2D iChannel0;

uniform float NUMRINGS=60.;
uniform float MAX_BLOCKS=60.;


mat2 Rot(float a) {
    float s=sin(a),c=cos(a);
    return mat2(vec2(c,-s),vec2(s,c));
}

float Hash31(vec3 p3) {
	p3  = fract(p3 * .1031);
    p3 += dot(p3, p3.yzx + 33.33);
    return fract((p3.x + p3.y) * p3.z);
}

vec3 GetRayDir(vec2 uv, vec3 p, vec3 l, vec3 up, float z) {
    vec3 f = normalize(l-p),
        r = normalize(cross(up, f)),
        u = cross(f,r),
        c = f*z,
        i = c + uv.x*r + uv.y*u,
        d = normalize(i);
    return d;
}

vec4 Galaxy(vec3 ro, vec3 rd, float seed, float a1, float a2, float cut) {
    
    mat2 rot = Rot(a1);
    ro.xy *= rot; rd.xy*=rot;
    rot=Rot(a2);ro.yz *= rot; rd.yz*=rot;
    
    vec2 uv = ro.xz+(ro.y/-rd.y)*rd.xz;
 
    seed = fract(sin(seed*123.42)*564.32);
        
    vec3 
        col = vec3(0),
        dustCol = vec3(.3, .6, 1.);
    
    float alpha = 0.;
    if(cut==0. || (ro.y*rd.y<0. && length(uv)<2.5)) {
        
        float 
            ringWidth = mix(10.,25., seed),
            twist = mix(.3, 2., fract(seed*10.)),
        	numStars = mix(2., 15., pow(fract(seed*65.),2.)),
        	contrast = fract(seed*3.),
            flip = 1.,
            t=iTime*.1*sign(seed-.5),
            z, r, ell, n, d, sL, sN, i;
        
        if(cut==0.) twist = 1.;
        
        for(i=0.; i<1.; i+=1./NUMRINGS) {

            flip *= -1.;
            z = mix(.06, 0., i)*flip*fract(sin(i*563.2)*673.2);
            r = mix(.1, 1., i);

            uv = ro.xz+((ro.y+z)/-rd.y)*rd.xz;
        
            vec2 st = uv*Rot(i*6.2832*twist);
            st.x *= mix(2., 1., i);

            ell = exp(-.5*abs(dot(st,st)-r)*ringWidth);
            vec2 texUv = .2*st*Rot(i*100.+t/r);
            vec3 
                dust = texture(iChannel0, texUv+i).rgb,
                dL = pow(ell*dust/r, vec3(.5+contrast));

            vec2 id = floor(texUv*numStars);
            texUv= fract(texUv*numStars)-.5;

            n = Hash31(id.xyy+i);

            d = length(texUv); 

            sL = smoothstep(.5, .0, d)*pow(dL.r,2.)*.2/d;
           
            sN = sL;
            sL *= sin(n*784.+iTime)*.5+.5;
            sL += sN*smoothstep(.9999,1., sin(n*784.+iTime*.05))*10.;
            col += dL*dustCol;

            alpha += dL.r*dL.g*dL.b;

            if(i>3./numStars)
            col += sL* mix(vec3(.5+sin(n*100.)*.5, .5, 1.), vec3(1), n);
        }

        col = col/NUMRINGS;
    }
    
    vec3 
        tint = 1.-vec3(pow(seed,3.), pow(fract(seed*98.),3.), 0.)*.5,
        center = vec3( exp(-.5*dot(uv,uv)*30.) ),
        cp = ro + max(0., dot(-ro, rd))*rd;
    
    col *= tint;
    
    cp.y*= 4.;
    center += dot(rd, vec3(rd.x, 0, rd.z))*exp(-.5*dot(cp,cp)*50.);
    
    col += center*vec3(1., .8, .7)*1.5*tint;
    
    return vec4(col, alpha);
}

vec3 Bg(vec3 rd) {
    vec2 uv = vec2(atan(rd.x,rd.z), rd.y*.5+.5);
	uv *= 2.;
    float wave = sin(rd.y*3.14+iTime*.1)*.5+.5;
    wave *= sin(uv.x+uv.y*3.1415)*.5+.5;
    return vec3(0.01*sin(iTime*.06),0,.05)*wave;
}

void fragment()
{
    vec2 iResolution =  1.0 / SCREEN_PIXEL_SIZE; // for copy-paste
    vec2 
//        uv = (FRAGCOORD.xy-.5*iResolution.xy)/iResolution.y,
        uv = UV - 0.5,
		M = vec2(0)/iResolution.xy;
  if(!is_card){
	uv *= 2.;
    uv.x *= iResolution.x/iResolution.y;
  } 
//	else {
//		uv *= 3.;
//		uv.x *= iResolution.y/iResolution.x;
//	}
    float 
        t = iTime*.1,
        dolly = (1.-sin(t)*.6),
        zoom = mix(.3, 2., pow(sin(t*.1), 5.)*.5+.5),
        dO = 0.;
    
    vec3 ro = vec3(0,2,-2)*dolly;
    ro.yz *= Rot(M.y*5.+sin(t*.5));
    ro.xz *= Rot(-M.x*5.+t*.1);
    vec3 up = vec3(0,1,0);
    up.xy *=Rot(sin(t*.2));
    vec3 
        rd = GetRayDir(uv, ro, vec3(0), up, zoom),
        col = Bg(rd),
        dir = sign(rd)*.5;
    
    for(float i=0.; i<MAX_BLOCKS; i++) {
    	vec3 p = ro+dO*rd;
        
        p.x += iTime*.2;
        vec3 
            id = floor(p),
            q = fract(p)-.5,
            rC = (dir-q)/rd;	// ray to cell boundary
        
        float 
            dC = min(min(rC.x, rC.y), rC.z)+.0001,		// distance to cell just past boundary
        	n = Hash31(id);
        
        dO += dC;
        
        if(n>.01) continue;
        
        float 
            a1 = fract(n*67.3)*6.2832,
            a2 = fract(n*653.2)*6.2832;
        
        col += Galaxy(q*4., rd, n*100., a1, a2,1.).rgb*smoothstep(25., 10., dO);
    }
    
    vec4 galaxy = Galaxy(ro, rd, 6., 0., 0.,0.);

    float 
        alpha = pow(min(1., galaxy.a*.6),1.),
        a = atan(uv.x,uv.y),
    	sB = sin(a*13.-iTime)*sin(a*7.+iTime)*sin(a*10.-iTime)*sin(a*4.+iTime),
    	d = length(uv);
    
    sB *= smoothstep(.0, .3, d);
    col = mix(col, galaxy.rgb*.1, alpha*.5);
    col += galaxy.rgb;
    col += max(0., sB)*smoothstep(5.0, 0., dot(ro,ro))*.03*zoom;
    
    col *= smoothstep(0.9, 0.5, d);
    
    COLOR = vec4(sqrt(col),1.0);
}
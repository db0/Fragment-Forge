shader_type canvas_item;
// Using code from

// Martijn Steinrucken  for the Double Traingle Truchet Doodle  shader
// https://www.shadertoy.com/view/MsXSRn
// Ported to Godot and customized for FragmentForge by Db0

// License Creative Commons Attribution-NonCommercial-ShareAlike 3.0 Unported License.

uniform bool is_card = true;
uniform float iTime;
uniform float speed = 0.2;

uniform float GRID=20.;

const float R2 =1.41421356;
const float HR2=0.70710678;
const float TR2=0.47140452;
const float SR2=0.23570226;
const float PI=3.14159265;

// from Dave Hoskins' 'Hash without Sine'
vec3 N23(vec2 p)
{
	vec3 p3 = fract(vec3(p.xyx) * vec3(.1031, .1030, .0973));
    p3 += dot(p3, p3.yxz+19.19);
    return fract((p3.xxy+p3.yzz)*p3.zyx);
}

vec4 UvCirc(vec2 uv, float radius, float thickness) {
	vec2 st = vec2(atan(uv.x, uv.y), length(uv));
    
    float t = thickness/2.;
    float w = .01;
    
    float r1 = radius-t;
    float r2 = radius+t;
    
    float mask = smoothstep(t+w, t, abs(radius-st.y));
    float alpha = smoothstep(t+.1, t, abs(radius-st.y));
    alpha = alpha*alpha*mix(.5, 1., mask);
    
    return vec4(st.x*radius, st.y, mask, alpha);
}

vec4 TriCoords(vec2 uv) {
	// normal uv in, center, barycentric coords out
    vec2 id = floor(uv);
    uv = fract(uv);
    
    vec2 c;  // the center of the triangle
    float e; // the distance to the closest edge
    float s; // the side the triangle is facing
    
    if(uv.x<uv.y) {
    	c = vec2(.333, .666);
        e = min(min(uv.x, 1.-uv.y), (uv.y-uv.x));
        uv = 1.-vec2(uv.x, uv.y);
        s = -1.;
    } else {
        c = vec2(.666, .333);
        e = min(min(1.-uv.x, uv.y), (uv.x-uv.y));
        s = 1.;
    }
    c += id;
    
    
    return vec4(c, uv);
}

float Band(float v, float y, float t, float b) {
	t/=2.;
    return smoothstep(t, t-b, abs(v-y));
}

void fragment()
{
	vec2 iResolution =  1.0 / SCREEN_PIXEL_SIZE; // for copy-paste
//	vec2 U = (FRAGCOORD.xy-iResolution.xy*.5)/iResolution.x;
	vec2 U = UV - 0.5;
  if(!is_card){
    U.x *= iResolution.x/iResolution.y;
  }
    vec2 m = (vec2(0)/iResolution.xy);
    
    float t = iTime * speed;
    
    
    U *= mix(2., GRID, sin(t*.5)*.5+.5);
	U += iTime;
    mat2 tt;
    
    //U.x *= .5*sqrt(2.)*sqrt(3./4.);			// stretch so sides are of equal length
   // tt = mat2(-HR2, HR2, HR2, HR2);
    
    float f1 = .942;
    tt = mat2(vec2(-.433013*f1, HR2), vec2(.433013*f1, HR2)); // triangle transform
    //tt = mat2(1,0,0,1);
   U *= tt; 					// apply rotation
    
    vec4 tc = TriCoords(U);
    vec3 n = N23(tc.xy);
    vec2 uv = tc.zw+tc.xy;
    
    //uv *= inverse(tt);
    
    vec3 col = vec3(tc.zw, 0);
   
    //m.x *= tc.a;
    tt = inverse(tt);
    //tc.zw *= inverse(tt);
    
    vec2 a = tc.zw*tt;
    vec2 b = (tc.zw-vec2(1,0))*tt;
    vec2 c = (tc.zw-vec2(1,1))*tt;
    vec3 d = vec3(length(a), length(b), length(c));
    
    vec2 a2 = (tc.zw-vec2(.5, .5))*tt;
    vec2 b2 = (tc.zw-vec2(.5,0))*tt;
    vec2 c2 = (tc.zw-vec2(1.,.5))*tt;
    vec3 d2 = vec3(length(a2), length(b2), length(c2));
    
    //col = d;
    float blur = .01;
    float w = .2;
    float ma=0., mb=0., mc=0.;
    
    float tile = n.z;
    if(tile<.1) {
    	ma = Band(d.r, TR2, w, blur);		// jump 1
    	mb = Band(d.g, TR2, w, blur);		// jump 1
    	mc = Band(d.b, TR2, w, blur);		// jump 1
    } else if(tile<.2){
    	ma = Band(d2.r, SR2, w, blur);		// jump 1
    	mb = Band(d2.g, SR2, w, blur);		// jump 1
    	mc = Band(d2.b, SR2, w, blur);		// jump 1
    } else if(tile<.4) {		
    	ma = Band(d.r, TR2, w, blur);		// jump 1
    	mb = Band(d2.b, SR2, w, blur);		// jump 1
        mc = Band(d.r, TR2*2., w, blur);	// jump 3	
    } else if(tile<.6) {
    	ma = Band(d.r, TR2*2., w, blur);	// jump 3
    	mb = Band(d.g, TR2*2., w, blur);	// jump 3
        mc = Band(d.b, TR2*2., w, blur);	// jump 3	
    }else if(tile<.8) {
        float f = (atan(tc.z, tc.w)/6.28)+.5;
        f = fract(f*8.);
        f = smoothstep(0.,1.,f);

        ma = Band(d2.b, TR2/2., w, blur);	// jump 1
        mb = Band(d.r, TR2+TR2*f, w, blur);	// jump 2
        
    	f = 1.-f;
        f *= f;
        mc = Band(d.r, TR2+TR2*f, w, blur);	// jump2
    } else {
    
        f1 = (atan(tc.z-1., tc.w)/6.28);
        f1 = fract(f1*4.);
        f1 = smoothstep(0.,1.,f1);

        ma = Band(d.r, TR2, w, blur);		// jump 1
        mb = Band(d.g, TR2+f1*TR2, w, blur);		// jump 2

        f1 = (atan(tc.z-1., tc.w-1.)/6.28);
        f1 = fract(f1*8.);
        f1 = smoothstep(0.,1.,f1);
        f1 = 1.-f1;

        mc = Band(d.b, TR2+f1*TR2, w, blur);		// jump 2
    }
    
    vec3 ribCol = vec3(.1, .1, 1.);
    vec4 v1 = vec4(1,0,0, ma);
    vec4 v2 = vec4(0,1,0, mb);
    vec4 v3 = vec4(0,0,1, mc);
    
    // composite in different orders
	vec4 v;
	if (n.x<.166) {
		v =  mix(v1, mix(v2, v3, v3.a), max(v2.a, v3.a));
	} else if (n.x<.333) {
		v= mix(v1, mix(v3, v2, v2.a), max(v2.a, v3.a));
	} else if (n.x<.5) {
		v= mix(v2, mix(v1, v3, v3.a), max(v1.a, v3.a));
	}else if (n.x<.5) {
		v= mix(v2, mix(v1, v3, v3.a), max(v1.a, v3.a));
	}else if (n.x<.666) {
		v= mix(v2, mix(v3, v1, v1.a), max(v1.a, v3.a));
	}else if (n.x<.833) {
		v= mix(v3, mix(v1, v2, v2.a), max(v1.a, v2.a));
	} else {
		v = mix(v3, mix(v2, v1, v1.a), max(v1.a, v2.a));    
	}

    
    col = mix(col*.2, v.rgb, v.a);
   // col = mix(col, vec3(f), .5) ;
    COLOR = vec4(col, 1);
    
}
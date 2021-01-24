shader_type canvas_item;
// Using code from

//Morgan McGuire for the noise function
// https://www.shadertoy.com/view/4dS3Wd
//jojobavg for the cloud shader
// https://www.shadertoy.com/view/tdGBRG
// Ported to Godot by Db0

// Licence: Creative Commons Attribution-NonCommercial-ShareAlike 3.0 Unported License
// https://creativecommons.org/licenses/by-nc-sa/3.0/deed.en_US
uniform float depth = 70.0;
uniform float fogSize = 25.0;
//const float fogCoef = 1.0/(depth-fogSize);
//const float PI = acos(-1.0);
uniform float seed = 0.0;

float random (in float x) {
	return fract(sin(x)*1e4);
}

float noise(in vec3 p) {
	const vec3 step = vec3(110.0, 241.0, 171.0);

	vec3 i = floor(p);
	vec3 f = fract(p);

	// For performance, compute the base input to a
	// 1D random from the integer part of the
	// argument and the incremental change to the
	// 1D based on the 3D -> 1D wrapping
	float n = dot(i, step);

	vec3 u = f * f * (3.0 - 2.0 * f);
	return mix( mix(mix(random(n + dot(step, vec3(0,0,0))),
	random(n + dot(step, vec3(1,0,0))),
	u.x),
	mix(random(n + dot(step, vec3(0,1,0))),
	random(n + dot(step, vec3(1,1,0))),
	u.x),
	u.y),
	mix(mix(random(n + dot(step, vec3(0,0,1))),
	random(n + dot(step, vec3(1,0,1))),
	u.x),
	mix(random(n + dot(step, vec3(0,1,1))),
	random(n + dot(step, vec3(1,1,1))),
	u.x),
	u.y),
	u.z);
}

mat2 rot(float a) {
	float ca=cos(a);
	float sa=sin(a);
	return mat2(vec2(ca,sa),vec2(-sa,ca));
}

float cloud(in vec3 p, float scale, float time) {
	float l = length(p*0.1);
	vec3 d = vec3(p.x+sin(l+time)*2.0,p.y+sin(l)*2.0,0.0);
	float coef = max(length(d)-1.5,0.0);
	float c=1.0;
	float n1=1.0;
	for(int i=0; i<8; ++i) {
		n1+=1.0/c*abs(noise((p*c+time*1.0)*scale));
		c*=2.0;
	}
	return n1+(coef);
}

float mapHyper(vec3 p, float time){
	return cloud(p,0.5,time+seed);
}  

//void mainImage(out vec4 fragColor, in vec2 fragCoord)
void fragment()
{
	vec2 iResolution =  1.0 / SCREEN_PIXEL_SIZE;
//	vec2 uv = vec2(FRAGCOORD.x / iResolution.x, FRAGCOORD.y / iResolution.y);
	vec2 uv = UV;
	uv -= 0.5;
	uv /= vec2(iResolution.y / iResolution.x, 1);
	vec3 s=vec3(0.5,0.5,100);
	float t2=(TIME*1.5);
	s.xz *= rot(sin(t2)*0.005);
	vec3 t=vec3(0,0,0);
	s.x += cos(t2*0.2)*0.10*sin(TIME*0.01);
	s.y += sin(t2*0.2)*0.10*sin(TIME*0.01+10.0);
	vec3 cz=normalize(t-s);
	vec3 cx=normalize(cross(cz,vec3(0,1,0)));
	vec3 cy=normalize(cross(cz,cx));
	vec3 r=normalize(uv.x*cx+uv.y*cy+cz*0.7);
	s.z+=TIME*-8.0;
	
	vec3 p=s;
	float d;
	float seuil=5.1;
	float c= 0.0;
	float distMax =50.0;
	float steps = 300.0;
	float color = 0.0;
	float cl;
	float dist = clamp((1.0-dot(vec3(0,0,-1.0),r))*4.0,0.0,1.0);
	int cc =int(mix(300.0,1000.0,dist));
	float uu =mix(1.0,0.25,dist);
	vec3 p3 = vec3(0);
	for(int i=0; i<cc; ++i) {
		float d2 ;
//		float d;
		if(color<0.001)d = mapHyper(p, TIME);
		c =d;  
		if( c>seuil )
		{vec3 p2 =p;
			if(p3.x==0.0)p3=p;
			for(int j;j<20;j++)
			{
				if(color<0.2)d2= mapHyper(p2, TIME);
				else
				d2 = 5.2;
				if(d2>seuil)
				{
					color = color*0.8 + d2*0.02*0.2;
				}
				p2 +=normalize(vec3(-0.0,-0.0,-5.0))*0.42;
			} 
		}
		cl = 1.0-color;
        p+=r*distMax/steps*uu;
		//p+=r*distMax/float(cc)*uu;
	}

	vec2 off=vec2(1.1,0.0);
	vec3 n=normalize(mapHyper(p3, TIME)-vec3(mapHyper(p3-off.xyy, TIME), mapHyper(p3-off.yxy, TIME), mapHyper(p3-off.yyx, TIME)));

	//compositing
	vec3 col=vec3(0);
	col = mix(vec3(0.0,0.0,0.2),vec3(0.88,0.88,0.9),max(cl-0.5,0.0)*2.0);
	float fogCoef=1.0/(depth-fogSize);
	float fog =  clamp((length(p3-s)-fogSize)*fogCoef,0.0,1.0);
	col = mix(col,vec3(0.88,0.88,0.9),fog);
	COLOR = vec4(col,1.0);
}
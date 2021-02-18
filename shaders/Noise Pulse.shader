shader_type canvas_item;
// Using code from

// nimitz for the Noise animation - Electric shader
// https://www.shadertoy.com/view/ldlXRS
// Ported to Godot and customized for FragmentForge by Db0

// Licence: Creative Commons Attribution-NonCommercial-ShareAlike 3.0 Unported License
// https://creativecommons.org/licenses/by-nc-sa/3.0/deed.en_US


uniform bool is_card = true;
uniform float iTime;
uniform sampler2D iChannel0;
uniform float multiplier=4.;
uniform vec3 tint = vec3(.2,0.1,0.4);

//#define time iTime*0.15
uniform float tau=6.2831853;

mat2 makem2(in float theta){
	float c = cos(theta);
	float s = sin(theta);
	return mat2(vec2(c,-s),vec2(s,c));
}
float noise( in vec2 x ){return texture(iChannel0, x*.01).x;}

float fbm(in vec2 p)
{	
	float z=2.;
	float rz = 0.;
	vec2 bp = p;
	for (float i= 1.;i < 6.;i++)
	{
		rz+= abs((noise(p)-0.5)*2.)/z;
		z = z*2.;
		p = p*2.;
	}
	return rz;
}

float dualfbm(in vec2 p)
{
	float time = iTime * 0.15;
    //get two rotated fbm calls and displace the domain
	vec2 p2 = p*.7;
	vec2 basis = vec2(fbm(p2-time*1.6),fbm(p2+time*1.7));
	basis = (basis-.5)*.2;
	p += basis;
	
	//coloring
	return fbm(p*makem2(time*0.2));
}

float circ(vec2 p) 
{
	float r = length(p);
	r = log(sqrt(r));
	return abs(mod(r*4.,tau)-3.14)*3.+.2;

}

void fragment()
{
	float time = iTime * 0.15;
	//setup system
	vec2 iResolution =  1.0 / SCREEN_PIXEL_SIZE;
//	vec2 p = FRAGCOORD.xy / iResolution.xy-0.5;
//	p.x *= iResolution.x/iResolution.y;
//	p*=4.;
	vec2 p = -UV ;
	p *= multiplier;
	p += 0.5 * multiplier;
	if(!is_card){
		p.x *= iResolution.x/iResolution.y;
	}
    float rz = dualfbm(p);
	
	//rings
	p /= exp(mod(time*10.,3.14159));
	rz *= pow(abs((0.1-circ(p))),.9);
	
	//final color
	vec3 col = tint/rz;
	col=pow(abs(col),vec3(.99));
	COLOR = vec4(col,1.);
}
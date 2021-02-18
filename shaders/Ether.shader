shader_type canvas_item;
// Using code from

// nimitz for the ether shader
// https://www.shadertoy.com/view/MsjSW3
// Ported to Godot and customized for FragmentForge by Db0

// Licence: Creative Commons Attribution-NonCommercial-ShareAlike 3.0 Unported License
// https://creativecommons.org/licenses/by-nc-sa/3.0/deed.en_US

uniform bool is_card = true;
uniform float iTime;
uniform int sharpness = 5;


mat2 m(float a){
	float c=cos(a);
	float s=sin(a);
	return mat2(vec2(c,-s),vec2(s,c));
}
float map(vec3 p){
    p.xz*= m(iTime*0.4);p.xy*= m(iTime*0.3);
    vec3 q = p*2.+iTime;
    return length(p+vec3(sin(iTime*0.7)))*log(length(p)+1.) + sin(q.x+sin(q.z+sin(q.y)))*0.5 - 1.;
}

void fragment(){	
	vec2 iResolution =  1.0 / SCREEN_PIXEL_SIZE;
	vec2 p = UV;// - vec2(.9,.5);
	p -= 0.5;
	
    vec3 cl = vec3(0.);
    float d = 2.5;
    for(int i=0; i<=sharpness; i++)	{
		vec3 pp = vec3(0,0,5.) + normalize(vec3(p.xy, -1.))*d;
        float rz = map(pp);
		float f =  clamp((rz - map(pp+.1))*0.5, -.1, 1. );
        vec3 l = vec3(0.1,0.3,.4) + vec3(5., 2.5, 3.)*f;
        cl = cl*l + smoothstep(2.5, .0, rz)*.7*l;
		d += min(rz, 1.);
	}
    COLOR = vec4(cl, 1.);
}
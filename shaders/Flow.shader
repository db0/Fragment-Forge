shader_type canvas_item;
// Using code from

// Otavio Good for the Let it Flow shader
// https://www.shadertoy.com/view/wtBBzG
// Ported to Godot and customized for FragmentForge by Db0

// Licence: CC0

uniform bool is_card = true;
uniform float iTime;




//#define t iTime*.2
mat2 rot(float a) 
{
	float s=sin(a),c=cos(a);
    return mat2(vec2(c,s),vec2(-s,c));
}
float de(vec3 p, inout vec3 col)
{
	float t=iTime*.2;
    float z=p.z,m=1000.,sc=1.;
    vec3 ot=vec3(1000);
    p.xy*=rot(p.z * .05 + t * 3.);
    p=abs(5.-mod(p,10.));
	vec3 cp=p;
    for (int i=0;i<10;i++) 
    {
        p.xy=abs(p.xy+.5)-abs(p.xy-.5)-p.xy-1.;
        p.yz*=rot(t);
        float s=-2.5/clamp(dot(p,p),.0,1.);
        p=p*s-1.;
        sc*=s;
        ot=min(ot,abs(p.yzz));
        m=min(m,abs(p.z));
    }
    m=exp(-1.*m);
    col=exp(-2.*ot)+m*.5;
    col*=fract(-t*3.+m*.3+z*.05)*4.;
    return (p.x/sc-.5)*.8;
}
vec3 march(vec3 from, vec3 dir, inout vec3 col) 
{
	float d,td=0.;
    vec3 p, c=vec3(0), ot=vec3(1000);
    for (int i=0; i<70; i++) 
    {
        p=from+dir*td;
        d=de(p, col);
        td+=max(.002, abs(d));
        if (td>50.) break;
        c+=col*max(0.,1.-d)*exp(-.05*td); 
    }
   	return pow(c*.02,vec3(1.5));
}
void fragment()
{
	vec3 col;
	float t=iTime*.2;
	vec2 iResolution =  1.0 / SCREEN_PIXEL_SIZE; // for copy-paste
//    vec2 uv=(FRAGCOORD.xy-iResolution.xy*.5)/iResolution.y;
    vec2 uv=(UV-0.5) * 3.;
  if(!is_card){
    uv.x *= iResolution.x/iResolution.y;
  }	
 	vec3 dir = normalize(vec3(uv, .7));
	vec3 from = vec3(cos(t*2.), 1., t*10.);
    dir.xz *= rot(smoothstep(-.3,.3,sin(t))*3.);
//	vec3 c = march(from, dir, col);
	vec3 c = march(from, dir, col);
    COLOR = vec4(c,1.0);
}
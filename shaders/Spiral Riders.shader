shader_type canvas_item;
// Using code from

// Pablo Roman Andrioli for the spiral riders shader
// https://www.shadertoy.com/view/3sGfD3
// Ported to Godot and customized for FragmentForge by Db0

// Licence: CC0

uniform bool is_card = true;
uniform float iTime;
uniform int color_choice = 0;

mat2 rot(float a) { 
	return mat2(vec2(cos(a),sin(a)),vec2(-sin(a),cos(a)));
}

vec3 render(vec2 p) {
    p*=rot(iTime*.1)*(.0002+.7*pow(smoothstep(0.,.5,abs(.5-fract(iTime*.01))),3.));
    p.y-=.2266;
    p.x+=.2082;
    vec2 ot=vec2(100.);
    float m=100.;
    for (int i=0; i<150; i++) {
        vec2 cp=vec2(p.x,-p.y);
		p=p+cp/dot(p,p)-vec2(0.,.25);
        p*=.1;
        p*=rot(1.5);
        ot=min(ot,abs(p)+.15*fract(max(abs(p.x),abs(p.y))*.25+iTime*.1+float(i)*.15));
        m=min(m,abs(p.y));
    }
    ot=exp(-200.*ot)*2.;
    m=exp(-200.*m);
	vec3 color_ret;
	switch(color_choice){
		// Some interesting zoom locations discovered via exploration.
		case 0:
			color_ret = vec3(ot.x,ot.y*.5+ot.x*.3,ot.y)+m*.2;
			break;	
		case 1:
			color_ret = vec3(ot.x,ot.y,ot.y*.5+ot.x*.3)+m*.2;
			break;	
		case 2:
			color_ret = vec3(ot.y*.5+ot.x*.3,ot.x,ot.y)+m*.2;
			break;	
		case 3:
			color_ret = vec3(ot.x*.5+ot.y*.3,ot.y,ot.x)+m*.2;
			break;	
		case 4:
			color_ret = vec3(ot.y,ot.x,ot.y*.5+ot.x*.3)+m*.2;
			break;	
		case 5:
			color_ret = vec3(ot.y,ot.y*.5+ot.x*.3,ot.x)+m*.2;
			break;	
    }
	return color_ret;

}

void fragment()
{
    vec2 iResolution =  1.0 / SCREEN_PIXEL_SIZE; // for copy-paste
//    vec2 uv = (FRAGCOORD.xy-iResolution.xy*.5)/iResolution.y;
    vec2 uv = UV - 0.5;
  if(!is_card){
    uv.x *= iResolution.x/iResolution.y;
  }	
    vec2 d=vec2(0.,.5)/iResolution.xy;
    vec3 col = render(uv)+render(uv+d.xy)+render(uv-d.xy)+render(uv+d.yx)+render(uv-d.yx);
    COLOR = vec4(col*.2,1.0);
}
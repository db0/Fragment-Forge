shader_type canvas_item;
// Using code from

// Pablo Roman Andrioli for the vitraux shader
// https://www.shadertoy.com/view/tdGSR3
// Ported to Godot and customized for FragmentForge by Db0

// Licence: CC0

uniform bool is_card = true;
uniform float iTime;

const int AA=3;

mat2 rot(float a){
	return mat2(vec2(cos(a),sin(a)),vec2(-sin(a),cos(a)));
} 

vec4 fractal(vec2 U) {
    float m=1e3,t=iTime;
    U*=.13-sin(t*.2)*.1;
    U*=rot(sin(t*.1)*3.14);
    U+=vec2(sin(t),cos(t))*.005*sin(t*.2);
    vec4 p=vec4(cos(U.x),sin(U.x),cos(U.y),sin(U.y));
    for (int i=0;i<8;i++) {
    	p=abs(p+1.)-abs(p-1.)-p;
        p=p*1.5/min(1.,dot(p,p))-1.;
		m=min(m,fract( length(p*2.) -t*.1 ) );
    }
    return pow(m,1.7)*normalize(2.+abs(p.xyww))*2.;
}

void fragment()
{
	vec2 iResolution =  1.0 / SCREEN_PIXEL_SIZE; // for copy-paste
    vec2 R=iResolution.xy;
    vec2 U=(UV-R*.5)/R.y;
  if(!is_card){
    U.x *= iResolution.x/iResolution.y;
  }	
//    vec2 U = UV - 0.5;
    U*=1.-dot(U,U)/4.;
	vec4 col = vec4(0);
	vec2 pix=1./R/float(AA)+max(0.,2.-iTime)*.005;
    for (int x=-AA;x<AA;x++) 
        for (int y=-AA;y<AA;y++)
		    col+=fractal(UV+vec2(float(x),float(y))*pix);
	col /= float(AA*AA);
	col.a = 1.0;
	COLOR = col;
}

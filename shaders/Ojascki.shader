shader_type canvas_item;
// Using code from

// Martijn Steinrucken for the Ojascki - Calling shader
// https://www.shadertoy.com/view/3sG3zy
// Ported to Godot and customized for FragmentForge by Db0

// License Creative Commons Attribution-NonCommercial-ShareAlike 3.0 Unported License.

uniform bool is_card = true;
uniform float iTime;
uniform bool reverse;


// Fabrice cleaned up my dirty code. Much nicer!
void fragment()
{
	vec2 iResolution =  1.0 / SCREEN_PIXEL_SIZE; // for copy-paste	
//    vec2 R = iResolution.xy,
//         U = ( FRAGCOORD.xy - .5*R ) / R.x;
	vec2 U = (UV - 0.5);
  if(!is_card){
    U.x *= iResolution.x/iResolution.y;
  }
	if (reverse) {
		U = U.yx;	
	}
	
    float a = iTime; a += sin(a*.5)*.25;
    U *= mat2(vec2(cos(a), -sin(a)), vec2(sin(a), cos(a)));

    a = 2. + sin(a*.4); 
    float x = atan(U.x, U.y)/6.283+.5,  
          y = 20./(9.*length(U)*a*a) - x;   
    x += ceil(y);
    y = fract(y)-.5;
    x = ( x*x*4.- sqrt(.25-y*y) )*3.;
    float w = fwidth(x),
          c = smoothstep(w, -w, abs(fract(x)-.5)-.25);
     
    COLOR = vec4(vec3( (c-.5) *  max(0.,1.-w) +.5 ), 1.);
}
shader_type canvas_item;
// Using code from

// iq for the fractal tiling shader
// https://www.shadertoy.com/view/Ml2GWy
// Ported to Godot and customized for FragmentForge by Db0

// Licence: Creative Commons Attribution-NonCommercial-ShareAlike 3.0 Unported License
// https://creativecommons.org/licenses/by-nc-sa/3.0/deed.en_US

uniform float iTime;
uniform vec3 contrast = vec3(0.5,0.7,0.8);
uniform float zoom = 128.0;
uniform float direction_x = 1.0;
uniform float direction_y = 1.0;
uniform float speed_x = 2.0;
uniform float speed_y = 2.0;
void fragment()
{
	vec2 iResolution =  1.0 / SCREEN_PIXEL_SIZE;	
	vec2 pos = zoom*UV;
	pos.x += iTime*speed_x*direction_x;
	pos.y += iTime*speed_y*direction_y;

    vec3 col = vec3(0.0);
    for( int i=0; i<6; i++ ) 
    {
        vec2 a = floor(pos);
        vec2 b = fract(pos);
        
        vec4 w = fract((sin(a.x*7.0+31.0*a.y + 0.01*iTime)+vec4(0.035,0.01,0.0,0.7))*13.545317); // randoms
                
        col += w.xyz *                                   // color
               2.0*smoothstep(0.45,0.55,w.w) *           // intensity
               sqrt( 16.0*b.x*b.y*(1.0-b.x)*(1.0-b.y) ); // pattern
        
        pos /= 2.0; // lacunarity
        col /= 2.0; // attenuate high frequencies
    }
    
    col = pow( col, contrast );    // contrast and color shape
    
    COLOR = vec4( col, 1.0 );
}
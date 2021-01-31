shader_type canvas_item;
// Using code from

// iq for the mandelbrot shader
// https://www.shadertoy.com/view/lsX3W4
// Ported to Godot and customized for FragmentForge by Db0

// Licence: Creative Commons Attribution-NonCommercial-ShareAlike 3.0 Unported License
// https://creativecommons.org/licenses/by-nc-sa/3.0/deed.en_US

uniform bool is_card = true;
uniform int zoom_choice = 9;
uniform float iTime;

float distanceToMandelbrot( in vec2 c )
{
        float c2 = dot(c, c);
        // skip computation inside M1 - http://iquilezles.org/www/articles/mset_1bulb/mset1bulb.htm
        if( 256.0*c2*c2 - 96.0*c2 + 32.0*c.x - 3.0 < 0.0 ) return 0.0;
        // skip computation inside M2 - http://iquilezles.org/www/articles/mset_2bulb/mset2bulb.htm
        if( 16.0*(c2+2.0*c.x+1.0) - 1.0 < 0.0 ) return 0.0;

    // iterate
    float di =  1.0;
    vec2 z  = vec2(0.0);
    float m2 = 0.0;
    vec2 dz = vec2(0.0);
    for( int i=0; i<300; i++ )
    {
        if( m2>1024.0 ) { di=0.0; break; }

		// Z' -> 2·Z·Z' + 1
        dz = 2.0*vec2(z.x*dz.x-z.y*dz.y, z.x*dz.y + z.y*dz.x) + vec2(1.0,0.0);
			
        // Z -> Z² + c			
        z = vec2( z.x*z.x - z.y*z.y, 2.0*z.x*z.y ) + c;
			
        m2 = dot(z,z);
    }

    // distance	
	// d(c) = |Z|·log|Z|/|Z'|
	float d = 0.5*sqrt(dot(z,z)/dot(dz,dz))*log(dot(z,z));
    if( di>0.5 ) d=0.0;
	
    return d;
}

void fragment()
{
   vec2 iResolution = 1.0 / SCREEN_PIXEL_SIZE; 
   vec2 uv = UV;
   uv -= 0.5;
   vec2 p = uv;
   if (!is_card){
		p = (2.0*FRAGCOORD.xy-iResolution.xy)/iResolution.y;
}

    // animation
	float tz = 0.5 - 0.5*cos(0.325*(iTime));
	// We can only do a max of 15x zoom before the math breaks down
	// Due to 32bit limits on floats in Godot shaders.
    float zoo = pow( 0.5, 15.0*tz );
	vec2 zoom_coords;
	switch(zoom_choice){
		// Some interesting zoom locations discovered via exploration.
		case 0:
			zoom_coords = vec2(-0.05,.6805);
			break;
		case 1:
			zoom_coords = vec2(-1.781112019099124,-0.0000136376471796);
			break;
		case 2:
			zoom_coords = vec2(0.35630947083789705,-0.648757851006298);
			break;
		case 3:
			zoom_coords = vec2(-1.768778833,-0.001738996);
			break;
		case 4:
			zoom_coords = vec2(-1.295325656318456,-0.4413355214180586);
			break;
		case 5:
			zoom_coords = vec2(0.3508865005476451,0.3843484734392114);
			break;
		case 6:
			zoom_coords = vec2(0.4245124140026012,-0.2075295589317497);
			break;
		case 7:
			zoom_coords = vec2(0.018879985495961128,-0.6582934744125648);
			break;
		case 8:
			zoom_coords = vec2(-0.7711605143050897,-0.11535251780381468);
			break;
		case 9:
			zoom_coords = vec2(-0.9396421133753767,0.2657828189979378);
			break;
	}
	vec2 c = zoom_coords + p*zoo;

    // distance to Mandelbrot
    float d = distanceToMandelbrot(c);
    
    // do some soft coloring based on distance
	d = clamp( pow(4.0*d/zoo,0.2), 0.0, 1.0 );
    
    vec3 col = vec3(d);
    
    COLOR = vec4( col, 1.0 );
}
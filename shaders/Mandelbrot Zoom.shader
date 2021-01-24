shader_type canvas_item;
// Using code from

//Morgan McGuire for the noise function
// https://www.shadertoy.com/view/4dS3Wd
//jojobavg for the cloud shader
// https://www.shadertoy.com/view/tdGBRG
// Ported to Godot by Db0

// Licence: Creative Commons Attribution-NonCommercial-ShareAlike 3.0 Unported License
// https://creativecommons.org/licenses/by-nc-sa/3.0/deed.en_US

uniform float seed = 0.0;
uniform float iterations = 512.;
uniform float maxZoom    = 20.;

void fragment()
{   
    
	vec2 iResolution = 1.0 / SCREEN_PIXEL_SIZE;
	vec2 uv = UV;
	uv -= 0.5;
    vec2  R      = iResolution.xy;                              // Resolution Variable
    float scale  = 0.5*exp2(mod(TIME, maxZoom));         // Set Scale to 2^time and Loop at MaxZoom
    vec2  scalar = vec2(3.5,3.5*R.y/R.x)/scale;                 // Always fit width
    vec2  aspect = vec2(1.4,2.0);                               // Old Coord Compatibility
    
    vec2     offset  = vec2(48.895,0);                                 // Hacky solution for multiple coordinates
    float    modTime = mod(TIME/maxZoom, 3.0);
//    offset = modTime < 1. ? vec2(21.30899,-5.33795) :
//             modTime < 2. ? vec2(5.39307,-41.7374)  :
//                            vec2(48.895,0)          ;
    
    vec2 T  = FRAGCOORD.xy-R*offset*scale/100.;                    // Mandelbrot Space Transform
    vec2 z0 = scalar/R*T - scalar/aspect;                       // Scaling and Aspect Correction
    vec2 z  = vec2(0);
    
    float iteration = iterations;
    
    for (float i=0.0; i < iterations; i++) {                    // Escape Time Computation
        //z = vec2(z.x*z.x-z.y*z.y, 2.0*z.x*z.y) + z0;
        z = mat2(z,vec2(-z.y,z.x))*z + z0;
        if(dot(z, z) > 4.){ iteration = i; break; }
    }
    
    // Custom Color Shader based on log functions
    float intensity = iteration == iterations ? 0.0 : iteration/iterations;
    float redGreen  = intensity*((-1./4.)*log((-1.0/11.112347)*intensity+0.09)-0.25);
    float blue      = (intensity*(1.-2.4*log(intensity+0.0000000001)));
	COLOR       = vec4(redGreen,redGreen, blue, 1);
}

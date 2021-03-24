shader_type canvas_item;
// Using code from

// Stefan Berke for the scifi shader
// https://www.shadertoy.com/view/Xlf3D8
// Ported to Godot and customized for FragmentForge by Db0

// Licence: AGPL3

uniform bool is_card = true;
uniform float iTime;
uniform float big_offset;
uniform int PATH=3;				// 1-3
uniform int NUM_ITER=19;			// very depended value
uniform int NUM_TEX_ITER=60;	// iterations for texture
uniform float NORM_EPS=0.002;
uniform int NUM_TRACE=100;
uniform float PRECISSION=0.1;
uniform float FOG_DIST=0.05;


vec3 magic_param(){
	float sec=(iTime / 5. + big_offset);
	return vec3(-.4+0.3*sin(sec/7.), -.8, -1.5 + 0.01*sin(sec/3.));
}
// -------------------------- fractal -----------------------------

// kali set
// position range depending on parameters
// but usually at least +/- 0.01 to 2.0 or even (even much) larger
// check the camera path's in main(), it's tiny!
float duckball_s(in vec3 p) 
{
	float mag;
	for (int i = 0; i < NUM_ITER; ++i) 
	{
		mag = dot(p, p);
		p = abs(p) / mag + magic_param();
	}
	return mag;
}

// same as above but in 'some' color
vec3 duckball_color(in vec3 p) 
{
    vec3 col = vec3(0.);
	float mag;
	for (int i = 0; i < NUM_TEX_ITER; ++i) 
	{
		mag = dot(p, p);
		p = abs(p) / mag + magic_param();
        col += p;
	}
	return min(vec3(1.), 2.0 * col / float(NUM_TEX_ITER));
}


// ---- canonical shader magic ----

float scene_d(in vec3 p)
{
	return min(50.1+50.*sin((iTime / 5. + big_offset)/12.), duckball_s(p)*0.01-0.004);
}

vec3 scene_n(in vec3 p)
{
	const vec3 e = vec3(19., 0., 0.);
	return normalize(vec3(
			scene_d(p + e.xyy) - scene_d(p - e.xyy),
			scene_d(p + e.yxy) - scene_d(p - e.yxy),
			scene_d(p + e.yyx) - scene_d(p - e.yyx) ));
}

vec3 scene_color(in vec3 p)
{
	vec3 ambcol = 
        vec3(0.9,0.5,0.1) * (0.2+duckball_color(p));
    
    // lighting
	float dull = max(0., dot(vec3(1.), scene_n(p)));
	return ambcol * (0.3+0.7*dull);
}

vec3 sky_color(in vec3 pos, in vec3 dir)
{
	vec3 c = vec3(0.2,0.6,0.9);
    return c * 0.5 + 0.1 * duckball_color(dir + 0.3 * pos);
}

vec3 traceRay(in vec3 pos, in vec3 dir)
{
	vec3 p;
	float t = 0.;
	for (int i=0; i<NUM_TRACE; ++i)
	{
		p = pos + t * dir;
		float d = scene_d(p);

        // increase distance for too close surfaces
        d += 0.01*(1. - smoothstep(0.01, 0.011, t));

	//	if (d < 0.001)
	//		break;

		t += d * PRECISSION;
	}
	
	return mix(scene_color(p), sky_color(p, dir), min(2.6, t/FOG_DIST));
}



 
// ---------- helper --------

vec2 rotate(in vec2 v, float r)
{
	float s = sin(r), c = cos(r);
    	return vec2(v.x * c - v.y * s, v.x * s + v.y * c);
}



void fragment()
{
	vec2 iResolution =  1.0 / SCREEN_PIXEL_SIZE; // for copy-paste	
//   	vec2 uv = FRAGCOORD.xy / iResolution.xy * 2. - 1.;
   	vec2 uv = -UV + 0.5;
  if(!is_card){
    uv.x *= iResolution.x/iResolution.y;
  }
	float sec=(iTime / 5. + big_offset);
    
	// ray direction (cheap sphere section)
	vec3 dir = normalize(vec3(uv, 1.5));

    vec3 pos = vec3(0.   + 0.25 * sin(sec/47.), 
                    0.   + 0.85 * sin(sec/17.), 
                    1.   + 0.95 * sin(sec/20.));
    dir.xy = rotate(dir.xy, sec*0.7 + sin(sec*0.41));
    dir.xz = rotate(dir.xz, sec*0.6);

    	// run
	vec3 col = traceRay(pos, dir);
//
   	COLOR = vec4(traceRay(pos, dir),1.0);
}
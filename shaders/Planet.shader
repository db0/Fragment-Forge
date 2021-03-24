shader_type canvas_item;
// Using code from

// Pablo Roman Andrioli for the habitable planet shader
// https://www.shadertoy.com/view/WdScRW
// Ported to Godot and customized for FragmentForge by Db0

// Licence: Creative Commons Attribution-NonCommercial-ShareAlike 3.0 Unported License
// https://creativecommons.org/licenses/by-nc-sa/3.0/deed.en_US

uniform bool is_card = true;
uniform float iTime;


const float det = .001;
uniform vec3 water_color = vec3(0., .4, .8);
uniform vec3 land_color1 = vec3(.6, 1., .5);
uniform vec3 land_color2 = vec3(.6, .2, .0);
uniform vec3 atmo_color = vec3(.4, .65, .9);
uniform vec3 cloud_color = vec3(1.3);


mat2 rot(float a) {
	float s = sin(a), c = cos(a);
    return mat2(vec2(c, s), vec2(-s, c));
}

float kset(int it, vec3 p, vec3 q, float sc, float c) {
    p.xz *= rot(iTime * .2);
    p += q;
    p *= sc;
    float l = 0.1, l2;
    for (int i = 0; i < it; i++) {
    	p = abs(p) / dot(p, p) - c;
		l += exp(-1. * abs(length(p) - l2));
	    l2 = length(p);
    }
    return l * .08;    
}

float clouds(vec3 p2, vec3 dir) {
		p2 -= .1 * dir;
    	p2.y *= 3.;
    	float cl1 = 0., cl2 = 0.;
        for (int i = 0; i < 15; i++) {
			p2 -= .05 * dir;
            cl1 += kset(20, p2, vec3(1.7, 3., .54), .3, .95);
            cl2 += kset(18, p2, vec3(1.2, 1.7, 1.4), .2, .85);
        }    
        cl1 = pow(cl1 * .045, 10.);
        cl2 = pow(cl2 * .055, 15.);
		return cl1 - cl2;
}

float de(vec3 p, inout float objcol, inout float objid, inout float coast) {
    float surf1 = kset(6, p, vec3(.523, 1.547, .754), .2, .9);
    float surf2 = kset(8, p, vec3(.723, 1.247, .354), .2, .8) * .7;
    float surf3 = kset(10, p, vec3(1.723, .347, .754), .3, .6) * .5;
    objcol = pow(surf1 + surf2 + surf3, 5.);
	float land = length(p) - 3. - surf1 * .8 - surf2 * .1;
    float water = length(p) - 3.31;
    float d = min(land, water);
	objid = step(water, d) + step(land, d) * 2.;
	coast = max(0., .03 - abs(land - water)) / .03;
    return d * .8;
}

float de_clouds(vec3 p, vec3 dir) {
    return length(p)-clouds(p, dir)*.05;
}


vec3 normal(vec3 p, inout float objcol, inout float objid, inout float coast) {
    vec3 eps = vec3(0., det, 0.);
	return normalize(vec3(de(p + eps.yxx, objcol,objid,coast), de(p + eps.xyx, objcol,objid,coast), de(p + eps.xxy, objcol,objid,coast)) - de(p, objcol,objid,coast));
}

vec3 normal_clouds(vec3 p, vec3 dir) {
    vec3 eps = vec3(0., .05, 0.);
	vec3 n = normalize(vec3(de_clouds(p + eps.yxx, dir), de_clouds(p + eps.xyx, dir), de_clouds(p + eps.xxy, dir)) - de_clouds(p, dir));
	return n;
}

float shadow(vec3 desde, inout vec3 ldir, inout float objcol, inout float objid, inout float coast) {
    ldir=normalize(ldir);
    float td=.1,sh=1.,d;
    for (int i=0; i<10; i++) {
		vec3 p=desde+ldir*td;
        d=de(p, objcol,objid,coast);
        td+=d;
		sh=min(sh,20.*d/td);
		if (sh<.001) break;
    }
    return clamp(sh,0.,1.);
}

vec3 color(float id, vec3 p, inout float objcol, inout float coast) {
	vec3 c = vec3(0.);
    float k = smoothstep(.0, .7, kset(9, p, vec3(.63, .7, .54), .1, .8));
    vec3 land = mix(land_color1, land_color2, k); 
    vec3 water = water_color * (objcol + .5) + coast * .7; 
	float polar = pow(min(1.,abs(p.y * .4 + k * .3 - .1)),10.);
    land = mix(land, vec3(1.), polar);
	water = mix(water, vec3(1.5), polar);
    c += water * step(abs(id - 1.), .1);
    c += land * step(abs(id - 2.), .1) * objcol * 3.;
    return c;
}


vec3 shade(vec3 p, vec3 dir, vec3 n, vec3 col, float id, inout vec3 ldir, inout float objcol, inout float objid, inout float coast) {
	ldir = normalize(ldir);
    float amb = .05;
    float sh = shadow(p,ldir, objcol,objid,coast);
    float dif = max(0., dot(ldir, n)) * .7 * sh;
    vec3 ref = reflect(ldir, n) * sh;
    float spe = pow(max(0., dot(ref, dir)), 10.) * .5 * (.3+step(abs(id - 1.), .1));
    return (amb + dif) * col + spe;
}

vec3 march(vec3 from, vec3 dir, inout vec3 ldir, inout float objcol, inout float objid, inout float coast) {
	float td, d, g = 0.;
    vec3 c = vec3(0.), p;
    for (int i = 0; i < 60; i++) {
    	p = from + dir * td;
        d = de(p, objcol,objid,coast);
        td += d;
        if (td > 50. || d < det) break;
		g += smoothstep(-4.,1.,p.x);
    }
    if (d < det) {
    	p -= det * dir * 2.;
        vec3 col = color(objid, p, objcol,coast);
        vec3 n = normal(p, objcol,objid,coast);
        c = shade(p, dir, n, col, objid, ldir, objcol,objid,coast);
        //cl1 = clamp(cl1, 0., 1.);
        float cl1 = clouds(p, dir);
		vec3 nc = normal_clouds(p, dir);
        c = mix(c, .1 + cloud_color * max(0., dot(normalize(ldir), nc)), clamp(cl1,0.,1.));
    }
    else
    {
        vec2 pp = dir.xy + vec2(.434, .746);
        float m1 = 100., m2 = m1;
        for (int i=0; i < 6; i++) {
        	pp = abs(pp) / dot(pp, pp) - .9;
        	m1 = min(m1, length(pp * vec2(4.,1.)));
        	m2 = min(m2, length(pp * vec2(1.,4.)));
        }
		c += pow(max(0., 1. - m1), 30.) * .5;		
		c += pow(max(0., 1. - m2), 30.) * .5;		
    }
    g /= 60.;
    return c + (pow(g, 1.3) + pow(g,1.7) * .5) * atmo_color * .5;
}


void fragment()
{
    // Normalized pixel coordinates (from 0 to 1)
	vec3 ldir = vec3(2., .5, -.5);
	float objid, objcol, coast;
    vec2 iResolution =  1.0 / SCREEN_PIXEL_SIZE; // for copy-paste
//    vec2 uv = (FRAGCOORD.xy - iResolution.xy * .5) / iResolution.y;
    vec2 uv = (-UV + 0.5) ;
  if(!is_card){
    uv.x *= iResolution.x/iResolution.y;
  }	
	float a, b;
    vec3 from = vec3(0., a, -10.);
	vec3 dir = normalize(vec3(uv, min(1.1, iTime * .5)));
    vec3 col = march(from, dir, ldir, objcol,objid,coast);
    
    // Output to screen
    COLOR = vec4(col*.85,1.0);
}
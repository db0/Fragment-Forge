shader_type canvas_item;
// Using code from

// Otavio Good for the runes shader
// https://www.shadertoy.com/view/MsXSRn
// Ported to Godot and customized for FragmentForge by Db0

// Licence: Creative Commons Attribution-NonCommercial-ShareAlike 3.0 Unported License
// https://creativecommons.org/licenses/by-nc-sa/3.0/deed.en_US

uniform bool is_card = true;
uniform float iTime;

//precision mediump float;

float random(vec2 v) {
    return fract(sin(v.x * 32.1231 - v.y * 2.334 + 13399.2312) * 2412.32312);
}
float random2(float x, float y) {
    return fract(sin(x * 32.1231 - y * 2.334 + 13399.2312) * 2412.32312);
}
float random3(float x) {
    return fract(sin(x * 32.1231 + 13399.2312) * 2412.32312);
}

float hue2rgb(float f1, float f2, float hue) {
    if (hue < 0.0)
        hue += 1.0;
    else if (hue > 1.0)
        hue -= 1.0;
    float res;
    if ((6.0 * hue) < 1.0)
        res = f1 + (f2 - f1) * 6.0 * hue;
    else if ((2.0 * hue) < 1.0)
        res = f2;
    else if ((3.0 * hue) < 2.0)
        res = f1 + (f2 - f1) * ((2.0 / 3.0) - hue) * 6.0;
    else
        res = f1;
    return res;
}
vec3 hsl2rgb(vec3 hsl) {
    vec3 rgb;
    
    if (hsl.y == 0.0) {
        rgb = vec3(hsl.z); // Luminance
    } else {
        float f2;
        
        if (hsl.z < 0.5)
            f2 = hsl.z * (1.0 + hsl.y);
        else
            f2 = hsl.z + hsl.y - hsl.y * hsl.z;
            
        float f1 = 2.0 * hsl.z - f2;
        
        rgb.r = hue2rgb(f1, f2, hsl.x + (1.0/3.0));
        rgb.g = hue2rgb(f1, f2, hsl.x);
        rgb.b = hue2rgb(f1, f2, hsl.x - (1.0/3.0));
    }   
    return rgb;
}

float character(float i) {
    if (i == 0.) return 31599.; // 0
    if (i == 1.) return 19748.; // 1
    if (i == 2.) return 31183.; // 2
    if (i == 3.) return 31207.; // 3
    if (i == 4.) return 23524.; // 4
    if (i == 5.) return 29671.; // 5
    if (i == 6.) return 29679.; // 6
    if (i == 7.) return 31012.; // 7
    if (i == 8.) return 31727.; // 8
    if (i == 9.) return 31719.; // 9
    if (i == 10.) return 31725.; // A
    if (i == 11.) return 15339.; // B
    if (i == 12.) return 29263.; // C
    if (i == 13.) return 15211.; // D
    if (i == 14.) return 29647.; // E
    if (i == 15.) return 29641.; // F
    return 0.;
}

void fragment() {
	vec2 iResolution =  1.0 / SCREEN_PIXEL_SIZE;
    vec2 S = 15. * vec2(3., 2.);
	float distance = 1.;
	if (!is_card) {
		distance = 1.5;
	}
	vec2 coord = -UV * distance;
	coord += 0.5 * distance;
    vec2 c = floor(coord * S);

    float offset = random3(c.x) * S.x;
    float speed = random3(c.x * 3.) * 1. + 0.5;
    float len = random3(c.x) * 15. + 10.;
    float u = 1. - fract(c.y / len + iTime * speed + offset) * 2.;

    float padding = 2.;
    vec2 smS = vec2(3., 5.);
    vec2 sm = floor(fract(coord * S) * (smS + vec2(padding))) - vec2(padding);
    float symbol = character(floor(random(c + floor(iTime * speed)) * 15.));
    bool s = sm.x < 0. || sm.x > smS.x || sm.y < 0. || sm.y > smS.y ? false
             : mod(floor(symbol / pow(2., sm.x + sm.y * smS.x)), 2.) == 1.;

    COLOR = vec4(s ? hsl2rgb(vec3(c.x / S.x, 1., 0.5)) * u : vec3(0.), 1.);
}
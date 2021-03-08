shader_type canvas_item;
// Using code from

// Matthew Arcus for the  Pentagonal Tessellations shader
// https://www.shadertoy.com/view/XlBBWG
// Ported to Godot and customized for FragmentForge by Db0

// Licence: Creative Commons Attribution-NonCommercial-ShareAlike 3.0 Unported License
// https://creativecommons.org/licenses/by-nc-sa/3.0/deed.en_US

uniform bool is_card = true;
uniform float iTime;
uniform sampler2D iChannel0;
uniform sampler2D iChannel1;
uniform vec2 iChannelResolution1;
uniform bool colour_change = false;
uniform float zoom = 2.0;

//vec2 iResolution =  1.0 / SCREEN_PIXEL_SIZE; // for copy-paste

const float PI = 3.141592654;
const float TWOPI = 2.0*PI;

vec2 perp(vec2 r) {
  return vec2(-r.y,r.x);
}

int imod(int n, int m) {
  int k = n - n/m*m;
  if (k < 0) return k+m;
  else return k;
}

vec3 getcol0(ivec2 s) {
  int i = 2*imod(s.x,2)+imod(s.y,2);
  if (i == 0) return vec3(1,0,0);
  if (i == 1) return vec3(0,1,0);
  if (i == 2) return vec3(0,0,1);
  if (i == 3) return vec3(1,1,0);
  if (i == 4) return vec3(1,0,1);
  if (i == 5) return vec3(0,1,1);
  if (i == 6) return vec3(1,1,1);
  return vec3(1,1,1);
}

vec3 getcol1(ivec2 s) {
  // http://www.iquilezles.org/www/articles/palettes/palettes.htm
  float t = 0.1*iTime + 0.1*0.618*float(s.x+s.y);
  vec3 a = vec3(0.4);
  vec3 b = vec3(0.6);
  vec3 c = vec3(1,1,1);
  vec3 d = vec3(0,0.33,0.67);
  vec3 col = a + b*cos(TWOPI*(c*t+d))/1.2;
  return col;
}

vec3 getcol(ivec2 s) {
  if (colour_change) {
    return 0.4+0.6*getcol0(s);
  } else {
    return getcol1(s);
  }
}

// segment function by FabriceNeyret2
float segment(vec2 p, vec2 a, vec2 b) {
  vec2 pa = p - a;
  vec2 ba = b - a;
  float h = clamp(dot(pa, ba) / dot(ba, ba), 0.0, 1.0);
  float d = length(pa - ba * h);
  return d;
}

ivec2 nextcell(ivec2 s, int q) {
  q = imod(q,4);
  if (q == 0) s.x++;
  else if (q == 1) s.y--;
  else if (q == 2) s.x--;
  else if (q == 3) s.y++;
  return s;
}

void fragment() {
  vec2 iResolution =  1.0 / SCREEN_PIXEL_SIZE; // for copy-paste
  float scale;
	if(!is_card){
		scale = 3.3 * zoom * 3.0;
	} else{
  scale = 3.3 * zoom;}
  float lwidth = 0.025;
  // Half the width of the AA line edge
  float awidth = 1.5*scale/iResolution.y;
//  vec2 q,p = (2.0*FRAGCOORD.xy-iResolution.xy)/iResolution.y;
	vec2 uv = UV -0.5;
	if(!is_card){
		uv.x *= iResolution.x/iResolution.y
	}	
  vec2 q,p = uv;
  // Just bouncing around
  q = mod(0.3*iTime*vec2(1,1.618),2.0);
  q = min(q,2.0-q);
  p *= scale;
  ivec2 s = ivec2(floor(p));
  p = mod(p,2.0)-1.0; // Fold down to ±1 square
  int parity = int((p.y < 0.0) != (p.x < 0.0)); // Reflection?
  int quad = 2*int(p.x < 0.0) + parity; // Quadrant
  p = abs(p);
  if (parity != 0) p.xy = p.yx;
  // Lines from triangle vertices to Wythoff point
  float d = 1e8;
  d = min(d,segment(p,vec2(0,0),q));
  d = min(d,segment(p,vec2(1,0),q));
  d = min(d,segment(p,vec2(1,1),q));
  d = min(d,segment(p,vec2(-q.y,q.x),vec2(q.y,-q.x)));
  d = min(d,segment(p,vec2(-q.y,q.x),vec2(q.y,2.0-q.x)));
  d = min(d,segment(p,vec2(2.0-q.y,q.x),vec2(q.y,2.0-q.x)));
  // Color - what side of the lines are we?
  float a = dot(p-q,perp(vec2(0,0)-q));
  float b = dot(p-q,perp(vec2(1,0)-q));
  float c = dot(p-q,perp(vec2(1,1)-q));
  bool unit = s == ivec2(0);
  if (b > 0.0) {
    if (c < 0.0) s = nextcell(s,quad);
  } else {
    if (a > 0.0) s = nextcell(s,quad+1);
  }
  vec3 col = getcol(s);
  col = mix(col,vec3(1),0.1);
  col *= 0.75;
  col = mix(vec3(0),col,smoothstep(lwidth-awidth,lwidth+awidth,d));

  COLOR = vec4(sqrt(col),1.0);
}

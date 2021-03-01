shader_type canvas_item;
// Using code from

// mla for the  Colourful Apollonia shader
// https://www.shadertoy.com/view/tsScDt
// Ported to Godot and customized for Fragment Forge by Db0

// Licence: Creative Commons Attribution-NonCommercial-ShareAlike 3.0 Unported License
// https://creativecommons.org/licenses/by-nc-sa/3.0/deed.en_US

uniform bool is_card = true;
uniform float iTime;
uniform sampler2D iChannel0;
uniform sampler2D iChannel1;
uniform vec2 iChannelResolution0;

//vec2 iResolution =  1.0 / SCREEN_PIXEL_SIZE; // for copy-paste

const int AA = 2;
uniform float N = 3.0;
const int max_iterations = 100;
const float pi = 3.14159265;

bool checkinverse(inout vec2 pos, vec3 c, float s, inout float mindist2) {
  vec2 p = pos-c.xy;
  float p2 = dot(p,p);
  float d2 = s*p2 - s*c.z;
  if (d2 > 0.0) {
    mindist2 = min(d2,mindist2);
    return false;
  }
  pos = p*c.z/p2 + c.xy;
  return true;
}
  
bool checkinverse2(inout vec2 pos, vec3 c, float s) {
  float mindist2;
  return checkinverse(pos,c,s,mindist2);
}

vec2 invert(vec2 pos, vec3 c) {
  vec2 p = pos-c.xy;
  float p2 = dot(p,p);
  return p*c.z/p2 + c.xy;
}
  
vec4 gasket(vec2 pos){
  float theta = pi/N;
  float r = 1.0/cos(theta);
  float s = tan(theta);
  float r2min = 0.0;
  for(int n = 0; n < max_iterations; n++){
    float mindist2 = 1e8;
    vec3 c1 = vec3(0,0,pow(r-s,2.0));
    vec3 c2 = vec3(0,0,pow(r+s,2.0));
    if (checkinverse(pos,c1,1.0,mindist2)) {
    } else if (checkinverse(pos,c2,-1.0,mindist2)) {
    } else {
      bool found = false;
      for (float i = 0.0; i < N; i++) {
        float t = 0.2*iTime/2.;
        vec3 c = vec3(r*sin(2.0*i*theta+t), r*cos(2.0*i*theta+t), s*s);
        if (checkinverse(pos,c,1.0,mindist2)) {
          found = true;
          break;
        }
      }
      if (!found) return vec4(pos,float(n),mindist2);
    }
  }
  return vec4(pos,float(max_iterations),r2min);
}

// Smooth HSV to RGB conversion 
// Function by iq, from https://www.shadertoy.com/view/MsS3Wc
vec3 hsv2rgb( in vec3 c ) {
  vec3 rgb = clamp( abs(mod(c.x*6.0+vec3(0.0,4.0,2.0),6.0)-3.0)-1.0, 0.0, 1.0 );
  rgb = rgb*rgb*(3.0-2.0*rgb); // cubic smoothing	
  return c.z * mix( vec3(1.0), rgb, c.y);
}

vec3 getCol(vec4 n){
  float t = iTime/2.;
  return hsv2rgb(vec3(mod((t+n.z)/50.0,1.0),0.8,0.8));
}

void fragment(){
  vec2 m = vec2(0,0.8);
  vec2 iResolution =  1.0 / SCREEN_PIXEL_SIZE; // for copy-paste
//  if (iMouse.x != 0.0) {
//    m = 2.0 * iMouse.xy / iResolution.y - vec2(iResolution.x / iResolution.y, 1.0);
//  }
  vec2 c = m*(1.0/dot(m,m));
  vec3 col = vec3(0);
  for (int i = 0; i < AA; i++) {
    for (int j = 0; j < AA; j++) {
      vec2 z = UV * 2. +vec2(float(i),float(j))/float(AA)-UV.xy;
      z -= 0.5 * 2. +vec2(float(i),float(j))/float(AA)-UV.xy;
//      vec2 z = (2.0*FRAGCOORD.xy+vec2(float(i),float(j))/float(AA)-iResolution.xy)/iResolution.y;
	if(!is_card){
		z.x *= iResolution.x/iResolution.y;
	} 
      if (false) {
        z.y += 1.0;
        z = invert(z,vec3(0,-1,2)); // Map half plane to unit disk.
      }
      z = invert(z,vec3(c,dot(c,c)-1.0));
      vec4 data = gasket(z);
      float d = 1.0/(sqrt(data.w)+1.0);
      col += 0.8*d*getCol(data);
    }
  }
  col /= float(AA*AA);
  COLOR = vec4(pow(col,vec3(0.4545)),1);
}

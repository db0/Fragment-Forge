shader_type canvas_item;
// Using code from

// Clean Voronoi Column Tracing
// by Tomasz Dobrowolski'2016 CC BY-SA
// https://www.shadertoy.com/view/4lyGDV

// Inspired by:
//   https://www.shadertoy.com/view/Ml3GDX "Reactive Voronoi" (by Genise Sole)

// Other references:
//   https://www.shadertoy.com/view/llG3zy "Faster Voronoi Borders"
//   https://www.shadertoy.com/view/XtK3RG "Voronoi Floor Tiling"
//   https://www.shadertoy.com/view/4djSRW Dave Hoskins hash functions

// Ported to Godot and customized for FragmentForge by Db0

// Licence: Creative Commons CC BY-SA


uniform float seed = 0.0;
uniform int zoom_choice = 9;
uniform sampler2D iChannel0;
uniform sampler2D iChannel1;
uniform float iTime;

uniform int USE_COLORS=3;

// Waving or city-like?
uniform int WAVING=1;

uniform int ROTATE=1;

uniform int SHADOWS=1;
uniform int AO=1;

uniform int ANIMATE=1;
uniform float ANIM_SPEED=.25;


float hash12(vec2 p)
{
if (WAVING == 1){
   float v = sin(p.x*.3)*sin(p.y*.3+iTime)*.5 + .5;
   return v*v;}
else{
   // Dave Hoskins hash
   vec3 p3  = fract(vec3(p.xyx) * vec3(.1031, .1030, .0973));
   p3 += dot(p3, p3.yzx + 19.19);
   return fract((p3.x + p3.y) * p3.z);
}
}

vec2 hash22(vec2 p)
{
if (ANIMATE == 0){
   //vec3 p3 = fract(vec3(p.xyx) * vec3(.1031, .1030, .0973));
   //p3 += dot(p3, p3.yzx+19.19);
   //return fract(vec2((p3.x + p3.y)*p3.z, (p3.x+p3.z)*p3.y))*.9+.05;
    // Texture-based
   return texture( iChannel0, (p+0.5)/256.0, -100.0 ).xy;}
else if (ANIMATE == 1){
   // Dave Hoskins hash with animation
   vec3 p3 = fract(vec3(p.xyx) * vec3(.1031, .1030, .0973));
   p3 += dot(p3, p3.yzx+19.19);
   vec2 v = fract(vec2((p3.x + p3.y)*p3.z, (p3.x+p3.z)*p3.y));
   return sin(iTime*ANIM_SPEED + v*6.283185)*.45 + .5;}
else{
   // Texture-based
   vec2 v = texture( iChannel0, (p+0.5)/256.0, -100.0 ).xy;
   return sin(iTime*ANIM_SPEED + 6.283185*v)*.45 + .5;
}
}

//---------------------------------------------------------------
// Trace through 2D Voronoi columns
// by Tomasz Dobrowolski'2016 CC BY-SA

// Requires:
//   vec2 hash22( in vec2 p ); // to get Voronoi seeds positions
//   float hash12( in vec2 p ); // to get column heights

const float eps = .0001;
const float max_dist = 9999.;

// Scan through all Voronoi neighbours in direction of ray.
float find_neighbour(vec2 n, vec2 f, vec2 dir, vec4 mc, out vec4 kc, out vec2 kdr)
{
   float kd = max_dist;
   // This is fast. approx of neighbour search,
   // to make it error free in all possible cases,
   // we would have to use 7x7 scan.
   for( int j=-2; j<=2; j++ )
   for( int i=-2; i<=2; i++ )
   {
      vec2 g = mc.zw + vec2(float(i),float(j));
      vec2 o = hash22( n + g );
      vec2 r = g + o - f;

      vec2 dr = r - mc.xy;
      if ( dot(dr,dr) > eps ) { // Check if not equal to cell seed
         float d = dot(dir,dr);
         if ( d > eps ) { // Check if in direction of ray
            d = dot(.5*(mc.xy + r),dr)/d;
            if (d < kd) {
               kd = d;
               kdr = dr;
               kc = vec4(r, g);
            }
         }
      }
   }
   return kd;
}

// Trace through 2D Voronoi columns
// Z-axis is height: 
//      0 = ground
//  max_h = max. column height (positive)
// Returns:
//   xy = Voronoi seed at hit pos.
//   zw = Voronoi grid cell at hit pos.
vec4 voronoi_column_trace(
         vec3 ray_pos,
         vec3 ray_dir,
         float max_h,
         out vec4 hit_pos,
         out vec3 hit_norm,
         out vec3 hit_dh )
{
   const int iter = 32;
   
   vec2 p = ray_pos.xy;
   float s = 1./length(ray_dir.xy);
   vec2 dir = ray_dir.xy*s;
   vec2 n = floor(p);
   vec2 f = fract(p);
   
   vec4 mc;
   float md;

   // Find closest Voronoi cell to ray starting position.
   md = 8.;

   // This is fast. approx of closest point search,
   // to make it error free in all possible cases,
   // we would have to use 4x4 scan.
   for( int j=-1; j<=1; j++ )
   for( int i=-1; i<=1; i++ )
   {
      vec2 g = vec2(float(i),float(j));
      vec2 o = hash22( n + g );
      vec2 r = g + o - f;
      float d = dot(r,r);

      if( d<md )
      {
         md = d;
         mc = vec4(r, g);
      }
   }
   
   vec2 mdr = vec2(0,1);
   float dh = 0.;
   float prev_h = 0.;
   float h = 0.;
   
   md = eps;

   for( int k=0; k<iter; ++k )
   {
      // Get height of the column
      h = hash12( mc.zw + n )*max_h;
      if (ray_dir.z >= 0.) {
         dh = ray_pos.z + ray_dir.z*md;
         if (dh < h || dh > max_h) break; // ray goes to inifnity or hits
      }
      
      vec4 kc;
      vec2 kdr;
      float kd = find_neighbour(n, f, dir, mc, kc, kdr)*s;
      
      if (ray_dir.z < 0.) {
         dh = ray_pos.z + ray_dir.z*kd;
         if (dh < h) break; // hit!
      }
      
      mc = kc;
      md = kd;
      mdr = kdr;
      prev_h = h;
   }
   
   if (dh >= h) {
      hit_pos = vec4(ray_pos + ray_dir*max_dist,max_dist);
      hit_norm = vec3(0,0,1);
      hit_dh = vec3(1,1,h);
      return vec4(0);
   }
   
   float d;
   if (ray_dir.z >= 0.) {
      d = md;
      hit_norm = vec3(-normalize(mdr),0);
      hit_dh = vec3(vec2(ray_pos.z + ray_dir.z*d - prev_h, h-prev_h)/max_h,h);
   }
   else {
      d = (h - ray_pos.z)/ray_dir.z;
      if (md > d) {
         d = md;
         hit_norm = vec3(-normalize(mdr),0);
         hit_dh = vec3(vec2(ray_pos.z + ray_dir.z*d - prev_h, h-prev_h)/max_h,h);
      } else {
         hit_norm = vec3(0,0,1);
         hit_dh = vec3(1,1,h);
      }
   }
   hit_pos = vec4(ray_pos + ray_dir*d, d);
   return mc + vec4(p, n);
} 

// Trace through 2D Voronoi columns with some tuning for artifact-free shadows
// Assumes: ray_dir.z >= 0
vec4 voronoi_column_trace_shadow(
         vec4 mc,
         vec3 ray_pos,
         vec3 ray_dir,
         float max_h,
         out vec4 hit_pos,
         out vec3 hit_norm )
{
   const int iter = 8;

   vec2 p = ray_pos.xy;
   float s = 1./length(ray_dir.xy);
   vec2 dir = ray_dir.xy*s;
   vec2 n = floor(p);
   vec2 f = fract(p);
   
   mc -= vec4(p, n);
   
   float md;
   
   vec2 mdr = vec2(0,1);
   float dh = 0.;
   float h = 0.;
   
   md = eps;

   for( int k=0; k<iter; ++k )
   {
      // Scan through all Voronoi neighbours in direction of ray.
      
      vec4 kc;
      vec2 kdr;
      float kd = find_neighbour(n, f, dir, mc, kc, kdr)*s;
      
      mc = kc;
      md = kd;
      mdr = kdr;
      
      // Get height of the column
      h = hash12( mc.zw + n )*max_h;
      dh = ray_pos.z + ray_dir.z*md;
      if (dh > max_h || dh < h) break;
   }
   
   if (dh >= h) {
      hit_pos = vec4(ray_pos + ray_dir*max_dist,max_dist);
      hit_norm = vec3(0,0,1);
      return vec4(0);
   }
   
   float d = md;
   hit_norm = vec3(-normalize(mdr),0);
   hit_pos = vec4(ray_pos + ray_dir*d, d);
   return mc + vec4(p, n);
}

// Calculate AO on the top face of the column
float voronoi_column_ao( vec2 x, vec4 mc )
{
    vec2 n = floor(x);
    vec2 f = fract(x);

    vec2 mr = mc.xy - x;
    vec2 mg = mc.zw - n;
    
    float mh = hash12( n + mg );
    
    // Set center of search based on which half of the cell we are in,
    // since 4x4 is not centered around "n".
    mg = step(.5,f) - 1.;

    float mao = 0.;
    for( int j=-1; j<=2; j++ )
    for( int i=-1; i<=2; i++ )
    {
        vec2 g = mg + vec2(float(i),float(j));
        vec2 o = hash22( n + g );
        vec2 r = g + o - f;

        if( dot(mr-r,mr-r)>eps ) // skip the same cell
        {
            float d = dot( 0.5*(mr+r), normalize(r-mr) );
            // Get height of the column
            float h = hash12( n + g );
            float ao = clamp((h - mh)*2.,0.,.5)*max(0., 1. - d*4.);
            mao = max(mao, ao);
        }
    }

    return mao;
}
//---------------------------------------------------------------

// Examplary rendering with simple shading

const float fog_density = .04;
const float fog_start = 16.;
const float cam_dist = 13.5;
const float ground = -.2;


vec4 trace(in vec3 ray_start, in vec3 ray_dir, in vec3 light_dir,
   out vec4 norm_h, out vec4 ret_mc, out vec2 shadow_ao )
{
	float max_h;
	if (WAVING == 1){
	max_h = 3.;
	}else{
	max_h = 2.;
	}

   vec3 p = ray_start;
   p.y += ground;
   
   norm_h = vec4(0,1,0,0);
   ret_mc = vec4(9999.,0,0,0);
   shadow_ao = vec2(0);

   if (p.y > max_h && ray_dir.y > -.0001)
      return vec4(0.);
   

   float dist = p.y - max_h;
   if (dist > .001) {
      dist /= -ray_dir.y;
      p += ray_dir*dist;
   } else {
      dist = 0.;
   }

   vec4 hit;
   vec3 hit_dh;
   ret_mc = voronoi_column_trace(p.xzy, ray_dir.xzy, max_h, hit, norm_h.xyz, hit_dh);
if (AO == 1){
   if (hit_dh.x < 1.) {
      shadow_ao.y = max(0., 1. - hit_dh.x*8.)*.5*hit_dh.y;
   } else {
      shadow_ao.y = voronoi_column_ao(hit.xy, ret_mc);
   }
}

if (SHADOWS == 1){
   if (hit.w < 48.-dist) {
      vec3 sh_dir = light_dir.xzy;
      vec4 sh_hit;
      vec3 sh_norm;
      if (dot(sh_dir,norm_h.xyz) < .001) {
         shadow_ao.x = 1.;
      } else {
         vec4 smc = voronoi_column_trace_shadow(ret_mc, hit.xyz, sh_dir, max_h, sh_hit, sh_norm);
         shadow_ao.x = 1.-step(max_dist-1.,sh_hit.w);
      }
   }
}

   hit = hit.xzyw;
   hit.w += dist;
   hit.y -= ground + hit_dh.z;
   norm_h = vec4(norm_h.xzy, hit_dh.z/max_h);
   return hit;
}

vec3 shade(in vec3 ray_start, in vec3 ray_dir, vec4 norm_h, vec4 mc,
   vec2 shadow_ao, in vec3 light_dir, in vec3 fog_color, in vec4 hit)
{   
   vec3 norm = norm_h.xyz;
   float diffuse = pow(max(0.05, dot(norm, light_dir)*(1.-shadow_ao.x*.9)),.3);
   diffuse *= 1. - shadow_ao.y*.7*(1.-shadow_ao.x*.6);
   float spec = max(0.0,dot(reflect(light_dir,norm),normalize(ray_dir)));
   spec = pow(spec, 32.0)*.5*(1.-shadow_ao.x);

float sh;
vec3 base_color;
if (USE_COLORS == 0){
   base_color = vec3(.6);
}else{
  if (USE_COLORS == 3){
   if (WAVING == 1){
     sh = sqrt(max(0.,norm_h.w))*.8+.2;
   }else{
     sh = norm_h.w*.8+.2;
   }
   base_color =
    vec3(exp(pow(sh-.75,2.)*-10.),
         exp(pow(sh-.50,2.)*-20.),
         exp(pow(sh-.25,2.)*-10.));
  }else if (USE_COLORS == 1){
   sh = mc.z; // + mc.w*17.;
   sh = (abs(mod(sh+6.,12.)-6.)+2.5)*(1./9.);
   // Ken Silverman's EvalDraw colors ;)
   base_color =
    vec3(exp(pow(sh-.75,2.)*-10.),
         exp(pow(sh-.50,2.)*-20.),
         exp(pow(sh-.25,2.)*-10.));
  }else{
   base_color = texture(iChannel1, mc.zw*.1, -100.).xyz;
  }
   vec3 an = abs(norm);
   vec2 option;
   if (an.y > an.x && an.y > an.z){
      option = hit.xz;
   } else if (an.x>an.z){
      option = hit.yz;
   } else {
      option = hit.xy;
}
   base_color = mix(base_color, texture(iChannel1, option*.25).xyz, .2);
//       ((an.y>an.x&&an.y>an.z)?hit.xz:(an.x>an.z)?hit.yz:hit.xy)*.25).xyz, .2);
}

   if (hit.w < max_dist-1.) {
      base_color *= 1.-dot(mc.xy-hit.xz,mc.xy-hit.xz)*.25;
   }
   vec3 color = mix(vec3(0.),vec3(1.),diffuse)*base_color +
      spec*vec3(1.,1.,.9);
  
   
   float fog_dist = max(0.,hit.w - fog_start);
   float fog = 1.0 - 1.0/exp(fog_dist*fog_density);
   color = mix(color, fog_color, fog);

   return color;
}

void fragment()
{
	vec2 iResolution =  1.0 / SCREEN_PIXEL_SIZE;
   vec2 uv = (FRAGCOORD.xy - iResolution.xy*0.5) / iResolution.y;

   uv = -UV;
   uv += .5;
//   vec2 uv = -UV;
   //vec3 light_dir = normalize(vec3(.5, 1.0, .25));
   vec3 light_dir = normalize(vec3(.25, .7, .25));
   
   // Simple model-view matrix:
   float ms = 2.5/iResolution.y;
   float ang, si, co;
	if (ROTATE == 1){
	   ang = -iTime*.125 + .7;}
	else{
		ang = .7;
}

   si = sin(ang); co = cos(ang);
   mat3 cam_mat = mat3(
      vec3(co, 0., si),
      vec3(0., 1., 0.),
      vec3(-si, 0., co));
if (ROTATE == 1){
   ang = cos(-iTime*.5)*.2 + .8;
}else{
   ang = .8;
}
   //ang = .1;
   ang = max(0.,ang);
   si = sin(ang); co = cos(ang);
   cam_mat = cam_mat * mat3(
      vec3(1., 0., 0.),
      vec3(0., co, si),
      vec3(0.,-si, co));

   vec3 pos = cam_mat*vec3(0., 0., -cam_dist);
   vec3 dir = normalize(cam_mat*vec3(uv, 1.));

   vec3 color;
   vec3 fog_color = vec3(min(1.,.4+max(-.1,dir.y*.8)));
   vec4 norm_h;
   vec4 mc;
   vec2 shadow_ao;
   vec4 hit = trace(pos, dir, light_dir, norm_h, mc, shadow_ao);
   if (hit.w == 0.) {
      color = fog_color;
   } else {
      color = shade(pos, dir, norm_h, mc, shadow_ao, light_dir, fog_color, hit);
   }
   
   // gamma correction:
   color = pow(color,vec3(.6));
   
   COLOR = vec4(color, 1.);
}

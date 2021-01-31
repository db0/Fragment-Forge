shader_type canvas_item;
// Using code from

// Reinder Nijhoff for the More Spheres shader
// https://www.shadertoy.com/view/lsX3DH
// Ported to Godot and customized for FragmentForge by Db0
// Unfortunately I can't get it to work even though the converted code
// works in ShaderToy. 
// Something in the trace() function break it in Godot.

// Creative Commons Attribution-NonCommercial-ShareAlike 4.0 International License.


uniform float iTime;
uniform int iFrame;

uniform bool MOTIONBLUR = false;
uniform bool DEPTHOFFIELD = false;

uniform int CUBEMAPSIZE=256;

uniform int SAMPLES=8;
uniform int PATHDEPTH=4;
uniform float TARGETFPS=60.;

uniform float FOCUSDISTANCE=17.;
uniform float FOCUSBLUR=0.25;

uniform int RAYCASTSTEPS=20;
uniform int RAYCASTSTEPSRECURSIVE=2;

uniform float EPSILON=0.001;
uniform float MAXDISTANCE=180.;
uniform float GRIDSIZE=8.;
uniform float GRIDSIZESMALL=5.9;
uniform float MAXHEIGHT=30.;
uniform float SPEED=0.5;


//
// math functions
//

float hash( float n ) {
	return fract(sin(n)*43758.54554213);
}
vec2 hash2( float n ) {
	return fract(sin(vec2(n,n+1.))*vec2(43758.5453123));
}
vec2 hash4( vec2 n ) {
	return fract(sin(vec2( n.x*n.y, n.x+n.y))*vec2(25.1459123,312.3490423));
}
vec3 hash3( vec2 n ) {
	return fract(sin(vec3(n.x, n.y, n.x+2.0))*vec3(36.5453123,43.1459123,11234.3490423));
}
//
// intersection functions
//

float intersectPlane( vec3 ro, vec3 rd, float height) {	
	if (rd.y==0.0) return 500.;	
	float d = -(ro.y - height)/rd.y;
	if( d > 0. ) {
		return d;
	}
	return 500.;
}

float intersectUnitSphere ( vec3 ro, vec3 rd, vec3 sph ) {
	vec3  ds = ro - sph;
	float bs = dot( rd, ds );
	float cs = dot( ds, ds ) - 1.0;
	float ts = bs*bs - cs;

	if( ts > 0.0 ) {
		ts = -bs - sqrt( ts );
		if( ts > 0. ) {
			return ts;
		}
	}
	return 500.;
}

//
// Scene
//

void getSphereOffset(  vec2 grid, out vec2 center ) {
	center = (hash4( grid+vec2(43.12,1.23) ) - vec2(0.5) )*(GRIDSIZESMALL);
}
void getMovingSpherePosition(  vec2 grid,  vec2 sphereOffset, out vec3 center, float time ) {
	// falling?
	float s = 0.1+hash( grid.x*1.23114+5.342+74.324231*grid.y );
	float t = fract(14.*s + time/s*.3);
	
	float y =  s * MAXHEIGHT * abs( 4.*t*(1.-t) );
	vec2 offset = grid + sphereOffset;
	
	center = vec3( offset.x, y, offset.y ) + 0.5*vec3( GRIDSIZE, 2., GRIDSIZE );
}
void getSpherePosition( vec2 grid, vec2 sphereOffset, out vec3 center ) {
	vec2 offset = grid + sphereOffset;
	center = vec3( offset.x, 0., offset.y ) + 0.5*vec3( GRIDSIZE, 2., GRIDSIZE );
}
vec3 getSphereColor( vec2 grid ) {
	vec3 col = hash3( grid+vec2(43.12*grid.y,12.23*grid.x) );
    return mix(col,col*col,.8);
}

vec3 getBackgroundColor( vec3 ro, vec3 rd ) {	
	return 1.4*mix(vec3(.5),vec3(.7,.9,1), .5+.5*rd.y);
}

vec3 trace(vec3 ro, vec3 rd, out vec3 intersection, out vec3 normal, 
           out float dist, out int material, int steps, in float time) {
	dist = MAXDISTANCE;
	float distcheck;
	
	vec3 sphereCenter, col, normalcheck;
	
	material = 0;
	col = getBackgroundColor(ro, rd);
	
	if( (distcheck = intersectPlane( ro,  rd, 0.)) < MAXDISTANCE ) {
		dist = distcheck;
		material = 1;
		normal = vec3( 0., 1., 0. );
		col = vec3(.7);
	} 
	
	// trace grid
	vec3 pos = floor(ro/GRIDSIZE)*GRIDSIZE;
	vec3 ri = 1.0/rd;
	vec3 rs = sign(rd) * GRIDSIZE;
	vec3 dis = (pos-ro + 0.5  * GRIDSIZE + rs*0.5) * ri;
	vec3 mm = vec3(0.0);
	vec2 offset;
		
	for( int i=0; i<steps; i++ )	{
		if( material == 2 ||  distance( ro.xz, pos.xz ) > dist+GRIDSIZE ) break; {
			getSphereOffset( pos.xz, offset );
			
			getMovingSpherePosition( pos.xz, -offset, sphereCenter, time );			
			if( (distcheck = intersectUnitSphere( ro, rd, sphereCenter )) < dist ) {
				dist = distcheck;
				normal = normalize((ro+rd*dist)-sphereCenter);
				col = getSphereColor(pos.xz);
				material = 2;
			}
			
			getSpherePosition( pos.xz, offset, sphereCenter );
			if( (distcheck = intersectUnitSphere( ro, rd, sphereCenter )) < dist ) {
				dist = distcheck;
				normal = normalize((ro+rd*dist)-sphereCenter);
				col = getSphereColor(pos.xz+vec2(1.,2.));
				material = 2;
			}		
			mm = step(dis.xyz, dis.zyx);
			dis += mm * rs * ri;
			pos += mm * rs;		
		}
	}
	
	intersection = ro+rd*dist;
	
	return col;
}


vec3 cosWeightedRandomHemisphereDirection2( vec3 n, vec2 rv2 ) {
	vec3  uu = normalize( cross( n, vec3(0.0,1.0,1.0) ) );
	vec3  vv = cross( uu, n );
	
	float ra = sqrt(rv2.y);
	float rx = ra*cos(6.2831*rv2.x); 
	float ry = ra*sin(6.2831*rv2.x);
	float rz = sqrt( 1.0-rv2.y );
	vec3  rr = vec3( rx*uu + ry*vv + rz*n );

    return normalize( rr );
}


void fragment() {
	float time = iTime;
	vec2 iResolution =  1.0 / SCREEN_PIXEL_SIZE;		
    vec2 q = FRAGCOORD.xy/iResolution.xy;
	vec2 p = -1.0+2.0*q;
	p.x *= iResolution.x/iResolution.y;
	
	vec3 col = vec3( 0. );
	
	// raytrace
	int material;
	vec3 normal, intersection;
	float dist;
	float seed = time+(p.x+iResolution.x*p.y)*1.51269341231;
	
	for( int j=0; j<SAMPLES + min(0,iFrame); j++ ) {
		float fj = float(j);
    vec2 rv2;


//#ifdef MOTIONBLUR
//		time = iTime + fj/(float(SAMPLES)*TARGETFPS);
//#endif
		
		rv2 = hash2( 24.4316544311*fj+time+seed );
		
		vec2 pt = p+rv2/(0.5*iResolution.xy);
				
		// camera	
		vec3 ro = vec3( cos( 0.232*time) * 10., 6.+3.*cos(0.3*time), GRIDSIZE*(time/SPEED) );
		vec3 ta = ro + vec3( -sin( 0.232*time) * 10., -2.0+cos(0.23*time), 10.0 );
		
		float roll = -0.15*sin(0.5*time);
		
		// camera tx
		vec3 cw = normalize( ta-ro );
		vec3 cp = vec3( sin(roll), cos(roll),0.0 );
		vec3 cu = normalize( cross(cw,cp) );
		vec3 cv = normalize( cross(cu,cw) );
	
    vec3 rd;
		rd = normalize( pt.x*cu + pt.y*cv + 1.5*cw );		
			
		vec3 colsample = vec3( 1. );
		
		// first hit
		rv2 = hash2( (rv2.x*2.4543263+rv2.y)*(time+1.) );
		colsample *= trace(ro, rd, intersection, normal, dist, material, RAYCASTSTEPS, time);

		// bounces
		for( int i=0; i<(PATHDEPTH-1); i++ ) {
			if( material != 0 ) {
				rd = cosWeightedRandomHemisphereDirection2( normal, rv2 );
				ro = intersection + EPSILON*rd;
						
				rv2 = hash2( (rv2.x*2.4543263+rv2.y)*(time+1.)+(float(i+1)*.23) );
						
				colsample *= trace(ro, rd, intersection, normal, dist, material, RAYCASTSTEPSRECURSIVE, time);
			}
		}	
		colsample = sqrt(clamp(colsample, 0., 1.));
		if( material == 0 ) {			
			col += colsample;	
		}
	}
	col  /= float(SAMPLES);
	
	COLOR = vec4( col,1.0);
}
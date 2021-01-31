shader_type canvas_item;
// Using code from

// Inigo Quilez for the Sierpinski 3D shader
// https://www.shadertoy.com/view/4dl3Wl
// Ported to Godot and customized for FragmentForge by Db0

// Licence: MIT
// https://opensource.org/licenses/MIT
uniform bool is_card = true;
uniform float iTime;
uniform float orient = 1.0;


const vec3 va = vec3(  0.0,  0.57735,  0.0 );
const vec3 vb = vec3(  0.0, -1.0,  1.15470 );
const vec3 vc = vec3(  1.0, -1.0, -0.57735 );
const vec3 vd = vec3( -1.0, -1.0, -0.57735 );

// return distance and address
vec2 map( vec3 p )
{
	float a = 0.0;
    float s = 1.0;
    float r = 1.0;
    float dm;
    vec3 v;
    for( int i=0; i<8; i++ )
	{
	    float d, t;
		d = dot(p-va,p-va);              v=va; dm=d; t=0.0;
        d = dot(p-vb,p-vb); if( d<dm ) { v=vb; dm=d; t=1.0; }
        d = dot(p-vc,p-vc); if( d<dm ) { v=vc; dm=d; t=2.0; }
        d = dot(p-vd,p-vd); if( d<dm ) { v=vd; dm=d; t=3.0; }
		p = v + 2.0*(p - v); r*= 2.0;
		a = t + 4.0*a; s*= 4.0;
	}
	
	return vec2( (sqrt(dm)-1.0)/r, a/s );
}

const float precis = 0.0002;

vec3 intersect( in vec3 ro, in vec3 rd )
{
	vec3 res = vec3( 1e20, 0.0, 0.0 );
	
	float maxd = 5.0;

	// sierpinski
    float h = 1.0;
    float t = 0.5;
	float m = 0.0;
    vec2 r;
	for( int i=0; i<100; i++ )
    {
	    r = map( ro+rd*t );
        if( r.x<precis || t>maxd ) break;
		m = r.y;
        t += r.x;
    }

    if( t<maxd && r.x<precis )
		res = vec3( t, 2.0, m );

	return res;
}

vec3 calcNormal( in vec3 pos )
{
    vec3 eps = vec3(precis,0.0,0.0);
	return normalize( vec3(
           map(pos+eps.xyy).x - map(pos-eps.xyy).x,
           map(pos+eps.yxy).x - map(pos-eps.yxy).x,
           map(pos+eps.yyx).x - map(pos-eps.yyx).x ) );
}

float calcOcclusion( in vec3 pos, in vec3 nor )
{
	float ao = 0.0;
    float sca = 1.0;
    for( int i=0; i<8; i++ )
    {
        float h = 0.001 + 0.5*pow(float(i)/7.0,1.5);
        float d = map( pos + h*nor ).x;
        ao += -(d-h)*sca;
        sca *= 0.95;
    }
    return clamp( 1.0 - 0.8*ao, 0.0, 1.0 );
}

//vec3 lig = normalize(vec3(1.0,0.7,0.9));

vec3 render( in vec3 ro, in vec3 rd )
{
    vec3 col = vec3(0.0);

	// raymarch
    vec3 tm = intersect(ro,rd);
    if( tm.y>0.5 )
    {
        // geometry
        vec3 pos = ro + tm.x*rd;
		vec3 nor = calcNormal( pos );
		vec3 maa = vec3( 0.0 );
		
        maa = 0.5 + 0.5*cos( 6.2831*tm.z + vec3(0.0,1.0,2.0) );

		float occ = calcOcclusion( pos, nor );

		// lighting
		vec3 lig = normalize(vec3(1.0,0.7,0.9));
		float amb = (0.5 + 0.5*nor.y);
		float dif = max(dot(nor,lig),0.0);

        // lights
		vec3 lin = 1.5*amb*vec3(1.0) * occ;

		// surface-light interacion
		col = maa * lin;
        
	}

    // gamma
	col = pow( clamp(col,0.0,1.0), vec3(0.45) );

    return col;
}
void fragment()
{
	vec2 iResolution =  1.0 / SCREEN_PIXEL_SIZE;
	vec2 q = FRAGCOORD.xy / iResolution.xy;
	vec2 p = -UV*2.5*orient;
	p += 1.25*orient;
	if (!is_card){
	    p = -1.0 + 2.0 * q;
	    p.x *= iResolution.x/iResolution.y;
	}
    vec2 m = vec2(0.5);

    //-----------------------------------------------------
    // camera
    //-----------------------------------------------------
	
	float an = 3.2 + 0.5*iTime - 6.2831*(m.x-0.5);

	vec3 ro = vec3(2.5*sin(an),0.0,2.5*cos(an));
    vec3 ta = vec3(0.0,-0.5,0.0);
    vec3 ww = normalize( ta - ro );
    vec3 uu = normalize( cross(ww,vec3(0.0,1.0,0.0) ) );
    vec3 vv = normalize( cross(uu,ww));
	vec3 rd = normalize( p.x*uu + p.y*vv + 5.0*ww*m.y );

    vec3 col = render( ro, rd );
    
    COLOR = vec4( col, 1.0 );
}

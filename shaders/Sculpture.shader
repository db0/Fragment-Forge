shader_type canvas_item;
// Using code from

// iq for the sculpture shader
// https://www.shadertoy.com/view/XtjSDK
// Ported to Godot and customized for FragmentForge by Db0

// Licence: Creative Commons Attribution-NonCommercial-ShareAlike 3.0 Unported License
// https://creativecommons.org/licenses/by-nc-sa/3.0/deed.en_US

uniform bool is_card = true;
uniform float iTime;
uniform int AA = 1;
uniform int iFrame;
uniform sampler2D iChannel0;
uniform float GROWX = 2.0; // 0.0 - 3.0
uniform bool COS_GROWX = false;
uniform float GROWY = 4.0; // 0.0 - 6.0
uniform bool COS_GROWY = false;
uniform float GROWZ = 8.0; // 6.0 - 10.0
uniform bool COS_GROWZ = false;
uniform float GROWW = 20.0; // 12.0 - 18.0
uniform bool COS_GROWW = false;
uniform vec3 tint = vec3(2.1,2.0,1.2);


float hash1( float n )
{
    return fract(sin(n)*43758.5453123);
}

float hash2( in vec2 f ) 
{ 
    return fract(sin(f.x+131.1*f.y)*43758.5453123); 
}


const float PI = 3.1415926535897932384626433832795;
const float PHI = 1.6180339887498948482045868343656;

vec3 forwardSF( float i, float n) 
{
    float phi = 2.0*PI*fract(i/PHI);
    float zi = 1.0 - (2.0*i+1.0)/n;
    float sinTheta = sqrt( 1.0 - zi*zi);
    return vec3( cos(phi)*sinTheta, sin(phi)*sinTheta, zi);
}


vec3 mapP( vec3 p, inout vec4 grow )
{
	if (COS_GROWX){
    	p.xyz += 1.000*cos(  GROWX*p.yzx )*grow.x;
	} else {
	    p.xyz += 1.000*sin(  GROWX*p.yzx )*grow.x;
	}
	if (COS_GROWY){
	    p.xyz += 0.500*cos(  GROWY*p.yzx )*grow.y;
	} else {
	    p.xyz += 0.500*sin(  GROWY*p.yzx )*grow.y;
	}
	if (COS_GROWZ){
	    p.xyz += 0.250*cos(  GROWZ*p.yzx )*grow.z;
	} else {
	    p.xyz += 0.250*sin(  GROWZ*p.yzx )*grow.z;
	}
	if (COS_GROWZ){
	    p.xyz += 0.050*cos( GROWW*p.yzx )*grow.w;
	} else {
	    p.xyz += 0.050*sin( GROWW*p.yzx )*grow.w;
	}
    return p;
}

float map( vec3 q,  inout vec4 grow )
{
    vec3 p = mapP( q, grow );
    float d = length( p ) - 1.5;
	return d * 0.05;
}

float intersect( in vec3 ro, in vec3 rd, inout vec4 grow )
{
	const float maxd = 7.0;

	float precis = 0.001;
    float h = 1.0;
    float t = 1.0;
    for( int i=0; i<1256; i++ )
    {
        if( (h<precis) || (t>maxd) ) break;
	    h = map( ro+rd*t, grow );
        t += h;
    }

    if( t>maxd ) t=-1.0;
	return t;
}

vec3 calcNormal( in vec3 pos, inout vec4 grow )
{
    vec3 eps = vec3(0.005,0.0,0.0);
	return normalize( vec3(
           map(pos+eps.xyy, grow) - map(pos-eps.xyy, grow),
           map(pos+eps.yxy, grow) - map(pos-eps.yxy, grow),
           map(pos+eps.yyx, grow) - map(pos-eps.yyx, grow) ) );
}

float calcAO( in vec3 pos, in vec3 nor, in vec2 pix, inout vec4 grow )
{
	float ao = 0.0;
    for( int i=0; i<64; i++ )
    {
        vec3 ap = forwardSF( float(i), 64.0 );
		ap *= sign( dot(ap,nor) ) * hash1(float(i));
        ao += clamp( map( pos + nor*0.05 + ap*1.0, grow )*32.0, 0.0, 1.0 );
    }
	ao /= 64.0;
	
    return clamp( ao*ao, 0.0, 1.0 );
}

float calcAO2( in vec3 pos, in vec3 nor, in vec2 pix, inout vec4 grow )
{
	float ao = 0.0;
    for( int i=0; i<32; i++ )
    {
        vec3 ap = forwardSF( float(i), 32.0 );
		ap *= sign( dot(ap,nor) ) * hash1(float(i));
        ao += clamp( map( pos + nor*0.05 + ap*0.2, grow )*100.0, 0.0, 1.0 );
    }
	ao /= 32.0;
	
    return clamp( ao, 0.0, 1.0 );
}

vec4 texCube( sampler2D sam, in vec3 p, in vec3 n, in float k )
{
	vec4 x = texture( sam, p.yz );
	vec4 y = texture( sam, p.zx );
	vec4 z = texture( sam, p.xy );
    vec3 w = pow( abs(n), vec3(k) );
	return (x*w.x + y*w.y + z*w.z) / (w.x+w.y+w.z);
}

void fragment()
{
	int ZERO = min(iFrame,0);
    vec2 iResolution =  1.0 / SCREEN_PIXEL_SIZE;
	vec4 grow = vec4(1.0);

    vec3 tot = vec3(0.0);
//    vec2 p = (2.0*FRAGCOORD.xy-iResolution.xy)/iResolution.y;
    vec2 p = (2.0*UV);
	p -= 0.5 * 2.0;
	vec2 q = UV - 0.5;


    
        grow = smoothstep( 0.0, 1.0, (iTime-vec4(0.0,1.0,2.0,3.0))/3.0 );


        //-----------------------------------------------------
        // camera
        //-----------------------------------------------------

        float an = 1.1 + 0.05*(iTime-10.0);

        vec3 ro = vec3(4.5*sin(an),1.0,4.5*cos(an));
        vec3 ta = vec3(0.0,0.2,0.0);
        // camera matrix
        vec3 ww = normalize( ta - ro );
        vec3 uu = normalize( cross(ww,vec3(0.0,1.0,0.0) ) );
        vec3 vv = normalize( cross(uu,ww));
        // create view ray
        vec3 rd = normalize( p.x*uu + p.y*vv + 1.5*ww );


        //-----------------------------------------------------
        // render
        //-----------------------------------------------------

        vec3 col = vec3(0.07)*clamp(1.0-length(q-0.5),0.0,1.0);

        // raymarch
        float t = intersect(ro,rd, grow);

        if( t>0.0 )
        {
            vec3 pos = ro + t*rd;
            vec3 nor = calcNormal(pos, grow);
            vec3 ref = reflect( rd, nor );
            vec3 sor = nor;

            vec3 q2 = mapP( pos, grow );
            float occ = calcAO( pos, nor, UV, grow ); occ = occ*occ;

            // materials
            col = vec3(0.04);
            float ar = clamp(1.0-0.7*length(q2-pos),0.0,1.0);
            col = mix( col, tint, ar);
            col  *= 0.3;          
            col *= mix(vec3(1.0,0.4,0.3), vec3(0.8,1.0,1.3), occ);
            float occ2 = calcAO2( pos, nor, UV, grow );


            col *= 1.0*mix( vec3(2.0,0.4,0.2), vec3(1.0), occ2*occ2*occ2 );
            float ks = texCube( iChannel0, pos*1.5, nor, 4.0 ).x;
            ks = 0.5 + 1.0*ks;
            ks *= (1.0-ar);

            // lighting
            float sky = 0.5 + 0.5*nor.y;
            float fre = clamp( 1.0 + dot(nor,rd), 0.0, 1.0 );
            float spe = pow(max( dot(-rd,nor),0.0),8.0);
            // lights
            vec3 lin  = vec3(0.0);
                 lin += 3.0*vec3(0.7,0.80,1.00)*sky*occ;
                 lin += 1.0*fre*vec3(1.2,0.70,0.60)*(0.1+0.9*occ);
            col += 0.3*ks*4.0*vec3(0.7,0.8,1.00)*smoothstep(0.0,0.2,ref.y)*(0.05+0.95*pow(fre,5.0))*(0.5+0.5*nor.y)*occ;
            col += 4.0*ks*1.5*spe*occ*col.x;
            col += 2.0*ks*1.0*pow(spe,8.0)*occ*col.x;
            col = col * lin;

            // dust
            col = mix( col, 0.2*fre*fre*fre+0.6*vec3(0.6,0.55,0.5)*sky*(0.8+0.4*texCube( iChannel0, pos*8.0, nor, 4.0 ).xyz), 0.6*smoothstep(0.3,0.7,nor.y)*sqrt(occ) );

            col *= 2.6*exp(-0.2*t);
        }

        col = pow(col,vec3(0.4545));
        
        tot += col;


    tot = pow( tot, vec3(1.0,1.0,1.4) ) + vec3(0.0,0.02,0.14);
    
    tot += (1.0/255.0)*hash2( UV );
    
    COLOR = vec4( tot, 1.0 );
}

shader_type canvas_item;
// Using code from

// Otavio Good for the runes shader
// https://www.shadertoy.com/view/MsXSRn
// Ported to Godot and customized for FragmentForge by Db0

// Licence: CC0

uniform bool is_card = true;
uniform float iTime;
uniform sampler2D iChannel0;
uniform sampler2D iChannel1;
uniform vec2 iChannelResolution1;

//vec2 iResolution =  1.0 / SCREEN_PIXEL_SIZE; // for copy-paste

// "Rubik" by Kali

const vec3 Xaxis=vec3(1.,0.,0.);
const vec3 Yaxis=vec3(0.,1.,0.);
const vec3 Zaxis=vec3(0.,0.,1.);
const float turn=1.570796;

// rotation matrix
mat3 rotmat(vec3 v, float angle)
{
	float c = cos(angle);
	float s = sin(angle);
	
	return mat3(vec3(c + (1.0 - c) * v.x * v.x, (1.0 - c) * v.x * v.y - s * v.z, (1.0 - c) * v.x * v.z + s * v.y),
		vec3((1.0 - c) * v.x * v.y + s * v.z, c + (1.0 - c) * v.y * v.y, (1.0 - c) * v.y * v.z - s * v.x),
		vec3((1.0 - c) * v.x * v.z - s * v.y, (1.0 - c) * v.y * v.z + s * v.x, c + (1.0 - c) * v.z * v.z)
		);
}

// get rotation matrix of cube at "pos" for the given frame
mat3 rotstep(in vec3 p, in vec3 pos, in float anirot, in float timestep) {
 	vec3 X=Xaxis;
 	vec3 Y=Yaxis;
 	vec3 Z=Zaxis;
	vec3 rotv1, rotv2;
	mat3 rot;
	rot=mat3(vec3(1.,0.,0.),vec3(0.,1.,0.),vec3(0.,0.,1.)); // identity matrix

	for (float i=0.; i<20.;i++) {

		if (i<timestep+.5) {	// do the rotations if before the current time step

			vec2 rotparam;
			rotparam.x=mod(i,3.)+1.; // alternate rotation vector
			rotparam.y=floor(mod(i*1.35468,3.))+1.; // alternate group of cubes to rotate

			// assign rotation vectors based on rotparam.x 
			if (rotparam.x==1.) {rotv1=Xaxis; rotv2=X;}
			if (rotparam.x==2.) {rotv1=Yaxis; rotv2=Y;}
			if (rotparam.x==3.) {rotv1=Zaxis; rotv2=Z;}

			vec3 c=(pos+vec3(2.))*rotv1; // length of c will be either 1, 2 or 3
										 // indicating the group of the current cube

			if (abs(length(c)-rotparam.y)<.5) { // if cube is in the rotation group, rotate!
				float ang;
				if (i<timestep) ang=turn; // complete turn
					else ang=turn*anirot; // angle of last turn is scaled based on fractional 
										  // part of time in order to get the animation

				mat3 rot1=rotmat(rotv2,ang); // rotation matrix using rotated axis
				mat3 rot2=rotmat(rotv1,-turn); // rotation matrix for rotating positions
				X*=rot1; // rotate all the axis
				Y*=rot1;
				Z*=rot1;
				pos=pos*rot2; // rotate the position of cube
				rot=rot*rot1; // the resulting rotation matrix
			}
		}
		}
	return rot;
}


// check cube intersection, return side 
bool cube ( in vec3 p, in vec3 dir, in vec3 posid, inout float start, inout int side)
{
	float fix=.00001;
	vec3 pos=posid;
	float size=.5;
	vec3 p2=p;
	vec3 dir2=dir;
	vec3 minim=pos-vec3(size);
	vec3 maxim=pos+vec3(size);
	vec3 omin = ( minim - p ) / dir;
	vec3 omax =( maxim - p ) / dir;
	vec3 maxi= max ( omax, omin );
	vec3 mini = min ( omax, omin );
	float end = min ( maxi.x, min ( maxi.y, maxi.z ) );
	start = max ( max ( mini.x, 0.0 ), max ( mini.y, mini.z ) );
	float rayhit=0.;
	if (end-start>fix) rayhit=1.;
	side=1;
	if (rayhit>0.5) {
		vec3 hit=p+start*dir;
		float border=size*.85;
		hit=p+start*dir;
		// get hit side
		if (abs(hit.x-minim.x)<fix) side=2;
		if (abs(hit.y-minim.y)<fix) side=3;
		if (abs(hit.z-minim.z)<fix) side=4;
		if (abs(hit.x-maxim.x)<fix) side=5;
		if (abs(hit.y-maxim.y)<fix) side=6;
		hit-=pos;
		// check for border of the cubes
		if (abs(hit.x)>border && abs(hit.x)<size-fix) side=0;
		if (abs(hit.y)>border && abs(hit.y)<size-fix) side=0;
		if (abs(hit.z)>border && abs(hit.z)<size-fix) side=0;
	}
	return rayhit>0.5;
}

// get side colors (I used an array before, but Firefox didn't allow it)
vec3 getcolor(int side) {
	vec3 sidecolor;
	if (side==0) sidecolor= vec3(0.12);
	if (side==1) sidecolor= vec3(0.90,0.90,0.90);
	if (side==2) sidecolor= vec3(0.90,0.10,0.10);
	if (side==3) sidecolor= vec3(0.10,0.80,0.10);
	if (side==4) sidecolor= vec3(0.10,0.20,0.90);
	if (side==5) sidecolor= vec3(0.90,0.90,0.10);
	if (side==6) sidecolor= vec3(0.90,0.40,0.10);
	return sidecolor;
}


// Main code
void fragment()
{
	vec2 iResolution =  1.0 / SCREEN_PIXEL_SIZE; // for copy-paste
	vec2 uv = UV-0.5;
//	uv=uv*2.-1.;
	uv.x*=iResolution.y/iResolution.x;
	COLOR=vec4(vec3(0.),1.);
	if (length(uv)>.45) return; // nothing outside this area
	vec2 mouse=vec2(0)/iResolution.xy-vec2(.5);

	//camera rotation
	mat3 camrot1,camrot2;
//	if (length(iMouse.xy)==0.) {
		camrot1=rotmat(vec3(0.,1.,0.),1.);
		camrot2=rotmat(vec3(1.,0.,0.),1.);
//	} else {
//		camrot1=rotmat(vec3(0.,1.,0.),mouse.x*turn*3.);
//		camrot2=rotmat(vec3(1.,0.,0.),-mouse.y*turn*3.);
//	}
	mat3 camrot=camrot1*camrot2; 
	vec3 from=vec3(0,0.,-8.)*camrot;
	vec3 dir=normalize(vec3(uv*.75,1.))*camrot;

	vec3 rdir,rfrom, hdir,hfrom;
	vec3 col=vec3(0.);
	int side=0;
	int hitside=-1;
	float hit=0.;
	float firsthit=1000.; 
	float hittest=0.0;

	// time manipulation - going reverse first, then fast forward
	// this is the trick for the self-solving, the shader was first designed
	// to scramble only, so the following two lines are the "AI" system :)
	float time=min(20.,22.-mod(iTime,28.));
	if (time<-2.) time=(abs(time)-2.)*5.;
	
	float ftime=max(0.,fract(time)*sign(time)); //fractional time used for animation
	float timestep=max(0.,floor(time)); // the current rotation stage

	// cube tracing
	for (float c=0.; c<27.; c++) {

		// get x,y,z coordinates of current cube within the sequential loop
		vec3 pos=vec3(mod(c,3.),floor(mod(c/3.,3.)),floor(c/9.))-vec3(1.);

		// get the rotation matrix for the current cube
		mat3 cuberot=rotstep(rdir, pos, ftime,timestep);

		//actually, the camera is rotated! :)
		rdir=dir*cuberot;
		rfrom=from*cuberot;

			// intersect
			if (cube(rfrom,rdir,pos,hit,side)) {
				hittest=1.0; // yes, we hit the cube
				if (hit<firsthit) { // the first hit?
					// save intersection info
					firsthit=hit;   
					hitside=side;   
					hdir=rdir;
					hfrom=rfrom;
				}
			}
	}
	
	if (hittest>.5) { // we hit the cube, draw the stuff
		vec3 hitv=hfrom+firsthit*hdir;
		col=vec3(getcolor(hitside)); // side color
		if (length(max(abs(hitv)-1.45,vec3(0.)))==0.) col=vec3(0.12); // inside color
		col*=exp(-.4*pow(max(0.,firsthit-6.5),1.7)); // distance shading
	} else {
		col=vec3(0.); // background
	}
	COLOR = vec4(col,1.0);
}
shader_type canvas_item;
// Using code from

// weyland for the barberella shader
// https://www.shadertoy.com/view/XdfGDr
// Ported to Godot and customized for FragmentForge by Db0

// Licence: Creative Commons Attribution-NonCommercial-ShareAlike 3.0 Unported License
// https://creativecommons.org/licenses/by-nc-sa/3.0/deed.en_US


uniform bool is_card = true;
uniform float iTime;
uniform vec3 tint = vec3(.1,.95,.65);

//vec2 iResolution =  1.0 / SCREEN_PIXEL_SIZE; // for copy-paste

// Barberella ... by Weyland Yutani, dedicated to Jane Fonda and Verner Panton
// Based on Metatunnel by FRequency, really old, might not work on your gpu

float h(vec3 q) // distance function
{
    float f=1.;
	// blobs
    f*=distance(q,vec3(-sin(iTime*.181)*.5,sin(iTime*.253),1.));
    f*=distance(q,vec3(-sin(iTime*.252)*.5,sin(iTime*.171),1.));
    f*=distance(q,vec3(-sin(iTime*.133)*.5,sin(iTime*.283),1.));
    f*=distance(q,vec3(-sin(iTime*.264)*.5,sin(iTime*.145),1.));
	// room
	f*=(cos(q.y))*(cos(q.z)+1.)*(cos(q.x+cos(q.z*3.))+1.)-.21+cos(q.z*6.+iTime/20.)*cos(q.x*5.)*cos(q.y*4.5)*.3;
    return f;
}
void fragment()
{
	vec2 iResolution =  1.0 / SCREEN_PIXEL_SIZE; // for copy-paste 
    vec2 p=-1.+2.*UV;
    vec3 o=vec3(p.x,p.y*1.25-0.3,0.);
    vec3 d=vec3(p.x+cos(iTime/20.)*0.3,p.y,1.)/64.;
    vec4 c=vec4(0.);
    float t=0.;
    for(int i=0;i<25;i++) // march
    {
        if(h(o+d*t)<.4)
        {
            t-=5.;
            for(int j=0;j<5;j++) { if(h(o+d*t)>.4) t+=1.; } // scatter
            vec3 e=vec3(.01,.0,.0);
            vec3 n=vec3(.0);
            n.x=h(o+d*t)-h(vec3(o+d*t+e.xyy));
            n.y=h(o+d*t)-h(vec3(o+d*t+e.yxy));
            n.z=h(o+d*t)-h(vec3(o+d*t+e.yyx));
            n=normalize(n);
            c+=max(dot(vec3(.0,.0,-.15),n),.0)+max(dot(vec3(.0,-.15,.15),n),.0)*.155;
            break;
        }
        t+=5.;
    }
	vec4 col = c+vec4(tint,1.)*(t*.03);
	col[3] = 1.;
    COLOR=col;
}
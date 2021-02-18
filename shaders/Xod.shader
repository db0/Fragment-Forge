shader_type canvas_item;
// Using code from

// evvvvil for the shader
// https://www.shadertoy.com/view/3d33zs
// Ported to Godot and customized for FragmentForge by Db0

// Licence: Creative Commons Attribution-NonCommercial-ShareAlike 3.0 Unported License
// https://creativecommons.org/licenses/by-nc-sa/3.0/deed.en_US

uniform bool is_card = true;
uniform float iTime;
uniform sampler2D iChannel0;

// uniform vec2 s=vec2(.000035,-.000035);
uniform vec2 e=vec2(.000035,-.000035);
//uniform float t;


mat2 r2(float r){
	return mat2(vec2(cos(r),sin(r)),vec2(-sin(r),cos(r)));
	}
float bo(vec3 p,vec3 r){
	vec3 q=abs(p)-r;return max(max(q.x,q.y),q.z);
	}
float cz(vec3 p,float r){p.z=0.;return length(p)-r;}
vec2 fb( vec3 p,float s)
{
  float tt=mod(iTime,62.83);
  float bs=(0.4+clamp(sin(tt*2.),-0.4,0.4))*1.25;
  p.xy*=r2(bs*1.4*s/5.);
  vec2 h,t=vec2(bo(p,vec3(10,.6,.8)),5.+s);
  h=vec2(bo(abs(p)-vec3(2,0,0),vec3(1.2,.8,1.2)),3.+s);
  h.x=min(bo(abs(abs(p)-vec3(0,.6,.6))-vec3(0,.3,.3),vec3(3,.1,.1)),h.x);
  t=(t.x<h.x)?t:h; return vec2(t.x*.5,t.y); 
}
vec2 mp( vec3 p, vec3 np, vec3 bp, float g)
{
	
  float tt=mod(iTime,62.83);
  float bb=(0.25+clamp(sin(tt),-0.25,0.25))*2.;
  float bs=(0.4+clamp(sin(tt*2.),-0.4,0.4))*1.25;
  float b=sin(p.z-tt*10.)*0.1;
  vec3 pp=p;
  bp=p;
  pp.xz*=r2(.785*2.*bb);    
  np=pp;
  float bro=(0.5-b*2.)*(1.-bs);
  for(int i=0;i<6;i++){
    np=abs(np)-mix(vec3(1.2+bro*.5,2.1,-.1),vec3(bro*.5,3,1.7),bb);  
    np.yz*=r2(.785*float(i));
    np.xz*=r2(.785*float(i)*.49-bro*.15);
    np-=.3*sin(p.y)*1.5;
      
    bp=abs(bp)-vec3(2,0.7,1.1);    
    bp.yz*=r2(.785*float(i));
    bp.xz*=r2(.785*float(i)*.5);
    bp-=.3*sin(p.y)*1.5;      
  }
  vec2 h,t=fb(np,0.);
  bp.xz*=r2(1.4);bp=abs(bp*0.7)-4.5;
  h=fb(bp,5.);
  h.x*=1.5;
  t=(t.x<h.x)?t:h;
  h=vec2(length(abs(pp-vec3(0,4.-bb,0))-vec3(3.+bro*3.,0,3.-bb))-2.5+bb,6);
  h.x=min(length(p-vec3(0,-3,0))-5.,h.x)*.7;
  
  h.x=min(cz(p+vec3(0,2.2,0),p.z>-21.?bro:0.),h.x);
  g=0.1/(0.1+h.x*h.x*20.);
  t=(t.x<h.x)?t:h;
  return t;
}
vec2 tr( vec3 ro, vec3 rd, vec3 np, vec3 bp, float g)
{
  vec2 h,t=vec2(0.1);
  for(int i=0;i<128;i++){
    h=mp(ro+rd*t.x, np, bp, g);
    if(h.x<.0001||t.x>50.) break;
    t.x+=h.x;t.y=h.y;
  }
  if(t.x>50.) t.x=0.;
  return t;
}
void fragment()
{
	vec2 iResolution =  1.0 / SCREEN_PIXEL_SIZE;
//    vec2 uv = vec2(FRAGCOORD.x/iResolution.x,FRAGCOORD.y/iResolution.y);
    vec2 uv = -UV*0.8;
    uv += 0.5*0.8;
	uv/=vec2(iResolution.y/iResolution.x,1);
    float tt=mod(iTime,62.83);
  	float bs=(0.4+clamp(sin(tt*2.),-0.4,0.4))*1.25;
    float bb=(0.25+clamp(sin(tt),-0.25,0.25))*2.;
    vec3 np;
    vec3 bp;
	float g;
    vec3 ro=vec3(cos(tt*0.5)*15.,sin(tt*0.5)*15.,-20.+cos(tt)*5.),
    cw=normalize(vec3(0)-ro),cu=normalize(cross(cw,vec3(0,1,0))),cv=normalize(cross(cu,cw)),
    rd=mat3(cu,cv,cw)*normalize(vec3(uv,.5)),
    co,fo,ld=normalize(vec3(0,0.5,-0.5));
    co=fo=vec3(.04)*(1.-(length(uv)-.2));
    vec2 s=tr(ro,rd,np,bp,g);
	float t=s.x;	
    if(t>0.){
        vec3 po=ro+rd*t,no=normalize(e.xyy*mp(po+e.xyy,np,bp,g).x+e.yyx*mp(po+e.yyx,np,bp,g).x+e.yxy*mp(po+e.yxy,np,bp,g).x+e.xxx*mp(po+e.xxx,np,bp,g).x),
        al=vec3(1,0.05,0);
        float dif=max(0.,dot(no,ld)),
        aor=t/50.,ao=exp2(-2.*pow(max(0.,1.-mp(po+no*aor,np,bp,g).x/aor),2.)),
        fr=pow(1.+dot(no,rd),4.),
        spo=exp2(7.*texture(iChannel0,vec2(np.y,dot(np.xz,vec2(.7)))/vec2(16,20)).r);
        if(s.y<5.) al=vec3(0);
        if(s.y>5.) al=vec3(1);
        if(s.y>7.) {al=vec3(0.1,0.5,0.9);spo=exp2(7.*texture(iChannel0,vec2(bp.y,dot(bp.xz,vec2(.7)))/vec2(10,16)).r);}
        if(s.y>9.) {al=vec3(0);}
        if(s.y>10.) {al=vec3(1);}
        
        vec3 sss=vec3(1.5)*smoothstep(0.,1.,mp(po+ld*0.4,np,bp,g).x/0.4),
        sp=vec3(0.5)*pow(max(dot(reflect(-ld,no),-rd),0.),spo);
        co=mix(sp+al*(.8*ao+0.2)*(dif+sss),fo,fr);
        co=mix(co,fo,1.-exp(-.00004*t*t*t));
    }
    COLOR = vec4(pow(co+g*.3*vec3(.2,.3,.6),vec3(.45)),1);
}
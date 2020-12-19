shader_type canvas_item;

uniform vec2 size = vec2(1.);

void fragment(){
    vec2 r = vec2(1., 1.) * size;
    vec3 c;
    float l,z = TIME;
    for(int i=0;i<3;i++) {
        vec2 uv,p=UV.xy / r * size;
        uv=p;
        p-=.5;
        p.x*=r.x/r.y;
        z+=.07;
        l=length(p);
        uv+=p/l*(sin(z)+1.)*abs(sin(l*9.-z*2.));
        l *= mix(1., 0.1 * sin(z * l * 0.1) * 0.5 + 0.5, cos(z)* 0.5 + 0.5);
        if (i == 0)
        c.r=.01/length(abs(mod(uv,1.)-.5));
        if (i == 1)
        c.g=.01/length(abs(mod(uv,1.)-.5));
        if (i == 2)
        c.b=.01/length(abs(mod(uv,1.)-.5));
    }
    COLOR=vec4(c/l,1.);
}
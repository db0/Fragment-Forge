shader_type canvas_item;

uniform float speed_color1 = 1.0;
uniform float speed_color2 = 1.0;
uniform float speed_color3 = 0.3;
uniform int style = 0;
uniform float gdstime;

void fragment() {
	// color2 rotates clockwise
	float color1_t_x = sin(gdstime * speed_color1) / 2.0;
	float color1_t_y = cos(gdstime * speed_color1) / 2.0;
	float color1_time_x = abs(sin(gdstime * speed_color1));
	float color1_time_y = abs(cos(gdstime * speed_color1));
	vec2 st = UV;
	float color1_x = (st.x * color1_time_x / (1.0 + color1_time_x));
	float color1_y = (st.y * color1_time_y / (1.0 + color1_time_y));
	if (color1_t_x > 0.0){
	 color1_x = color1_t_x - color1_x;
	} else {
	 color1_x = color1_x;
	}
	if (color1_t_y > 0.0){
	 color1_y = color1_t_y - color1_y;
	} else {
	 color1_y = color1_y;
	}
	float color1 = color1_x + color1_y;
	// color2 rotates counter-clockwise
	float color2_t_x = cos(gdstime * speed_color2) / 2.0;
	float color2_t_y = sin(gdstime * speed_color2) / 2.0;
	float color2_time_x = abs(cos(gdstime * speed_color2));
	float color2_time_y = abs(sin(gdstime * speed_color2));
	float color2_x = (st.x * color2_time_x / (1.0 + color2_time_x));
	float color2_y = (st.y * color2_time_y / (1.0 + color2_time_y));
	if (color2_t_x > 0.0){
	 color2_x = color2_t_x - color2_x;
	} else {
	 color2_x = color2_x;
	}
	if (color2_t_y > 0.0){
	 color2_y = color2_t_y - color2_y;
	} else {
	 color2_y = color2_y;
	}
	float color2 = color2_x + color2_y;
	
	float color3_time = abs(sin(gdstime * speed_color3));
	float color3 = color3_time * 0.6;
	switch(style) {
		case 0: 
			COLOR = vec4(color1_time_x * color1,color2_time_x * color2,color3,1.0);
			break;
		case 1:
			COLOR = vec4(color3,color1_time_x * color1,color2_time_x * color2,1.0);
			break;
		case 2:
			COLOR = vec4(color2_time_x * color2,color3,color1_time_x * color1,1.0);
			break;
	}
}

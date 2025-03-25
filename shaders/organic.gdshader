shader_type spatial;

mat2 RM2D(float angle){
	float c = cos(angle);
	float s  = sin(angle);
	return mat2(vec2(c, -s), vec2(s, c));
}

void fragment() {
	vec2 n=vec2(0.0), q=vec2(0.0), u = vec2(UV - 0.5);
	float d = dot(u,u), s=8.0, t=TIME, o=0.0, j=0.0;
	//mat2 m = RM2D(5.0);
	for(mat2 m=RM2D(2.0); j++<20.0;){
		u = m*u;
		n = m*n;
		q = u*s+t*0.5+sin(t*4.0-d*6.0)*0.8+j+n;
		o += dot(cos(q)/s, vec2(2.0));
		n -= sin(q);
		s *= 1.2;
	}

	ALBEDO = vec3(o*0.5, 0.01, 0.0075);
}
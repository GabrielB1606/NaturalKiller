shader_type spatial;

uniform float animation_speed = 20.0;
uniform sampler2D albedo_texture: repeat_enable;
uniform float delta_time = 0.01666;

void fragment() {
	vec2 uv = vec2(20.0*UV.x+(TIME*animation_speed*delta_time), 3.0*UV.y);
	vec4 albedo_color = texture(albedo_texture, uv);
	vec3 final_color = albedo_color.rgb;
	final_color.r = final_color.r * 1.0;
	final_color.g = final_color.g * 0.125;
	final_color.b = final_color.b * 0.125;
	ALBEDO = final_color;
}

//void light() {
	// Called for every pixel for every light affecting the material.
	// Uncomment to replace the default light processing function with this one.
//}

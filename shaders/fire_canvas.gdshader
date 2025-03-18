shader_type canvas_item;

uniform float animation_speed = 0.5;
uniform float y_offset = 0.5;
uniform sampler2D noise_texture: hint_default_black, repeat_enable;
uniform vec3 flame_color: source_color = vec3(1.0);

void fragment() {
	vec2 uv = vec2(UV.x, UV.y+(TIME*animation_speed));
	vec4 noise_color = texture(noise_texture, uv);
	vec3 final_color = noise_color.rgb;
	final_color += vec3(UV.y - y_offset);
	final_color = step(final_color, vec3(0.5));
	final_color = vec3(1.0) - final_color;
	float a = final_color.r;
	final_color = flame_color;
	COLOR = vec4( final_color.r, final_color.g, final_color.b, a);
}

//void light() {
	// Called for every pixel for every light affecting the material.
	// Uncomment to replace the default light processing function with this one.
//}

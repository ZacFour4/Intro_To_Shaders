shader_type spatial;

uniform sampler2D noise_texture : source_color;

uniform float scroll_speed : hint_range(0.f, 1.f);
uniform float noise_scale : hint_range(0.f, 2.f);

uniform float scroll_speed2 : hint_range(0.f, 1.f);
uniform float noise_scale2 : hint_range(0.f, 2.f);

uniform float scroll_speed3 : hint_range(0.f, 1.f);
uniform float noise_scale3 : hint_range(0.f, 2.f);

void fragment() {
	vec2 shifted_uv = UV * noise_scale + vec2(.3f, .45f) * TIME * scroll_speed;
	vec2 shifted_uv2 = UV * noise_scale2 + vec2(-.3f, .45f) * TIME * scroll_speed2;
	vec2 shifted_uv3 = UV * noise_scale3 + vec2(-.05f, .15f) * TIME * scroll_speed3;

	vec3 noise_value =
		texture(noise_texture, shifted_uv).rgb * 
		texture(noise_texture, shifted_uv2).rgb *
		texture(noise_texture, shifted_uv3).rgb;

	ALBEDO = noise_value;
}

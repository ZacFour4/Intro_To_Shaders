shader_type spatial;

uniform sampler2D noise_texture : source_color;

uniform float scroll_speed : hint_range(0.f, 1.f);
uniform float noise_scale : hint_range(0.f, 2.f);

void fragment() {
	vec2 shifted_uv = UV * noise_scale + vec2(.3f, .45f) * TIME * scroll_speed;
	ALBEDO = texture(noise_texture, shifted_uv).rgb;
}


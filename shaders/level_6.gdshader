shader_type spatial;

uniform sampler2D noise_texture : source_color;

uniform float scroll_speed : hint_range(0.f, 1.f);
uniform float noise_scale : hint_range(0.f, 2.f);

uniform float scroll_speed2 : hint_range(0.f, 1.f);
uniform float noise_scale2 : hint_range(0.f, 2.f);

uniform vec4 dark_colour : source_color;
uniform vec4 light_colour : source_color;

void vertex() {
	VERTEX.y += sin(VERTEX.x + TIME);
}

void fragment() {
	vec2 shifted_uv = UV * noise_scale + vec2(.3f, .45f) * TIME * scroll_speed;
	vec2 shifted_uv2 = UV * noise_scale2 + vec2(-.3f, .45f) * TIME * scroll_speed2;

	float noise_value =
		texture(noise_texture, shifted_uv).r * 
		texture(noise_texture, shifted_uv2).r;
		
	vec3 out_colour = mix(dark_colour, light_colour, noise_value).rgb;

	ALBEDO = out_colour;
}

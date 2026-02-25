shader_type spatial;

uniform sampler2D noise_texture : source_color;

uniform float scroll_speed : hint_range(0.f, 1.f);
uniform float noise_scale : hint_range(0.f, 2.f);

uniform float scroll_speed2 : hint_range(0.f, 1.f);
uniform float noise_scale2 : hint_range(0.f, 2.f);

uniform vec4 colour : source_color;
uniform vec4 light_colour : source_color;
uniform vec4 dark_colour : source_color;

uniform float wave_height : hint_range(0.f, 1.f);
uniform float wave_speed : hint_range(0.f, 1.f);
uniform float wave_frequency : hint_range(0.f, 10.f);

uniform int wave_count : hint_range(1, 100);

uniform float foam_height : hint_range(-.25f, .25f);
uniform float depth_height : hint_range(-.25f, .25f);
uniform float smoothness : hint_range(0.f, .6f);

varying float height;

float rand(float val)
{
	return fract(sin(val + 234.235) * 34891.24359);
}

void vertex() {
	height = 0.f;
	float influence = wave_height;
	float frequency = wave_frequency;
	float speed = wave_speed;
	for (int octave = 0; octave < wave_count; ++octave)
	{
		vec2 direction = vec2(rand(float(octave)), rand(float(-octave)));
		height += sin(dot(VERTEX.xz, direction) * frequency + TIME * speed) * influence;
		influence *= 0.7f;
		frequency *= 1.25f;
		speed *= 1.5f;
	}

	VERTEX.y += height;
}

void fragment() {
	vec2 shifted_uv = UV * noise_scale + vec2(.3f, .45f) * TIME * scroll_speed;
	vec2 shifted_uv2 = UV * noise_scale2 + vec2(-.3f, .45f) * TIME * scroll_speed2;

	float noise_value =
		texture(noise_texture, shifted_uv).r *
		texture(noise_texture, shifted_uv2).r;

	float foam_mask = smoothstep(foam_height - smoothness, foam_height + smoothness, height);

	vec3 depth_colour = mix(dark_colour.rgb, vec3(1., 1., 1.), smoothstep(depth_height - smoothness, depth_height + smoothness, height));

	vec3 out_colour = mix(colour, light_colour, noise_value * foam_mask).rgb * depth_colour;

	ALBEDO = out_colour;
}
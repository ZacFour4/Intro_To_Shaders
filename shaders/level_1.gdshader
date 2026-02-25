shader_type spatial;

uniform sampler2D noise_texture : source_color;

void fragment() {
	ALBEDO = texture(noise_texture, UV).rgb;
}


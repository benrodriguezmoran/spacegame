shader_type sky;

uniform sampler2D source_panorama : filter_linear, source_color, hint_default_black;
uniform float cameraSaturation;
uniform sampler2D screen_texture : hint_screen_texture, repeat_disable, filter_nearest;

void sky() {
	COLOR = texture(source_panorama, SKY_COORDS).rgb * cameraSaturation;
}
void fragment() {
	
}
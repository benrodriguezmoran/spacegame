shader_type sky;

uniform sampler2D source_panorama : filter_linear, source_color, hint_default_black;
uniform float cameraSaturation : hint_range(0.0,1.0) = 1.0 ;

void sky() {
	COLOR = texture(source_panorama, SKY_COORDS).rgb * cameraSaturation;
}

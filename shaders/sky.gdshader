shader_type sky;
uniform sampler2D panorama;
void sky() {
	COLOR = texture(panorama, SKY_COORDS).rgb;
	ALPHA = 1.0;
}

shader_type sky;

uniform sampler2D source_panorama : filter_linear, source_color, hint_default_black;
uniform float cameraSaturation;
uniform sampler2D screen_texture : hint_screen_texture, repeat_disable, filter_nearest;
uniform float camSat = 1.0;
void sky() {

	//= texture(screen_texture, SCREEN_UV).r;
	COLOR = texture(source_panorama, SKY_COORDS).rgb * vec3(camSat,camSat,camSat+.5*camSat);
    //c.rgb = mix(vec3(0.0), c.rgb, 1);
    //c.rgb = mix(vec3(0.5), c.rgb, 1);
    //c.rgb = mix(vec3(dot(vec3(1.0), c.rgb) * 0.33333), c.rgb, 1);
}

shader_type spatial;
render_mode unshaded, cull_disabled, blend_mix;
uniform sampler2D depth_texture : hint_depth_texture, repeat_disable, filter_nearest;
uniform bool emission;
uniform float emissionMulti : hint_range(0.0,100.0);
uniform float alpha : hint_range(0.0,1.0) = 0.5;
uniform sampler2D color : source_color;
uniform float thrust : hint_range(0.0,1.0) = 1.0;
uniform float acceleration : hint_range(0.0, 10.0) = 0.00;
uniform float speed : hint_range(0.0, 10.0) = 5.0;
uniform float speed2 : hint_range(0.0, 10.0) = 5.0;
uniform float height = 1.0;
uniform sampler2D noise_texture;
uniform sampler2D noise_texture2;
uniform float tail_mult = 1.0;

void fragment() {
	vec4 noise1 = texture(noise_texture, vec2(pow(UV.y,2), 0.0) + TIME * speed);
	vec4 noise2 = texture(noise_texture, vec2(UV.y,UV.y) + TIME * speed2);
	ALPHA = clamp((UV.y *4.0 - (noise2.r * noise1.r) + texture(noise_texture, vec2(UV.x+mod(TIME,10.0),UV.x-mod(TIME,20.0))).r * 0.5) * thrust, 0.0, 1.0) * alpha ;
	ALBEDO = texture(color, UV.yy).rgb;
	if (emission == true)
		EMISSION = texture(color, UV).rgb*emissionMulti;
	float depth = textureLod(depth_texture, SCREEN_UV, 0.0).r;
    vec4 upos = INV_PROJECTION_MATRIX * vec4(SCREEN_UV * 2.0 - 1.0, depth, 1.0);
    vec3 pixel_position = upos.xyz / upos.w;
}
void vertex() {
	VERTEX.y += (VERTEX.y+height) * (VERTEX.y+height) * clamp(acceleration + 0.5 * thrust, 0.01, 10.0);
	if (VERTEX.y > height){
		VERTEX.y += texture(noise_texture2, UV + TIME * speed).r * clamp(acceleration, 1.0, 10.0) * tail_mult;
	}
}
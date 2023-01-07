shader_type canvas_item;

void fragment() {
	vec2 uv0 = UV - vec2(0.5);
	uv0 -= mod(uv0, 0.01);
	
	float a = atan(uv0.x, uv0.y);

	float s = 1.0 + 0.1 * sin(a * 3.0 + TIME) + 0.05 * sin(a * 10.0 - TIME * 2.0);

	uv0 = uv0 * s + vec2(0.5);

	COLOR = texture(TEXTURE, uv0);
}

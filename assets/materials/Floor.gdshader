//https://godotshaders.com/shader/quick-procedural-floor-tiles/

shader_type spatial;

uniform sampler2D noise_texture;
uniform float strenght = 0.0001;

uniform float tile_scale = 45.0;
uniform float grout_thickness : hint_range(0.0, 1.0) = 0.009;
uniform vec3 tile_color : source_color = vec3(1.0);
uniform vec3 grout_color : source_color = vec3(0.0);
uniform float roughness : hint_range(0.0, 1.0) = 0.2;
uniform float diamond_size : hint_range(0.0, 1.0) = 0.565;

varying vec4 world_pos;


void vertex() {
	world_pos = MODEL_MATRIX * vec4(VERTEX, 1.0) * strenght;
}

void fragment() {
	vec4 tex = texture(noise_texture, world_pos.xz);
	ALBEDO = tex.rgb;
	
	vec2 world_uv = vec2(world_pos.x, world_pos.z);
	world_uv = fract(world_uv * tile_scale);
	
	//Draw circles
	float c = distance(vec2(0.5), world_uv);
	c = 1.0 - step(diamond_size, c);
	
	//Draw vertical lines
	float vl1 = step(grout_thickness, world_uv.x);
	float vl2 = 1.0 - step(1.0 - grout_thickness, world_uv.x);
	
	//Draw horizontal lines
	float hl1 = step(grout_thickness, world_uv.y);
	float hl2 = 1.0 - step(1.0 - grout_thickness, world_uv.y);
	
	//Combine lines
	float lines = vl1 * vl2 * hl1 * hl2;
	
	//Create pattern mask
	float pattern_mask = clamp(lines * c , 0.0, 1.0);
	
	//Mix colors
	// vec3 color = mix(accent_color, vec3(1.0), accent_mask);
	vec3 color = mix(grout_color, tile_color, pattern_mask);
	//color = mix(color, tile_color, tile_mask);
	
	ALBEDO = color;
	ROUGHNESS = roughness;
}



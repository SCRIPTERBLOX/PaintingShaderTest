shader_type canvas_item;

uniform sampler2D screen_texture : hint_screen_texture, repeat_disable, filter_nearest;
uniform vec3[50] allowed_colors; // Array of allowed colors

vec4 get_pixel_color(vec2 uv) {return textureLod(screen_texture, uv, 0.0); }

float color_distance_squared(vec3 color_a, vec3 color_b) {
	return dot(color_a - color_b, color_a - color_b);
}

void fragment() {
	if (SCREEN_UV.x < 0.5) { // Pixel is in the left side
		vec4 current_color = get_pixel_color(SCREEN_UV);
		vec3 current_rgb = current_color.rgb;

		vec3 closest_allowed_color = vec3(0.0);
		float min_distance_sq = 1000000.0; // Initialize with a large value

		// Find the closest allowed color
		if (allowed_colors.length() > 0) {
			closest_allowed_color = allowed_colors[0]; // Initialize with the first color
			min_distance_sq = color_distance_squared(current_rgb, closest_allowed_color.rgb);

			for (int i = 1; i < allowed_colors.length(); ++i) {
				vec3 allowed = allowed_colors[i];
				float dist_sq = color_distance_squared(current_rgb, allowed.rgb);
				if (dist_sq < min_distance_sq) {
					min_distance_sq = dist_sq;
					closest_allowed_color = allowed;
				}
			}
			COLOR.rgb = closest_allowed_color; // Set the pixel color to the closest allowed color
		}
	} else {
		COLOR = get_pixel_color(SCREEN_UV); // Right side
	}
}
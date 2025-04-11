shader_type canvas_item;

uniform sampler2D screen_texture : hint_screen_texture, repeat_disable, filter_nearest;
uniform sampler2D shape_mask : repeat_disable, filter_linear;
uniform int diagonal_square_radius = 0;

vec4 get_pixel_color(vec2 uv) {return textureLod(screen_texture, uv, 0.0);}
float randf (vec2 st) {return fract(sin(dot(st.xy, vec2(12.9898,78.233)))*43758.5453123);}

void fragment() {
	if (SCREEN_UV.r < 0.5) { // Pixel is inside the shape (white area)
		vec4 this_color = get_pixel_color(SCREEN_UV);

		vec4[] colors = {this_color};

		vec2 start_pos = SCREEN_UV - vec2(float(-diagonal_square_radius), float(-diagonal_square_radius));

		for (int x = 0; x < diagonal_square_radius*2; x++) {
			for (int y = 0; y < diagonal_square_radius*2; y++) {
				vec2 pixel_position = vec2(float(x), float(y));
				vec4 col = get_pixel_color(pixel_position);

				float col_r = col.r;
				float col_g = col.g;
				float col_b = col.b;

				vec4 total_col;

				for (int i = 0; i < colors.length(); i++) {
					total_col += colors[i];
				}

				vec4 average_col = vec4(total_col.r / float(colors.length()), total_col.g / float(colors.length()), total_col.b / float(colors.length()), 1);

				COLOR = average_col;
			}
		}
	} else {COLOR = get_pixel_color(SCREEN_UV); /* Left side */}
}
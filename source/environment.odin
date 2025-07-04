package forest

import "core:fmt"
import "core:math"
import rl "vendor:raylib"

env: Environment

Environment :: struct {
	frame_time:    f32,
	fps:           i32,
	window_size:   [2]i32,
}

//Updates variables needed for drawing current frame
update_environment :: proc() {
	env.frame_time = rl.GetFrameTime()
	env.fps = i32(math.ceil_f32(1 / env.frame_time))
	env.window_size = {rl.GetRenderWidth(), rl.GetRenderHeight()}
}


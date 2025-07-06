package forest

import sa "core:container/small_array"
import "core:fmt"
import rl "vendor:raylib"

run: bool
back_color := rl.Color{49, 124, 100, 255}
trees: sa.Small_Array(30, Branch) //container for all current and future trees
world_seed: i32 = 0
world_step: i32 = 0
debug_mode: bool = true
rng: PCG32

//Initializes the program
init :: proc() {
	run = true

	rl.SetConfigFlags({.VSYNC_HINT, .WINDOW_RESIZABLE, .WINDOW_MAXIMIZED})
	rl.SetTargetFPS(60)
	rl.InitWindow(800, 600, "Forest")
	rl.MaximizeWindow()

	generate_world()
}

//Updates and draws everything each frame
update :: proc() {

	env := get_environment_data()

	draw(env)

	free_all(context.temp_allocator)
}

//Draws current frame
draw :: proc(env: Environment) {
	rl.BeginDrawing()
	rl.ClearBackground(back_color)

	if debug_mode {draw_debug(env)}

	rl.EndDrawing()
}

//(re)generates the entire forest based on specified parameters
generate_world :: proc() {
	rng: PCG32 = pcg32_init(u64(world_seed))
}


should_run :: proc() -> bool {
	when ODIN_OS != .JS {
		if rl.WindowShouldClose() {
			run = false
		}
	}

	return run
}

shutdown :: proc() {
	rl.CloseWindow()
}

parent_window_size_changed :: proc(w, h: int) {
	// 	rl.SetWindowSize(c.int(w), c.int(h))
}


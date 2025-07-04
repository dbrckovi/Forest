package forest

import "core:fmt"
import rl "vendor:raylib"

run: bool
back_color := rl.Color{49, 124, 100, 255}

//Initializes the program
init :: proc() {
	run = true

	rl.SetConfigFlags({.VSYNC_HINT, .WINDOW_RESIZABLE, .WINDOW_MAXIMIZED})
	rl.SetTargetFPS(60)
	rl.InitWindow(800, 600, "Forest")
	rl.MaximizeWindow()
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

	draw_debug(env)

	rl.EndDrawing()
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


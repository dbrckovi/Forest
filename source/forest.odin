package forest

import "core:fmt"
import rl "vendor:raylib"

run: bool
back_color := rl.Color{49, 124, 100, 255}
debug_back_color := rl.Color{22, 22, 22, 155}
debug_fore_color := rl.Color{255, 255, 255, 150}

init :: proc() {
	run = true

	rl.SetConfigFlags({.VSYNC_HINT, .WINDOW_RESIZABLE, .WINDOW_MAXIMIZED})
	rl.SetTargetFPS(60)
	rl.InitWindow(800, 600, "Forest")
	rl.MaximizeWindow()
}

update :: proc() {

	update_environment()

	draw()

	free_all(context.temp_allocator)
}


draw :: proc() {
	rl.BeginDrawing()
	rl.ClearBackground(back_color)


	//draw debug section
	rl.DrawRectangle(
		0,
		env.window_size.y - 40,
		env.window_size.x,
		env.window_size.y,
		debug_back_color,
	)

	message: cstring = fmt.ctprint("Size: ", env.window_size, ", Fps:", env.fps)

	rl.DrawText(message, 5, env.window_size.y - 35, 30, debug_fore_color)

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


package forest

import "core:fmt"
import rl "vendor:raylib"

run: bool
back_color := rl.Color{49, 124, 100, 255}

init :: proc() {
	run = true

	rl.SetConfigFlags({.VSYNC_HINT, .WINDOW_RESIZABLE, .WINDOW_MAXIMIZED})
	rl.SetTargetFPS(60)
	rl.InitWindow(800, 600, "Forest")
	rl.MaximizeWindow()
}

update :: proc() {
	frame_time := rl.GetFrameTime()
	rl.BeginDrawing()
	rl.ClearBackground(back_color)

	fps := 1 / frame_time
	rl.DrawText(fmt.ctprint(fps), 10, 10, 60, rl.WHITE)

	rl.EndDrawing()

	// Anything allocated using temp allocator is invalid after this.
	free_all(context.temp_allocator)
}

should_run :: proc() -> bool {
	when ODIN_OS != .JS {
		// Never run this proc in browser. It contains a 16 ms sleep on web!
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


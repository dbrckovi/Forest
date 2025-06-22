// These procs are the ones that will be called from `index.html`, which is
// generated from `index_template.html`.

package main_web

import forest ".."
import "base:runtime"
import "core:c"
import "core:mem"

@(private = "file")
web_context: runtime.Context

@(export)
main_start :: proc "c" () {
	context = runtime.default_context()

	context.allocator = emscripten_allocator()
	runtime.init_global_temporary_allocator(1 * mem.Megabyte)

	context.logger = create_emscripten_logger()
	web_context = context

	forest.init()
}

@(export)
main_update :: proc "c" () -> bool {
	context = web_context
	forest.update()
	return forest.should_run()
}

@(export)
main_end :: proc "c" () {
	context = web_context
	forest.shutdown()
}

@(export)
web_window_size_changed :: proc "c" (w: c.int, h: c.int) {
	context = web_context
	forest.parent_window_size_changed(int(w), int(h))
}


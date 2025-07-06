package forest

Branch :: struct {
	//Pointer to a parent branch. Branch without a parent is a trunk and grows from ground
	parent:          ^Branch,
	//Point (percentage) along the parent branch length where this branch starts from
	start_point:     f32,
	//World step when this branch was created. Used for calculating length, thickness, etc
	created_at_step: i32,
	//angle relative to parent at which this branch grows (0 means it's growing in the same direction as parent)
	parent_angle:    f32,
}


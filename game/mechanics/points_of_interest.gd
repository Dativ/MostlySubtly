class_name PointsOfInterest extends Node3D


var points: Dictionary 

func _ready() -> void:
	for point in get_children():
		if point is PointOfInterest:
			if not points.has(point.type):
				points[point.type] = []
			points[point.type].append(point)
			

func get_random_point() -> PointOfInterest:
	return points[points.keys().pick_random()].pick_random()

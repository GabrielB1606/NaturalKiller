class_name ParticleGroup
extends Node3D

func emit() -> void:
	for node in get_children():
		if node is GPUParticles3D:
			node.restart()

func stop() -> void:
	for node in get_children():
		if node is GPUParticles3D:
			node.emitting = false

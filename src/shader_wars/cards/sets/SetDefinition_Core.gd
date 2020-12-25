# This file contains just card definitions. See also `CardConfig.gd`

extends Reference

const SET = "Core Set"
const CARDS := {
	"Circle Shader": {
		"Type": "Shader",
		"Tags": [],
		"Abilities": "Create them circles",
		"Time": 0,
		"Value": 1,
		"skill_req": 0,
		"cred_req": 0,
		"motivation_req": 0,
	},
	"Advanced Shader": {
		"Type": "Shader",
		"Tags": [],
		"Abilities": "Some tricky stuff",
		"Time": 1,
		"Value": 2,
		"skill_req": 1,
		"cred_req": 0,
		"motivation_req": 0,
	},
}

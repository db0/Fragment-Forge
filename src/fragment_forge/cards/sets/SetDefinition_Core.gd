# This file contains just card definitions. See also `CardConfig.gd`
extends Reference



const SET = "Core Set"
const CARDS := {
### BEGIN Shaders ###
	"Simple Colours": {
		"Type": CardConfig.CardTypes.SHADER,
		"Tags": [],
		"Abilities": " ",
		"Time": 0,
		"Value": 1,
		"Kudos": 0,
		"skill_req": 0,
		"cred_req": 0,
		"motivation_req": 0,
	},
	"Fractal Tiling": {
		"Type": CardConfig.CardTypes.SHADER,
		"Tags": [],
		"Abilities": "TODO",
		"Time": 1,
		"Value": 0,
		"Kudos": 0,
		"skill_req": 0,
		"cred_req": 0,
		"motivation_req": 0,
	},
	"Sierpinski": {
		"Type": CardConfig.CardTypes.SHADER,
		"Tags": [],
		"Abilities": "TODO",
		"Time": 1,
		"Value": 0,
		"Kudos": 0,
		"skill_req": 1,
		"cred_req": 0,
		"motivation_req": 0,
	},
	"Light": {
		"Type": CardConfig.CardTypes.SHADER,
		"Tags": [],
		"Abilities": " ",
		"Time": 2,
		"Value": 3,
		"Kudos": 0,
		"skill_req": 0,
		"cred_req": 0,
		"motivation_req": 0,
	},
	"Twister": {
		"Type": CardConfig.CardTypes.SHADER,
		"Tags": [],
		"Abilities": " ",
		"Time": 5,
		"Value": 6,
		"Kudos": 0,
		"skill_req": 0,
		"cred_req": 0,
		"motivation_req": 0,
	},
	"Fractal Pyramid": {
		"Type": CardConfig.CardTypes.SHADER,
		"Tags": [],
		"Abilities": " ",
		"Time": 1,
		"Value": 4,
		"Kudos": 0,
		"skill_req": 1,
		"cred_req": 0,
		"motivation_req": 0,
	},
	"Mandelbrot": {
		"Type": CardConfig.CardTypes.SHADER,
		"Tags": [],
		"Abilities": " ",
		"Time": 2,
		"Value": 5,
		"Kudos": 0,
		"skill_req": 1,
		"cred_req": 0,
		"motivation_req": 0,
	},
	"Cloud": {
		"Type": CardConfig.CardTypes.SHADER,
		"Tags": [],
		"Abilities": " ",
		"Time": 1,
		"Value": 6,
		"Kudos": 0,
		"skill_req": 2,
		"cred_req": 0,
		"motivation_req": 0,
	},
	"Strings": {
		"Type": CardConfig.CardTypes.SHADER,
		"Tags": [],
		"Abilities": " ",
		"Time": 4,
		"Value": 9,
		"Kudos": 0,
		"skill_req": 2,
		"cred_req": 0,
		"motivation_req": 0,
	},
	"Voronoi Column Tracing": {
		"Type": CardConfig.CardTypes.SHADER,
		"Tags": [],
		"Abilities": "After you play this card, draw a card.",
		"Time": 6,
		"Value": 10,
		"Kudos": 0,
		"skill_req": 2,
		"cred_req": 0,
		"motivation_req": 0,
	},
	"Seascape": {
		"Type": CardConfig.CardTypes.SHADER,
		"Tags": [],
		"Abilities": " ",
		"Time": 2,
		"Value": 10,
		"Kudos": 0,
		"skill_req": 3,
		"cred_req": 0,
		"motivation_req": 0,
	},
### BEGIN Resources ###
	"Newbie Tutor": {
		"Type": CardConfig.CardTypes.RESOURCE,
		"Tags": ["Tutor"],
		"Abilities": "If you have 0 skill, you are considered to have 1 skill "\
				+ "for shaders with skill_req 1.",
		"Time": 1,
		"Value": 0,
		"Kudos": 0,
		"skill_req": 0,
		"cred_req": 0,
		"motivation_req": 0,
	},
	"Cheerleader": {
		"Type": CardConfig.CardTypes.RESOURCE,
		"Tags": ["Collaborator"],
		"Abilities": "After recruiting this tutor, lose 1 cred. " \
				+ "You win extra 1 cred for winning a tournament",
		"Time": 1,
		"Value": 2,
		"Kudos": 0,
		"skill_req": 0,
		"cred_req": 1,
		"motivation_req": 4,
	},
	"Guru": {
		"Type": CardConfig.CardTypes.RESOURCE,
		"Tags": ["Tutor"],
		"Abilities": "All skill_req 4+ shaders are reduced by 1",
		"Time": 2,
		"Value": 0,
		"Kudos": 0,
		"skill_req": 3,
		"cred_req": 4,
		"motivation_req": 0,
	},
	"Chiptunes Musician": {
		"Type": CardConfig.CardTypes.RESOURCE,
		"Tags": ["Collaborator"],
		"Abilities": "Increase the value of your Demo this round by 5.\n"\
				+ "Discard after this round ends",
		"Time": 1,
		"Value": 0,
		"Kudos": 4,
		"skill_req": 0,
		"cred_req": 1,
		"motivation_req": 0,
	},
	"Graphics Artist": {
		"Type": CardConfig.CardTypes.RESOURCE,
		"Tags": ["Collaborator"],
		"Abilities": "If you use at least 2 shaders of skill_req 1, "\
				+ "increase your Demo value by 4.\n"\
				+ "Discard after this competition ends",
		"Time": 1,
		"Value": 0,
		"Kudos": 1,
		"skill_req": 0,
		"cred_req": 2,
		"motivation_req": 0,
	},
	"Git": {
		"Type": CardConfig.CardTypes.RESOURCE,
		"Tags": ["Knowledge"],
		"Abilities": "Events that make you lose time, make you lose 1 less time. "\
				+ "After you add the fourth shader to your demo, gain 1 time.",
		"Time": 1,
		"Value": 0,
		"Kudos": 0,
		"skill_req": 0,
		"cred_req": 0,
		"motivation_req": 0,
	},
	"Discord Mod": {
		"Type": CardConfig.CardTypes.RESOURCE,
		"Tags": ["Volunteering"],
		"Abilities": "Comes into the game with 12 Kudos tokens\n\n"\
				+ "1 Time: Take 2 Kudos tokens from this card. "\
				+ "When it has no more kudos tokens, discard it.",
		"Time": 1,
		"Value": 0,
		"Kudos": 0,
		"skill_req": 0,
		"cred_req": 1,
		"motivation_req": 4,
	},
	"Private Forum Mod": {
		"Type": CardConfig.CardTypes.RESOURCE,
		"Tags": ["Volunteering"],
		"Abilities": "Pay 1 Time: Draw 1 card and gain 1 Kudos",
		"Time": 1,
		"Value": 0,
		"Kudos": 3,
		"skill_req": 0,
		"cred_req": 3,
		"motivation_req": 0,
	},
	"Hacking Buddy": {
		"Type": CardConfig.CardTypes.RESOURCE,
		"Tags": ["Collaborator", "Unique"],
		"Abilities": "Reduce the time cost of all Shaders by 1.\n"\
				+ "Discard after this competition ends",
		"Time": 0,
		"Value": 0,
		"Kudos": 5,
		"skill_req": 0,
		"cred_req": 0,
		"motivation_req": 0,
	},
	"Search Engine Expertise": {
		"Type": CardConfig.CardTypes.RESOURCE,
		"Tags": ["Knowledge"],
		"Abilities": "Once per Competition, you may look "\
				+ "at the top card of the deck\n\n"\
				+ "Discard this card: Draw one card",
		"Time": 1,
		"Value": 0,
		"Kudos": 0,
		"skill_req": 0,
		"cred_req": 0,
		"motivation_req": 0,
	},	
### BEGIN Prep ###
	"Get Some Advice": {
		"Type": CardConfig.CardTypes.ACTION,
		"Tags": [],
		"Abilities": "Play a Shader as if you had +1 skill",
		"Time": 0,
		"Value": 0,
		"Kudos": 0,
		"skill_req": 0,
		"cred_req": 0,
		"motivation_req": 0,
	},
	"Google-Fu!": {
		"Type": CardConfig.CardTypes.ACTION,
		"Tags": [],
		"Abilities": "Draw 3 cards",
		"Time": 1,
		"Value": 0,
		"Kudos": 0,
		"skill_req": 0,
		"cred_req": 0,
		"motivation_req": 5,
	},
	"Post Some Progress": {
		"Type": CardConfig.CardTypes.ACTION,
		"Tags": [],
		"Abilities": "Gain 1 Cred",
		"Time": 1,
		"Value": 0,
		"Kudos": 0,
		"skill_req": 0,
		"cred_req": 0,
		"motivation_req": 0,
	},
	"Help out Some Newbs": {
		"Type": CardConfig.CardTypes.ACTION,
		"Tags": [],
		"Abilities": "Gain 5 Kudos",
		"Time": 1,
		"Value": 0,
		"Kudos": 0,
		"skill_req": 1,
		"cred_req": 0,
		"motivation_req": 0,
	},
	"Social Networking": {
		"Type": CardConfig.CardTypes.ACTION,
		"Tags": [],
		"Abilities": "Discard a Tutor, Collaborator, or Volunteering Resource"\
				+ " from hand or board to gain 1 Cred and 2 Kudos.\n\n"\
				+ "If the Resource was installed, gain 3 more Kudos.",
		"Time": 1,
		"Value": 0,
		"Kudos": 0,
		"skill_req": 0,
		"cred_req": 0,
		"motivation_req": 5,
	},
}

# Ideas
# Prep: Found out what the next tournament is
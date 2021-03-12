# This file contains just card definitions. See also `CardConfig.gd`
extends Reference


const GEN = -1
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
		"_illustration": "Db0",
		"_affinity": "NEUTRAL",
	},
	"Fractal Tiling": {
		"Type": CardConfig.CardTypes.SHADER,
		"Tags": [],
		"Abilities": "After you install this Shader, discard a random card",
		"Time": 2,
		"Value": GEN,
		"Kudos": 0,
		"skill_req": 0,
		"cred_req": 0,
		"motivation_req": 0,
		"_abilities_power": -2,
		"_illustration": "Inigo Quilez",
		"_affinity": "NEUTRAL",
	},
	"Light": {
		"Type": CardConfig.CardTypes.SHADER,
		"Tags": [],
		"Abilities": " ",
		"Time": 3,
		"Value": GEN,
		"Kudos": 0,
		"skill_req": 0,
		"cred_req": 0,
		"motivation_req": 0,
		"_illustration": "Danilo Guanabara",
		"_affinity": "NEUTRAL",
	},
	"Twister": {
		"Type": CardConfig.CardTypes.SHADER,
		"Tags": [],
		"Abilities": " ",
		"Time": 5,
		"Value": GEN,
		"Kudos": 0,
		"skill_req": 0,
		"cred_req": 0,
		"motivation_req": 0,
		"_illustration": "Inigo Quilez",
		"_affinity": "NEUTRAL",
	},
	"Ether": {
		"Type": CardConfig.CardTypes.SHADER,
		"Tags": [],
		"Abilities": "After installing this Shader, "\
				+ "search your deck for the first Collaborator "\
				+ "and put them in your hand",
		"Time": 6,
		"Value": GEN,
		"Kudos": 0,
		"skill_req": 0,
		"cred_req": 0,
		"motivation_req": 4,
		"_abilities_power": 3,
		"_illustration": "nimitz",
		"_affinity": "ART",
	},
	"Matrix": {
		"Type": CardConfig.CardTypes.SHADER,
		"Tags": [],
		"Abilities": "You cannot play this shader, "\
				+ " if you have another Shader installed",
		"Time": 2,
		"Value": GEN,
		"Kudos": 0,
		"skill_req": 0,
		"cred_req": 0,
		"motivation_req": 0,
		"_abilities_power": -2,
		"_illustration": "Otavio Good",
		"_affinity": "ART",
	},
	"Runes": {
		"Type": CardConfig.CardTypes.SHADER,
		"Tags": ["Restricted"],
		"Abilities": "After you install another Shader "\
				+ "install this Shader from your discard pile "\
				+ "without paying any costs.",
		"Time": 2,
		"Value": GEN,
		"Kudos": 0,
		"skill_req": 0,
		"cred_req": 0,
		"motivation_req": 0,
		"_abilities_power": 2,
		"_max_allowed": 1,
		"_illustration": "Otavio Good",
		"_affinity": "ZIP",
	},
	"Liquid Bubbles": {
		"Type": CardConfig.CardTypes.SHADER,
		"Tags": [],
		"Abilities": "If this is the first card you play this turn, "\
				+ "increase its value by 2 ",
		"Time": 4,
		"Value": GEN,
		"Kudos": 0,
		"skill_req": 0,
		"cred_req": 0,
		"motivation_req": 4,
		"_abilities_power": 1,
		"_illustration": "Inigo Quilez & Weyland",
		"_affinity": "WIN",
	},
	"Barberella": {
		"Type": CardConfig.CardTypes.SHADER,
		"Tags": [],
		"Abilities": "After you play another Shader "\
				+ "reduce this card's value by 2 ",
		"Time": 5,
		"Value": GEN,
		"Kudos": 0,
		"skill_req": 0,
		"cred_req": 0,
		"motivation_req": 4,
		"_abilities_power": -2,
		"_illustration": "Weyland",
		"_affinity": "ZIP",
	},
#### skill_req 1
	"Fractal Pyramid": {
		"Type": CardConfig.CardTypes.SHADER,
		"Tags": [],
		"Abilities": " ",
		"Time": 1,
		"Value": GEN,
		"Kudos": 0,
		"skill_req": 1,
		"cred_req": 0,
		"motivation_req": 0,
		"_illustration": "bradjamesgrant",
		"_affinity": "NEUTRAL",
	},
	"Pentagonal Tesselations": {
		"Type": CardConfig.CardTypes.SHADER,
		"Tags": [],
		"Abilities": " ",
		"Time": 6,
		"Value": GEN,
		"Kudos": 0,
		"skill_req": 1,
		"cred_req": 0,
		"motivation_req": 0,
		"_illustration": "Matthew Arcus",
		"_affinity": "NEUTRAL",
	},
	"Sierpinski": {
		"Type": CardConfig.CardTypes.SHADER,
		"Tags": [],
		"Abilities": "Comes with 1 Activation token\n"\
				+ "After you install a shader, remove an activation token "\
				+ "to give that Shader +3 Value",
		"Time": 4,
		"Value": GEN,
		"Kudos": 0,
		"skill_req": 1,
		"cred_req": 0,
		"motivation_req": 0,
		"_abilities_power": 3,
		"_illustration": "Inigo Quilez",
		"_affinity": "WIN",
	},
	"Plasma Globe": {
		"Type": CardConfig.CardTypes.SHADER,
		"Tags": ["Burnout"],
		"Abilities": "After you install this shader, lose 1 motivation",
		"Time": 1,
		"Value": GEN,
		"Kudos": 0,
		"skill_req": 1,
		"cred_req": 0,
		"motivation_req": 0,
		"_abilities_power": -3,
		"_illustration": "nmz",
		"_affinity": "ZIP",
	},
	"Noise Pulse": {
		"Type": CardConfig.CardTypes.SHADER,
		"Tags": [],
		"Abilities": "After you install a Collaborator or Tutor, "\
				+ "increase this Shader's value by 1",
		"Time": 4,
		"Value": GEN,
		"Kudos": 0,
		"skill_req": 1,
		"cred_req": 0,
		"motivation_req": 0,
		"_abilities_power": 1,
		"_illustration": "nmz",
		"_affinity": "WIN",
	},
	"Apollonian": {
		"Type": CardConfig.CardTypes.SHADER,
		"Tags": [],
		"Abilities": "2 Time, Exhaust: Increase this Shader's value by 3",
		"Time": 3,
		"Value": GEN,
		"Kudos": 0,
		"skill_req": 1,
		"cred_req": 0,
		"motivation_req": 0,
		"_abilities_power": 1,
		"_illustration": "Matthew Arcus",
		"_affinity": "WIN",
	},
	"Mandelbrot": {
		"Type": CardConfig.CardTypes.SHADER,
		"Tags": ["Burnout"],
		"Abilities": "If you do not take first place while this shader is installed "\
				+ "lose 1 motivation.",
		"Time": 6,
		"Value": GEN,
		"Kudos": 0,
		"skill_req": 1,
		"cred_req": 0,
		"motivation_req": 0,
		"_abilities_power": -4,
		"_illustration": "Inigo Quilez",
		"_affinity": "ZIP",
	},
	"Topologica": {
		"Type": CardConfig.CardTypes.SHADER,
		"Tags": [],
		"Abilities": "If you take first place while this shader is installed "\
				+ "gain 1 motivation.",
		"Time": 6,
		"Value": GEN,
		"Kudos": 0,
		"skill_req": 1,
		"cred_req": 0,
		"motivation_req": 0,
		"_abilities_power": 2,
		"_illustration": "Otavio Good",
		"_affinity": "WIN",
	},
	"Sculpture": {
		"Type": CardConfig.CardTypes.SHADER,
		"Tags": ["Obscure"],
		"Abilities": "If you draw this card using a card effect, "\
				+ "it is immediately discarded.",
		"Time": 3,
		"Value": GEN,
		"Kudos": 0,
		"skill_req": 1,
		"cred_req": 0,
		"motivation_req": 0,
		"_abilities_power": -2,
		"_illustration": "Inigo Quilez",
		"_affinity": "ART",
	},
#### skill_req 2
	"Cloud": {
		"Type": CardConfig.CardTypes.SHADER,
		"Tags": [],
		"Abilities": " ",
		"Time": 4,
		"Value": GEN,
		"Kudos": 0,
		"skill_req": 2,
		"cred_req": 0,
		"motivation_req": 0,
		"_illustration": "nmz",
		"_affinity": "NEUTRAL",
	},
	"Strings": {
		"Type": CardConfig.CardTypes.SHADER,
		"Tags": [],
		"Abilities": " ",
		"Time": 6,
		"Value": GEN,
		"Kudos": 0,
		"skill_req": 2,
		"cred_req": 0,
		"motivation_req": 0,
		"_illustration": "Inigo Quilez",
		"_affinity": "NEUTRAL",
	},
	"Voronoi Column Tracing": {
		"Type": CardConfig.CardTypes.SHADER,
		"Tags": [],
		"Abilities": "After you install this Shader, draw a card.",
		"Time": 9,
		"Value": GEN,
		"Kudos": 0,
		"skill_req": 2,
		"cred_req": 0,
		"motivation_req": 0,
		"_abilities_power": 1,
		"_illustration": "Tomasz Dobrowolski",
		"_affinity": "WIN",
	},
	"Xod": {
		"Type": CardConfig.CardTypes.SHADER,
		"Tags": [],
		"Abilities": "After you install this Shader, discard an installed Shader",
		"Time": 1,
		"Value": GEN,
		"Kudos": 0,
		"skill_req": 2,
		"cred_req": 0,
		"motivation_req": 0,
		"_abilities_power": -4,
		"_illustration": "evvvvil",
		"_affinity": "ZIP",
	},
	"Spine": {
		"Type": CardConfig.CardTypes.SHADER,
		"Tags": [],
		"Abilities": "This Shader has -1 value for each Shader in your demo",
		"Time": 5,
		"Value": GEN,
		"Kudos": 0,
		"skill_req": 2,
		"cred_req": 0,
		"motivation_req": 0,
		"_abilities_power": -4,
		"_illustration": "evvvvil",
		"_affinity": "ZIP",
	},
	"Lanterns": {
		"Type": CardConfig.CardTypes.SHADER,
		"Tags": [],
		"Abilities": "After installing this Shader, unexhaust "\
				+ "a Collaborator or Tutor",
		"Time": 3,
		"Value": GEN,
		"Kudos": 0,
		"skill_req": 2,
		"cred_req": 0,
		"motivation_req": 0,
		"_abilities_power": 1,
		"_illustration": "Inigo Quilez",
		"_affinity": "WIN",
	},
	"Ininite Shader": {
		"Type": CardConfig.CardTypes.SHADER,
		"Tags": [],
		"Abilities": "After installing this Shader, lose all remaining time",
		"Time": 3,
		"Value": GEN,
		"Kudos": 0,
		"skill_req": 2,
		"cred_req": 0,
		"motivation_req": 4,
		"_abilities_power": -3,
#		"_illustration": "Inigo Quilez",
		"_affinity": "ART",
	},
#### skill_req 3+
	"Seascape": {
		"Type": CardConfig.CardTypes.SHADER,
		"Tags": [],
		"Abilities": " ",
		"Time": 5,
		"Value": GEN,
		"Kudos": 0,
		"skill_req": 3,
		"cred_req": 0,
		"motivation_req": 0,
		"_illustration": "Alexander Alekseev",
		"_affinity": "NEUTRAL",
	},
	"Flux Core": {
		"Type": CardConfig.CardTypes.SHADER,
		"Tags": [],
		"Abilities": "Reduce this shader's skill_req by the amount of "\
				+ "installed Tutors",
		"Time": 4,
		"Value": GEN,
		"Kudos": 0,
		"skill_req": 5,
		"cred_req": 0,
		"motivation_req": 0,
		"_illustration": "Otavio Good",
		"_affinity": "ZIP",
	},
### BEGIN Resources ###
	"Difios": {
		"Type": CardConfig.CardTypes.RESOURCE,
		"Tags": ["Tutor"],
		"Abilities": "You have +1 skill for Shaders of 1 skill_req or lower.",
		"Time": 2,
		"Value": 0,
		"Kudos": 0,
		"skill_req": 0,
		"cred_req": 0,
		"motivation_req": 0,
		"_illustration": "Artbreeder",
		"_affinity": "ART",
	},
	"Cheerleader": {
		"Type": CardConfig.CardTypes.RESOURCE,
		"Tags": [],
		"Abilities": "After recruiting this Resource, lose 1 cred. " \
				+ "You win extra 1 cred for winning a tournament",
		"Time": 1,
		"Value": 0,
		"Kudos": 0,
		"skill_req": 0,
		"cred_req": 1,
		"motivation_req": 5,
		"_illustration": "Artbreeder",
		"_affinity": "WIN",
	},
	"Guru": {
		"Type": CardConfig.CardTypes.RESOURCE,
		"Tags": ["Tutor"],
		"Abilities": "You have +1 skill for shader of 2 skill_req or higher.",
		"Time": 1,
		"Value": 0,
		"Kudos": 0,
		"skill_req": 3,
		"cred_req": 4,
		"motivation_req": 0,
		"_illustration": "Artbreeder",
		"_affinity": "ZIP",
	},
	"Echo": {
		"Type": CardConfig.CardTypes.RESOURCE,
		"Tags": ["Tutor"],
		"Abilities": "1 Time, Exhaust: Increase the value of "\
				+ "one of your installed Shaders by 2",
		"Time": 1,
		"Value": 0,
		"Kudos": 2,
		"skill_req": 0,
		"cred_req": 0,
		"motivation_req": 0,
		"_illustration": "Artbreeder",
		"_affinity": "NEUTRAL",
	},
	"Zhee": {
		"Type": CardConfig.CardTypes.RESOURCE,
		"Tags": ["Collaborator"],
		"Abilities": "Increase the value of your Demo this round by 5.\n",
		"Time": 1,
		"Value": 0,
		"Kudos": 4,
		"skill_req": 0,
		"cred_req": 1,
		"motivation_req": 0,
		"_illustration": "Artbreeder",
		"_affinity": "NEUTRAL",
	},
	"Hardcode": {
		"Type": CardConfig.CardTypes.RESOURCE,
		"Tags": ["Contact"],
		"Abilities": "Whenever you play a Shader with higher skill_req "\
				+ "than your Skill, gain 1 Time",
		"Time": 1,
		"Value": 0,
		"Kudos": 4,
		"skill_req": 0,
		"cred_req": 1,
		"motivation_req": 0,
		"_illustration": "Artbreeder",
		"_affinity": "ZIP",
	},
	"Vectornator": {
		"Type": CardConfig.CardTypes.RESOURCE,
		"Tags": ["Collaborator"],
		"Abilities": "If you use at least 2 shaders of skill_req 1, "\
				+ "increase your Demo value by 4.",
		"Time": 1,
		"Value": 0,
		"Kudos": 1,
		"skill_req": 0,
		"cred_req": 2,
		"motivation_req": 0,
		"_illustration": "Artbreeder",
		"_affinity": "WIN",
	},
	"A3sop": {
		"Type": CardConfig.CardTypes.RESOURCE,
		"Tags": ["Contact"],
		"Abilities": "Exhaust, return an installed Shader to your hand: "\
				+ "Gain an amount of Time equal its Time cost",
		"Time": 1,
		"Value": 0,
		"Kudos": 3,
		"skill_req": 0,
		"cred_req": 0,
		"motivation_req": 5,
		"_illustration": "Artbreeder",
		"_affinity": "NEUTRAL",
	},
	"Git": {
		"Type": CardConfig.CardTypes.RESOURCE,
		"Tags": ["Knowledge"],
		"Abilities": "Events that make you lose time, make you lose 1 less time. "\
				+ "After you add the fourth shader to your demo, draw a card.",
		"Time": 1,
		"Value": 0,
		"Kudos": 0,
		"skill_req": 0,
		"cred_req": 0,
		"motivation_req": 0,
		"_affinity": "NEUTRAL",
	},
	"Discord Mod": {
		"Type": CardConfig.CardTypes.RESOURCE,
		"Tags": ["Community"],
		"Abilities": "Comes into the game with 12 Kudos tokens\n"\
				+ "1 Time: Take 2 Kudos tokens from this card. "\
				+ "When it has no more kudos tokens, discard it.",
		"Time": 1,
		"Value": 0,
		"Kudos": 0,
		"skill_req": 0,
		"cred_req": 0,
		"motivation_req": 4,
		"_affinity": "NEUTRAL",
	},
	"Private Forum Mod": {
		"Type": CardConfig.CardTypes.RESOURCE,
		"Tags": ["Community"],
		"Abilities": "Pay 1 Time: Draw 1 card and gain 1 Kudos",
		"Time": 1,
		"Value": 0,
		"Kudos": 3,
		"skill_req": 0,
		"cred_req": 3,
		"motivation_req": 0,
		"_affinity": "ZIP",
	},
	"Junker": {
		"Type": CardConfig.CardTypes.RESOURCE,
		"Tags": ["Tutor", "Collaborator", "Unique"],
		"Abilities": "Reduce the time cost of all Shaders by 1.",
		"Time": 0,
		"Value": 0,
		"Kudos": 5,
		"skill_req": 0,
		"cred_req": 0,
		"motivation_req": 0,
		"_illustration": "Artbreeder",
		"_affinity": "NEUTRAL",
	},
	"Search Engine Expertise": {
		"Type": CardConfig.CardTypes.RESOURCE,
		"Tags": ["Knowledge"],
		"Abilities": "Once per Competition, you may look "\
				+ "at the top card of the deck\n"\
				+ "Discard this card: Draw one card",
		"Time": 1,
		"Value": 0,
		"Kudos": 0,
		"skill_req": 0,
		"cred_req": 0,
		"motivation_req": 0,
		"_affinity": "WIN",
	},
	"Silver Tongue": {
		"Type": CardConfig.CardTypes.RESOURCE,
		"Tags": ["Knowledge", "Reputation"],
		"Abilities": "After you install a Collaborator or a Tutor, "\
				+ "Draw a card",
		"Time": 2,
		"Value": 0,
		"Kudos": 0,
		"skill_req": 0,
		"cred_req": 0,
		"motivation_req": 0,
		"_affinity": "WIN",
	},
	"ShaderToy": {
		"Type": CardConfig.CardTypes.RESOURCE,
		"Tags": ["Knowledge"],
		"Abilities": "1 Time, Shuffle 2 random cards from your hand "\
				+ "into the deck: Draw 2 cards",
		"Time": 1,
		"Value": 0,
		"Kudos": 0,
		"skill_req": 0,
		"cred_req": 0,
		"motivation_req": 2,
		"_affinity": "NEUTRAL",
	},
	"Blog": {
		"Type": CardConfig.CardTypes.RESOURCE,
		"Tags": ["Community"],
		"Abilities": "1 Time, Exhaust, Discard an installed card: "\
				+ "Gain 4 Kudos",
		"Time": 1,
		"Value": 0,
		"Kudos": 0,
		"skill_req": 0,
		"cred_req": 0,
		"motivation_req": 0,
		"_affinity": "ZIP",
	},
	"Igorrr": {
		"Type": CardConfig.CardTypes.RESOURCE,
		"Tags": ["Unique"],
		"Abilities": "1 Kudos, Exhaust: Put the top Shader of your "\
				+ "Discard Pile into your hand.",
		"Time": 1,
		"Value": 0,
		"Kudos": 2,
		"skill_req": 1,
		"cred_req": 1,
		"motivation_req": 1,
		"_illustration": "Artbreeder",
		"_affinity": "ZIP",
	},
	"Prismatic": {
		"Type": CardConfig.CardTypes.RESOURCE,
		"Tags": ["Collaborator"],
		"Abilities": "If all your Shaders are different "\
				+ "increase you demo value by 8.",
		"Time": 1,
		"Value": 0,
		"Kudos": 4,
		"skill_req": 0,
		"cred_req": 0,
		"motivation_req": 0,
		"_illustration": "Artbreeder",
		"_affinity": "ART",
	},
	"Constant": {
		"Type": CardConfig.CardTypes.RESOURCE,
		"Tags": ["Tutor"],
		"Abilities": "All your skill_req 1 Shaders have +1 value ",
		"Time": 1,
		"Value": 0,
		"Kudos": 3,
		"skill_req": 0,
		"cred_req": 1,
		"motivation_req": 0,
		"_illustration": "Artbreeder",
		"_affinity": "WIN",
	},
	"Fidazzia": {
		"Type": CardConfig.CardTypes.RESOURCE,
		"Tags": ["Tutor"],
		"Abilities": "After a Shader's value increases, increase it by 1 more.",
		"Time": 1,
		"Value": 0,
		"Kudos": 1,
		"skill_req": 0,
		"cred_req": 0,
		"motivation_req": 0,
		"_illustration": "Artbreeder",
		"_affinity": "WIN",
	},
	"Antisocial": {
		"Type": CardConfig.CardTypes.RESOURCE,
		"Tags": ["Reputation"],
		"Abilities": "After you install this card, lose all your Kudos.\n"\
				+ "You cannot install Collaborators or Tutors.\n"\
				+ "+2 Motivation",
		"Time": 0,
		"Value": 0,
		"Kudos": 0,
		"skill_req": 0,
		"cred_req": 0,
		"motivation_req": 0,
		"_affinity": "ART",
	},
### BEGIN Prep ###
	"Collaboration": {
		"Type": CardConfig.CardTypes.ACTION,
		"Tags": ["Community"],
		"Abilities": "Discard an installed Shader to gain Kudos equal to its value",
		"Time": 1,
		"Value": 0,
		"Kudos": 0,
		"skill_req": 0,
		"cred_req": 0,
		"motivation_req": 0,
		"_affinity": "ART",
	},
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
		"_affinity": "NEUTRAL",
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
		"_affinity": "WIN",
	},
	"Massive Compression": {
		"Type": CardConfig.CardTypes.ACTION,
		"Tags": [],
		"Abilities": "Gain 1 Cred",
		"Time": 1,
		"Value": 0,
		"Kudos": 0,
		"skill_req": 0,
		"cred_req": 0,
		"motivation_req": 0,
		"_affinity": "ZIP",
	},
	"Help out Some Newbs": {
		"Type": CardConfig.CardTypes.ACTION,
		"Tags": ["Community"],
		"Abilities": "Gain 5 Kudos",
		"Time": 1,
		"Value": 0,
		"Kudos": 0,
		"skill_req": 1,
		"cred_req": 0,
		"motivation_req": 0,
		"_affinity": "NEUTRAL",
	},
	"Social Networking": {
		"Type": CardConfig.CardTypes.ACTION,
		"Tags": ["Community"],
		"Abilities": "Discard a Tutor or Collaborator"\
				+ " from hand or board to gain 1 Cred and 2 Kudos.\n"\
				+ "If the card was installed, gain 3 more Kudos.",
		"Time": 1,
		"Value": 0,
		"Kudos": 0,
		"skill_req": 0,
		"cred_req": 0,
		"motivation_req": 5,
		"_affinity": "WIN",
	},
	"Creative Block": {
		"Type": CardConfig.CardTypes.ACTION,
		"Tags": [],
		"Abilities": "This card cannot be played.\n"\
				+ "After this card is discarded from hand, draw three cards.\n"\
				+ "After this card is drawn, draw a card.",
		"Time": 0,
		"Value": 0,
		"Kudos": 0,
		"skill_req": 0,
		"cred_req": 0,
		"motivation_req": 0,
		"_is_unplayable": true,
		"_affinity": "ART"
	},
	"Presentation": {
		"Type": CardConfig.CardTypes.ACTION,
		"Tags": ["Community"],
		"Abilities": "Gain 1 Kudos for each installed Shader",
		"Time": 0,
		"Value": 0,
		"Kudos": 0,
		"skill_req": 0,
		"cred_req": 0,
		"motivation_req": 4,
		"_affinity": "ART"
	},
	"Fresh Start": {
		"Type": CardConfig.CardTypes.ACTION,
		"Tags": [],
		"Abilities": "Discard your hand and draw cards equal to your motivation",
		"Time": 3,
		"Value": 0,
		"Kudos": 0,
		"skill_req": 0,
		"cred_req": 0,
		"motivation_req": 6,
		"_affinity": "NEUTRAL",
	},
	"Meditation": {
		"Type": CardConfig.CardTypes.ACTION,
		"Tags": [],
		"Abilities": "Increase your motivation by 1",
		"Time": 7,
		"Value": 0,
		"Kudos": 0,
		"skill_req": 0,
		"cred_req": 0,
		"motivation_req": 0,
		"_affinity": "NEUTRAL",
	},
	"Pivot": {
		"Type": CardConfig.CardTypes.ACTION,
		"Tags": [],
		"Abilities": "Pay 1 Kudos per installed Shader: "\
				+ "Draw 1 card per installed Shader",
		"Time": 1,
		"Value": 0,
		"Kudos": 0,
		"skill_req": 0,
		"cred_req": 0,
		"motivation_req": 0,
		"_affinity": "NEUTRAL",
	},
	"Crowdsourcing": {
		"Type": CardConfig.CardTypes.ACTION,
		"Tags": [],
		"Abilities": "Lose all Kudos: "\
				+ "Install a Shader from hand, "\
				+ "reducing its final time cost by the amount of Kudos lost",
		"Time": 0,
		"Value": 0,
		"Kudos": 0,
		"skill_req": 0,
		"cred_req": 0,
		"motivation_req": 0,
		"_affinity": "WIN"
	},
	"Insight": {
		"Type": CardConfig.CardTypes.ACTION,
		"Tags": [],
		"Abilities": "Discard a shader from your hand: "\
				+ "Gain 6 time",
		"Time": 0,
		"Value": 0,
		"Kudos": 2,
		"skill_req": 0,
		"cred_req": 0,
		"motivation_req": 5,
		"_affinity": "NEUTRAL",
	},
	"All-Nighter": {
		"Type": CardConfig.CardTypes.ACTION,
		"Tags": ["Burnout"],
		"Abilities": "Fill your hand up to your motivation. Lose 1 motivation",
		"Time": 0,
		"Value": 0,
		"Kudos": 0,
		"skill_req": 0,
		"cred_req": 0,
		"motivation_req": 0,
		"_affinity": "ZIP"
	},
	"Refactoring": {
		"Type": CardConfig.CardTypes.ACTION,
		"Tags": ["Burnout"],
		"Abilities": "Discard an installed Shader. Lose 1 motivation:"\
				+ "Install the highest Time-cost Shader from your hand "\
				+ "that is up to 1 skill_req higher "\
				+ "than the discarded Shader without paying any costs.",
		"Time": 0,
		"Value": 0,
		"Kudos": 0,
		"skill_req": 0,
		"cred_req": 0,
		"motivation_req": 0,
		"_affinity": "ZIP"
	},
	"Enhance": {
		"Type": CardConfig.CardTypes.ACTION,
		"Tags": [],
		"Abilities": "Install a Shader from your hand with +2 final time cost."\
				+ " Increase its value by 5",
		"Time": 1,
		"Value": 0,
		"Kudos": 0,
		"skill_req": 0,
		"cred_req": 0,
		"motivation_req": 0,
		"_affinity": "ART"
	},
	"Monetary Incentives": {
		"Type": CardConfig.CardTypes.ACTION,
		"Tags": [],
		"Abilities": "Lose 1 Cred: Play a Shader as if you had +2 skill",
		"Time": 1,
		"Value": 0,
		"Kudos": 0,
		"skill_req": 0,
		"cred_req": 1,
		"motivation_req": 0,
		"_affinity": "WIN"
	},
# Need to figure out how to script this first
#	"Task Warrior": {
#		"Type": CardConfig.CardTypes.ACTION,
#		"Tags": [],
#		"Abilities": "Reveal the next tournament.\n"\
#				+ "At the start of the next tournament, gain 3 time",
#		"Time": 4,
#		"Value": 0,
#		"Kudos": 0,
#		"skill_req": 0,
#		"cred_req": 0,
#		"motivation_req": 3,
#	},
}

# Ideas
# Prep: Found out what the next tournament is

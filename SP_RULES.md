# Fragment Forge (Single-Player) v0.4

You're a newbie coder who's trying to become known for his demo effect skills, and decided to try and compete in a few prestigious demoparty competitions.

This is a card Game, where you're trying to build up the skill set to create the best demo you can during each "round" or Competition. The objective is to reach your Cred goal until the end of the third competition.

## Terminology:

* Cred: A slang for "Credibility". How accepted you are as a coder in the demoscene. Effectively Victory Points
* Kudos: Your social credit with other members of the demoscene. How much you have helped others determines how much they're willing to help you back.
* Time: How much time you have to complete you demo in each Competition
* Skill: How good you are at writing Fragment Shaders.
* Motivation: How motivated you are to improve your demo. The cost to draw new cards is affected by this amount.
* Shader: A type of card which adds value to your demo. See Card Types.
* Resource: A type of card which provides supporting effects. See Card Types.
* Prep: A type of card which rerpesents you **prep**aring for the competition. See Card Types.
* Install: To play a card on the board
* Value: How impressive a Shader is or how Impressive your demo is.
* Demo: Each Installed Shader adds it value to your total for this competition. The total value amount of installed Shaders is your demo value.
* Competition: Effectively, a "round". See (#Competitions)

## Card Types:

All cards have a few values which determine how you can play them and what they do.

* Name: The name of the card is on the very top.
* Tags: Any special keywords related to this card. Some other cards might look for cards with these tags
* Abilities: The main text of the card. It explains special rules caused by this card. Abilities on cards always override rules specified in this document!
* Time: How much time it takes to play or install this card
* cred_req: How much cred you need to have before you can play this card
* motivation_req: How much motivation you need to have before you can play this card


### Shader

Shaders (AKA Fragment Shader ) are the core component of any good demo effect.  They use the following extra fields

* skill_req: How much skill is required to develop this shader. Having 1 less skill means significantly more time. Having 2+ less skill means the shader is impossible for you.

### Resources

Resources are people, knowledge, jobs and other thing which are peripherally useful for creating a good demo.

### Prep

Prep cards are events and actions you take while working on your demo.

## Rules

### Hand

When you start the game, you'll draw 5 cards to start with. You can play any card by paying it's time and kudos costs. If a card is playable, it will be highlighted white.
If it's highlighted green, it's playable with a discount. If it's highlighted yellow, it's playable with an increase in cost.

If highlighted red, it's not playable.

Check the cost breakdown to see what modifies a card's cost and why. Card which alter the cost will be mentioned in the breakdown.

You can draw more cards by double-clicking on your deck to the left. Each card you draw, costs time (representing the effort of seeking new information on the net). The amount of time is dependent on your motivation and the
amount of cards already in your hand. To draw cards up to your motivation, costs 1 time, Cards over your motivation cost 2 time (representing the overheads of onboarding too many projects). Your maximum hand-size is 10.

If your deck runs out, nothing happens, but you cannot draw anymore cards.

To play a card from your hand, either double click on it, or drag it to the board. If it's a Prep, it will be discarded after being used. Otherwise it will be Installed. You can specify the install position by dragging it to the spot you want in the correct grid for the type. You can play more than 1 card with the same name, unless it has the 'Unique' tag.

Shaders are a bit special to pay for.
* If you have as much skill as the shader's skill_req, then you can play it with the time cost written on it.
* If you have 1 less skill than the shader, then you have to pay double its time cost + one, (representing the effort of trying to develop something exceeding your talents)
* If you have more skill than the shader, then you reduce its time cost by 1 for each skill you have more, to a minimum of half.

### Board

Whenever you play a Shader or Resource, you Install it on your board. You have enough space for 12 Shaders and 12 Resources. If you run out of space, you cannot play anymore. You can drag Installed cards around to reorganize
them to your liking.

At the end of each competition (i.e. round), all shaders will be discarded. This represents starting effort on a new demo for the next competition.
Some resources might be discarded as well, but they will mention it when they do so.

Some cards might have abilities while Installed. Double-click on them to use them.

### Competitions

To start the game, press the "Start Competition" button. It will give you your initial cards.

In the top middle part, you will see details about the competition.
* Each competition provides an amount of Time you can use to create your demo. When this runs out, you have to move to the next competition.
* Each competition might have some special rules as well. They will be written in the yellow textbox.
* Each competition has 3 placements you can achieve, from 3rd to 1st. Each of them gives more Cred for reaching it, but requires more Demo value. Once you achieve a placement, it will be highlighted green.
* Each subsequent Competition increases the amount of Cred you get by placing well within it, but also the placement requirements


Once you run out of time (or you don't want to spend any more), press "Next Competition". In the standard game mode, you take part in 3 competitions.
You can see on which competition you are on the left of the Competition Details.

Be aware: If you do not make any placement in the competition, you will lose 2 motivation. However if you earn the first place, you will instead gain 1 motivation!

### Game Goal

The game goal is to amass a specified amount of Cred, based on the difficulty. The amount you need is written to the left of the Competition details

The game will end immediately after you achieve your goal, or after you end your last competition. Then it will inform you if you've won or lost.

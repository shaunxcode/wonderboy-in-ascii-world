T = require "node-term-ui"

centerText = (y, text) -> 
	T.pos((T.width / 2) - (text.length / 2), y).out text 

Mode = 
	titleScreen:
		init: ->

		draw: -> 
			T.clear()
			T.hideCursor()
			mv = T.height / 2
			centerText mv, "wonderboy-in-ascii-world"
			centerText mv + 1, "press any key to start"

		keypress: (char, key) -> 
			console.log char, key 

	startGame: -> 

	globe: -> 

	overworld: -> 

	#town, dungeon, or what not
	locality: -> 

	building: -> 


#state is empty to start
STATE = {}

#game starts on title screen 
mode = Mode.titleScreen

#handle transitioning between modes
transition = (newMode) -> 
	mode.leave? STATE
	mode = newMode
	mode.enter? STATE 
	mode.init STATE
	draw()

#draw the first time and keep handle for resize
do draw = -> 
	mode.draw STATE

T.on "keypress", (char, key) ->
	mode.keypress? char, key

T.on "resize", -> 
	draw()

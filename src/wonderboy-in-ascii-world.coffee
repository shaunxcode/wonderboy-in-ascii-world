T = require "node-term-ui"
Dialog = require "./Dialog"

_center = (max, len = 0) -> ((max / 2) - (len / 2)) + 1
getCenterX = (len) -> _center T.width, len 
getCenterY = (len) -> _center T.height, len
	
centerText = (y, text) -> 
	T.pos((getCenterX text.length), y).out(text) 

Mode = 
	titleScreen:
		init: ->

		draw: -> 
			T.clear()
			T.hideCursor()
			mv = getCenterY()
			centerText mv, "wonderboy-in-ascii-world"
			centerText mv + 1, "press any key to start"

		keypress: (char, key) -> 
			transition Mode.startGame

	startGame:
		draw: -> 
			T.clear()
			
			story = new Dialog
				bounds:
					w: 65
					h: 10
					x: getCenterX 65
					y: getCenterY 25
				content: [
					"Shion has awoken once again."
					"This time his surroundings are both familiar and yet not."
					"After defeating BioMeka and the Demon King shion finds himself"
					"washed up on the shore of a strange island made of text."
					""
					"Equipped with nothing but a sword and and old pair of sneakers"
					"your adventure begins!"]

			story.draw().focus()
			
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
	mode.init? STATE
	draw()

#draw the first time and keep handle for resize
do draw = -> mode.draw STATE

#listen to the terminal 
T.on "keypress", (char, key) -> mode.keypress? char, key
T.on "resize", draw

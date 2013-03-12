T = require "node-term-ui"
Dialog = require "./Dialog"

_center = (max, len = 0) -> ((max / 2) - (len / 2)) + 1
getCenterX = (len) -> _center T.width, len 
getCenterY = (len) -> _center T.height, len

_portion = (max, per) -> Math.floor max * per
getPortionH = (per) -> _portion T.height, per
getPortionW = (per) -> _portion T.width, per

centerText = (y, text) -> 
	T.pos((getCenterX text.length), y).out(text) 

dialogs = require "./dialogs"

screen = new T.Box bounds: x: 2, y: 2
info =  new T.Box bounds: x: 2
dialog = new Dialog 

writeJournal = (entry) -> 
	for line in entry.split "\n"
		info.content.push line
	info.draw()
	
confirm = (statement, options) ->
	dialog.setBounds(w: 65, h: 10).setContent statement.split "\n"
	dialog.setOptions options
	dialog.show()

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
		init: ->
			confirm dialogs.start, [
				["egress", "Egress to Reality", -> T.quit()]
				["embark", "Embark Upon Adventure", -> transition Mode.newGame]]

		draw: -> 
			T.clear()
			screen.setBounds(x: 2, y: 2, h: getPortionH(.75), w: T.width - 2)
			info.setBounds(x:2, y: screen.bounds.h + 2, h: getPortionH(.25), w: T.width - 2)
			dialog.setBounds(x: getCenterX(65), y: getCenterY(25))

		leave: ->
			T.clear()
			dialog.hide()
			screen.draw()
			info.draw()

	newGame:
		init: ->
			writeJournal "Shion has chosen to face the new world despite the harsh reality."
			
		draw: -> 
			T._d "DRAW NEW GAME STATE"
			
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

T = require "node-term-ui"

class Dialog extends T.Box
	constructor: (opts) -> 
		super opts
		@botRightCorner = @botLeftCorner = @topRightCorner = @topLeftCorner = T.B 3, 3, 3, 3
		@_optionBoxes = []

	draw: -> 
		super()
		@rightX = @bounds.x + @bounds.w - 1
		@botY = @bounds.y + @bounds.h - 1
		
		@drawOptions()
		this
		
	drawBorders: -> 
		super()

		T.saveFg().fg @borderColor
		
		#top left 
		T.pos(@bounds.x - 1, @bounds.y).out(T.B 0, 3, 3, 0)
			.pos(@bounds.x - 1, @bounds.y - 1).out(T.B 0, 3, 0, 3)
			.pos(@bounds.x, @bounds.y - 1).out(T.B 3, 0, 0, 3)
			.pos(@bounds.x + 1, @bounds.y).out(T.B 3, 3, 0, 0)

		#right 
		rightX = @bounds.x + @bounds.w - 1
		T.pos(rightX + 1, @bounds.y).out(T.B 3, 0, 3, 0)
			.pos(rightX + 1, @bounds.y - 1).out(T.B 3, 0, 0, 3)
			.pos(rightX, @bounds.y - 1).out(T.B 0, 3, 0, 3)
			.pos(rightX - 1, @bounds.y).out(T.B 3, 3, 0, 0)
		
		#bot right
		botY = @bounds.y + @bounds.h - 1
		T.pos(rightX + 1, botY).out(T.B 3, 0, 0, 3)
			.pos(rightX + 1, botY + 1).out(T.B 3, 0, 3, 0)
			.pos(rightX, botY + 1).out(T.B 0, 3, 3, 0)
			.pos(rightX - 1, botY).out(T.B 3, 3, 0, 0)

		#bot left
		T.pos(@bounds.x - 1, botY).out(T.B 0, 3, 0, 3)
			.pos(@bounds.x - 1, botY + 1).out(T.B 0, 3, 3, 0)
			.pos(@bounds.x, botY + 1).out(T.B 3, 0, 3, 0)
			.pos(@bounds.x + 1, botY).out(T.B 3, 3, 0, 0)

		T.restoreFg()
  
	setOptions: (options) ->
		box.destroy() for box in @_optionBoxes 
		
		@dialogOptions = options
		@_optionBoxes = []

		for option, handler of @dialogOptions
			@_optionBoxes.push box = new T.Box
				ellipsizeContent: false
				bounds:
					w: "fit"
					h: "fit"
				borders:
					t: false
				content: [option]

			box.onKey_space = handler
		box.focus()
		
		@drawOptions()
		
	drawOptions: ->
		curX = @rightX - 2
		for option in @_optionBoxes
			curX -= option.bounds.w
			option.setBounds(x: curX, y: @botY)
			T.pos(curX, @botY).out T.B 1, 1, 0, 1
			T.pos(curX + option.bounds.w - 1, @botY).out T.B 1, 1, 0, 1
		this
		
	focus: -> 
		super()
		@drawOptions()
		this
	
	
	blur: ->
		super() 
		@drawOptions()
		this

		
		
module.exports = Dialog
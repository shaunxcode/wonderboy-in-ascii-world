T = require "node-term-ui"

class Dialog extends T.Box
	constructor: (opts) -> 
		super opts
		@botRightCorner = @botLeftCorner = @topRightCorner = @topLeftCorner = T.B 3, 3, 3, 3
		
		@tabs = new T.Tabs
			position: "bottom"
			
		@tabs.on "activeTab", (option) => 
			@dialogOptionHandlers[option]?()

	draw: -> 
		super()

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
		@dialogOptions = options
		@dialogOptionHandlers = {}
		for option in options
			@dialogOptionHandlers[option[0]] = option[2]
			
		@tabs.setItems options

	drawOptions: -> 
		@tabs.x = @bounds.x + @bounds.w - @tabs.width - 2
		@tabs.y = @bounds.y + @bounds.h - 1
		T._d @bounds
		@tabs.draw()

	focus: -> 
		super()
		@drawOptions()
		
	blur: -> 
		super()
		@drawOptions()
		
	hide: -> 
		super()
		@tabs.hide()
		this
		
module.exports = Dialog
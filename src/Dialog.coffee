T = require "node-term-ui"

class Dialog extends T.Box
	constructor: (opts) -> 
		super opts
		@topLeftCorner = T.B 0, 3, 0, 3
		@topRightCorner = T.B 3, 0, 0, 3
		@botLeftCorner = T.B 0, 3, 3, 0
		@botRightCorner = T.B 3, 0, 3, 0
    
	draw: -> 
		super()

  
module.exports = Dialog
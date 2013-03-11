#this will be a collection of things I discovered as I worked on the project
T::{method} refers to node-term-ui::{method} 

##wtf why is it not always centering the text... beyond that why is it showing escape characters?
Aww because T::pos was not handling floats which I had not yet encountered do to lack of built in centering. 
Solution? Math.floor in the T::pos

##on centering
I am realizing I am using centering often enough that it should be in T itself. 

##box scrolling bug
apparently there is a bug in scrolling letting the scroll bar go higher than it should. 

##box showing scroller un-necessarily
allow customizing the scroll char and also do not show it unless there is actually scrollable content

##box allowing horizontal scrolling when un-necessary

##running into need for destroy method
realized I had not yet needed to destroy a ui element. At first glance this need only splice the widget instances excluding the destroyed element. Immediate issues that come up to me are: should it then redraw remaining elements? in a game that could be foolish as you most likely want to redraw all the elements at once so if you are destroying multiple elements that would be wasteful. Perhaps it should just emit a destroyed event so anything that should redraw itself can listen to that.

##floats rear their head
hah - need to fix the float bounds issue at the constructor level rather than the output level to avoid calculations down the line having strangeness. 

## was going to make confirm a modal but realized that is not what I want 
you want the modal to stay up but you may want to let the user use the command console to see their inventory etc.
to make decisions?

##make confirm take an array of tuples
it makes more sense to not try and abuse generic objects/hash where order is not guaranteed when you need order. 
Also this makes sense because I can now pass [id, label, handler] so I can refer to the action id in later code. 
This also allows for a more meaningful approach to moving between options with the arrow keys. 

##just realized my bottom buttons... are tabs
I can totally repurpose the tab widget to get the same effect of my bottom buttons! This would give me the arrow key nav for free. 
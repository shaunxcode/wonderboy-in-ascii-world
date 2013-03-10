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
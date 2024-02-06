/* Initial beliefs and rules */
random_dir(DirList,RandomNumber,Dir) :- (RandomNumber <= 0.25 & .nth(0,DirList,Dir)) |
 (RandomNumber <= 0.5 & .nth(1,DirList,Dir)) | 
 (RandomNumber <= 0.75 & .nth(2,DirList,Dir)) |
  (.nth(3,DirList,Dir)).


agent_loc(0,0,0). //agent_loc(X,Y,coordinate)


ava_dir(Direction) :- member(Direction, [e, s, w, n]).

// dir(e).
// dir(w).
// dir(s).
// dir(n).

// get_ava_dir :- (dir(e)|Dir = e) & (dir(w)|Dir = w) & (dir(s)|Dir = s) & (dir(n)|Dir = n).

get_ava_dir(Dir):- ava_dir(Dir).


get_dir(X, Y, Dir):- (X = 1 & Y = 0 & Dir = e).
get_dir(X, Y, Dir):- (X = -1 & Y = 0 & Dir = w).
get_dir(X, Y, Dir):- (X = 0 & Y = 1 & Dir = s).
get_dir(X, Y, Dir):- (X = 0 & Y = -1 & Dir = n).
get_dir(_,_,null).


// get_dir(X, Y, e):- X = 1 , Y = 0.
// get_dir(X, Y, w):- X = -1 , Y = 0.
// get_dir(X, Y, s):- X = 0 , Y = 1.
// get_dir(X, Y, n):- X = 0 , Y = -1.
// get_dir(_,_,null):- !.



// get_dir(1, 0, e).
// get_dir(-1, 0, w).
// get_dir(0, 1, s).
// get_dir(0, -1, n).
// get_dir(_,_,null): - !.

dir_on(X, Y, Dir):- get_dir(X,Y,Dir).
dir_on(_,_,null).


check_dir(X,Y,Dir):- (Dir = e& X> 1).
check_dir(X,Y,Dir):- (Dir = w& X< -1).
check_dir(X,Y,Dir):- (Dir = s& Y> 1).
check_dir(X,Y,Dir):- (Dir = n& Y< -1).
check_dir(X,Y,Dir):- (Dir = e& X>0 & Y=1).
check_dir(X,Y,Dir):- (Dir = w& X<0 & Y=1).
check_dir(X,Y,Dir):- (Dir = e& X>0 & Y=-1).
check_dir(X,Y,Dir):- (Dir = w& X<0 & Y=-1). 
check_dir(X,Y,Dir):- (Dir = s& X=1 & Y>0).
check_dir(X,Y,Dir):- (Dir = n& X=1 & Y<0).
check_dir(X,Y,Dir):- (Dir = s& X=-1 & Y>0).
check_dir(X,Y,Dir):- (Dir = s& X=-1& Y<0).
check_dir(X,Y,Dir):- (Dir = e& X>1 &Y=0).
check_dir(X,Y,Dir):- (Dir = w& X< -1 &Y=0).
check_dir(X,Y,Dir):- (Dir = s& X=0 &Y>1).
check_dir(X,Y,Dir):- (Dir = n& X=0 &Y< -1).


check_dir(X,Y,Dir):- (Dir = null & X=0&Y=1).
check_dir(X,Y,Dir):- (Dir = null & X=0&Y=-1).
check_dir(X,Y,Dir):- (Dir = null & X=1&Y=0).
check_dir(X,Y,Dir):- (Dir = null & X=-1&Y=0).




check_dir_on(X,Y,Dir) :- (X < 0 & Dir=w).
check_dir_on(X,Y,Dir) :- (X > 0 & Dir=e).
check_dir_on(X,Y,Dir) :- (Y < 0 & Dir=n).
check_dir_on(X,Y,Dir) :- (Y > 0 & Dir=s).
check_dir_on(X,Y,Dir) :- (X < 0 & Y=0 & Dir=w).
check_dir_on(X,Y,Dir) :- (X > 0 & Y=0 & Dir=e ).
check_dir_on(X,Y,Dir) :- (X=0 & Y < 0 & Dir=n).
check_dir_on(X,Y,Dir) :- (X=0 & Y > 0 & Dir=s).
check_dir_on(X,Y,Dir) :- (X=0 & Y=0 & Dir = null).

// check_dir(0,1,Dir) :- Dir = null.
// check_dir(0,-1,Dir) :- Dir = null.
// check_dir(1,0,Dir) :- Dir = null.
// check_dir(-1,0,Dir) :- Dir = null.

dir_rotate(CurrentDir,NewDir,Dir_R):-(CurrentDir =n & NewDir =e & Dir_R =cw ).
dir_rotate(CurrentDir,NewDir,Dir_R):-(CurrentDir =e & NewDir =s & Dir_R =cw ).
dir_rotate(CurrentDir,NewDir,Dir_R):-(CurrentDir =s & NewDir =w & Dir_R =cw ).
dir_rotate(CurrentDir,NewDir,Dir_R):-(CurrentDir =w & NewDir =n & Dir_R =cw ).
dir_rotate(CurrentDir,NewDir,Dir_R):-(CurrentDir =n & NewDir =w & Dir_R =ccw ).
dir_rotate(CurrentDir,NewDir,Dir_R):-(CurrentDir =w & NewDir =s & Dir_R =ccw ).
dir_rotate(CurrentDir,NewDir,Dir_R):-(CurrentDir =s & NewDir =e & Dir_R =ccw ).
dir_rotate(CurrentDir,NewDir,Dir_R):-(CurrentDir =e & NewDir =n & Dir_R =ccw ).
dir_rotate(CurrentDir,NewDir,Dir_R):-(CurrentDir =n & NewDir =n & Dir_R =null ).
dir_rotate(CurrentDir,NewDir,Dir_R):-(CurrentDir =e & NewDir =e & Dir_R =null ).
dir_rotate(CurrentDir,NewDir,Dir_R):-(CurrentDir =s & NewDir =s & Dir_R =null ).
dir_rotate(CurrentDir,NewDir,Dir_R):-(CurrentDir =w & NewDir =w & Dir_R =null ).
dir_rotate(CurrentDir,NewDir,Dir_R):-(CurrentDir =e & NewDir =w & Dir_R =cw ).
dir_rotate(CurrentDir,NewDir,Dir_R):-(CurrentDir =w & NewDir =e & Dir_R =cw ).
dir_rotate(CurrentDir,NewDir,Dir_R):-(CurrentDir =n & NewDir =s & Dir_R =cw ).
dir_rotate(CurrentDir,NewDir,Dir_R):-(CurrentDir =s & NewDir =n & Dir_R =cw ).

// dir_rotate(CurrentDir,NewDir,Dir_R):-(CurrentDir = & NewDir = & Dir_R = ).
// dir_rotate(CurrentDir,NewDir,Dir_R):-(CurrentDir = & NewDir = & Dir_R = ).
// dir_rotate(CurrentDir,NewDir,Dir_R):-(CurrentDir = & NewDir = & Dir_R = ).
// dir_rotate(CurrentDir,NewDir,Dir_R):-(CurrentDir = & NewDir = & Dir_R = ).






// check_dir(X,Y,Dir):- 
// (X > 0 & Y == 0 & Dir = e);
// (X < 0, Y == 0, Dir = w);
// (Y > 0, X == 0, Dir = s);
// (Y < 0, X == 0, Dir = n);
// (X == 0, Y == 0, Dir = null).


// dispenser(e):-thing(X,Y,dispenser,_)& X = 1 & Y = 0
// dispenser(w):-thing(X,Y,dispenser,_)& X = -1 & Y = 0
// dispenser(s):-thing(X,Y,dispenser,_)& X = 0 & Y = 1
// dispenser(n):-thing(X,Y,dispenser,_)& X = 0 & Y = -1

// ava_dir(dir):








/* Initial goals */

!start.

/* Plans */

// +!start : true <- 
// 	.print("hello massim world.").

// +step(X) : thing(0,1,dispenser,_)<-
// 	request(s).

// +step(X) : thing(0,-1,dispenser,_)<-
// 	request(n).

// +step(X) : thing(1,0,dispenser,_)<-
// 	request(e).

// +step(X) : thing(-1,0,dispenser,_)<-
// 	request(w).


// true <-
 	.print("Received step percept.").
	
+actionID(X) : true <- 
	.print("Determining my action");
	!move_random.
//	skip.

+!move_random : .random(RandomNumber) & random_dir([n,s,e,w],RandomNumber,Dir)
<-	move(Dir).


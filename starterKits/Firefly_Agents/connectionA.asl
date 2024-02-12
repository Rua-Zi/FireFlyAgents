// Agent bob in project MAPC2018.mas2j
/* Initial beliefs and rules */
random_Direction(DirectionList,RandomNumber,Direction) :- (RandomNumber <= 0.25 & .nth(0,DirectionList,Direction)) | (RandomNumber <= 0.5 & .nth(1,DirectionList,Direction)) | (RandomNumber <= 0.75 & .nth(2,DirectionList,Direction)) | (.nth(3,DirectionList,Direction)).

escape_interval(70).
escape_step(4).
init_step(30).
init_dirs([n,w, n,e, s,w, s,e, w,e]).

my_id(-1).

/* helper functions */
ids([1, 2, 3, 4, 5]).
name2id(Name, Id) :- 
	(.substring("1", Name) & Id = 1) | 
	(.substring("2", Name) & Id = 2) | 
	(.substring("3", Name) & Id = 3) | 
	(.substring("4", Name) & Id = 4) | 
	(.substring("5", Name) & Id = 5) |
	(.print("Error: unknown name", Name) & Id = -1).

/* Initial goals */

!start.

/* Plans */

+!start : .my_name(N) & name2id(N, ID) <- 
	-+my_id(ID);
	.print("hello massim world. ID=", ID).

+step(X) : my_id(ID) & init_step(IS) & (X <= IS) & init_dirs(Dirs) & .nth((ID-1)*2, Dirs, D1) & .nth((ID-1)*2+1, Dirs, D2) & .nth(X mod 2, [D1, D2], Dir) <-
	move(Dir).

+step(X) : my_id(ID) & escape_interval(EI) & escape_step(ES) & ((ES*ID) <= (X mod EI) & (X mod EI) < (ES*(ID+1))) <-
	.print("Escaping!!! step=", X);
	!move_random.

+step(X) : lastFailed(Steps) <-
	.print("Error handling...", Steps);
	-lastFailed(Steps);
	if(Steps > 1) {
		+lastFailed(Steps-1);
	};
	!move_random.

// Handle submit
+step(X) : attached(Block_x, Block_y) & goal(0,0) & task(TASK,_,_,[req(Block_x, Block_y, Block_type)]) <-  
	.print("Block attached at ", Block_x, ", ", Block_y, ", moving to goal.");
    submit(TASK).

/* Error Handling */
+lastAction(Action) : lastActionResult(Result) & (Result \== success) <-
	.print("@@@@@@@@@@@@@@Action ", Action, " failed! Result: ", Result);
	+lastFailed(2);
	.

+step(X) : blockattached(Block_x, Block_y, _) & not goal(Goal_x, Goal_y) <-
	.print("Block attached at ", Block_x, ", ", Block_y, ", moving to goal.");
    !move_random.

// Handle rotation
+step(X) : attached(Block_x, Block_y) & goal(0,0) <-
	.print("Block attached at ", Block_x, ", ", Block_y, ", rotating to goal.");
    if(Block_x == 1){
        rotate(cw);
	} elif (Block_y == -1){
		rotate(ccw);
	} elif (Block_x == -1){
		rotate(ccw);
	} else {
		!move_random;
	}.

// Move to goal
+step(X) : attached(Block_x, Block_y)  & goal(0, Goal_y) & not goal(0,0)<-
	.print("Block attached at ", 0, ", ", Block_y, ", moving to goal.");
	if(Goal_y < 0){
		move(n);
	} elif(Goal_y > 0){
		move(s);
	} else {
		!move_random;
	}.

+step(X) : attached(Block_x, Block_y)  & goal(Goal_x, 0) & not goal(0,0)<-
	.print("Block attached at ", Block_x, ", ", 0, ", moving to goal.");
	if(Goal_x < 0){
		move(w);
	} elif(Goal_x > 0){
		move(e);
	} else {
		!move_random;
	}.

+step(X) : attached(Block_x, Block_y)  & goal(Goal_x, Goal_y) & not goal(0,0)<-
	.print("Block attached at ", Block_x, ", ", Block_y, ", moving to goal.");
	if(Goal_x < 0){
		move(w);
	} elif(Goal_y < 0){
		move(n);
	} elif(Goal_x > 0){
		move(e);
	} elif(Goal_y > 0){
		move(s);
	} else {
		!move_random;
	}.

// Handle attach
+step(X) : thing(0,1,block,Block_type) <-
	attach(s);
	+blockattached(0,1,Block_type).
+step(X) : thing(0,-1,block,Block_type)<-
	attach(n);
	+blockattached(0,-1,Block_type).
+step(X) : thing(1,0,block,Block_type)<-
	attach(e);
	+blockattached(1,0,Block_type).
+step(X) : thing(-1,0,block,Block_type)<-
	attach(w);
	+blockattached(-1,0,Block_type).

// Handle request
+step(X) : thing(0,1,dispenser,_) <-
 	request(s).
+step(X) : thing(0,-1,dispenser,_) <-
 	request(n).
+step(X) : thing(1,0,dispenser,_) <-
 	request(e).
+step(X) : thing(-1,0,dispenser,_) <-
	request(w).


// Move to Dispenser
+step(X) : thing(0, Dispenser_y, dispenser, D) <-
	if(Dispenser_y < 0){
        move(n);
    } elif (Dispenser_y > 0){
        move(s);
    } else {
		!move_random;
	}.
+step(X) : thing(Dispenser_x, 0, dispenser, D) <- 
    if(Dispenser_x < 0){
        move(w);
    } elif (Dispenser_x > 0){
        move(e);
    } else {
		!move_random;
	}.
+step(X) : thing(Dispenser_x, Dispenser_y, dispenser, D) <- 
    if(Dispenser_x < 0){
        move(w);
    } elif (Dispenser_y < 0){
        move(n);
    } elif(Dispenser_x > 0){
        move(e);
    } elif(Dispenser_y > 0){
        move(s);
    } else {
		!move_random;
	}.

+step(X) : not thing(Dispenser_x, Dispenser_y ,dispenser,_) <-
	!move_random_5.

+step(X) : not goal(Goal_x, Goal_y) <-
	!move_random_5.

// Default function
+step(X) : true <- 
	.print("No action to take.").
	!move_random.	

+!move_random : .random(RandomNumber) & random_Direction([n, s, e, w], RandomNumber, Direction) <-
    move(Direction).

+!move_random_5 : true <- 
    .random(R); 
    if (R < 0.25) { !move_in_direction(n, 5); }
    elif (R < 0.5) { !move_in_direction(e, 5); }
    elif (R < 0.75) { !move_in_direction(s, 5); }
    else { !move_in_direction(w, 5); }.

+!move_in_direction(Direction, Steps) : Steps > 0 & not block(Direction) <- 
    move(Direction); 
    !move_in_direction(Direction, Steps - 1).
+!move_in_direction(Direction, Steps) : Steps > 0 & block(Direction) <- 
    .print("Blocked in direction ", Direction, ", stopping.").
+!move_in_direction(Direction, 0) <- 
    .print("Finished moving in direction ", Direction).

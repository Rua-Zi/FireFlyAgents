/* Initial beliefs and rules */
random_Direction(DirectionList,RandomNumber,Direction) :- (RandomNumber <= 0.25 & .nth(0,DirectionList,Direction)) | (RandomNumber <= 0.5 & .nth(1,DirectionList,Direction)) | (RandomNumber <= 0.75 & .nth(2,DirectionList,Direction)) | (.nth(3,DirectionList,Direction)).

/* Initial goals */

!start.

/* Plans */

+!start : true <- 
	.print("hello massim world.").

+step(X) : blockattached(Block_x, Block_y, _) & not goal(Goal_x, Goal_y) <-
    !move_random.

+step(X) : attached(Block_x, Block_y) & goal(0,0) & task(TASK,_,_,[req(Block_x, Block_y, Block_type)]) <-  
    submit(TASK).

+step(X) : attached(Block_x, Block_y) & goal(0,0) <-
    if(Block_x == 1){
       rotate(cw);
	};
	if(Block_y == -1){
		rotate(ccw);
	};
	if(Block_x == -1){
		rotate(ccw);
	};.

+step(X) : attached(Block_x, Block_y)  & goal(Goal_x, Goal_y) & not goal(0,0)<-
	if(Goal_x < 0){
		move(w);
	};
	if(Goal_y < 0){
		move(n);
	};
	if(Goal_x > 0){
		move(e);
	};
	if(Goal_y > 0){
		move(s);
	};.

+step(X) : attached(_,_) & not goal(_,_) <-
    move(w).

+step(X) : thing(0,1,block,Block_type) <-
	attach(s);
	+blockattached(0,1,Block_type).
+step(X) : thing(0,-1,block,Block_type)<-
	attach(n);
	+blockattached(0,-1,Block_type).


+step(X) : thing(Dispenser_x, Dispenser_y, dispenser, D) <- 
    if(Dispenser_x < 0){
        move(w);
    };
	if(Dispenser_y < 0){
        move(n);
    };
    if(Dispenser_x > 0){
        move(e);
    };
    if(Dispenser_y > 0){
        move(s);
    };.

+step(X) : not thing(Dispenser_x, Dispenser_y ,dispenser,_) <-
	!move_random.

+step(X) : not goal(Goal_x, Goal_y) <-
	!move_random.

+!move_random : .random(RandomNumber) & random_Direction([n, s, e, w], RandomNumber, Direction) <-
    move(Direction).

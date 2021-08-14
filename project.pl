project(_,[]).  % With the null list of actions do nothing
project(T,[ACT|REST]) :- 
   write(ACT), 
   projectAction(T,ACT,TEND), 
   project(TEND,REST).

projectAction(T,ACT,TEND) :- 
   occurs(T,TEND,ACT), 
   checkFeasible(T,ACT),
   projectStates(T,ACT,TEND).

checkFeasible(T,ACT) :- 
   atemporalPrecs(ACT,APRECS), 
   allTrue(APRECS), 
   temporalPrecs(ACT,PRECS), 
   allHold(T,PRECS).

% % Check that a collection of statements are all true.

allTrue([]).
allTrue([T|REST]) :- call(T),allTrue(REST).

% % Check that all the preconditions hold.
allHold(_,[]). % Base Case: Null list of preconditions is satisfied
allHold(T,[PREC|REST]) :- holds(T,PREC), allHold(T,REST). 

projectStates(T,ACT,TEND) :- % compute and assert all the states that hold at TEND.
   effects(ACT,EFFECTS),
   assertEffects(TEND,EFFECTS), % direct effects
   containedEffects(T,TEND,ACT), % indirect effects: update directContained 
   (ACT = dump(O) -> dumpEffect(T,TEND,dump(O)); computeUnchanged(T,ACT,TEND)).

% assert that all the fluents in EFFECTS hold at time T
assertEffects(_,[]). % Base case: Null list
assertEffects(T,[EFFECT|REST]) :-  
   addState(T,EFFECT),
   assertEffects(T,REST).

% assert that all the fluents not changed by ACT that hold in T still hold TEND.
% this uses backtracking to loop through the fluents that hold in T.
computeUnchanged(T,ACT,TEND) :-
   format('compute unchanged ~n'),
   erases(ACT,ERASES),
   holds(T,Q), 
   not(member(Q,ERASES)),
   addState(TEND,Q),
   fail.

computeUnchanged(_,_,_).

addState(T,EFFECT) :-
   assertz(holds(T,EFFECT)),
   format('Adding state '), 
   print(holds(T,EFFECT)), 
   format('~n').

% problem to be solved: repeated add states 

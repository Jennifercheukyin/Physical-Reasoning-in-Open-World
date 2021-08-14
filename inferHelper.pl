:- dynamic notOccurs/3.
:- multifile(notOccurs/3).
:- multifile(holds/2).

getEarliestTime(TEarliest,TEND) :- 
    not(earlier(T,TEND)),
    TEarliest = TEND. 

getEarliestTime(TEarliest,TEND) :- 
    earlier(T,TEND), 
    getEarliestTime(TEarliest,T). 

notOccurs(TA,TB,E) :-
    earlier(TX,TA), 
    notOccurs(TX,TB,E). 

notOccurs(TA,TB,E) :-
    earlier(TB,TY),
    notOccurs(TA,TY,E).

notOccurs(TA,TB,E) :-
    earlier(TX,TA),
    earlier(TB,TY),
    notOccurs(TX,TY,E). 

notOccurs(TA,TB,carrySomewhere(_)) :- 
    notOccurs(TX,TY,carrySomethingSomewhere).

notOccurs(TA,TB,loadIntoSomething(_)) :- 
    notOccurs(TX,TY,load).

checkNotContained(T,notContained(OB,OC)) :-
    OB \= OC,
    holds(T,outsideAt(OB,_)).

checkNotContained(T,notContained(OB,OC)) :-
    holds(T,directContained(OB,OM)), 
    OM \= OC,
    checkNotContained(T,notContained(OM,OC)).

checkContained(T,contained(OA,OC)) :- 
    holds(T,directContained(OA,OC)). 

checkContained(T,contained(OA,OC)) :-
    holds(T,directContained(OB,OC)),
    checkContained(T,contained(OA,OB)).

% [T,TNEXT] has occurs happen -- update states 
projectStatesAtEachInterval(T,holds(TEND,GOAL)) :- 
    earlier(T,TNEXT), 
    occurs(T,TNEXT,ACT),
    format('enter projectStatesAtEachInterval in t=~s ~n',T), 
    projectActionInOpenWorld(T,TNEXT,ACT), 
    computeUnchangedInOpenWorld(T,TNEXT,ACT),
    (holds(TEND,GOAL) -> format('End at t=~s ~n',TNEXT); projectStatesAtEachInterval(TNEXT,holds(TEND,GOAL))). 

projectActionInOpenWorld(T,TNEXT,ACT) :-  
    format('enter projectActionInOpenWorld ~n'),
    checkFeasible(T,ACT),
    projectStatesInOpenWorld(T,TNEXT,ACT).

projectStatesInOpenWorld(T,TNEXT,ACT) :- % compute and assert all the states that hold at TEND.
    format('enter projectStatesInOpenWorld ~n'),
    effects(ACT,EFFECTS),
    assertEffects(TNEXT,EFFECTS), % direct effects
    containedEffects(T,TNEXT,ACT), % indirect effects: update directContained 
    (ACT = dump(O) -> dumpEffect(T,TNEXT,dump(O)); true).

computeUnchangedInOpenWorld(T,TNEXT,ACT) :- % for all the holding state at T, if persists, then make it true at TNEXT
    format('enter computeUnchangedInOpenWorld ~n'),
    erases(ACT,ERASES), 
    forall(holds(T,Q), checkPersists(T,TNEXT,Q,ERASES)). 

% [T,TNEXT] didn't have occurs happen
projectStatesAtEachInterval(T,holds(TEND,GOAL)) :-
    earlier(T,TNEXT), 
    not(occurs(T,TNEXT,ACT)),
    not(holds(T,GOAL)),
    format('enter projectStatesAtEachInterval in t=~s ~n',T), 
    fail. 

% TODO: test if all holds(T,Q) will be added to the TNEXT
projectStatesAtEachInterval(T,holds(TEND,GOAL)) :-
    earlier(T,TNEXT), 
    not(occurs(T,TNEXT,ACT)),
    format('enter projectStatesAtEachInterval in t=~s ~n',T), 
    computePersistWhenNoActionHappen(T,TNEXT), 
    (holds(TEND,GOAL) -> format('End at t=~s ~n',TNEXT); projectStatesAtEachInterval(TNEXT,holds(TEND,GOAL))). 

computePersistWhenNoActionHappen(T,TNEXT) :- 
    format('enter computePersistWhenNoActionHappen ~n'),
    forall(holds(T,Q), checkPersists(T,TNEXT,Q,[])).

checkPersists(T,TNEXT,Q,ERASES) :-
    not(member(Q,ERASES)),
    (persists(T,TNEXT,Q) -> addState(TNEXT,Q); true).



:- dynamic notOccurs/3.
:- multifile(notOccurs/3).
:- multifile(holds/2).


infer(holds(TEND,GOAL)) :-
    holds(TEND,GOAL).

infer(holds(TEND,GOAL)) :-
    occurs(TA,TEND,ACT),
    ACT \= dump(OX),
    condEffect(ACT,GOAL,QLIST).
    forall(member(Q,QLIST),infer(holds(TA,Q))).

% for dump 
infer(holds(TEND,GOAL)) :-
    occurs(TA,TEND,ACT),
    ACT = dump(OX), 
    condEffect(TA,T,ACT,GOAL).

infer(holds(TEND,GOAL)) :-
    earlier(TA,TEND),
    infer(holds(TA,GOAL)),
    persists(TA,TEND,GOAL).


   
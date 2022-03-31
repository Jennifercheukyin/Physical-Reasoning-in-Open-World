% directContained(OA,OB)
% contained(OA,OB)
% outsideAt(O,L)
% effective(O)
% ineffective(O)

:- use_module(library(gensym)).
:- dynamic occurs/3.
:- dynamic earlier/2.
:- multifile(earlier/2).
:- multifile(occurs/3).
:- multifile(notOccurs/3).
:- multifile(holds/2).

% inconsistentState(P,Q) 
% returns true when P and Q are mutually exclusive at a given time; 
% returns false if P and Q can coexist at a given time 
inconsistentState(directContained(O,_),outsideAt(O,_)). 
inconsistentState(outsideAt(O,_),directContained(O,_)). 
inconsistentState(contained(O,_),outsideAt(O,_)). 
inconsistentState(outsideAt(O,_),contained(O,_)).
inconsistentState(ineffective(O),effective(O)).
inconsistentState(effective(O),ineffective(O)).
inconsistentState(outsideAt(O,LA),outsideAt(O,LB)). 

findChangedState(TA,TB,P) :-
    holds(TB,Q),
    inconsistentState(P,Q), 
    infer(holds(TA,P)),
    format('found inconsistent state: '), 
    print(P), 
    print(Q), 
    format('~n').

% inferEvents succeeds if one of the events in "actions" must have occured and fail otherwise.
inferEvents(TA,TB,[]).
inferEvents(TA,TB,[ACTION|ACTIONS]) :-
    format('current action tested: ~w ~n', [ACTION]),
    findChangedState(TA,TB,P), 
    assertHypotheticalStates(TA,TB,TC,TD,P,ACTION), 
    (infer(holds(TD,P)) -> 
    successCallBack(TA,TB,TC,TD,P,ACTION,ACTIONS); 
    failCallBack(TA,TB,TC,TD,P,ACTION,ACTIONS)). 
inferEvents(TA,TB,[ACTION|ACTIONS]) :- % actions happen in [TC,TB]
    earlier(TA,TX), 
    format('Between [~w, ~w]: ~n', [TX,TB]), 
    inferEvents(TX,TB,[ACTION|ACTIONS]).
    
successCallBack(TA,TB,TC,TD,P,ACTION,ACTIONS) :-
    format('success, ~w must have happened. ~n', [ACTION]), 
    cleanup(TA,TB,TC,TD,P,ACTION), 
    earlier(TA,TX), 
    assertz(occurs(TA,TX,ACTION)),
    format('call inferEvents(~w,~w,~w) ~n', [TX,TB,ACTIONS]),
    inferEvents(TX,TB,ACTIONS).

failCallBack(TA,TB,TC,TD,P,ACTION,ACTIONS) :-
    format('fail, infer(holds(~w,~w)), ~w did not happen. ~n', [TD,P,ACTION]),
    cleanup(TA,TB,TC,TD,P,ACTION), 
    inferEvents(TA,TB,ACTIONS).

assertHypotheticalStates(TA,TB,TC,TD,P,ACTION) :-
    gensym(t,TC),
    gensym(t,TD), 
    format('created hypothetical time points: '),
    print(TC), 
    print(TD),
    format('~n'),  
    assertz(earlier(TC,TD)),
    assertz(earlier(TA,TC)), 
    assertz(earlier(TD,TB)), 
    assertz(holds(TC,P)),
    assertz(notOccurs(TC,TD,ACTION)).

cleanup(TA,TB,TC,TD,P,ACTION) :-
    retract(earlier(TC,TD)),
    retract(earlier(TA,TC)),
    retract(earlier(TD,TB)),
    retract(holds(TC,P)), 
    retract(notOccurs(TC,TD,ACTION)). 
:- dynamic forall/3.
:- dynamic holds/2.

% Definition of container world
object(O) :- block(O).
object(O) :- closedContainer(O).
object(O) :- openContainer(O).
object(O) :- lid(O).
object(O) :- containerWithLid(O).

% Definition of load

atemporalPrecs(load(O,OC),[object(O),openContainer(OC)]).

temporalPrecs(load(O,OC),[outsideAt(O,L),outsideAt(OC,L),effective(O),effective(OC)]).

effects(load(O,OC),[directContained(O,OC)]).

erases(load(O,OC),[outsideAt(O,L)]).

containedEffects(_,_,load(_,_)).

dumpEffect(_,_,load(_,_)).

% Definition of unload 

atemporalPrecs(unload(O,OC),[object(O),openContainer(OC)]).

temporalPrecs(unload(O,OC),[directContained(O,OC),outsideAt(OC,L),effective(O),effective(OC)]).

effects(unload(O,OC),[outsideAt(O,L)]).

erases(unload(O,OC),[directContained(O,OC)]).

containedEffects(_,_,unload(_,_)).

dumpEffect(_,_,unload(_,_)). 

% Definition of carry

atemporalPrecs(carry(O,LFROM,LTO),[object(O),location(LFROM),location(LTO)]).

temporalPrecs(carry(O,LFROM,LTO),[outsideAt(O,LFROM), effective(O)]).

effects(carry(O,_,LTO),[outsideAt(O,LTO)]).      

erases(carry(O,LFROM,_),[outsideAt(O,LFROM)]).

containedEffects(_,_,carry(_,_,_)).

dumpEffect(_,_,carry(_,_,_)). 
   
% Definition of seal 

atemporalPrecs(seal(OC,OL,OW),[openContainer(OC),lid(OL),containerWithLid(OW),fitsOn(OL,OC)]).

temporalPrecs(seal(OC,OL,OW),[outsideAt(OC,L),outsideAt(OL,L),outsideAt(OW,L),effective(OC),effective(OL),ineffective(OW)]). 

effects(seal(OC,OL,OW),[ineffective(OL),ineffective(OC),effective(OW),components(OC,OL,OW)]). 

erases(seal(OC,OL,OW),[effective(OC),effective(OL),ineffective(OW)]).

containedEffects(T,TEND,seal(OC,OL,OW)) :-
    format('inside containedEffects ~n'),
    forall(holds(T,directContained(X,OC)), print(holds(T,directContained(X,OC)))),
    forall(holds(T,directContained(X,OC)), assertz(holds(TEND,directContained(X,OW)))).

dumpEffect(_,_,seal(_,_,_)). 

% Definition of unseal 

atemporalPrecs(unseal(OW,OL,OC), [containerWithLid(OW),lid(OL),openContainer(OC),components(OC,OL,OW)]). 

temporalPrecs(unseal(OW,OL,OC),[outsideAt(OC,L),outsideAt(OL,L),outsideAt(OW,L),ineffective(OL),ineffective(OC),effective(OW)]).

effects(unseal(OW,OL,OC),[effective(OC),effective(OL),ineffective(OW)]). 

erases(unseal(OW,OL,OC),[ineffective(OL),ineffective(OC),effective(OW)]).

containedEffects(T,TEND,unseal(OW,OL,OC)) :-
    forall(holds(T,directContained(X,OW)), assertz(holds(TEND,directContained(X,OC)))). 

dumpEffect(_,_,unseal(_,_,_)). 

% Definition of dump  

atemporalPrecs(dump(O),[object(O)]). 

temporalPrecs(dump(O),[outsideAt(O,L),effective(O)]).

effects(dump(O),[]). 

erases(dump(O),[]). 

containedEffects(_,_,dump(O)).

dumpEffect(T,TEND,dump(O)) :- dumpEffects(T,TEND,O). 




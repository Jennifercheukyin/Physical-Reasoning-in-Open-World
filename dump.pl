:- dynamic forall/3.
:- dynamic holds/2.

% open container is outermost 
dumpEffects(T, TEND, O) :-
    openContainer(O), 
    holds(T,outsideAt(O,L)),
    format('open container ~s starts at outside ~n',O),
    forall(holds(T, directContained(X, O)), assertz(holds(TEND, outsideAt(X,L)))),
    format('Adding States: ~n'),
    forall(holds(T, directContained(X, O)), print(holds(TEND, outsideAt(X,L)))),
    forall(holds(T, directContained(X, O)), dumpEffects(T,TEND,X)). 

dumpEffects(T, TEND, O) :-
    openContainer(O), 
    holds(TEND,outsideAt(O,L)),
    format('open container ~s ends at outside ~n', O),
    forall(holds(T, directContained(X, O)), assertz(holds(TEND, outsideAt(X,L)))),
    format('Adding States: ~n'),
    forall(holds(T, directContained(X, O)), print(holds(TEND, outsideAt(X,L)))),
    forall(holds(T, directContained(X, O)), dumpEffects(T,TEND,X)). 

dumpEffects(T, TEND, O) :-
    openContainer(O), 
    holds(TEND, directContained(O, NearestClosed)), 
    format('open container ~s is contained in ~s ~n', [O, NearestClosed]), 
    forall(holds(T, directContained(X, O)), assertz(holds(TEND, directContained(X,NearestClosed)))),
    format('Adding States: ~n'),
    forall(holds(T, directContained(X, O)), print(holds(TEND, directContained(X,NearestClosed)))),
    forall(holds(T, directContained(X, O)), dumpEffects(T,TEND,X)). 

% closed container is outmost 
dumpEffects(T, TEND, O) :- 
    closedContainer(O),
    holds(T,outsideAt(O,L)),
    format('closed container ~s starts at outside ~n', O), 
    forall(holds(T,directContained(X,O)), assertz(holds(TEND, directContained(X,O)))),
    format('Adding States: ~n'),
    forall(holds(T,directContained(X,O)), print(holds(TEND, directContained(X,O)))),
    forall(holds(T, directContained(X, O)), dumpEffects(T,TEND,X)). 

dumpEffects(T, TEND, O) :- % doesn't matter where this closed container end up in. It will contain whatever is inside inside. 
    closedContainer(O), 
    not(holds(T,outsideAt(O,L))),
    format('closed container ~s starts contained ~n', O),
    forall(holds(T, directContained(X, O)), assertz(holds(TEND, directContained(X, O)))),
    format('Adding States: ~n'),
    forall(holds(T, directContained(X, O)), print(holds(TEND, directContained(X, O)))),
    forall(holds(T, directContained(X, O)), dumpEffects(T,TEND,X)).

% containerWithLid is a closed container 
dumpEffects(T, TEND, O) :- 
    containerWithLid(O),
    holds(T,outsideAt(O,L)),
    format('container with lid ~s starts outside ~n', O),
    forall(holds(T,directContained(X,O)), assertz(holds(TEND, directContained(X,O)))),
    format('Adding States: ~n'),
    forall(holds(T,directContained(X,O)), print(holds(TEND, directContained(X,O)))),
    forall(holds(T, directContained(X, O)), dumpEffects(T,TEND,X)). 

dumpEffects(T, TEND, O) :- 
    containerWithLid(O), 
    not(holds(T,outsideAt(O,L))),
    format('container with lid ~s starts contained ~n', O),
    forall(holds(T, directContained(X, O)), assertz(holds(TEND, directContained(X, O)))),
    format('Adding States: ~n'),
    forall(holds(T,directContained(X,O)), print(holds(TEND, directContained(X,O)))),
    forall(holds(T, directContained(X, O)), dumpEffects(T,TEND,X)).

dumpEffects(T,TEND,O) :-
    block(O),
    format('~s reach end ~n', O).


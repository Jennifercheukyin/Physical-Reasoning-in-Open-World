:- dynamic earlier/2.
:- multifile(holds/2).

earlier(t0,t1).
earlier(t1,t2).
block(a1).
block(a2).
block(a3).
openContainer(b1).
containerWithLid(b2).
openContainer(b3).
openContainer(oc).
openContainer(od). 
location(l0).

holds(t0,effective(a1)). 
holds(t0,effective(a2)). 
holds(t0,effective(a3)). 
holds(t0,effective(b1)). 
holds(t0,effective(b2)). 
holds(t0,effective(b3)). 
holds(t0,effective(oc)).
holds(t0,effective(od)).

holds(t0,directContained(a1,b1)).
holds(t0,directContained(b1,oc)).
holds(t0,directContained(a2,b2)).
holds(t0,directContained(b2,oc)).
holds(t0,directContained(a3,b3)).
holds(t0,directContained(b3,oc)).
holds(t0,outsideAt(oc,l0)).
holds(t0,outsideAt(od,l0)).

occurs(t0,t1,dump(od)). 
occurs(t1,t2,dump(oc)). 

closedContainer(xd).
lid(xl).
containerWithLid(xw).

% ?- holds(t0,contained(a1,oc)). true 
% ?- holds(t0, notContained(a1,b2)). true
% ?- infer(holds(t1,directContained(a1,b1))). true 
% ?- infer(holds(t2,directContained(a2,b2))). true
% Scenario 1
:- dynamic earlier/2.

earlier(t0,t1).
earlier(t1,t2).
earlier(t2,t3).

block(oa).
openContainer(oc).
lid(ol). 
containerWithLid(ow).
fitsOn(ol,oc).
location(la).

holds(t0,outsideAt(oa,la)).
holds(t0,outsideAt(ol,la)).
holds(t0,outsideAt(oc,la)).
holds(t0,outsideAt(ow,la)).
holds(t0,effective(oa)).
holds(t0,effective(ol)).
holds(t0,effective(oc)).
holds(t0,ineffective(ow)).

occurs(t0,t1,load(oa,oc)).
occurs(t1,t2,seal(oc,ol,ow)).

notOccurs(t0,t3,unsealToAnything(ow)).

closedContainer(xc).

% ?- infer(holds(t3,contained(oa,ow))). true. tested condEffect(seal,contained), condEffect(load,contained), persists(contained(oa,ow))
% ?- infer(holds(t3,outsideAt(ow,la))). false. tested persists(outsideAt,load), persists(outsideAt,seal), persists(outsideAt,notOccurs)
% Scenario 1
:- dynamic earlier/2.

earlier(t0,t1).
earlier(t1,t2).
earlier(t2,t3).
block(oa).
block(ob).
block(od).
openContainer(oc).

location(la).
location(lb).
effective(oa).
effective(ob).
effective(oc).
effective(od).

holds(t0,directContained(oa,oc)).
holds(t0,effective(oa)).
holds(t0,effective(ob)).
holds(t0,effective(oc)).
holds(t0,effective(od)).
holds(t0,outsideAt(ob,la)).
holds(t0,outsideAt(oc,la)).
holds(t0,outsideAt(od,la)).

occurs(t0,t1,load(ob,oc)).
occurs(t2,t3,carry(oc,la,lb)).
notOccurs(t0,t3,dumpAnything).
notOccurs(t1,t2,unload(oa,oc)).
notOccurs(t0,t3,carrySomewhere(od)).
notOccurs(t0,t3,loadIntoSomething(od)).

notOccurs(t0,t3,carrySomewhere(oc)).
notOccurs(t0,t3,loadIntoSomething(oc)).

notOccurs(t0,t3,sealWithAnything(oa)).
notOccurs(t1,t2,unseal(ow,ol,oa)).
notOccurs(t0,t3,sealWithAnything(ob)).
notOccurs(t1,t2,unseal(ow,ol,ob)).
notOccurs(t0,t3,sealWithAnything(oc)).
notOccurs(t1,t2,unseal(ow,ol,oc)).
notOccurs(t0,t3,sealWithAnything(od)).
notOccurs(t1,t2,unseal(ow,ol,od)).
% ?- infer(holds(t3,directContained(oa,oc))).  % should succeed
% ?- infer(holds(t3,outsideAt(od,la))).  % should succeed -> this should fail, since [t1,t2] all effective lose effects 
% ?- infer(holds(t3,directContained(ob,oc))).  % should fail


closedContainer(xd).
lid(xl).
containerWithLid(xw).

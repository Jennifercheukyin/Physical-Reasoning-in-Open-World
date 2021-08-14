earlier(t0,t1).
earlier(t1,t2).
earlier(t2,t3).
earlier(t3,t4).

block(oa).
openContainer(oc).
lid(od).
containerWithLid(ow).
components(oc,od,ow).
location(la).
location(lb).

holds(t0,outsideAt(oa,la)).
holds(t0,outsideAt(oc,la)).
holds(t0,outsideAt(od,la)).
holds(t0,effective(oc)).
holds(t0,effective(od)).
holds(t0,ineffective(ow)).

occurs(t0,t1,load(oa,oc)).
occurs(t1,t2,seal(oc,od,ow)).
notOccurs(t2,t4,unseal(oc,od,ow)).
notOccurs(t0,t4,dumpAnything).
notOccurs(t2,t4,unload(oa,ow)).

% ?- infer(directContained(oa,ow)) should succeed.


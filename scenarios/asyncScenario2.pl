:- dynamic earlier/2.

earlier(t0,t1).
earlier(t0,t3).
earlier(t1,t2).
earlier(t3,t4).
earlier(t2,t5).
earlier(t4,t5).
earlier(t5,t6).

block(oa). 
block(ob). 
openContainer(oc). 
location(l).
holds(t0,outsideAt(oa,l)).
holds(t0,outsideAt(ob,l)).
holds(t0,outsideAt(oc,l)).
holds(t0,effective(oc)).

occurs(t1,t2,load(oa,oc)).
occurs(t3,t4,load(ob,oc)).
occurs(t5,t6,dump(oc)).

notOccurs(t2,t5,unload(oa,oc)).
notOccurs(t2,t5,dumpAnything).
notOccurs(t4,t5,unload(ob,oc)).
notOccurs(t4,t5,dumpAnything).
notOccurs(t0,t5,sealWithAnything(oc)).
notOccurs(t0,t5,carrySomewhere(oc)).
notOccurs(t0,t5,loadIntoSomething(oc)).

closedContainer(xc). 
containerWithLid(xw).
lid(xl).

% ?- infer(holds(t6,outsideAt(oa,l))). should succeed. 

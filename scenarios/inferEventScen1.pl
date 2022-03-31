% This scenario infers event happen in [TA,TB]
% where TA and TB are the actual time period the actions happen 
:- dynamic earlier/2.

earlier(ta,tb).
earlier(tb,tc).
earlier(tc,td).

block(oa).
openContainer(oc).
lid(ol). 
containerWithLid(ow).
components(oc,ol,ow).
location(la). 
location(lb).

holds(ta,ineffective(oc)).
holds(ta,ineffective(ol)).
holds(ta,effective(ow)).
holds(ta,outsideAt(ow,la)). 
holds(ta,directContained(oa,ow)). 
holds(tc,outsideAt(oa,la)). 
holds(td,outsideAt(oa,lb)). 

notOccurs(ta,td,dump(oc)).
notOccurs(tc,td,loadIntoSomething(oa)).

occurs(x0,x1,xa).
closedContainer(xc). 

% ?- inferEvents(ta,tb,[unseal(ow,ol,oc)]). should succeed
% ?- inferEvents(ta,tb,[unload(oa,oc)]). should fail since oc could be dumped
% ?- inferEvents(ta,tb,[carry(ow,la,lb)]). should fail since we need to include immediate actions 
% ?- inferEvents(ta,td,[unseal(ow,ol,oc), unload(oa,oc), carry(oa,la,lb)]). should fail if outsideAt(la); succeed if outsideAt(lb)
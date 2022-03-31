% This scenario infer events happening in [TA,TB]
% where [TA,TB] is the superinterval of [TC,TB],
% [TC,TB] is when the actions actually happen 

:- multifile(earlier/2).

earlier(ta,tb).
earlier(tb,tc).
earlier(tc,td).
earlier(td,te).

block(oa).
openContainer(oc).
lid(od).
containerWithLid(ow).
components(oc,od,ow).
location(la).
location(lb).

holds(ta,outsideAt(oa,la)).
holds(ta,outsideAt(oc,la)).
holds(ta,outsideAt(od,la)).
holds(ta,effective(oc)).
holds(ta,effective(od)).
holds(ta,ineffective(ow)).

occurs(ta,tb,load(oa,oc)).
occurs(tb,tc,seal(oc,od,ow)).
% occurs(tc,td,unseal(ow,od,oc)).
% holds(te,effective(oc)).
holds(te,outsideAt(oa,la)).

% notOccurs(tc,te,dumpAnything). 
notOccurs(tc,te,unload(oa,oc)).

closedContainer(xc). 

% ?- inferEvents(ta/tc,te,[unseal(ow,od,oc)]). this should succeed with or without holds(te,effective(oc)).
% ?- inferEvents(tc,te,[unload(oa,oc)]). this should fail, since we can't guarantee infer(TD,directContained(oa,ow)).
% ?- inferEvents(tc,te,[unseal(ow,od,oc),unload(oa,oc)]). This should succeed if notOccurs(tc,te,dumpAnything). 
% ?- inferEvents(tc,te,[unseal(ow,od,oc),dump(oc)]). This should succeed if notOccurs(tc,te,unload(oa,oc)).
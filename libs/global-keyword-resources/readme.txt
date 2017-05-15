This folder provides generalized keyword resources at a very high design level that can (should) be used by the test suites as much as possible.

Please don't mess this folder up with small ad hoc keyword resources just for the purpose of making some of your personal test suites more compact.
Instead store such individual keyword files locally in your test suite folder.

This global-keyword-resource folder MUST contain ONLY resource files that are ...
1. ... dedicated to a well defined topic that is clearly distinguished (distinguishable) from the tasks of other global resources
2. ... built on a sophisticated designed level - i.e. having a much wider field of activities in view than the current test suite needs would require
3. ... fully parametrized - i.e. none of the keywords is allowed to assume the extistance of any global variable except of ${ROBOT WORKSPACE PATH} - instead local arguments MUST be used
4. ... well documented - i.e. each keyword MUST have a detailed header describing its general purpose, all input parameters, the output values and the keyaword's author
5. ... using as much functionalities of other existing global-keyword-resource files as possible - i.e. avoid code redundances and thus increase maintainability of the whole global-keyword-resource folder

Again, this is a container of general purpose LIBRARIES that require much higher programming/designing efforts and skills than keyword resources of individual test suites require. 
Design errors on this global level will have an impact on a huge amount of test suites and thus have the potential to screw up the whole robotworkspace, whereas design errors on local level only affect a single test suite. 


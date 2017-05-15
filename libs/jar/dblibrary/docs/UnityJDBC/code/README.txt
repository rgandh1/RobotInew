README
------

If the unityjdbc.jar is installed in an existing classpath, then it is
straightforward to compile and execute the sample code.

Make sure you are in the code directory.

To compile:

javac -cp . test/ExampleQuery.java
 
or

javac -cp .;../unityjdbc.jar test/ExampleQuery.java
 
To execute:

java -cp . test.ExampleQuery

or

java -cp .;../unityjdbc.jar test.ExampleQuery

or

java -cp .;../unityjdbc.jar;../sampleDB/hsqldb/hsqldb.jar test.ExampleQuery

(if neither unityjdbc.jar or hsqldb.jar is installed in your classpath)

Note: Splunk JDBC driver test ExampleSplunk.java also requires gson-2.2.4.jar (in drivers/Splunk) in classpath.
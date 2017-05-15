README
------

For more information on UnityJDBC, go to www.unityjdbc.com or send an email to support@unityjdbc.com.

UnityJDBC allows querying multiple sources in one SQL query.  The unityjdbc.jar file contains built-in JDBC drivers for MongoDB, Splunk, and ServiceNow that can be used independently of UnityJDBC.


QUICK START MongoDB
-------------------

1) Copy the unityjdbc.jar and drivers/mongo-java-driver-2.12.2.jar into CLASSPATH OR the mongodb_unityjdbc_full.jar into the CLASSPATH.

2) JDBC Driver class name:  mongodb.jdbc.MongoDriver
   URL format:              jdbc:mongo://<serverName>/<databaseName>
   Example live URL:        jdbc:mongo://ds029847.mongolab.com:29847/tpch

3) Use SQL and JDBC as usual.


QUICK START ServiceNow
----------------------

1) Copy the unityjdbc.jar into CLASSPATH.

2) JDBC Driver class name:  snow.jdbc.SNowDriver
   URL format:              jdbc:snow://<serverName>
   Example live URL:        jdbc:snow://demoodbc.service-now.com

3) Use SQL and JDBC as usual.


	
PACKAGE CONTENTS
----------------

unityjdbc.jar 			- main UnityJDBC jar file
mongodb_unityjdbc_full.jar	- may use instead of UnityJDBC jar.  Contains unityjdbc.jar bundled with mongo-java-driver.jar.
UnityJDBCDoc.pdf		- PDF version of user documentation
initsources.bat			- script to start SourceBuilder utility (Windows)
initsources.sh			- script to start SourceBuilder utility (UNIX)

code/              
   test/
     ExampleQuery.java		- query example of UnityJDBC driver
     ExampleMetaData.java	- query example showing how to extract metadata information
     ExampleUpdate.java		- demonstrates INSERT/UPDATE/DELETE
     ExampleNoFileConnection.java - shows how to pass connection information directly to the driver without storing in files
     ExampleEngine.java		- shows how users can use the UnityJDBC database engine directly
     
     xspec/
       UnityDemo.xml		- source group file for example databases
       UnityDemoOrder.xml	- schema file for TPC-H Order database schema
       UnityDemoPart.xml	- schema file for TPC-H Part database schema       
       mydb.xml			- schema file for HSQL database with a customer table
       emptydb.xml		- schema file for (mostly) empty HSQL database 
     
   mongodb			- Example code using MongoDB JDBC built into UnityJDBC which can be used directly as well
       ExampleMongoJDBC.java					- Demonstrates how to write queries using the Mongo JDBC driver. 
       ExampleMongoJDBCDataSource.java				- The JDBC Driver for MongoDB supports connecting using DataSource and XADataSource for use with connection pools and web application servers.       
       ExampleMongoJDBCMetadata.java				- Demonstrates how to retrieve and build metadata for a MongoDB database.
       ExampleMongoJDBCNestedArray.java				- Demonstrates how to write queries using the Mongo JDBC driver using a database with nested collections and arrays. 
       ExampleMongoJDBCUpdate.java				- Demonstrates how to write queries using the Mongo JDBC driver using a database with read/write privileges. 
       ExampleMongoPreparedStatement.java			- Demonstrates how to use PreparedStatements using the Mongo JDBC driver. 
       ExampleMongoPreparedStatementInsertUpdateDelete.java	- Demonstrates how to use PreparedStatements using the Mongo JDBC driver with INSERT, UPDATE, and DELETE statements.
       ExampleMongoTranslate.java				- Demonstrates how to use the MongoDB JDBC driver as a SQL to MongoDB query translation service.
       ExampleMongoJDBCDynamicSchema.java			- Demonstrates how to dynamically modify the schema of the Mongo JDBC driver using the Java API.
       mongo.jsp						- JSP file connecting to MongoDB
       mongo_jstl.jsp						- JSTL connecting to MongoDB
       mongo_jstl_multiple_query.jsp				- JSTL connecting to MongoDB with multiple queries

   quandl
       ExampleQuandl.java			- Example of using Quandl JDBC driver.
       
   servicenow
       ExampleServiceNow.java			- Example using ServiceNow JDBC driver built into UnityJDBC which can be used directly as well
       ExampleServiceNowExtractLargeTable.java	- Example using ServiceNow JDBC driver to parallel extract large table for use in ETL and data warehousing
              
   splunk
       ExampleSplunk.java	- Example using Splunk JDBC driver built into UnityJDBC which can be used directly as well
       
   com/unityjdbc/sourcebuilder
       SchemaExtractor.java	- Java code for extracting schemas for use with UnityJDBC (can use instead of SourceBuilder)
       
   unity/       
     functions/
       A_Aggregate_template.java- Template for aggregate user-defined functions
       A_Fibonacci.java		- Example aggregate UDF
       F_Function_template.java	- Template for single row user-defined functions
       F_Multiply.java		- Example standard row UDF
       F_Double.java		- Example user-defined function
       mapping.xml		- Example mapping file to specify user-defined functions
       
sampleDB/
   hsqldb/
     startDB.sh			- Linux script to start HSQL database server
     startDB.bat		- Windows script to start HSQL database server
     startDBManager.bat		- Windows script to start HSQL database manager client (GUI for HSQL DB)
     startDBManager.sh		- Linux script to start HSQL database manager client (GUI for HSQL DB)  
     (other files for three sample DBs: tpch, mydb, emptydb)

webserver/			- information on how to configure UnityJDBC for use with web servers
   webserver_config.pdf		- step-by-step instructions for web server configuration
   unity/			- a complete web application for testing
   jars/			- some supporting jars that may be used for connection pooling


INSTALLATION
------------
Copy the unityjdbc.jar into a directory that is in your CLASSPATH.
An easy method to do this is to put the file in your ext directory of your JDK and JRE installation.
e.g. C:\Program Files\Java\jdk1.7\jre\lib\ext


RUNNING TESTS
-------------

1) Start the HSQL database by running startDB.sh or startDB.bat.
2) Compile and run the test programs in your development environment.  

If you are in the code directory from the command-line execute this to compile: 

javac -cp .;../unityjdbc.jar;../sampleDB/hsqldb/hsqldb.jar test/ExampleQuery.java

Then this to run:

java -cp .;../unityjdbc.jar;../sampleDB/hsqldb/hsqldb.jar test.ExampleQuery


SETTING UP YOUR OWN ENVIRONMENT
-------------------------------

You need to do two things.  First, create a sources XML file that lists the connection information for all the sources
you want to query.  The example UnityDemo.xml is a sources file and looks like this:

<SOURCES>	
	<DATABASE>
		<URL>jdbc:hsqldb:hsql://localhost/tpch</URL>
		<USER>sa</USER>
		<PASSWORD></PASSWORD>
		<DRIVER>org.hsqldb.jdbcDriver</DRIVER>
		<XSPEC>UnityDemoPart.xml</XSPEC>
	</DATABASE>
	<DATABASE>
		<URL>jdbc:hsqldb:hsql://localhost/tpch</URL>
		<USER>sa</USER>
		<PASSWORD></PASSWORD>
		<DRIVER>org.hsqldb.jdbcDriver</DRIVER>
		<XSPEC>UnityDemoOrder.xml</XSPEC>
	</DATABASE>
	<DATABASE>
		<URL>jdbc:hsqldb:hsql://localhost/emptydb</URL>
		<DRIVER>org.hsqldb.jdbcDriver</DRIVER>
		<XSPEC>emptydb.xml</XSPEC>		
	</DATABASE>
	<DATABASE>
		<URL>jdbc:hsqldb:hsql://localhost/xdb</URL>
		<DRIVER>org.hsqldb.jdbcDriver</DRIVER>
		<XSPEC>mydb.xml</XSPEC>
		<USER>test</USER>
		<PASSWORD>test</PASSWORD>
	</DATABASE>	
</SOURCES>


This is showing four data sources.  Note that we split the TPC-H schema into two data sources: a Part database and an Order database.  Each database entry contains the regular JDBC connection information including the JDBC URL, driver class, and the location of the XSpec schema XML file describing the database schema and contents.

The XSpec schema XML file is used so that the driver does not have to extract schema information every query and can perform better
optimization.  It also allows users to provide a view of the database by only including tables and fields in the XSpec file
that the UnityJDBC driver can access.  The XSpec file must be locally accessible but can be retrieved over the Internet.
There is an encryption feature for XSpecs if you put them in Internet-accessible locations.

As an example, open up the UnityDemoOrder.xml XSpec.  It contains an XML encoding of the schema.  A few important tags:

<databaseName>OrderDB</databaseName> 		- OrderDB will be the name of the database in queries (very important)
<databaseId>95010800</databaseId>		- Specifies the dialect is an HSQL database.  Allows UnityJDBC to translate query to source dialect automatically.
<semanticTableName></semanticTableName> 	- You can rename any database table to have your own alias.
<tableName>CUSTOMER</tableName>			- The database table name in the schema.
<numTuples>1500</numTuples>			- The size of the table in tuples.  Used by optimizer.
...
<semanticFieldName></semanticFieldName>		- You can provide an alias for any field as well.
<fieldName>C_ADDRESS</fieldName>		- Field name assigned in the schema.
...
<numDistinctValues>1500</numDistinctValues>	- Used by optimizer.


Although you can build the sources.xml file manually, the easiest way is to use the SourceBuilder.java program.  This is a GUI that will guide you through creating the files.  It will automatically extract source information and build the necessary files.  Then, copy and modify the ExampleQuery.java program to use your sources XML file and write an appropriate query for your schema.


SUPPORT
-------

If you have any problems, consult the documentation and user support forums at www.unityjdbc.com.  We would also appreciate any
bug fixes or suggested new features.  You may also send your support related questions to support@unityjdbc.com.

--
UnityJDBC Team
     
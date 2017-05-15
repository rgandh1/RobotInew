package test;

import java.sql.DatabaseMetaData;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Properties;

import unity.annotation.GlobalSchema;
import unity.io.FileManager;
import unity.jdbc.UnityConnection;
import unity.util.StringFunc;

/**
 * Demonstrates how to pass the connection and database schema information to UnityJDBC without storing this information in files.
 * 
 * <p>There are two choices:
 * <ol>
 * <li>Create all your connection information in the sources file and all the schema files and pass them in as properties during the call to getConnection().
 * <li>At any time, you can add or remove sources by database name.  For adding a source, you must either provide the source information in XML format or as parameters
 * to the method.  All schema information must be passed in XML format.
 * </ol>
 * 
 * <p>The name of the property is "sources" that should be passed into the driver as connection information.  There should also be a property with the name of each database
 * schema.  For example, if your schema contains databases order and part, then their should be two properties order and part which have values equal to the string representation
 * of their XML schema file.
 */
@SuppressWarnings("nls")
public class ExampleNoFileConnection 
{		 
	private static String url="jdbc:unity://virtual";				// By specifying virtual instead of a file path, UnityJDBC does not look for a sources.xml file.
	private static UnityConnection con = null;

	// The Sources file in string form.  This could be produced dynamically rather than hard-coded.
	private static String sourcesXML = "<SOURCES>"	
									+"\n<DATABASE>"
									+"\n<URL>jdbc:hsqldb:hsql://localhost/tpch</URL>"
									+"\n<USER>sa</USER>"
									+"\n<PASSWORD></PASSWORD>"
									+"\n<DRIVER>org.hsqldb.jdbcDriver</DRIVER>"
									+"\n<XSPEC>OrderDB</XSPEC>"
									+"\n</DATABASE>"
									+"\n<DATABASE>"
									+"\n<URL>jdbc:hsqldb:hsql://localhost/tpch</URL>"
									+"\n<USER>sa</USER>"
									+"\n<PASSWORD></PASSWORD>"
									+"\n<DRIVER>org.hsqldb.jdbcDriver</DRIVER>"
									+"\n<XSPEC>PartDB</XSPEC>"
									+"\n</DATABASE>"
									+"\n</SOURCES>";
	
	private static String orderSchema, partSchema;	
	/**
	 * Main method
	 * @param argv
	 * 			no argv required
	 */
	public static void main(String []argv)
	{
		try
		{
			// Create new instance of UnityDriver and make connection
			System.out.println("Registering driver.");
			Class.forName("unity.jdbc.UnityDriver");
	
			System.out.println("Getting connection:  "+url);
			Properties info = new Properties();
			info.put("sources", sourcesXML);
			
			// Read in the schema files so can pass them directly to driver
			// This XML information could be retrieved from a database or other secure location.
			orderSchema = FileManager.readFileToString("test/xspec/UnityDemoOrder.xml");
			info.put("OrderDB", orderSchema);

			partSchema = FileManager.readFileToString("test/xspec/UnityDemoPart.xml");
			info.put("PartDB", partSchema);

			con = (UnityConnection)DriverManager.getConnection(url, info);					// Note: The use of properties when configuring the connection.
			System.out.println("Connection successful for "+ url);
			
			// Output the list of tables to demonstrate that the schema has been loaded.
			printSchema();
            
            // Remove the PartDB database from the schema
			GlobalSchema gs = con.getGlobalSchema();
            gs.removeDatabase("PartDB");
            
            // Output the list of tables to demonstrate that the PartDB tables have been removed.
			printSchema();
			
			// Add the database by providing all the information as parameters
			gs.addDatabase("PartDB", "sa", null,  "org.hsqldb.jdbcDriver", "jdbc:hsqldb:hsql://localhost/tpch", partSchema);
			printSchema();
						
			// Remove the database
			gs.removeDatabase("PartDB");
			
			// Add the database again but this time pass the database information as an XML string
			int secondDBPos = sourcesXML.lastIndexOf("<DATABASE>");
			String dbinfo = "<SOURCES>"+sourcesXML.substring(secondDBPos);
	        gs.addDatabase("PartDB", dbinfo, partSchema);
			printSchema();
		}
		catch (Exception e)
		{	System.out.println(e);
		}
	}

	private static void printSchema() throws SQLException
	{
		System.out.println("\n\n");
		DatabaseMetaData dmd = con.getMetaData(); 
    	ResultSet rst = dmd.getTables(null, "%", "%", new String[]{"TABLE"});                       
        String result = StringFunc.resultSetToString(rst);
        rst.close();
        System.out.println(result);
	}	   
}

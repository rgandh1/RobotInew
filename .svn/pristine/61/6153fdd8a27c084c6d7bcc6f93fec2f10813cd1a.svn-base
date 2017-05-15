package test;

import java.sql.*;

/**
 * Demonstrates the UnityJDBC driver's support for the DatabaseMetaData interface. 
 * Lists all the databases, tables, and fields accessible in all the sources integrated.
 */
@SuppressWarnings({"nls"})
public class ExampleMetaData
{	

	/**
	 * Main method
	 * @param args
	 * 			no args required
	 */
	public static void main(String[] args)
	{	// Change this line to reference the location of your sources XML file

		String url="jdbc:unity://test/xspec/UnityDemo.xml";		
		
		try 
		{	// Load driver class
			Class.forName("unity.jdbc.UnityDriver");
		}
		catch (java.lang.ClassNotFoundException e) 
		{
			System.err.println("ClassNotFoundException: " +e);
		}

		Connection con = null;
		try {
			con = DriverManager.getConnection(url);

			String []tblTypes = {"TABLE"};				// What table types to retrieve

			// Retrieve the database metadata
			DatabaseMetaData dmd = con.getMetaData();  	// Get metadata
			ResultSet rs1, rs5; 
			
			// Retrieve all the tables
			rs1 = dmd.getTables(null,null, "%",tblTypes);
			
			System.out.println("List all table metadata fields: ");
			ResultSetMetaData rsmd = rs1.getMetaData();
			for (int i=0; i < rsmd.getColumnCount(); i++)
				System.out.println(rsmd.getColumnName(i+1));

			System.out.println("\nList all tables in all databases: ");
			
			while (rs1.next()) 
			{
				String tblName = rs1.getString(3);
				String dbName = rs1.getString(1); 
				System.out.println("\nDatabase: "+dbName+" Table: "+tblName);
				
				// Retrieve all the fields for a table
				rs5 = dmd.getColumns(dbName,null,tblName,"%");
				System.out.println("Attributes: ");

				while (rs5.next()) {
					System.out.println(rs5.getString(4));
				}
				rs5.close();
			} // end outer while
			rs1.close();

		}
		catch (SQLException ex) 
		{
			System.err.println("SQLException: " + ex); 
		}
		finally
		{			
			try
			{	// Close connection
				if (con != null)
					con.close();
			}
			catch (SQLException ex)
			{	System.err.println("SQLException: " + ex);
			}
		}
	}
}

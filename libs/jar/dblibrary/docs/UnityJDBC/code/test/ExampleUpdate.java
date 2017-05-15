package test;

import java.sql.*;

import unity.jdbc.UnityStatement;

/**
 * Provides examples of performing INSERT, UPDATE, and DELETE with UnityJDBC.
 * Contains an example of performing an INSERT INTO .. SELECT where the query result produced by the SELECT is inserted into a different database.
 */
@SuppressWarnings({"nls"})
public class ExampleUpdate
{
	// URL for sources.xml file specifying what databases to integrate.
	private static String url="jdbc:unity://test/xspec/UnityDemo.xml";	// Add ?debug=true to end of URL to enter verbose, debugging mode

	/**
	 * Main method
	 * 
	 * @param args
	 * 			no args required
	 */
	public static void main(String [] args)
	{
		Connection con = null;
		Statement stmt = null;
		ResultSet rst = null;

		try
		{
			// Create new instance of UnityDriver and make connection
			System.out.println("\nRegistering driver.");
			Class.forName("unity.jdbc.UnityDriver");

			System.out.println("\nGetting connection:  "+url);
			con = DriverManager.getConnection(url);
			System.out.println("\nConnection successful for "+ url);

			System.out.println("\nCreating statement.");
			stmt = con.createStatement();

			// Example #1: Basic Query
			String sql = "SELECT * FROM mydb.Customer;";
			System.out.println("\nExecuting query: \n"+sql);
			long timeStart = System.currentTimeMillis();
			long timeEnd;
			rst = stmt.executeQuery(sql);
			int i = printResult(rst);
			timeEnd = System.currentTimeMillis();
			System.out.println("Query took: "+((timeEnd-timeStart)/1000)+" seconds");
			System.out.println("Number of results printed: "+i);
			stmt.close();
			System.out.println("\nOPERATION COMPLETED SUCCESSFULLY!");

			// Example #2: DELETE using native parsing
			sql = "DELETE FROM mydb.customer WHERE mydb.customer.id = 51 or mydb.customer.id=52;";
			stmt.executeUpdate(sql);

			// Example #3: INSERT (by-pass method)
			String databaseName = "mydb";
			sql = "INSERT INTO Customer (id,firstname,lastname,street,city) VALUES (51,'Joe','Smith','Drury Lane', 'Detroit')";
			((UnityStatement) stmt).executeByPassUpdate(databaseName,sql);

			// Example #4: INSERT - Unity Parsed
			sql = "INSERT INTO mydb.Customer (id, firstname, lastname, street, city) VALUES (52,'Fred','Jones','Smith Lane', 'Chicago');";
			stmt.executeUpdate(sql);

			// Let's verify the last two records were inserted successfully
			sql = "SELECT * FROM mydb.Customer;";
			rst = stmt.executeQuery(sql);
			printResult(rst);

			// Example #5: INSERT INTO (SELECT...) across databases
			sql = "INSERT INTO emptydb.customer SELECT * FROM mydb.customer;";
			stmt.executeUpdate(sql);

			// Prove that we transferred the data
			sql = "SELECT * FROM emptydb.Customer;";
			rst = stmt.executeQuery(sql);
			printResult(rst);
			
			System.out.println("\n\nUPDATE OPERATIONS SUCCESSFUL.");
		}
		catch (Exception ex)
		{	System.out.println("SQLException: " + ex);
		}
		finally
		{
			if (con != null)
				try{
					con.close();
				}
			catch (SQLException ex)
			{	
				System.out.println("SQLException: " + ex);
			}
			
			if (rst != null)
				try{
					rst.close();
				}
				catch (SQLException ex)
				{	
					System.out.println("SQLException: " + ex);
				}
		} // end try-catch-finally block
	} //end main()


	/**
	 * Print all results in the result set
	 * 
	 * @param rst
	 * 			Result Set
	 * @return # of result set printed
	 * @throws SQLException
	 * 			if a SQL error occurs
	 */
	public static int printResult(ResultSet rst) throws SQLException
	{
		System.out.println("\n\nTHE RESULTS:");
		int i=0;

		ResultSetMetaData meta = rst.getMetaData();

		System.out.println("Total columns: " + meta.getColumnCount());
		System.out.print(meta.getColumnName(1));
		for (int j = 2; j <= meta.getColumnCount(); j++)
			System.out.print(", " + meta.getColumnName(j));
		System.out.println();

		while (rst.next()) {
			System.out.print(rst.getObject(1));
			for (int j = 2; j <= meta.getColumnCount(); j++)
				System.out.print(", " + rst.getObject(j));
			System.out.println();
			i++;
		}
		return i;
	}
}

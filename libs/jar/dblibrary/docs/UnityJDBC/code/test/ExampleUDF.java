package test;
 
import java.sql.*;

import unity.util.StringFunc;

/**
 * Demonstrates how to write queries using the UnityJDBC driver that have user-defined functions (UDFs).
 * 
 * Note: udf.jar in unity/functions or the class files for F_Double.class, F_Multiply.class, A_Fibonacci.class must be in classpath for ExampleUDF to run. 
 */
@SuppressWarnings({"nls"})
public class ExampleUDF 
{
	// URL for sources.xml file specifying what databases to integrate.  This file must be locally accessible or available over the Internet.
	private static String url="jdbc:unity://test/xspec/UnityDemo.xml";
	
	/**
	 * Main method
	 * 
	 * @param args
	 * 			no arguments required
	 */
	public static void main(String[] args)
	{
		Connection con = null;
		Statement stmt = null;
		ResultSet rst;
		
		try {
			// Create new instance of UnityDriver and make connection
			System.out.println("\nRegistering driver.");
			Class.forName("unity.jdbc.UnityDriver");
			
			System.out.println("\nGetting connection:  "+url);
			con = DriverManager.getConnection(url);
			System.out.println("\nConnection successful for "+ url);

			System.out.println("\nCreating statement.");
			stmt = con.createStatement();
	
			// User-defined functions DOUBLE() as well as MULTIPLY().
			// Note: UDFs not defined by a mapping.xml file in Unity will automatically be passed down to source for execution.
			//       If this is not correct, then you must create a mapping.xml file for execution.
			// This example involves a join across sources so the functions will be executed by UnityJDBC not on the sources.
			String sql = "SELECT n_nationkey, double(n_nationkey) as doubleNum, multiply(n_nationkey, 4) as multiplyVal " +
						 " FROM OrderDB.Nation N INNER JOIN PartDB.Region R ON N.n_regionkey = R.r_regionkey" +
						 " WHERE n_nationkey < 4;";
					
			System.out.println("\nExecuting query: \n"+sql);
			rst = stmt.executeQuery(sql);
						
			// Print out results
			System.out.println(StringFunc.resultSetToString(rst));
						
			
			// User-defined aggregate function example
			// Fibonacci() aggregate function returns the kth A_Aggregate_template.java
			// Returns the kth Fibonacci number where k is the number of rows with non-null values for given expression
			// Note: Using a CASE statement to make all odd values NULL.
			sql = "SELECT n_regionkey, fibonacci(CASE WHEN n_regionkey % 2 = 0 THEN 1 ELSE null END) as fib " +
                    " FROM OrderDB.Nation N INNER JOIN PartDB.Region R ON N.n_regionkey = R.r_regionkey" +
                    " GROUP BY n_regionkey";
               
			System.out.println("\nExecuting query: \n"+sql);
			rst = stmt.executeQuery(sql);
               
			// Print out results
			System.out.println(StringFunc.resultSetToString(rst));
			
			stmt.close();  			
			System.out.println("\nOPERATION COMPLETED SUCCESSFULLY!"); 
		}
		catch (Exception ex)
		{	System.out.println("Exception: " + ex);
		}
		finally
		{			
			if (con != null)
			{	try
				{	// Close the connection
					con.close();				
				}
				catch (SQLException ex)
				{	System.out.println("SQLException: " + ex);
				}
			}
		} 		
	} 
} 

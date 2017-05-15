/*
 * This code was created by Unity Data Inc. (www.unityjdbc.com).
 * 
 * It may be freely used, modified, and distributed with no restrictions.
 */

package splunk;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.ResultSetMetaData;
import java.sql.SQLException;
import java.sql.Statement;

/**
 * Demonstrates how to write queries using the Splunk JDBC driver.
 */
public class ExampleSplunk
{
    // Splunk connection URL
    // This URL will use the existing schema (if it exists)
    private static String url = "jdbc:splunk://localhost:8089?schema=splunk_schema.xml&debug=false";

    // This URL would rebuild the schema
    // private static String url = "jdbc:splunk://localhost:8089?schema=splunk_schema.xml&debug=false&rebuildschema=true";

    /**
     * Main program.
     * 
     * @param args
     *            input arguments (none expected)
     */
    public static void main(String[] args)
    {
        Connection con = null;

        try
        {
            // Create new instance of Splunk JDBC Driver and make connection
            System.out.println("\nRegistering driver.");
            Class.forName("splunk.jdbc.SplunkDriver");

            String user = "admin", password = "";   // TODO: Change these.
            System.out.println("\nGetting connection:  " + url);
            con = DriverManager.getConnection(url, user, password);
            System.out.println("\nConnection successful for " + url);

            // Do a dynamic search
            String sql = "SELECT * FROM DynamicSearch WHERE search = 'search error | head 10';";
            doQuery(con, sql);

            // Execute a saved search with an additional filter
            sql = "SELECT bytes, clientip FROM \"Errors in the last 24 hours\" WHERE bytes > 1000 ORDER BY bytes DESC LIMIT 10;";
            doQuery(con, sql);

            System.out.println("\nOPERATION COMPLETED SUCCESSFULLY!");
        }
        catch (Exception ex)
        {
            System.out.println("Exception: " + ex);
            ex.printStackTrace();
        }
        finally
        {
            if (con != null)
            {
                try
                {	// Close the connection
                    con.close();
                }
                catch (SQLException ex)
                {
                    System.out.println("SQLException: " + ex);
                }
            }
        }
    }

    /**
     * Executes a query on a connection to Splunk.
     * 
     * @param con
     *            Splunk connection
     * @param sql
     *            SQL query to execute
     * @throws Exception
     *             if an error occurs
     */
    public static void doQuery(Connection con, String sql)
            throws Exception
    {
        System.out.println("\nExecuting query: \n" + sql);
        long timeStart = System.currentTimeMillis();
        long timeEnd;

        Statement stmt = con.createStatement();
        ResultSet rst;

        rst = stmt.executeQuery(sql);

        System.out.println("\n\nTHE RESULTS:");
        int i = 0;

        ResultSetMetaData meta = rst.getMetaData();

        // Print out a row of column headers
        System.out.println("Total columns: " + meta.getColumnCount());
        System.out.print(meta.getColumnName(1));
        for (int j = 2; j <= meta.getColumnCount(); j++)
            System.out.print(", " + meta.getColumnName(j));
        System.out.println();

        // Print out all rows in the ResultSet
        while (rst.next())
        {
            System.out.print(rst.getObject(1));
            for (int j = 2; j <= meta.getColumnCount(); j++)
                System.out.print(", " + rst.getObject(j));
            System.out.println();

            i++;
        }

        timeEnd = System.currentTimeMillis();
        System.out.println("Query took: " + (timeEnd - timeStart) + " milliseconds");
        System.out.println("Number of results printed: " + i);
        rst.close();
        stmt.close();
    }
}

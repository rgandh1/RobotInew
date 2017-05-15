/*
 * This code was created by Unity Data Inc. (www.unityjdbc.com).
 * 
 * It may be freely used, modified, and distributed with no restrictions.
 */

package quandl;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.ResultSetMetaData;
import java.sql.SQLException;
import java.sql.Statement;

/**
 * Demonstrates how to write queries using the Quandl JDBC driver.
 */
public class ExampleQuandl
{
    // Quandl connection URL
    // This URL will create a schema on each connection for the Quandl codes (tables) listed:
    private static String url = "jdbc:quandl://www.quandl.com/api/v1?debug=false&tables=FRED/CAPOP,FRED/POPTTLCAA173NUPN,FRED/POPTTLUSA148NRUG,ODA/USA_NGDP";
    
    // To cache a schema and not rebuild it each time use the schema parameter like this:
    // Note that the schema must have been previously built.
    // private static String url = "jdbc:quandl://www.quandl.com/api/v1?schema=quandl_schema.xml";
    
    // Other parameters:
    //    debug=true            - provide additional information on query processing
    //    schema=quandl.xml     - save the schema in a local file called quandl.xml (default is quandl_schema.xml)
    //    password=X            - specify a Quandl authentication code in the URL
    
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
            String user = "", password = "expu3QCG3yrRWq4oFTmj";    // TODO: Enter your Quandl authentication code for a password
            System.out.println("\nGetting connection:  " + url);
            con = DriverManager.getConnection(url, user, password);
            System.out.println("\nConnection successful for " + url);

            // Execute a query
            System.out.println("\n\nCalifornia Population Last 3 Years");
            System.out.println("----------------------------------");
            String sql = "SELECT Date, Value as California_Population_In_Thousands FROM \"FRED/CAPOP\" WHERE Date > '2001-01-01' ORDER BY Date ASC LIMIT 3;";
            doQuery(con, sql);

            // Execute a query that involves expressions and a join
            System.out.println("\n\nCalifornia Population Versus USA Population Since 1980");
            System.out.println("------------------------------------------------------");
            sql = "SELECT year(USA.Date) Year, CA.Value/1000 as California_Population_In_Millions, USA.Value as USA_Population_In_Millions, round(CA.value/USA.Value*10)/100+'%' as Percent_In_California "
                    +" FROM \"FRED/CAPOP\" CA INNER JOIN \"FRED/POPTTLUSA148NRUG\" USA ON CA.Date = USA.Date WHERE Year >= 1980 ORDER BY Year ASC;";
            doQuery(con, sql);

            System.out.println("\nQUERIES COMPLETED SUCCESSFULLY!");
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
     * Executes a query on a connection to Quandl.
     * 
     * @param con
     *            Quandl connection
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

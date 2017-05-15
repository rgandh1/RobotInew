/*
 * This code was created by Unity Data Inc. (www.unityjdbc.com).
 * 
 * It may be freely used, modified, and distributed with no restrictions.
 */

package servicenow;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Calendar;

/**
 * Administrators often need to extract data from ServiceNow to load it into another database for analysis. The ServiceNow JDBC driver makes this
 * process easy and has been optimized to move large data sets out of ServiceNow efficiently using a SQL/JDBC interface that works with all popular ETL software.
 * 
 * This example demonstrates how to extract very large tables from ServiceNow. The JDBC driver automatically handles batching and parallel requests to
 * improve speed. In this example, we also skip building a schema and only request a schema for a small set of tables to be extracted.
 */
public class ExampleServiceNowExtractLargeTable
{
    // TODO: Change this URL to your system URL.
    // By default: batchsize=1000, threads=5. These URL parameters do not have to be specified if use defaults.
    // Set the tables parameter to be a comma-separated list of the tables to extract/query.
    private static String url = "jdbc:snow://demoodbc.service-now.com?tables=alm_asset,incident&debug=false&batchsize=2000&threads=6";

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
            // Create new instance of ServiceNow JDBC Driver and make connection
            // TODO: Set the user id and password for ServiceNow user.
            // Note: This user must have SOAP privilege and access to the table being queried.
            String user = "admin", password = "admin";
            System.out.println("\nGetting connection:  " + url);
            con = DriverManager.getConnection(url, user, password);
            System.out.println("\nConnection successful for " + url);
            Statement stmt = con.createStatement();

            // Retrieve incident table records
            String sql = "SELECT * FROM incident";
            ResultSet rst = stmt.executeQuery(sql);

            System.out.println("\n\nResults from Incident table:\n");
            // Note: To minimize output to screen, only printing incident number, but can use code below to print out entire ResultSet
            // String result = StringFunc.resultSetToString(rst);
            // System.out.println(result);
            int count = 0;
            while (rst.next())
            {
                System.out.println(rst.getString("number"));
                count++;
            }

            System.out.println("Total rows retrieved: " + count);

            System.out.println("\n\nResults from Incident table in last 4 hours (used for ETL warehouse refresh):\n");

            // A common ETL task is to refresh update the data. To minimize data transfer on every load, you can use the ServiceNow sys_updated_on field to
            // only retrieve rows updated since a given time.
            // Set up date to be 4 hours earlier
            Calendar cal = Calendar.getInstance();
            cal.add(Calendar.HOUR, -4);
            DateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
            sql += " WHERE sys_updated_on >= '" + dateFormat.format(cal.getTime()) + "' ORDER BY sys_updated_on ASC";

            System.out.println("SQL query executed: " + sql);

            rst = stmt.executeQuery(sql);
            count = 0;
            while (rst.next())
            {
                System.out.println(rst.getString("number") + ", " + rst.getString("sys_updated_on"));
                count++;
            }

            System.out.println("Total rows updated in last 4 hours: " + count);
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
}

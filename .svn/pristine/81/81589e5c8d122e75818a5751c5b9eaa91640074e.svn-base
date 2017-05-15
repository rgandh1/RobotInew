package test;

import java.math.BigDecimal;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;

import unity.engine.Tuple;
import unity.jdbc.UnityStatement;
import unity.operators.DynamicHashJoin;
import unity.operators.MergeSort;
import unity.operators.Operator;
import unity.operators.Projection;
import unity.operators.ProjectionList;
import unity.operators.ResultSetScan;
import unity.operators.Selection;
import unity.predicates.And;
import unity.predicates.ConstantSelectionPredicate;
import unity.predicates.Greater;
import unity.predicates.IntJoinPredicate;
import unity.predicates.JoinPredicate;
import unity.predicates.Less;
import unity.predicates.SelectionPredicate;
import unity.predicates.SortComparator;
import unity.query.GlobalQuery;
import unity.query.LQTree;
import unity.query.LocalQuery;

/**
 * Built into the UnityJDBC driver is a relational database engine that you can use directly.
 * 
 * <p>There are two common uses:
 * <ol>
 * <li> Execute your own queries to get ResultSets.  Build a logical query tree of relational operators to select, project, or join the ResultSets together however you wish.
 * <li> Write a UnityJDBC query and have the driver parse and build the execution tree for you.  Modify the tree or just monitor its execution as the query is running.
 * </ol>
 */
@SuppressWarnings({"nls","javadoc"})
public class ExampleEngine
{
	private static String url="jdbc:unity://test/xspec/UnityDemo.xml";
	
	public static void main(String [] args) throws Exception
	{
		example1();	
		example2();
	}
	
	// These variables are used for example 1
	private	static String dburl = "jdbc:hsqldb:hsql://localhost/tpch";
	private	static String uid = "sa";
	private	static String pw = "";

	// TPC-H queries
	private static String query1 = "SELECT O_orderkey, o_custkey, o_orderdate, o_totalprice FROM Orders WHERE o_totalprice < 1000";	
	private static String query2 = "Select c_custkey, c_name, c_acctbal FROM customer";	
	
	/**
	 * This example shows how a user can use the engine to manipulate ResultSets using relational algebra operators.
	 */
	public static void example1()
	{	
		System.out.println("\nBEGINNING EXAMPLE 1: USING THE UNITYJDBC DATABASE ENGINE\n");
		
		try
		{			
			Connection con = makeConnection();
			// Build an execution tree with a projection, selection, global join, and two result set scans
			// Global join can either be a merge join or a hash join
			// On top of tree is sort by operator
			// Equivalent global query is:
			//	SELECT c_acctbal, c_custkey, c_name, o_orderkey
			//	FROM Orders O, Customer C 
			//	WHERE O.o_custkey = C.c_custkey AND c_acctbal > 0 and o_totalprice < 1000
			//	ORDER BY c_acctbal
			
			// First execute subqueries and generate ResultSets used for ResultSet scan operator
			// Note: This execution is normally done with the Unity execution engine
			Statement stmt1 = con.createStatement();
			ResultSet rst1 = stmt1.executeQuery(query1);		
			ResultSetScan fs1 = new ResultSetScan(rst1);
			fs1.init();		// ResultSetScan uses its init to set up its output relation which will be used by other operators.
			
			Statement stmt2 = con.createStatement();
			ResultSet rst2 = stmt2.executeQuery(query2);
			ResultSetScan fs2 = new ResultSetScan(rst2);
			fs2.init();		
			
			// Above that is a join operator in the tree
			// Note can only use merge join if result is sorted on join key
			// Merge join and hash join are equi-joins.  Hence, must define an equi-join predicate.  
			JoinPredicate ep = new IntJoinPredicate(1, 0, null);		// Requires index of attributes to equate
			
			// MERGE JOIN
			// NOTE: Must sort on custkey for merge join to work
			// Can do this by doing ORDER BY custkey in the individual queries or sorting as they come in (we will choose the latter)
			// int msbfr = 10, msbsize = 1000;
			// SortComparator ms1sorter = new SortComparator(new int[]{1}, new boolean[]{true});
			// SortComparator ms2sorter = new SortComparator(new int[]{0}, new boolean[]{true});
			// MergeSort sorter1 = new MergeSort(fs1, msbsize, msbfr, ms1sorter);
			// MergeSort sorter2 = new MergeSort(fs2, msbsize, msbfr, ms2sorter);
			// MergeJoin joinOp = new MergeJoin(new Operator[]{sorter1,sorter2}, ep);
			
			// HASH JOIN: Dynamic (hybrid) hash join
			// DYNAMIC HASH JOIN
			int memsize = 1000000;		// Memory size in bytes
			DynamicHashJoin joinOp = new DynamicHashJoin(new Operator[]{fs1,fs2}, ep, memsize, false, false, null);
						
			// Add a global selection on top
			// ConstantSelectionPredicate have the form:  attributeIndex  comparisonOP constant
			// Example:  c_acctbal > 0  (except need to know index of c_acctbal in input)			
			ConstantSelectionPredicate pred1 = new ConstantSelectionPredicate(3, new BigDecimal(1000), new Less());
			ConstantSelectionPredicate pred2 = new ConstantSelectionPredicate(6, new BigDecimal(0), new Greater());
			// Can build complicated predicates by combining expressions using AND, OR, NOT
			SelectionPredicate pred = new And(pred1,pred2);
			Selection sel = new Selection(joinOp, pred);
			
			// Add a global projection
			// Just list attributes that you want to project out (renaming is optional)
			Projection proj = new Projection(sel,new ProjectionList(new int[]{6,1,5,0},null));
            // Other option for projection is to build an array of expressions (ExtractAttribute(), functions, operators, etc.)
            // Expression[] exprList = new Expression[num];            
            // Projection projOp = new Projection(sel, exprList, null);
            
			// Finally, let's sort by c_acctbal (field 1 ASC)
			SortComparator acctSorter = new SortComparator(new int[]{0}, new boolean[]{true});
			MergeSort sorter = new MergeSort(proj, memsize, acctSorter, null);
			
			// Since sort is the "root" of the tree, execute it
			Operator it = sorter;
			
			it.init();
			stmt1.close();
			stmt2.close();
			rst1.close();
			rst2.close();
			
			// Uncomment this line if want to write output to a tab separated text file
			// PrintWriter outFile = FileManager.openTextOutputFile("outputEngine.txt");

			int i = 0;
			Tuple t = new Tuple();
			System.out.println("c_acctbal, c_custkey, c_name, o_orderkey");
			while (it.next(t))
			{
				i++;
				System.out.println(t);
			
				// Can write tuple to output file if desired
				// t.writeText(outFile);						
			}			
			// FileManager.closeFile(outFile);
	
			System.out.println("# of results: "+i);
			it.close();
		}		
		catch (SQLException ex)
		{	System.err.println("SQLException: " + ex);
		}

		System.out.println("\nEND EXAMPLE 1");
	}	// end example1
		
	/**
	 * This example shows how a user can have the driver parse a query to get a global execution tree then
	 * monitor the execution of the query by tracking local queries and relational algebra operators internal to the engine.
	 */
	public static void example2()
	{	
		System.out.println("\nBEGINNING EXAMPLE 2: TRACKING GLOBAL QUERY EXECUTION\n");
		
		Connection con = null;
		Statement stmt = null;
		ResultSet rst;
		
		try{			
			Class.forName("unity.jdbc.UnityDriver");			
			con = DriverManager.getConnection(url);						
			stmt = con.createStatement();
									
			String sql = "SELECT P.P_NAME, L.L_QUANTITY, C.C_Name, S.s_name \n" +
			 " FROM OrderDB.CUSTOMER AS C, OrderDB.LINEITEM AS L, OrderDB.ORDERS AS O, PartDB.PART AS P, PartDB.Supplier AS S \n" +
			 " WHERE L.L_PARTKEY = P.P_PARTKEY AND L.L_ORDERKEY = O.O_ORDERKEY " +
			 " AND O.O_CUSTKEY = C.C_CUSTKEY and S.s_suppkey = L.l_suppkey AND C.C_Name = 'Customer#000000025';";
						
			System.out.println("Executing query: \n"+sql+"\n\n");
			
			// Cast to UnityStatement so can use some additional features of the UnityStatement class
			UnityStatement ustmt = (UnityStatement) stmt;
			
			// Request that the query be parsed and a global query be built but not yet executed
			GlobalQuery gq = ustmt.parseQuery(sql);		
			System.out.println("NOTE: Percentages may not equal 100% (plus or minus) due to estimation errors.  Percentages are calculated using source estimates.");
			System.out.println("Logical query tree for global query is:\n");
			gq.getLogicalQueryTree().print();
			System.out.println("\n\nExecution query tree for global query is:\n");
			Operator.printTree(gq.getExecutionTree(), 0);
			
			// Retrieve the list of local queries (on the data sources) executed for this global query
			ArrayList<LocalQuery> localQueries = gq.getLocalQueries();
			
			// At this point, you could modify the global query by re-arranging operators, etc.
			// We will just execute it as is but track the progress of the individual operators in the execution tree.
			
			rst = ustmt.executeQuery(gq);  	

			System.out.println("\n\nQUERY RESULTS");			
			int i =0;
			while (rst.next())
			{	i++;
				System.out.println("Result tuple: "+i+" generated:");
				System.out.println(rst.getString(1)+","+rst.getBigDecimal(2)+","+rst.getString(3)+","+rst.getString(4));
				
				System.out.println("\nLocal query progress: \n");
				for (int j=0;j < localQueries.size(); j++)
				{	LocalQuery lq = localQueries.get(j);
					System.out.print("Query "+j+": "+lq.getResultSetScan().getRowsOutput()+" tuples read\t");
				}
				// Note that percentages may not total 100% as the optimizer may not estimate the output size of operators exactly   
				System.out.println("\nNumber of results generated (and expected) for each operator: \n");
				LQTree.printProgressTree(gq.getLogicalQueryTree().getRoot());	
				System.out.println();
			}
			System.out.println("Results tuples are "+i);
			System.out.println("\nFinal tree status:\n");
			LQTree.printProgressTree(gq.getLogicalQueryTree().getRoot());
			stmt.close();   
		}
		catch (Exception ex)
		{	System.out.println("Exception: " + ex);
		}
		finally
		{			
			if (con != null)
			try{
				con.close();				
			}
			catch (SQLException ex)
			{	System.out.println("SQLException: " + ex);
			}
		} // end try-catch-finally block
		System.out.println("\nOPERATION COMPLETED SUCCESSFULLY!");

		System.out.println("\nEND EXAMPLE 2");
	}	// end example2


	/**
	 * Makes a connection to the sample HSQL database (which should be already started).
	 * @return
	 * 		connection to HSQL database
	 */
	public static Connection makeConnection()
	{
		try {	// Load driver class
			Class.forName("org.hsqldb.jdbcDriver");
		}
		catch (java.lang.ClassNotFoundException e) {
			System.err.println("ClassNotFoundException: " +e);
		}

		Connection con = null;
		try {
			con = DriverManager.getConnection(dburl,uid,pw);
		}
		catch (SQLException ex)
		{
			System.out.println("SQLException: " + ex);
		}
		return con;
	}
}

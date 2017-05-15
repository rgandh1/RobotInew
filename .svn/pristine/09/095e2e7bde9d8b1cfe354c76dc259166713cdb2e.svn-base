package unity.functions;


import java.sql.SQLException;

import unity.engine.Attribute;
import unity.engine.Relation;
import unity.engine.Tuple;

/**
 * User-defined function that multiples input by 2.
 */
public class F_Double extends Function {
    private static final long serialVersionUID = 1L;
    
    /**
     * Number to multiply by 2.
     */
    private Expression expr;

	/**
	 * Constructor.
	 * 
	 * @param e
	 *     number to multiply by 2
	 */
	public F_Double(Expression e) {
		expr = e;
		returnType = expr.getReturnType();
	}

	/**
	 * Called for each row.
	 */
	public Object evaluate(Tuple t) throws SQLException
	{
		Object val = expr.evaluate(t);

		if (val != null)
			if (val instanceof Double)
				return new Double(((Double) val).doubleValue() * 2);
			else if (val instanceof Float)
				return new Float(((Float) val).floatValue() * 2);
			else if (val instanceof Integer)
				return new Integer(((Integer) val).intValue() * 2);
			else if (val instanceof Number)
				return new Double(((Number) val).doubleValue() * 2);

		return null;
	}

	/**
     * Get return type.
     */
	public int getReturnType() {
		return returnType;
	}

	 /**
     * Returns list of input parameter types.
     * 
     * @return
     *      Array of input parameter types
     */
	public static int[] getParamListTypes() {
		return new int[] { Attribute.TYPE_NUMBER };
	}

	/**
     * Get function name.
     * 
     * @return
     *      function name
     */
	public static String getFunctionName() {
		return "DOUBLE";
	}

	public String toString(Relation relation) {
		return "DOUBLE(" + expr.toString(relation) + ")";
	}
}
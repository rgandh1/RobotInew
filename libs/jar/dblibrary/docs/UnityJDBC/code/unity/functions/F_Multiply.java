/*
 * Copyright (c) 2011-2014 Unity Data Inc. All rights reserved.
 *
 * The copyright to this software is the property of Unity Data Inc.
 * The software and source code may be used only with the written permission of 
 * Unity Data Inc. or in accordance with the terms and conditions stipulated 
 * in the agreement/contract under which the software has been supplied.
 *
 * Author: Ramon Lawrence (lawrence@unityjdbc.com)
 */
package unity.functions;

import java.sql.SQLException;
import java.sql.Types;

import unity.engine.Attribute;
import unity.engine.Tuple;
import unity.engine.Relation;

/**
 * User defined function that multiplies its first parameter by the second parameter.  Usage: multiply(10, 5)
 */
public class F_Multiply extends Function 
{
	private static final long serialVersionUID = 1L;


	/**
	 * Number to multiply
	 */
	private Expression number;

	/**
     * Number to multiply by
     */
    private Expression multiplyBy;
    
	/**
	 * Constructor for multiply function.  
	 * 
	 * @param number
	 *      first number 
	 * @param multiplyBy 
	 *      second number
	 */
	public F_Multiply(Expression number, Expression multiplyBy) 
	{
		this.number = number;
		this.multiplyBy = multiplyBy;
		
		// Determine return type based on return type of two expressions
		int numType = this.number.getReturnType();
		int multType = this.multiplyBy.getReturnType();
		
		if (numType == Types.DOUBLE || multType == Types.DOUBLE)
		    this.returnType = Types.DOUBLE;
		else
		    this.returnType = Types.INTEGER;				
	}

	@Override
	public Object evaluate(Tuple t) throws SQLException 
	{
		Object num = this.number.evaluate(t);
		Object num2 = this.multiplyBy.evaluate(t);
		
		if (num != null && num2 != null)
		{
		    if (this.returnType == Types.INTEGER)
		    {
		        if (num instanceof Number && num2 instanceof Number)
		            return new Integer( ((Number) num).intValue()  * ((Number) num2).intValue());
		        else
		            throw new SQLException("Numbers must be used for multiply!");
		    }
		    else 
            {
                if (num instanceof Number && num2 instanceof Number)
                    return new Double( ((Number) num).doubleValue()  * ((Number) num2).doubleValue());
                else
                    throw new SQLException("Numbers must be used for multiply!");
            }		    
		}
		return null;
	}

	@Override
	public int getReturnType() 
	{
		return this.returnType;
	}

	 
    /**
     * Returns list of input parameter types.
     * 
     * @return
     * 		Array of input parameter types
     */
	public static int[] getParamListTypes() 
	{
		return new int[] { Attribute.TYPE_NUMBER, Attribute.TYPE_NUMBER };
	}

	/**
	 * Get function name.
	 * 
	 * @return
	 * 		function name
	 */
	@SuppressWarnings("nls")
	public static String getFunctionName() 
	{
		return "MULTIPLY";
	}

	@SuppressWarnings("nls")
	@Override
	public String toString(Relation relation) {
		return "MULTIPLY(" + this.number.toString(relation) +", " + this.multiplyBy.toString(relation) + ")";
	}
}
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

import unity.engine.Attribute;
import unity.engine.Tuple;
import unity.engine.Relation;


/**
 * User Defined Function template for regular (row at a time) functions.
 */
public class F_Function_template extends Function 
{
	private static final long serialVersionUID = 1L;
	
	/**
	 * Input expression
	 */
	private Expression expr;

	/** 
	 * The constructor of the function, may receive input of zero to many
	 * Expressions. Only one constructor may be defined.
	 * 
	 * @param e
	 * 		input expression 
	 */
	public F_Function_template(Expression e) 
	{
		this.expr = e;
		this.returnType = this.expr.getReturnType();
	}

	/** 
	 * The evaluate() method is called for each row (tuple) processed.
	 * It must return an object of its chosen return type (or null).
	 */  
	@Override
	public Object evaluate(Tuple t) throws SQLException 
	{
		Object val = this.expr.evaluate(t);

		// TODO: Do something with the val object. 
		// In this case, return the value itself.

		return val;
	}

	/**
	 * Get return type.
	 */
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
		return new int[] { Attribute.TYPE_NUMBER };
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
		return "F_Function_template";
	}
	
	@SuppressWarnings("nls")
	@Override
	public String toString(Relation relation) 
	{
		return "F_Function_template(" + this.expr.toString(relation) + ")";
	}
}
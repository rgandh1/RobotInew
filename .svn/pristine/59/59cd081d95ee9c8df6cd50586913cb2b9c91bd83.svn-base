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

import unity.engine.Attribute;
import unity.engine.Tuple;
import unity.engine.Relation;


import java.sql.SQLException;
import java.util.ArrayList;

/**
 * User Defined Function template for aggregate functions.
 */
public class A_Aggregate_template extends Aggregate_Function 
{
	private static final long serialVersionUID = 1L;

	/**
	 *  The constructor of the function, receives an input of exactly one 
	 *  Expression. Only one constructor may be defined. This constructor creates
	 *  the ArrayList of this node's children and what Expression is being
	 *  evaluated by it. For most aggregate functions, this should not be changed.
	 * 
	 * @param exp
	 * 		input expression
	 */	
	public A_Aggregate_template(Expression exp) 
	{
		this.children = new ArrayList<Expression>(1);
		this.children.add(exp);
		this.computedExpr = exp;
		this.returnType = Attribute.TYPE_INT;
	}

	/**
	 * The reset() method must be implemented.
	 * It is used when resetting the functions aggregate data.
	 * Reset() is called before processing each group of rows.
	 */
	@Override
	public void reset() 
	{
		// TODO: Fill-in
	}

	/**
	 * The add() method must be implemented.
	 * It is called for each row processed in a group.
	 * This method should process the incoming data and extract what data the function requires for
	 * computation. 
	 */
	@Override
	public void add(Tuple t) throws SQLException
	{
		@SuppressWarnings("unused")
		Object val = this.computedExpr.evaluate(t);

		// TODO: Perform some computation on the value		
	}

	/**
	 * compute() is called when all rows in a group have been processed to compute the aggregate value.
	 */	
	@Override
	public Object compute() 
	{
		// TODO: Compute and return aggregate value.	    
		return new Integer(0);
	}

	@Override
	@SuppressWarnings("nls")
	public String toString(Relation relation, Attribute outputAttribute) 
	{
		return "A_Aggregate_template(" + this.computedExpr.toString(relation)+ ") AS " + outputAttribute.getName();
	}
}
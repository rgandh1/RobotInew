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
import java.util.ArrayList;

import unity.engine.Attribute;
import unity.engine.Tuple;
import unity.engine.Relation;


/**
 * Example user-defined aggregate function that returns the Fibonacci sequence value up to the tuple count.  
 * Usage: fibonacci(attribute_name)
 */
public class A_Fibonacci extends Aggregate_Function 
{
	private static final long serialVersionUID = 1L;

	/**
	 * Count of number of values in group
	 */
	protected int counter;

	/**
	 * Cached array of Fibonacci values
	 */
	protected int[] fibMemo;
	
	/**
	 * Construct Aggregate UDF function with input expression to aggregate.
	 * 
	 * @param exp
	 * 		expression to apply aggregate function
	 */
	public A_Fibonacci(Expression exp) 
	{
		this.children = new ArrayList<Expression>(1);
		this.children.add(exp);
		this.computedExpr = exp;
		this.returnType = Attribute.TYPE_INT;
	}

	/**
	 * Reset tuple counter.
	 */
	@Override
	public void reset() 
	{
		this.counter = 0;
	}

	/**
	 * Add a tuple to count.
	 */
	@Override
	public void add(Tuple t) throws SQLException 
	{
		Object val = this.computedExpr.evaluate(t);
		if (val != null)
			this.counter++;
	}

	/**
	 * Compute Fibonacci sequence up to given value.
	 * 
	 * @param i
	 * 		index in sequence
	 * @return
	 * 		Fibonacci value at that index
	 */
	private int fib(int i) 
	{
		if (i == 0) 
			return 0;
		else if (i == 1) 
			return 1;
		else 
		{
			if (this.fibMemo[i] == 0)
				this.fibMemo[i] = fib(i - 1) + fib(i - 2);
			return this.fibMemo[i];
		}
	}

	/**
	 * Returns result of applying function over all tuples in group.
	 */
	@Override
	public Object compute() 
	{
		this.fibMemo = new int[this.counter+1];
		return new Integer(fib(this.counter));        
	}

	@SuppressWarnings("nls")
	@Override
	public String toString(Relation relation, Attribute outputAttribute) 
	{
		return "fibonacci(" + this.computedExpr.toString(relation) + ") AS "+ outputAttribute.getName();
	}
}
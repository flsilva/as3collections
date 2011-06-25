/*
 * Licensed under the MIT License
 * 
 * Copyright 2010 (c) Flávio Silva, http://flsilva.com
 *
 * Permission is hereby granted, free of charge, to any person
 * obtaining a copy of this software and associated documentation
 * files (the "Software"), to deal in the Software without
 * restriction, including without limitation the rights to use,
 * copy, modify, merge, publish, distribute, sublicense, and/or sell
 * copies of the Software, and to permit persons to whom the
 * Software is furnished to do so, subject to the following
 * conditions:
 *
 * The above copyright notice and this permission notice shall be
 * included in all copies or substantial portions of the Software.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
 * EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES
 * OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
 * NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
 * HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
 * WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
 * FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
 * OTHER DEALINGS IN THE SOFTWARE.
 * 
 * http://www.opensource.org/licenses/mit-license.php
 */

package org.as3collections
{
	import org.as3collections.errors.NoSuchElementError;
	import org.as3collections.utils.CollectionUtil;
	import org.as3coreaddendum.errors.UnsupportedOperationError;
	import org.as3utils.ReflectionUtil;

	import flash.errors.IllegalOperationError;

	/**
	 * This class provides skeletal implementations of some <code>IQueue</code> operations.
	 * The implementations in this class are appropriate when the base implementation does not allow <code>null</code> elements.
	 * Methods <code>add</code>, <code>dequeue</code>, and <code>element</code> are based on <code>offer</code>, <code>poll</code>, and <code>peek</code>, respectively but throw errors instead of indicating failure via <code>false</code> or <code>null</code> returns. 
	 * <p>An <code>IQueue</code> implementation that extends this class must minimally define a method <code>offer</code> which does not permit insertion of <code>null</code> elements, along with methods <code>peek</code>, <code>poll</code>, <code>ICollection.iterator</code> supporting <code>IIterator.remove</code> and <code>clone</code>.
	 * Typically, additional methods will be overridden as well.
	 * If these requirements cannot be met, consider instead subclassing <code>AbstractCollection</code>.</p>
	 * 
	 * @author Flávio Silva
	 */
	public class AbstractQueue extends AbstractCollection implements IQueue
	{
		/**
		 * Constructor, creates a new <code>AbstractQueue</code> object.
		 * 
		 * @param 	source 	an array to fill the queue.
		 * @throws 	IllegalOperationError 	If this class is instantiated directly, in other words, if there is <b>not</b> another class extending this class.
		 */
		public function AbstractQueue(source:Array = null)
		{
			super(source);
			if (ReflectionUtil.classPathEquals(this, AbstractQueue))  throw new IllegalOperationError(ReflectionUtil.getClassName(this) + " is an abstract class and shouldn't be instantiated directly.");
		}

		/**
		 * Inserts the specified element into this queue if it is possible to do so immediately without violating restrictions.
		 * This method differs from <code>offer</code> only in that it throws an error if the element cannot be inserted.
		 * <p>This implementation returns the result of <code>offer</code> unless the element cannot be inserted.</p>
		 * 
		 * @param  	element 	the element to be added.
		 * @throws 	ArgumentError  	if the specified element is <code>null</code>.
		 * @throws 	org.as3coreaddendum.errors.ClassCastError  		if the class of the specified element prevents it from being added to this queue.
		 * @throws 	flash.errors.IllegalOperationError  			if the specified element cannot be inserted.
		 * @return 	<code>true</code> if this queue changed as a result of the call.
		 */
		override public function add(element:*): Boolean
		{
			if (element == null) throw new ArgumentError("The 'element' argument must not be 'null'.");
			
			var b:Boolean = offer(element);
			
			if (!b) throw new IllegalOperationError("The element cannot be inserted: " + element);
			
			return b;
		}

		/**
		 * Retrieves and removes the head of this queue.
		 * This method differs from <code>poll</code> only in that it throws an error if this queue is empty.
		 * <p>This implementation returns the result of <code>poll</code> unless the queue is empty.</p>
		 * 
		 * @throws 	org.as3collections.errors.NoSuchElementError  		if this queue is empty.
		 * @return 	the head of this queue.
 		 */
		public function dequeue(): *
		{
			var e:* = poll();
			
			if (!e) throw new NoSuchElementError("The queue is empty.");
			
			return e;
		}

		/**
		 * Retrieves, but does not remove, the head of this queue.
		 * This method differs from <code>peek</code> only in that it throws an error if this queue is empty. 
		 * <p>This implementation returns the result of <code>peek</code>  unless the queue is empty.</p>
		 * 
		 * @throws 	org.as3collections.errors.NoSuchElementError 	if this queue is empty.
		 * @return 	the head of this queue.
 		 */
		public function element(): *
		{
			var e:* = peek();
			
			if (!e) throw new NoSuchElementError("The queue is empty.");
			
			return e;
		}

		/**
		 * This method uses <code>CollectionUtil.equalConsideringOrder</code> method to perform equality, sending this list and <code>other</code> argument.
		 * 
		 * @param  	other 	the object to be compared for equality.
		 * @return 	<code>true</code> if the arbitrary evaluation considers the objects equal.
		 * @see 	org.as3collections.utils.CollectionUtil#equalConsideringOrder() CollectionUtil.equalConsideringOrder()
		 */
		override public function equals(other:*): Boolean
		{
			return CollectionUtil.equalConsideringOrder(this, other);
		}

		/**
		 * Inserts the specified element into this queue if it is possible to do so immediately without violating restrictions.
		 * When using a restricted queue (like <code>TypedQueue</code> and <code>UniqueQueue</code>), this method is generally preferable to <code>add</code>, which can fail to insert an element only by throwing an error. 
		 * <p>This implementation always throws an <code>UnsupportedOperationError</code>.</p>
		 * 
		 * @param  	element 	the element to add.
		 * @throws 	org.as3coreaddendum.errors.UnsupportedOperationError  	if the <code>offer</code> operation is not supported by this queue.
		 * @return 	<code>true</code> if the element was added to this queue, else <code>false</code>. 
		 */
		public function offer(element:*): Boolean
		{
			throw new UnsupportedOperationError("Method must be overridden in subclass: " + ReflectionUtil.getClassPath(this));
		}

		/**
		 * Retrieves, but does not remove, the head of this queue, or returns <code>null</code> if this queue is empty. 
		 * <p>This implementation always throws an <code>UnsupportedOperationError</code>.</p>
		 * 
		 * @throws 	org.as3coreaddendum.errors.UnsupportedOperationError  	if the <code>peek</code> operation is not supported by this queue.
		 * @return 	the head of this queue, or <code>null</code> if this queue is empty.
 		 */
		public function peek(): *
		{
			throw new UnsupportedOperationError("Method must be overridden in subclass: " + ReflectionUtil.getClassPath(this));
		}

		/**
		 * Retrieves and removes the head of this queue, or returns <code>null</code> if this queue is empty. 
		 * <p>This implementation always throws an <code>UnsupportedOperationError</code>.</p>
		 * 
		 * @throws 	org.as3coreaddendum.errors.UnsupportedOperationError  	if the <code>poll</code> operation is not supported by this queue.
		 * @return 	the head of this queue, or <code>null</code> if this queue is empty.
 		 */
		public function poll(): *
		{
			throw new UnsupportedOperationError("Method must be overridden in subclass: " + ReflectionUtil.getClassPath(this));
		}

	}

}
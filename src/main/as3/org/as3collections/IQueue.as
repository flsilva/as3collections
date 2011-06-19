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
	import org.as3collections.ICollection;

	/**
	 * A collection designed for holding elements prior to processing.
	 * Besides basic <code>ICollection</code> operations, queues provide additional insertion, extraction, and inspection operations.
	 * Each of these methods exists in two forms: one throws an error if the operation fails, the other returns a special value (either <code>null</code> or <code>false</code>, depending on the operation).
	 * <p>
	 * <table class="innertable">
	 * <tr>
	 * <th></th>
	 * <th><em>Throws error</em></th>
	 * <th><em>Returns special value</em></th>
	 * </tr>
	 * <tr>
	 * <td><b>Insert</b></td>
	 * <td><code>add</code></td>
	 * <td><code>offer</code></td>
	 * </tr>
	 * <tr>
	 * <td><b>Remove</b></td>
	 * <td><code>dequeue</code></td>
	 * <td><code>poll</code></td>
	 * </tr>
	 * <tr>
	 * <td><b>Examine</b></td>
	 * <td><code>element</code></td>
	 * <td><code>peek</code></td>
	 * </tr>
	 * </table>
	 * </p>
	 * <p>Queues typically, but do not necessarily, order elements in a FIFO (first-in-first-out) manner.
	 * Among the exceptions are priority queues, which order elements according to a supplied comparator, or the elements' natural ordering, and LIFO queues (or stacks) which order the elements LIFO (last-in-first-out).
	 * Whatever the ordering used, the head of the queue is that element which would be removed by a call to <code>dequeue</code> or <code>poll</code>.
	 * In a FIFO queue, all new elements are inserted at the <em>tail</em> of the queue.
	 * Other kinds of queues may use different placement rules.
	 * Every <code>IQueue</code> implementation must specify its ordering properties.</p>
	 * <p>The <code>offer</code> method inserts an element if possible, otherwise returning <code>false</code>.
	 * This differs from the <code>add</code> method, which can fail to add an element only by throwing an error.
	 * The <code>offer</code> method is designed for use when failure is a normal, rather than exceptional occurrence.</p>
	 * <p>The <code>dequeue</code> and <code>poll</code> methods remove and return the head of the queue.
	 * Exactly which element is removed from the queue is a function of the queue's ordering policy, which differs from implementation to implementation.
	 * The <code>dequeue</code> and <code>poll</code> methods differ only in their behavior when the queue is empty: the <code>dequeue</code> method throws an error, while the <code>poll</code> method returns <code>null</code>.</p> 
	 * <p>The <code>element</code> and <code>peek</code> methods return, but do not remove, the head of the queue.
	 * The <code>element</code> and <code>peek</code> methods differ only in their behavior when the queue is empty: the <code>element</code> method throws an error, while the <code>peek</code> method returns null.</p>
	 * <p><code>IQueue</code> implementations generally do not allow insertion of <code>null</code> elements</p>
	 * 
	 * @author Flávio Silva
	 */
	public interface IQueue extends ICollection
	{
		/**
		 * Retrieves and removes the head of this queue.
		 * 
		 * @throws 	org.as3collections.errors.NoSuchElementError 	if this queue is empty.
		 * @return 	the head of this queue.
 		 */
		function dequeue(): *;

		/**
		 * Retrieves, but does not remove, the head of this queue.
		 * This method differs from <code>peek</code> only in that it throws an error if this queue is empty. 
		 * 
		 * @throws 	org.as3collections.errors.NoSuchElementError 	if this queue is empty.
		 * @return 	the head of this queue.
 		 */
		function element(): *;

		/**
		 * Inserts the specified element into this queue if it is possible to do so immediately without violating restrictions.
		 * When using a restricted queue (like <code>TypedQueue</code> and <code>UniqueQueue</code>), this method is generally preferable to <code>add</code>, which can fail to insert an element only by throwing an error. 
		 * 
		 * @param  	element 	the element to add.
		 * @return 	<code>true</code> if the element was added to this queue, else <code>false</code>. 
		 */
		function offer(element:*): Boolean;

		/**
		 * Retrieves, but does not remove, the head of this queue, or returns <code>null</code> if this queue is empty. 
		 * 
		 * @return 	the head of this queue, or <code>null</code> if this queue is empty.
 		 */
		function peek(): *;

		/**
		 * Retrieves and removes the head of this queue, or returns <code>null</code> if this queue is empty. 
		 * 
		 * @return 	the head of this queue, or <code>null</code> if this queue is empty.
 		 */
		function poll(): *;
	}

}
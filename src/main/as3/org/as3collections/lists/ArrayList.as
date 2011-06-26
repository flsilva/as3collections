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

package org.as3collections.lists
{
	import org.as3collections.AbstractList;
	import org.as3collections.ICollection;
	import org.as3collections.IIterator;
	import org.as3collections.IList;
	import org.as3collections.IListIterator;
	import org.as3collections.errors.IndexOutOfBoundsError;
	import org.as3collections.iterators.ArrayIterator;
	import org.as3collections.iterators.ListIterator;

	/**
	 * Resizable-array implementation of the <code>IList</code> interface.
	 * Implements all optional list operations, and permits all elements, including <code>null</code>.
	 * <p>Each <code>ArrayList</code> instance has a capacity.
	 * The capacity is the size of the array used to store the elements in the list.
	 * It is always at least as large as the list size.
	 * As elements are added to an <code>ArrayList</code>, its capacity grows automatically.</p>
	 * <p>In addition to implementing the <code>IList</code> interface, this class provides the <code>ensureCapacity</code> method to arbitrarily manipulate the size of the array (this usage is not common) that is used internally to store the elements.
	 * Check the examples at the bottom of the page for further information about usage.</p>
	 * <p>It's possible to create unique lists, typed lists and even unique typed lists.
	 * You just sends the <code>ArrayList</code> object to the wrappers <code>UniqueList</code> or <code>TypedList</code> or uses the <code>ListUtil.getUniqueList</code>, <code>ListUtil.getTypedList</code> or <code>ListUtil.getUniqueTypedList</code>.</p>
	 * 
	 * @example
	 * 
	 * <b>Example 1</b>
	 * <listing version="3.0">
	 * import org.as3collections.IList;
	 * import org.as3collections.lists.ArrayList;
	 * 
	 * var list1:IList = new ArrayList();
	 * 
	 * list1                           // []
	 * 
	 * list1.size()                    // 0
	 * list1.contains(null)            // false
	 * list1.contains("abc")           // false
	 * list1.isEmpty()                 // true
	 * list1.modCount                  // 0
	 * 
	 * list1.clear()
	 * 
	 * list1.modCount                  // 0
	 * list1.isEmpty()                 // true
	 * list1.size()                    // 0
	 * 
	 * list1.add(null)                 // true
	 * list1                           // [null]
	 * list1.isEmpty()                 // false
	 * list1.size()                    // 1
	 * list1.modCount                  // 1
	 * list1.contains(null)            // true
	 * list1.contains("abc")           // false
	 * 
	 * list1.add("abc")                // true
	 * list1                           // [null,abc]
	 * list1.size()                    // 2
	 * list1.modCount                  // 2
	 * list1.contains("abc")           // true
	 * 
	 * list1.add(null)                 // true
	 * list1                           // [null,abc,null]
	 * list1.size()                    // 3
	 * list1.modCount                  // 3
	 * list1.indexOf(null)             // 0
	 * list1.lastIndexOf(null)         // 2
	 * 
	 * list1.addAt(0, 123)             // true
	 * list1                           // [123,null,abc,null]
	 * list1.size()                    // 4
	 * list1.modCount                  // 4
	 * 
	 * list1.addAt(4, "def")           // true
	 * list1                           // [123,null,abc,null,def]
	 * list1.size()                    // 5
	 * 
	 * list1.addAt(4, "abc")           // true
	 * list1                           // [123,null,abc,null,abc,def]
	 * list1.size()                    // 6
	 * list1.modCount                  // 6
	 * 
	 * list1.getAt(0)                  // 123
	 * list1.getAt(2)                  // abc
	 * list1.getAt(5)                  // def
	 * 
	 * list1.removeAt(0)               // 123
	 * list1                           // [null,abc,null,abc,def]
	 * list1.size()                    // 5
	 * list1.modCount                  // 7
	 * 
	 * list1.removeAt(4)               // def
	 * list1                           // [null,abc,null,abc]
	 * list1.size()                    // 4
	 * list1.modCount                  // 8
	 * 
	 * list1.removeAt(0)               // null
	 * list1                           // [abc,null,abc]
	 * list1.size()                    // 3
	 * list1.modCount                  // 9
	 * 
	 * var list2:IList = list1.clone();
	 * 
	 * list2                           // [abc,null,abc]
	 * 
	 * list1.containsAll(list1)        // true
	 * list1.containsAll(list2)        // true
	 * list2.containsAll(list1)        // true
	 * list1.equals(list2)             // true
	 * 
	 * list2.remove("abc")             // true
	 * list2.remove("abc")             // true
	 * list2.add(null)                 // true
	 * list2                           // [null,null]
	 * 
	 * list1.containsAll(list2)        // true
	 * list2.containsAll(list1)        // false
	 * list1.equals(list2)             // false
	 * 
	 * list1                           // [abc,null,abc]
	 * list1.size()                    // 3
	 * list1.setAt(2, "ghi")           // abc
	 * list1                           // [abc,null,ghi]
	 * list1.size()                    // 3
	 * list1.modCount                  // 9
	 * 
	 * list1.clear()
	 * 
	 * list1.modCount                  // 10
	 * list1.isEmpty()                 // true
	 * list1.size()                    // 0
	 * </listing>
	 * 
	 * <b>Example 2</b>
	 * <listing version="3.0">
	 * import org.as3collections.IList;
	 * import org.as3collections.lists.ArrayList;
	 * 
	 * var arr:Array = [1, 2, 3, 4];
	 * var list1:IList = new ArrayList(arr);
	 * 
	 * list1                                 // [1,2,3,4]
	 * list1.size()                          // 4
	 * list1.isEmpty()                       // false
	 * list1.modCount                        // 0
	 * 
	 * var list2:IList = new ArrayList([9, 10, 11, 12]);
	 * 
	 * list2                                 // [9,10,11,12]
	 * list2.size()                          // 4
	 * list2.isEmpty()                       // false
	 * list2.modCount                        // 0
	 * 
	 * list1.addAll(list2)                   // true
	 * list1                                 // [1,2,3,4,9,10,11,12]
	 * list1.size()                          // 8
	 * list1.modCount                        // 4
	 * 
	 * var list3:IList = new ArrayList([5, 6, 7, 8]);
	 * 
	 * list3                                 // [5,6,7,8]
	 * list3.size()                          // 4
	 * list3.isEmpty()                       // false
	 * list3.modCount                        // 0
	 * 
	 * list1.addAllAt(4, list3)              // true
	 * list1                                 // [1,2,3,4,5,6,7,8,9,10,11,12]
	 * list1.size()                          // 12
	 * list1.modCount                        // 8
	 * 
	 * list1.containsAll(list3)              // true
	 * list3.containsAll(list1)              // false
	 * 
	 * list1.removeAll(list3)                // true
	 * list1                                 // [1,2,3,4,9,10,11,12]
	 * list1.size()                          // 8
	 * list1.modCount                        // 12
	 * 
	 * list1.removeAll(list3)                // false
	 * list1                                 // [1,2,3,4,9,10,11,12]
	 * list1.size()                          // 8
	 * list1.modCount                        // 12
	 * 
	 * list1.retainAll(list2)                // true
	 * list1                                 // [9,10,11,12]
	 * list1.size()                          // 4
	 * list1.modCount                        // 16
	 * 
	 * list1.subList(0, 1)                   // [9]
	 * list1.subList(0, 2)                   // [9,10]
	 * list1.subList(0, 4)                   // [9,10,11,12]
	 * list1.subList(0, list1.size())        // [9,10,11,12]
	 * 
	 * list1.removeRange(1, 3)               // [10,11]
	 * list1                                 // [9,12]
	 * list1.size()                          // 2
	 * list1.modCount                        // 17
	 * 
	 * list1.remove(9)                       // true
	 * list1                                 // [12]
	 * list1.size()                          // 1
	 * list1.modCount                        // 18
	 * 
	 * list1.retainAll(list3)                // true
	 * list1                                 // []
	 * list1.size()                          // 0
	 * list1.modCount                        // 19
	 * </listing>
	 * 
	 * <b>Example 3</b>
	 * <listing version="3.0">
	 * import org.as3collections.IList;
	 * import org.as3collections.lists.ArrayList;
	 * 
	 * var list1:ArrayList = new ArrayList();
	 * 
	 * list1                     // []
	 * list1.addAt(3, 4)         // IndexOutOfBoundsError: The 'index' argument is out of bounds: 3 (min: 0, max: 0)
	 * 
	 * list1.ensureCapacity(5)
	 * 
	 * list1                     // [undefined,undefined,undefined,undefined,undefined]
	 * list1.modCount            // 1
	 * list1.isEmpty()           // false
	 * list1.size()              // 5
	 * 
	 * list1.addAt(3, 4)         // true
	 * list1                     // [undefined,undefined,undefined,4,undefined,undefined]
	 * list1.modCount            // 2
	 * list1.size()              // 6
	 * 
	 * list1.getAt(1)            // undefined
	 * 
	 * list1.ensureCapacity(3)
	 * 
	 * list1                     // [undefined,undefined,undefined,4,undefined,undefined]
	 * list1.modCount            // 2
	 * list1.size()              // 6
	 * 
	 * list1.setAt(2, 3)         // undefined
	 * list1                     // [undefined,undefined,3,4,undefined,undefined]
	 * list1.modCount            // 2
	 * list1.size()              // 6
	 * 
	 * list1.remove(undefined)   // true
	 * list1.remove(undefined)   // true
	 * list1                     // [3,4,undefined,undefined]
	 * list1.modCount            // 4
	 * list1.size()              // 4
	 * </listing>
	 * 
	 * <b>Example 4 - Using equality (org.as3coreaddendum.system.IEquatable)</b>
	 * 
	 * <listing version="3.0">
	 * package test
	 * {
	 *     import org.as3coreaddendum.system.IEquatable;
	 * 
	 *     public class TestEquatableObject implements IEquatable
	 *     {
	 *         private var _id:String;
	 * 		
	 *         public function get id(): String { return _id; }
	 * 
	 *         public function set id(value:String): void { _id = value; }
	 * 
	 *         public function TestEquatableObject(id:String)
	 *         {
	 *             _id = id;
	 *         }
	 * 
	 *         public function equals(other:*): Boolean
	 *         {
	 *             return other is TestEquatableObject &amp;&amp; _id == (other as TestEquatableObject).id;
	 *         }
	 * 
	 *         public function toString(): String
	 *         {
	 *             return "[TestEquatableObject " + _id + "]";
	 *         }
	 *     }
	 * }
	 * </listing>
	 * 
	 * <listing version="3.0">
	 * import test.TestEquatableObject;
	 * 
	 * import org.as3collections.IList;
	 * import org.as3collections.lists.ArrayList;
	 * import org.as3collections.lists.UniqueList;
	 * 
	 * var list1:ArrayList = new ArrayList();
	 * 
	 * list1                               // []
	 * 
	 * var o1:TestEquatableObject = new TestEquatableObject("o1");
	 * var o2:TestEquatableObject = new TestEquatableObject("o2");
	 * var o3:TestEquatableObject = new TestEquatableObject("o3");
	 * var o4:TestEquatableObject = new TestEquatableObject("o4");
	 * 
	 * list1.contains(o1)                  // false
	 * list1.add(o1)                       // true
	 * list1                               // [[TestEquatableObject o1]]
	 * list1.contains(o1)                  // true
	 * 
	 * var o5:TestEquatableObject = new TestIndexablePriority("o1"); // -> Attention to the id, which is "o1"
	 * 
	 * list1.contains(o5)                  // true -> without equality would return false, because o1 and o5 are different objects.
	 * 
	 * list1.add(o5)                       // true
	 * list1                               // [[TestEquatableObject o1],[TestEquatableObject o1]]
	 * 
	 * o1.equals(o5)                       // true
	 * o1.equals("abc")                    // false
	 * 
	 * var list2:ArrayList = new ArrayList();
	 * 
	 * list2.equals(list1)                 // false
	 * list2.add(o5)                       // true
	 * list1                               // [[TestEquatableObject o1],[TestEquatableObject o1]]
	 * list2                               // [[TestEquatableObject o1]]
	 * list2.equals(list1)                 // false
	 * 
	 * list2.add(o5)                       // true
	 * list1                               // [[TestEquatableObject o1],[TestEquatableObject o1]]
	 * list2                               // [[TestEquatableObject o1],[TestEquatableObject o1]]
	 * list2.equals(list1)                 // true
	 * 
	 * list2.remove(o1)                    // true -> equality used
	 * list2                               // [[TestEquatableObject o1]]
	 * 
	 * var uniqueList:UniqueList = new UniqueList(new ArrayList());
	 * 
	 * uniqueList.contains(o1)             // false
	 * uniqueList.add(o1)                  // true
	 * uniqueList                          // [[TestEquatableObject o1]]
	 * uniqueList.contains(o1)             // true
	 * 
	 * uniqueList.add(o5)                  // false
	 * uniqueList.contains(o5)             // true -> by equality the object o5 is in the list because its 'id' is the same of the object o1.
	 * uniqueList                          // [[TestEquatableObject o1]]
	 * </listing>
	 * 
	 * @see org.as3collections.utils.ListUtil#getUniqueList() ListUtil.getUniqueList()
	 * @see org.as3collections.utils.ListUtil#getTypedList() ListUtil.getTypedList()
	 * @see org.as3collections.utils.ListUtil#getUniqueTypedList() ListUtil.getUniqueTypedList()
	 * @author Flávio Silva
	 */
	public class ArrayList extends AbstractList
	{
		/**
		 * Constructor, creates a new ArrayList object.
		 * 
		 * @param 	source 	an array to fill the list.
		 */
		public function ArrayList(source:Array = null)
		{
			super(source);
		}

		/**
		 * Inserts the specified element at the specified position in this list. Shifts the element currently at that position (if any) and any subsequent elements to the right (adds one to their indices).
		 * 
		 * @param  	index 		index at which the specified element is to be inserted.
		 * @param  	element 	the element to be added.
		 * @throws 	org.as3collections.errors.IndexOutOfBoundsError 		if the index is out of range <code>(index &lt; 0 || index &gt; size())</code>. 
		 * @return 	<code>true</code> if this list changed as a result of the call.
		 */
		override public function addAt(index:int, element:*): Boolean
		{
			checkIndex(index, size());
			data.splice(index, 0, element);
			elementAdded(element);
			return true;
		}

		/**
		 * Removes all of the elements from this list. The list will be empty after this method returns.
		 */
		override public function clear(): void
		{
			if (isEmpty()) return;
			_modCount++;
			data.splice(0);
			_totalEquatable = 0;
		}

		/**
		 * Creates and return a new <code>ArrayList</code> object containing all elements in this list (in the same order).
		 * 
		 * @return 	a new <code>ArrayList</code> object containing all elements in this list (in the same order).
 		 */
		override public function clone(): *
		{
			return new ArrayList(data);
		}

		/**
		 * Increases the capacity of this <code>ArrayList</code> instance, if necessary, to ensure that it can hold at least the number of elements specified by the <code>minCapacity</code> argument. 
 		 */
		public function ensureCapacity(minCapacity:int): void
		{
			if (minCapacity <= data.length) return;
			_modCount++;
			data.length = minCapacity;
		}

		/**
		 * Returns an iterator over a set of elements.
		 * <p>This implementation returns an <code>ArrayIterator</code> object.</p>
		 * 
		 * @return 	an iterator over a set of elements.
		 * @see 	org.as3collections.iterators.ArrayIterator ArrayIterator
 		 */
		override public function iterator(): IIterator
		{
			return new ArrayIterator(data);
		}

		/**
		 * Returns a list iterator of the elements in this list (in proper sequence), starting at the specified position in this list. The specified index indicates the first element that would be returned by an initial call to <code>next</code>. An initial call to <code>previous</code> would return the element with the specified index minus one. 
		 * <p>This implementation returns an <code>ListIterator</code> object.</p>
		 * 
		 * @param  	index 	index of first element to be returned from the list iterator (by a call to the <code>next</code> method) 
		 * @return 	a list iterator of the elements in this list (in proper sequence), starting at the specified position in this list.
		 * @see 	org.as3collections.iterators.ListIterator ListIterator
		 */
		override public function listIterator(index:int = 0): IListIterator
		{
			return new ListIterator(this, index);
		}

		/**
		 * Removes the element at the specified position in this list. Shifts any subsequent elements to the left (subtracts one from their indices). Returns the element that was removed from the list. 
		 * 
		 * @param  	index 	the index of the element to be removed.
		 * @throws 	org.as3collections.errors.IndexOutOfBoundsError 		if the index is out of range <code>(index &lt; 0 || index &gt;= size())</code>.
		 * @return 	the element previously at the specified position.
		 */
		override public function removeAt(index:int): *
		{
			if (isEmpty()) throw new IndexOutOfBoundsError("The 'index' argument is out of bounds: <" + index + ">. This list is empty.");//TODO:pensar em mudar para outro erro, por ex IllegalOperationError
			
			checkIndex(index, size() - 1);
			
			var e:* = data.splice(index, 1)[0];
			elementRemoved(e);
			
			return e;
		}

		/**
		 * Removes all of the elements whose index is between <code>fromIndex</code>, inclusive, and <code>toIndex</code>, exclusive. Shifts any subsequent elements to the left (subtracts their indices).
		 * <p>If <code>toIndex == fromIndex</code>, this operation has no effect.</p>
		 * 
		 * @param  	fromIndex 	the index to start removing elements (inclusive).
		 * @param  	toIndex 	the index to stop removing elements (exclusive).
		 * @throws 	org.as3collections.errors.IndexOutOfBoundsError 		if <code>fromIndex</code> or <code>toIndex</code> is out of range <code>(index &lt; 0 || index &gt; size())</code>.
		 * @return 	a new <code>ArrayList</code> object containing all the removed elements.
		 */
		override public function removeRange(fromIndex:int, toIndex:int): ICollection
		{
			if (isEmpty()) throw new IndexOutOfBoundsError("This list is empty.");//TODO:pensar em mudar para outro erro, por ex IllegalOperationError
			
			checkIndex(fromIndex, size());
			checkIndex(toIndex, size());
			
			var l:IList = new ArrayList(data.splice(fromIndex, toIndex - fromIndex));
			
			if (_totalEquatable < 1)
			{
				_modCount += l.size();
				return l;
			}
			
			var it:IIterator = l.iterator();
			var e:*;
			
			while(it.hasNext())
			{
				e = it.next();
				elementRemoved(e);
			}
			
			return l;
		}

		/**
		 * Replaces the element at the specified position in this list with the specified element.
		 * 
		 * @param  	index 		index of the element to replace.
		 * @param  	element 	element to be stored at the specified position.
		 * @throws 	org.as3collections.errors.IndexOutOfBoundsError 		if the index is out of range <code>(index &lt; 0 || index &gt;= size())</code>.
		 * @return 	the element previously at the specified position.
		 */
		override public function setAt(index:int, element:*): *
		{
			if (isEmpty()) throw new IndexOutOfBoundsError("The 'index' argument is out of bounds: <" + index + ">. This list is empty.");//TODO:pensar em mudar para outro erro, por ex IllegalOperationError
			checkIndex(index, size() - 1);
			
			var old:* = data[index];
			data[index] = element;
			
			elementRemoved(old);
			elementAdded(element);
			_modCount -= 2;// elementRemoved() and elementAdded() will increase modCount undesirably
			
			return old;
		}

		/**
		 * Returns a new <code>ArrayList</code> that is a view of the portion of this <code>ArrayList</code> between the specified <code>fromIndex</code>, inclusive, and <code>toIndex</code>, exclusive.
		 * <p>Modifications in the returned <code>ArrayList</code> object doesn't affect this list.</p>
		 * 
		 * @param  	fromIndex 	the index to start retrieving elements (inclusive).
		 * @param  	toIndex 	the index to stop retrieving elements (exclusive).
		 * @throws 	org.as3collections.errors.IndexOutOfBoundsError 		if <code>fromIndex</code> or <code>toIndex</code> is out of range <code>(index &lt; 0 || index &gt; size())</code>.
		 * @return 	a new <code>ArrayList</code> that is a view of the specified range within this list.
		 */
		override public function subList(fromIndex:int, toIndex:int): IList
		{
			if (isEmpty()) throw new IndexOutOfBoundsError("This list is empty.");//TODO:pensar em mudar para outro erro, por ex IllegalOperationError
			
			checkIndex(fromIndex, size());
			checkIndex(toIndex, size());
			
			var l:IList = new ArrayList(data.slice(fromIndex, toIndex));
			
			return l;
		}

	}

}
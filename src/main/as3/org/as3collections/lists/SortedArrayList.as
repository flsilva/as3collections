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
	import org.as3collections.ICollection;
	import org.as3collections.IList;
	import org.as3collections.ISortedList;
	import org.as3collections.errors.IndexOutOfBoundsError;
	import org.as3coreaddendum.system.IComparator;
	import org.as3utils.ReflectionUtil;

	/**
	 * A list that provides a <em>total ordering</em> on its elements.
	 * The list is ordered according to the <em>natural ordering</em> of its elements, by a <em>IComparator</em> typically provided at sorted list creation time, or by the arguments provided to the <code>sort</code> or <code>sortOn</code> methods.
	 * <p>For each change that occurs the list is automatically ordered using the <code>comparator</code> and <code>options</code>.
	 * If none was provided the default behavior of the <code>sort</code> method is used.</p>
	 * <p>The user of this list may change their order at any time using the setters <code>comparator</code> and <code>options</code>, or by calling the <code>sort</code> or <code>sortOn</code> method and imposing others arguments to change the sort behaviour.</p>
	 * <p>It's possible to create unique sorted lists, typed sorted lists and even unique typed sorted lists.
	 * You just sends the <code>SortedArrayList</code> object to the wrappers <code>UniqueList</code> or <code>TypedList</code> or uses the <code>ArrayListUtil.getUniqueTypedList</code>.
	 * But there's a problem here: the return type will be <code>UniqueList</code> or <code>TypedList</code>.
	 * Thus you will not be able to use <code>sort</code> and <code>sortOn</code> methods directly (and even the setters <code>comparator</code> and <code>options</code>).
	 * This is not such a big problem because <code>SortedArrayList</code> is automatically ordered whenever it changes, using the provided <code>comparator</code> and <code>options</code> constructor's arguments.
	 * But you will not be able to change the <code>comparator</code> and <code>options</code>.
	 * Check the examples at the bottom of the page for further information about usage.</p>
	 * 
	 * @example
	 * 
	 * <b>Example 1</b>
	 * 
	 * <listing version="3.0">
	 * import org.as3collections.IList;
	 * import org.as3collections.ISortedList;
	 * import org.as3collections.lists.SortedArrayList;
	 * 
	 * var list1:ISortedList = new SortedArrayList([3, 5, 1, 7], null, Array.NUMERIC | Array.DESCENDING);
	 * 
	 * list1                       // [7,5,3,1]
	 * list1.size()                // 4
	 * 
	 * list1.addAt(3, 8)           // true
	 * list1                       // [8,7,5,3,1]
	 * list1.size()                // 5
	 * 
	 * list1.add(4)                // true
	 * list1                       // [8,7,5,4,3,1]
	 * list1.size()                // 6
	 * 
	 * list1.add(5)                // true
	 * list1                       // [8,7,5,5,4,3,1]
	 * list1.size()                // 7
	 * 
	 * list1.sort(null, Array.NUMERIC)
	 * list1                       // [1,3,4,5,5,7,8]
	 * 
	 * list1.add(2)                // true
	 * list1                       // [8,7,5,5,4,3,2,1]
	 * list1.size()                // 8
	 * 
	 * list1.reverse()
	 * list1                       // [1,2,3,4,5,5,7,8]
	 * 
	 * list1.add(6)                // true
	 * list1                       // [1,2,3,4,5,5,6,7,8]
	 * 
	 * list1.add(9)                // true
	 * list1                       // [1,2,3,4,5,5,6,7,8,9]
	 * 
	 * list1.reverse()
	 * list1                       // [9,8,7,6,5,5,4,3,2,1]
	 * 
	 * list1.add(10)               // true
	 * list1                       // [10,9,8,7,6,5,5,4,3,2,1]
	 * 
	 * list1.add(-1)               // true
	 * list1                       // [10,9,8,7,6,5,5,4,3,2,1,-1]
	 * 
	 * //list1.add("c")            // TypeError: Error #1034: Falha de coerção de tipo: não é possível converter "c" em Number.
	 * </listing>
	 * 
	 * <b>Example 2</b>
	 * 
	 * <listing version="3.0">
	 * import org.as3collections.IList;
	 * import org.as3collections.ISortedList;
	 * import org.as3collections.lists.SortedArrayList;
	 * import org.as3coreaddendum.system.comparators.AlphabeticComparator;
	 * 
	 * var comparator:AlphabeticComparator = new AlphabeticComparator(false);
	 * var arr:Array = ["c", "a", "d", "b"];
	 * var list1:ISortedList = new SortedArrayList(arr, comparator);
	 * 
	 * list1                              // [a,b,c,f]
	 * list1.size()                       // 4
	 * 
	 * list1.addAt(1, "x")                // true
	 * list1                              // [a,b,c,f,x]
	 * list1.size()                       // 5
	 * 
	 * list1.add("d")                     // true
	 * list1                              // [a,b,c,d,f,x]
	 * list1.size()                       // 6
	 * 
	 * list1.add("d")                     // true
	 * list1                              // [a,b,c,d,d,f,x]
	 * list1.size()                       // 7
	 * 
	 * list1.sort()
	 * list1                              // [a,b,c,d,d,f,x]
	 * 
	 * list1.add(2)                       // true
	 * list1                              // [2,a,b,c,d,d,f,x]
	 * list1.size()                       // 8
	 * </listing>
	 * 
	 * <b>Example 3</b>
	 * 
	 * <listing version="3.0">
	 * import org.as3collections.IList;
	 * import org.as3collections.ISortedList;
	 * import org.as3collections.lists.SortedArrayList;
	 * 
	 * var arr:Array = [5, 1, 100, 10, 99];
	 * var list1:ISortedList = new SortedArrayList(arr); // default behavior of the sort method
	 * 
	 * list1                       // [1,10,100,5,99]
	 * list1.size()                // 5
	 * 
	 * list1.add(50)               // true
	 * list1                       // [1,10,100,5,50,99]
	 * list1.size()                // 6
	 * 
	 * list1.sort(null, Array.NUMERIC)
	 * list1                       // [1,5,10,50,99,100]
	 * 
	 * list1.add(200)              // true
	 * list1                       // [1,10,100,200,5,50,99]
	 * list1.size()                // 7
	 * </listing>
	 * 
	 * <b>Example 4 - Unique Sorted List</b>
	 * 
	 * <listing version="3.0">
	 * import org.as3collections.IList;
	 * import org.as3collections.ISortedList;
	 * import org.as3collections.lists.SortedArrayList;
	 * import org.as3collections.utils.ArrayListUtil;
	 * 
	 * var arr:Array = [5, 1, 100, 10, 99, 5];
	 * 
	 * var l1:ISortedList = new SortedArrayList(arr, null, Array.NUMERIC | Array.DESCENDING);
	 * 
	 * var list1:IList = ArrayListUtil.getUniqueList(l1);  // return type is UniqueList
	 * 
	 * list1                 // [100,99,10,5,1]
	 * list1.size()          // 5
	 * 
	 * list1.add(50)         // true
	 * list1                 // [100,99,50,10,5,1]
	 * list1.size()          // 6
	 * 
	 * //list1.sort()        // cannot do this
	 * //list1.sortOn()      // or this
	 * 
	 * list1.add(10)         // false
	 * list1                 // [100,99,50,10,5,1]
	 * list1.size()          // 6
	 * </listing>
	 * 
	 * <b>Example 5 - Typed Sorted List</b>
	 * 
	 * <listing version="3.0">
	 * import org.as3collections.IList;
	 * import org.as3collections.ISortedList;
	 * import org.as3collections.lists.SortedArrayList;
	 * import org.as3collections.utils.ArrayListUtil;
	 * 
	 * var arr:Array = [5, 1, 100, 10, 99, 5];
	 * 
	 * var l1:ISortedList = new SortedArrayList(arr, null, Array.NUMERIC | Array.DESCENDING);
	 * 
	 * var list1:IList = ArrayListUtil.getTypedList(l1);  // return type is TypedList
	 * 
	 * list1                 // [100,99,10,5,5,1]
	 * list1.size()          // 6
	 * 
	 * list1.add(50)         // true
	 * list1                 // [100,99,50,10,5,5,1]
	 * list1.size()          // 7
	 * 
	 * //list1.sort()        // cannot do this
	 * //list1.sortOn()      // or this
	 * 
	 * list1.add(10)         // true
	 * list1                 // [100,99,50,10,10,5,5,1]
	 * list1.size()          // 8
	 * 
	 * list1.add("a")        // ClassCastError: Invalid element type. element: a | type: String | expected type: int
	 * </listing>
	 * 
	 * <b>Example 6 - Unique Typed Sorted List</b>
	 * 
	 * <listing version="3.0">
	 * import org.as3collections.IList;
	 * import org.as3collections.ISortedList;
	 * import org.as3collections.lists.SortedArrayList;
	 * import org.as3collections.utils.ArrayListUtil;
	 * 
	 * var arr:Array = [5, 1, 100, 10, 99, 5];
	 * 
	 * var l1:ISortedList = new SortedArrayList(arr, null, Array.NUMERIC | Array.DESCENDING);
	 * 
	 * var list1:IList = ArrayListUtil.getUniqueTypedList(l1);  // return type is TypedList
	 * 
	 * list1                 // [100,99,10,5,1]
	 * list1.size()          // 5
	 * 
	 * list1.add(50)         // true
	 * list1                 // [100,99,50,10,5,1]
	 * list1.size()          // 6
	 * 
	 * //list1.sort()        // cannot do this
	 * //list1.sortOn()      // or this
	 * 
	 * list1.add(10)         // false
	 * list1                 // [100,99,50,10,5,1]
	 * list1.size()          // 6
	 * 
	 * list1.add("a")        // ClassCastError: Invalid element type. element: a | type: String | expected type: int
	 * </listing>
	 * 
	 * @see org.as3collections.utils.ArrayListUtil ArrayListUtil
	 * @author Flávio Silva
	 */
	public class SortedArrayList extends ArrayList implements ISortedList
	{
		private var _comparator: IComparator;
		private var _options: uint;
		private var _reversed: Boolean;

		/**
		 * Defines the comparator object to be used automatically to sort.
		 * <p>If this value change the list is automatically reordered with the new value.</p>
		 */
		public function get comparator(): IComparator { return _comparator; }

		public function set comparator(value:IComparator): void
		{
			_comparator = value;
			_sort();
		}

		/**
		 * Defines the options to be used automatically to sort.
		 * <p>If this value change the list is automatically reordered with the new value.</p>
		 */
		public function get options(): uint { return _options; }

		public function set options(value:uint): void
		{
			_options = value;
			_sort();
		}

		/**
		 * Constructor, creates a new <code>SortedArrayList</code> object.
		 * 
		 * @param 	source 		an array to fill the list.
		 * @param 	comparator 	the comparator object to be used internally to sort.
		 * @param 	options 	the options to be used internally to sort.
		 */
		public function SortedArrayList(source:Array = null, comparator:IComparator = null, options:uint = 0)
		{
			super(source);
			
			_comparator = comparator;
			_options = options;
			_sort();
		}

		/**
		 * Inserts the specified element at the specified position in this list. Shifts the element currently at that position (if any) and any subsequent elements to the right (adds one to their indices).
		 * <p>Before returning, the list is reordered, so there's no guarantee that the element remains in the inserted position.</p>
		 * 
		 * @param  	index 		index at which the specified element is to be inserted.
		 * @param  	element 	the element to be added.
		 * @throws 	org.as3coreaddendum.errors.IndexOutOfBoundsError 		if the index is out of range <code>(index &lt; 0 || index &gt; size())</code>. 
		 * @return 	<code>true</code> if this list changed as a result of the call.
		 */
		override public function addAt(index:int, element:*): Boolean
		{
			var b:Boolean = super.addAt(index, element);
			if (b) _sort();
			return b;
		}

		/**
		 * Creates and return a new <code>SortedArrayList</code> object containing all elements in this list (in the same order).
		 * 
		 * @return 	a new <code>SortedArrayList</code> object containing all elements in this list (in the same order).
 		 */
		override public function clone(): *
		{
			return new SortedArrayList(data, _comparator, _options);
		}

		/**
		 * Performs an arbitrary, specific evaluation of equality between this object and the <code>other</code> object.
		 * <p>This implementation considers two differente objects equal if:</p>
		 * <p>
		 * <ul><li>object A and object B are instances of the same class</li>
		 * <li>object A contains all elements of object B</li>
		 * <li>object B contains all elements of object A</li>
		 * <li>elements have exactly the same order</li>
		 * <li>object A and object B has the same type of comparator</li>
		 * <li>object A and object B has the same options</li>
		 * </ul></p>
		 * <p>This implementation takes care of the order of the elements in the list.
		 * So, for two lists are equal the order of elements returned by the iterator object must be equal.</p>
		 * 
		 * @param  	other 	the object to be compared for equality.
		 * @return 	<code>true</code> if the arbitrary evaluation considers the objects equal.
		 */
		override public function equals(other:*): Boolean
		{
			if (this == other) return true;
			
			if (!ReflectionUtil.classPathEquals(this, other)) return false;
			
			var l:ISortedList = other as ISortedList;
			
			if (_options != l.options) return false;
			if (!_comparator && l.comparator) return false;
			if (_comparator && !l.comparator) return false;
			if (!ReflectionUtil.classPathEquals(_comparator, l.comparator)) return false;
			
			return super.equals(other);
		}

		/**
		 * Removes a single instance (only one occurrence) of the specified object from this list, if it is present.
		 * <p>Before returning, the list is reordered.</p>
		 * 
		 * @param  	o 	the object to be removed from this collection, if present.
		 * @return 	<code>true</code> if an object was removed as a result of this call.
		 */
		override public function remove(o:*): Boolean
		{
			var b:Boolean = super.remove(o);
			if (b) _sort();
			return b;
		}

		/**
		 * Removes all of this list's elements that are also contained in the specified collection. After this call returns, this list will contain no elements in common with the specified collection.
		 * <p>Before returning, the list is reordered.</p>
		 * 
		 * @param  	collection 	the collection containing elements to be removed from this list.
		 * @return 	<code>true</code> if this list changed as a result of the call.
		 */
		override public function removeAll(collection:ICollection): Boolean
		{
			var b:Boolean = super.removeAll(collection);
			if (b) _sort();
			return b;
		}

		/**
		 * Removes the element at the specified position in this list. Shifts any subsequent elements to the left (subtracts one from their indices). Returns the element that was removed from the list. 
		 * <p>Before returning, the list is reordered.</p>
		 * 
		 * @param  	index 	the index of the element to be removed.
		 * @throws 	org.as3coreaddendum.errors.IndexOutOfBoundsError 		if the index is out of range <code>(index &lt; 0 || index &gt;= size())</code>.
		 * @return 	the element previously at the specified position.
		 */
		override public function removeAt(index:int): *
		{
			var e:* = super.removeAt(index);
			_sort();
			return e;
		}

		/**
		 * Removes all of the elements whose index is between <code>fromIndex</code>, inclusive, and <code>toIndex</code>, exclusive. Shifts any subsequent elements to the left (subtracts their indices).
		 * <p>If <code>toIndex == fromIndex</code>, this operation has no effect.</p>
		 * <p>Before returning, the list is reordered.</p>
		 * 
		 * @param  	fromIndex 	the index to start removing elements (inclusive).
		 * @param  	toIndex 	the index to stop removing elements (exclusive).
		 * @throws 	org.as3coreaddendum.errors.IndexOutOfBoundsError 		if <code>fromIndex</code> or <code>toIndex</code> is out of range <code>(index &lt; 0 || index &gt; size())</code>.
		 * @return 	a new <code>ArrayList</code> object containing all the removed elements.
		 */
		override public function removeRange(fromIndex:int, toIndex:int): ICollection
		{
			var c:ICollection = super.removeRange(fromIndex, toIndex);
			_sort();
			return c;
		}

		/**
		 * Retains only the elements in this list that are contained in the specified collection. In other words, removes from this list all of its elements that are not contained in the specified collection.
		 * <p>Before returning, the list is reordered.</p>
		 * 
		 * @param  	collection 	the collection containing elements to be retained in this collection.
		 * @return 	<code>true</code> if this list changed as a result of the call. 	
		 */
		override public function retainAll(collection:ICollection): Boolean
		{
			var b:Boolean = super.retainAll(collection);
			if (b) _sort();
			return b;
		}

		/**
		 * Reverses the list.
		 * When this method is called, the list is reversed and an internal status <em>reversed</em> (<code>true</code>/<code>false</code>) is stored.
		 * When the list is automatically ordered by any change, if status is <em>reversed</em> = <code>true</code>, the list remains reversed.
		 * Thus, after any change it will remain sorted and reversed as it was before the change.
		 * A second call to <code>reverse</code> will reverse the list again and change the status to <em>reversed</em> = <code>false</code>.
		 * The default value is <code>false</code>.
		 * This condition is not used in the user call to <code>sort</code> or <code>sortOn</code> methods (i.e. even if status is <em>reversed</em> = <code>true</code> it will not be used automatically).
		 * So if is desirable to reverse the list after directly call <code>sort</code> or <code>sortOn</code> methods, <code>reverse</code> method should be explicitly called after that.
		 */
		override public function reverse(): void
		{
			_reversed = !_reversed;
			super.reverse();
		}

		/**
		 * Replaces the element at the specified position in this list with the specified element.
		 * <p>Before returning, the list is reordered.</p>
		 * 
		 * @param  	index 		index of the element to replace.
		 * @param  	element 	element to be stored at the specified position.
		 * @throws 	org.as3coreaddendum.errors.IndexOutOfBoundsError 		if the index is out of range <code>(index &lt; 0 || index &gt;= size())</code>.
		 * @return 	the element previously at the specified position.
		 */
		override public function setAt(index:int, element:*): *
		{
			var e:* = super.setAt(index, element);
			_sort();
			return e;
		}

		/**
		 * Sorts the objects within this class.
		 * <p>For more info see <code>org.as3coreaddendum.system.ISortable.sort()</code> in the link below.</p>
		 * 
		 * @param compare
		 * @param options
		 * @return
		 */
		public function sort(compare:Function = null, options:uint = 0): Array
		{
			if (compare != null)
			{ 
				return data.sort(compare, options);
			}
			else
			{
				return data.sort(options);
			}
		}

		/**
		 * @inheritDoc
		 * 
		 * @see http://help.adobe.com/en_US/FlashPlatform/reference/actionscript/3/Array.html#sortOn()
		 */
		public function sortOn(fieldName:*, options:* = null): Array
		{
			return data.sortOn(fieldName, options);
		}

		/**
		 * Returns a new <code>SortedArrayList</code> that is a view of the portion of this <code>SortedArrayList</code> between the specified <code>fromIndex</code>, inclusive, and <code>toIndex</code>, exclusive.
		 * <p>Modifications in the returned <code>SortedArrayList</code> object doesn't affect this list.</p>
		 * 
		 * @param  	fromIndex 	the index to start retrieving elements (inclusive).
		 * @param  	toIndex 	the index to stop retrieving elements (exclusive).
		 * @throws 	org.as3coreaddendum.errors.IndexOutOfBoundsError 		if <code>fromIndex</code> or <code>toIndex</code> is out of range <code>(index &lt; 0 || index &gt; size())</code>.
		 * @return 	a new <code>SortedArrayList</code> that is a view of the specified range within this list.
		 */
		override public function subList(fromIndex:int, toIndex:int): IList
		{
			if (isEmpty()) throw new IndexOutOfBoundsError("This list is empty.");//TODO:pensar em mudar para outro erro, por ex IllegalOperationError
			
			checkIndex(fromIndex, size());
			checkIndex(toIndex, size());
			return new SortedArrayList(data.slice(fromIndex, toIndex));
		}

		/**
		 * @private
		 */
		protected function _sort(): void
		{
			if (_comparator)
			{
				sort(_comparator.compare, _options);
			}
			else
			{
				sort(null, _options);
			}
			
			if (_reversed) super.reverse();
		}

	}

}
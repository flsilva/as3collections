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

package org.as3collections.utils
{
	import flash.errors.IllegalOperationError;
	
	import org.as3collections.IList;
	import org.as3collections.lists.TypedArrayList;
	import org.as3collections.lists.UniqueArrayList;

	/**
	 * A utility class to work with implementations of the <code>IList</code> interface.
	 * 
	 * @author Flávio Silva
	 */
	public class ArrayListUtil
	{
		/**
		 * <code>ArrayListUtil</code> is a static class and shouldn't be instantiated.
		 * 
		 * @throws 	IllegalOperationError 	<code>ArrayListUtil</code> is a static class and shouldn't be instantiated.
		 */
		public function ArrayListUtil()
		{
			throw new IllegalOperationError("ArrayListUtil is a static class and shouldn't be instantiated.");
		}

		/**
		 * Returns a new <code>TypedArrayList</code> with the <code>wrapList</code> argument wrapped.
		 * 
		 * @example
		 * 
		 * <listing version="3.0">
		 * import org.as3collections.IList;
		 * import org.as3collections.lists.ArrayList;
		 * import org.as3collections.utils.ArrayListUtil;
		 * 
		 * var l1:IList = new ArrayList([3, 5, 1, 7]);
		 * 
		 * var list1:IList = ArrayListUtil.getTypedArrayList(l1, int);
		 * 
		 * list1                       // [3,5,1,7]
		 * list1.size()                // 4
		 * 
		 * list1.addAt(1, 4)           // true
		 * list1                       // [3,4,5,1,7]
		 * list1.size()                // 5
		 * 
		 * list1.addAt(2, 3)           // true
		 * list1                       // [3,4,3,5,1,7]
		 * list1.size()                // 6
		 * 
		 * list1.add("def")            // ClassCastError: Invalid element type. element: def | type: String | expected type: int
		 * </listing>
		 * 
		 * @param  	wrapList 	the target list to be wrapped by the <code>TypedArrayList</code>.
		 * @param  	type 		the type of the elements allowed by the returned <code>TypedArrayList</code>.
		 * @throws 	org.as3coreaddendum.errors.NullPointerError  	if the <code>wrapList</code> argument is <code>null</code>.
		 * @throws 	org.as3coreaddendum.errors.NullPointerError  	if the <code>type</code> argument is <code>null</code>.
		 * @throws 	org.as3coreaddendum.errors.ClassCastError  		if the types of one or more elements in the <code>wrapList</code> argument are incompatible with the <code>type</code> argument.
		 * @return 	a new <code>TypedArrayList</code> with the <code>wrapList</code> argument wrapped.
		 */
		public static function getTypedArrayList(wrapList:IList, type:*): TypedArrayList
		{
			return new TypedArrayList(wrapList, type);
		}

		/**
		 * Returns a new <code>UniqueArrayList</code> with the <code>wrapList</code> argument wrapped.
		 * 
		 * @example
		 * 
		 * <listing version="3.0">
		 * import org.as3collections.IList;
		 * import org.as3collections.lists.ArrayList;
		 * import org.as3collections.utils.ArrayListUtil;
		 * 
		 * var l1:IList = new ArrayList([3, 5, 1, 7]);
		 * 
		 * var list1:IList = ArrayListUtil.getUniqueArrayList(l1);
		 * 
		 * list1                       // [3,5,1,7]
		 * list1.size()                // 4
		 * 
		 * list1.addAt(1, 4)           // true
		 * list1                       // [3,4,5,1,7]
		 * list1.size()                // 5
		 * 
		 * list1.addAt(2, 3)           // false
		 * list1                       // [3,4,5,1,7]
		 * list1.size()                // 5
		 * </listing>
		 * 
		 * @param  	wrapList 	the target list to be wrapped by the <code>UniqueArrayList</code>.
		 * @throws 	org.as3coreaddendum.errors.NullPointerError  	if the <code>wrapList</code> argument is <code>null</code>.
		 * @return 	a new <code>UniqueArrayList</code> with the <code>wrapList</code> argument wrapped.
		 */
		public static function getUniqueArrayList(wrapList:IList): UniqueArrayList
		{
			return new UniqueArrayList(wrapList);
		}

		/**
		 * Returns a new <code>TypedArrayList</code> that wraps a new <code>UniqueArrayList</code> that wraps the <code>wrapList</code> argument.
		 * <p>The result will be a unique and typed array list, despite of the return type <code>TypedArrayList</code>.</p>
		 * 
		 * @example
		 * 
		 * <listing version="3.0">
		 * import org.as3collections.IList;
		 * import org.as3collections.lists.ArrayList;
		 * import org.as3collections.lists.TypedArrayList;
		 * import org.as3collections.utils.ArrayListUtil;
		 * 
		 * var l1:IList = new ArrayList([3, 5, 1, 7]);
		 * 
		 * var list1:IList = ArrayListUtil.getUniqueTypedArrayList(l1, int);
		 * 
		 * list1                   // [3,5,1,7]
		 * list1.size()            // 4
		 * 
		 * list1.add(8)            // true
		 * list1                   // [3,5,1,7,8]
		 * list1.size()            // 5
		 * 
		 * list1.addAt(1, 4)       // true
		 * list1                   // [3,4,5,1,7,8]
		 * list1.size()            // 6
		 * 
		 * list1.addAt(1, 5)       // false
		 * list1                   // [3,4,5,1,7,8]
		 * list1.size()            // 6
		 * 
		 * list1.add("abc")        // ClassCastError: Invalid element type. element: abc | type: String | expected type: int
		 * 
		 * var list2:IList = list1.clone();
		 * 
		 * list2                   // [3,4,5,0,1,7,8]
		 * list2.size()            // 7
		 * 
		 * list2.add(9)            // true
		 * list2                   // [3,4,5,0,1,7,8,9]
		 * list2.size()            // 8
		 * 
		 * list2.add(1)            // false
		 * list2                   // [3,4,5,0,1,7,8,9]
		 * list2.size()            // 8
		 * 
		 * list2.add("def")        // ClassCastError: Invalid element type. element: def | type: String | expected type: int
		 * </listing>
		 * 
		 * @param  	wrapList 	the target list to be wrapped.
		 * @param  	type 		the type of the elements allowed by the returned <code>TypedArrayList</code>.
		 * @throws 	org.as3coreaddendum.errors.NullPointerError  	if the <code>wrapList</code> argument is <code>null</code>.
		 * @throws 	org.as3coreaddendum.errors.NullPointerError  	if the <code>type</code> argument is <code>null</code>.
		 * @throws 	org.as3coreaddendum.errors.ClassCastError  		if the types of one or more elements in the <code>wrapList</code> argument are incompatible with the <code>type</code> argument.
		 * @return 	a new <code>TypedArrayList</code> with the <code>wrapList</code> argument wrapped.
		 */
		public static function getUniqueTypedArrayList(wrapList:IList, type:*): TypedArrayList
		{
			return new TypedArrayList(new UniqueArrayList(wrapList), type);
		}

	}

}
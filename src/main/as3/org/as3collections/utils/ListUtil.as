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
	import org.as3collections.IList;
	import org.as3collections.ISortedList;
	import org.as3collections.lists.TypedList;
	import org.as3collections.lists.TypedSortedList;
	import org.as3collections.lists.UniqueList;
	import org.as3collections.lists.UniqueSortedList;

	import flash.errors.IllegalOperationError;

	/**
	 * A utility class to work with implementations of the <code>IList</code> interface.
	 * 
	 * @author Flávio Silva
	 */
	public class ListUtil
	{
		/**
		 * <code>ListUtil</code> is a static class and shouldn't be instantiated.
		 * 
		 * @throws 	IllegalOperationError 	<code>ListUtil</code> is a static class and shouldn't be instantiated.
		 */
		public function ListUtil()
		{
			throw new IllegalOperationError("ListUtil is a static class and shouldn't be instantiated.");
		}

		/**
		 * Returns a new <code>TypedList</code> with the <code>wrapList</code> argument wrapped.
		 * 
		 * @param  	wrapList 	the target list to be wrapped by the <code>TypedList</code>.
		 * @param  	type 		the type of the elements allowed by the returned <code>TypedList</code>.
		 * @throws 	ArgumentError  	if the <code>wrapList</code> argument is <code>null</code>.
		 * @throws 	ArgumentError  	if the <code>type</code> argument is <code>null</code>.
		 * @throws 	org.as3coreaddendum.errors.ClassCastError  		if the types of one or more elements in the <code>wrapList</code> argument are incompatible with the <code>type</code> argument.
		 * @return 	a new <code>TypedList</code> with the <code>wrapList</code> argument wrapped.
		 */
		public static function getTypedList(wrapList:IList, type:*): TypedList
		{
			return new TypedList(wrapList, type);
		}
		
		/**
		 * Returns a new <code>TypedSortedList</code> with the <code>wrapList</code> argument wrapped.
		 * 
		 * @param  	wrapList 	the target list to be wrapped by the <code>TypedSortedList</code>.
		 * @param  	type 		the type of the elements allowed by the returned <code>TypedSortedList</code>.
		 * @throws 	ArgumentError  	if the <code>wrapList</code> argument is <code>null</code>.
		 * @throws 	ArgumentError  	if the <code>type</code> argument is <code>null</code>.
		 * @throws 	org.as3coreaddendum.errors.ClassCastError  		if the types of one or more elements in the <code>wrapList</code> argument are incompatible with the <code>type</code> argument.
		 * @return 	a new <code>TypedSortedList</code> with the <code>wrapList</code> argument wrapped.
		 */
		public static function getTypedSortedList(wrapList:ISortedList, type:*): TypedSortedList
		{
			return new TypedSortedList(wrapList, type);
		}

		/**
		 * Returns a new <code>UniqueList</code> with the <code>wrapList</code> argument wrapped.
		 * 
		 * @param  	wrapList 	the target list to be wrapped by the <code>UniqueList</code>.
		 * @throws 	ArgumentError  	if the <code>wrapList</code> argument is <code>null</code>.
		 * @return 	a new <code>UniqueList</code> with the <code>wrapList</code> argument wrapped.
		 */
		public static function getUniqueList(wrapList:IList): UniqueList
		{
			return new UniqueList(wrapList);
		}
		
		/**
		 * Returns a new <code>UniqueSortedList</code> with the <code>wrapList</code> argument wrapped.
		 * 
		 * @param  	wrapList 	the target list to be wrapped by the <code>UniqueSortedList</code>.
		 * @throws 	ArgumentError  	if the <code>wrapList</code> argument is <code>null</code>.
		 * @return 	a new <code>UniqueSortedList</code> with the <code>wrapList</code> argument wrapped.
		 */
		public static function getUniqueSortedList(wrapList:ISortedList): UniqueSortedList
		{
			return new UniqueSortedList(wrapList);
		}

		/**
		 * Returns a new <code>TypedList</code> that wraps a new <code>UniqueList</code> that wraps the <code>wrapList</code> argument.
		 * <p>The result will be a unique and typed array list, despite of the return type <code>TypedList</code>.</p>
		 * 
		 * @param  	wrapList 	the target list to be wrapped.
		 * @param  	type 		the type of the elements allowed by the returned <code>TypedList</code>.
		 * @throws 	ArgumentError  	if the <code>wrapList</code> argument is <code>null</code>.
		 * @throws 	ArgumentError  	if the <code>type</code> argument is <code>null</code>.
		 * @throws 	org.as3coreaddendum.errors.ClassCastError  		if the types of one or more elements in the <code>wrapList</code> argument are incompatible with the <code>type</code> argument.
		 * @return 	a new <code>TypedList</code> that wraps a new <code>UniqueList</code> that wraps the <code>wrapList</code> argument.
		 */
		public static function getUniqueTypedList(wrapList:IList, type:*): TypedList
		{
			return new TypedList(new UniqueList(wrapList), type);
		}
		
		/**
		 * Returns a new <code>TypedSortedList</code> that wraps a new <code>UniqueSortedList</code> that wraps the <code>wrapList</code> argument.
		 * <p>The result will be a unique and typed sorted list, despite of the return type <code>TypedSortedList</code>.</p>
		 * 
		 * @param  	wrapList 	the target list to be wrapped.
		 * @param  	type 		the type of the elements allowed by the returned <code>TypedSortedList</code>.
		 * @throws 	ArgumentError  	if the <code>wrapList</code> argument is <code>null</code>.
		 * @throws 	ArgumentError  	if the <code>type</code> argument is <code>null</code>.
		 * @throws 	org.as3coreaddendum.errors.ClassCastError  		if the types of one or more elements in the <code>wrapList</code> argument are incompatible with the <code>type</code> argument.
		 * @return 	a new <code>TypedSortedList</code> that wraps a new <code>UniqueSortedList</code> that wraps the <code>wrapList</code> argument.
		 */
		public static function getUniqueTypedSortedList(wrapList:ISortedList, type:*): TypedSortedList
		{
			return new TypedSortedList(new UniqueSortedList(wrapList), type);
		}

	}

}
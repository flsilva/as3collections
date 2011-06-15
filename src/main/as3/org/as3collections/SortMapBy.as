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
	import flash.errors.IllegalOperationError;
	
	import org.as3coreaddendum.system.Enum;

	/**
	 * The enumeration class that defines the acceptable values for sort maps by keys or values.
	 * <p>This is a type-safe enumeration class, which means there is no possibility of creating instances externally.
	 * All acceptable values will be created automaticaly by this class internaly, through the constants.</p>
	 * 
	 * @author Flávio Silva
	 */
	public class SortMapBy extends Enum
	{
		/**
		 * Defines the constant that indicates that the map should be sorted by its keys.
		 */
		public static const KEY	: SortMapBy = new SortMapBy("Key", 0);

		/**
		 * Defines the constant that indicates that the map should be sorted by its values.
		 */
		public static const VALUE	: SortMapBy = new SortMapBy("Value", 1);

		/**
		 * @private
		 */
		private static var _created :Boolean = false;
		
		{
			_created = true;
		}

		/**
		 * Constructor, creates a new <code>SortMapBy</code> object.
		 * 
		 * @param 	name 			The name of this enumeration constant.
		 * @param 	ordinal 		The ordinal of this enumeration constant, that is its position in the enum declaration (where the initial constant is assigned an ordinal of zero).
		 * @throws 	IllegalOperationError 	If there is an attempt to instantiation outside the internal code of this class. All acceptable values will be created automaticaly by this class internaly, through the constants. There's no possibility to use this constructor externally.
		 */
		public function SortMapBy(name:String, ordinal:int)
		{
			super(name, ordinal);
			if (_created) throw new IllegalOperationError("The set of acceptable values by this Enumerated Type has already been created internally.");
		}

	}

}
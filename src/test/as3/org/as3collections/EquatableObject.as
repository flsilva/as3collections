/*
 * Licensed under the MIT License
 * 
 * Copyright 2011 (c) Flávio Silva, flsilva.com
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
	import org.as3coreaddendum.system.IEquatable;
	import org.as3utils.StringUtil;

	/**
	 * description
	 * 
	 * @author Flávio Silva
	 */
	public class EquatableObject implements IEquatable
	{
		private var _id:String;
		
		public function get id():String { return _id; }
		
		public function EquatableObject(id:String)
		{
			if (StringUtil.isBlank(id)) throw new ArgumentError("Argument <id> must not be null nor an empty String.");
			_id = id;
		}
		
		public function equals(other:*): Boolean
		{
			if (this == other) return true;
			if (!(other is EquatableObject)) return false;
			
			var otherEquatable:EquatableObject = other as EquatableObject;
			return id == otherEquatable.id;
		}
		
		public function toString():String
		{
			return _id;
		}

	}

}
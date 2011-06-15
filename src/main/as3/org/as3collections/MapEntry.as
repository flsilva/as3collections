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
	import org.as3coreaddendum.system.IEquatable;
	import org.as3utils.ReflectionUtil;

	/**
	 * An entry maintaining a key and a value.
	 * 
	 * @author Flávio Silva
	 */
	public class MapEntry implements IMapEntry
	{
		private var _key :*;
		private var _value :*;

		/**
		 * Returns the key corresponding to this entry.
		 */
		public function get key(): * { return _key; }

		/**
		 * Returns the value corresponding to this entry.
		 */
		public function get value(): * { return _value; }

		/**
		 * Constructor, creates a new <code>MapEntry</code> object.
		 * 
		 * @param 	key 	the key represented by this entry.
		 * @param 	value 	the value represented by this entry.
		 */
		public function MapEntry(key:*, value:*)
		{
			_key = key;
			_value = value;
		}

		/**
		 * Creates and return a new <code>MapEntry</code> object with the same key-value mapping.
		 * 
		 * @return 	a new <code>MapEntry</code> object with the same key-value mapping.
 		 */
		public function clone(): *
		{
			return new MapEntry(_key, _value);
		}

		/**
		 * Performs an arbitrary, specific evaluation of equality between this object and the <code>other</code> object.
		 * <p>This implementation considers two differente objects equal if:</p>
		 * <p>
		 * <ul><li>object A and object B are instances of the same class</li>
		 * <li>A.key == B.key</li>
		 * <li>A.value == B.value</li>
		 * </ul></p>
		 * 
		 * @param  	other 	the object to be compared for equality.
		 * @return 	<code>true</code> if the arbitrary evaluation considers the objects equal.
		 */
		public function equals(other:*): Boolean
		{
			if (this == other) return true;
			
			if (!ReflectionUtil.classPathEquals(this, other)) return false;
			
			var o:IMapEntry = other as IMapEntry;
			
			if (!o) return false;
			
			var k:Boolean;
			var v:Boolean;
			
			if (_key is IEquatable && o.key is IEquatable)
			{
				k = (_key as IEquatable).equals(o.key);
			}
			else
			{
				k = _key == o.key;
			}
			
			if (_value is IEquatable && o.value is IEquatable)
			{
				v = (_value as IEquatable).equals(o.value);
			}
			else
			{
				v = _value == o.value;
			}
			
			return k && v;
		}

		/**
		 * Returns the string representation of this instance.
		 * 
		 * @return the string representation of this instance.
 		 */
		public function toString():String 
		{
			return _key + "=" + _value;
		}
	}

}
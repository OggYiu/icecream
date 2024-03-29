/**
 * Style.as
 * Keith Peters
 * version 0.97
 * 
 * A collection of style variables used by the components.
 * If you want to customize the colors of your components, change these values BEFORE instantiating any components.
 * 
 * Copyright (c) 2009 Keith Peters
 * 
 * Permission is hereby granted, free of charge, to any person obtaining a copy
 * of this software and associated documentation files (the "Software"), to deal
 * in the Software without restriction, including without limitation the rights
 * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 * copies of the Software, and to permit persons to whom the Software is
 * furnished to do so, subject to the following conditions:
 * 
 * The above copyright notice and this permission notice shall be included in
 * all copies or substantial portions of the Software.
 * 
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
 * THE SOFTWARE.
 */
 
package minimalcomps;

#if neash
typedef Int = Int;
#end

class Style {
	public inline static var BACKGROUND:Int = 0xCCCCCC;
	public inline static var BUTTON_FACE:Int = 0xFFFFFF;
	public inline static var INPUT_TEXT:Int = 0x333333;
	public inline static var LABEL_TEXT:Int = 0x666666;
	public inline static var DROPSHADOW:Int = 0x000000;
	public inline static var PANEL:Int = 0xF3F3F3;
	public inline static var PROGRESS_BAR:Int = 0xFFFFFF;
}

package com.furusystems.fl.gui.layouts;
import flash.display.DisplayObject;
import flash.display.DisplayObjectContainer;
import flash.display.Sprite;
import flash.events.Event;

/**
 * Distributes views along an axis with a length
 * @author Andreas Rønning
 */
class DBox extends AbstractLayout
{
	public var orientation:Orientation;
	public var length(get, set):Float;
	var _length:Float = 0;
	
	public function get_length():Float {
		return _length;
	}
	
	public function set_length(f:Float):Float {
		_length = f;
		layout();
		return _length;
	}
	
	public function new(?orientation:Orientation, length:Float = 100)
	{
		if (orientation == null) orientation = HORIZONTAL;
		this.orientation = orientation;
		_length = length;
		super();
	}
	override public function layout():Void 
	{
		if (numChildren == 0) return;
		var v:Float = 0;
		var furthest = getChildAt(numChildren - 1);
		switch(orientation) {
			case VERTICAL:
				var max = _length - furthest.height;
				for (i in 0...numChildren) {
					var t = i / (numChildren - 1);
					var c = getChildAt(i);
					c.y = t * max;
				}
			case HORIZONTAL:
				var max = _length - furthest.width;
				for (i in 0...numChildren) {
					var t = i / (numChildren - 1);
					var c = getChildAt(i);
					c.x = t * max;
				}
				
		}
	}
	
}
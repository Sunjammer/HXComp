package com.furusystems.fl.gui.layouts;
import flash.display.DisplayObject;
import flash.display.Sprite;
import flash.events.Event;

/**
 * ...
 * @author Andreas Rønning
 */
class LinearLayout extends AbstractLayout
{
	public var spacing:Float;
	public var orientation:Orientation;
	public var stride:Float;
	public function new(?orientation:Orientation)
	{
		super();
		stride = -1;
		if (orientation == null) orientation = HORIZONTAL;
		this.orientation = orientation;
		spacing = 3;
	}
	
	override public function layout():Void {
		if (orientation == null) return;
		var v:Float = 0;
		switch(orientation) {
			case VERTICAL:
				for (i in 0...numChildren) {
					getChildAt(i).y = v;
					if (stride == -1) v += getChildAt(i).height + spacing;
					else v += stride + spacing;
				}
			case HORIZONTAL:
				for (i in 0...numChildren) {
					getChildAt(i).x = v;
					if (stride == -1) v += getChildAt(i).width + spacing;
					else v += stride + spacing;
				}
				
		}
	}	
}
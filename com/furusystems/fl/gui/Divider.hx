package com.furusystems.fl.gui;
import com.furusystems.fl.gui.Orientation;
import flash.display.Shape;

/**
 * ...
 * @author ...
 */
class Divider extends Shape
{

	public function new(length:Int, orientation:Orientation) 
	{
		super();
		graphics.clear();
		graphics.lineStyle(0, 0);
		switch(orientation) {
			case VERTICAL:
				graphics.lineTo(0, length);
			case HORIZONTAL:
				graphics.lineTo(length, 0);
		}
	}
	
}
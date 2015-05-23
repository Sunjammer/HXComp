package com.furusystems.fl.gui;
import com.furusystems.fl.gui.Orientation;
import flash.display.Shape;

/**
 * ...
 * @author ...
 */
class Divider extends Shape
{

	public function new(length:Int, orientation:Orientation, margin:Int = 0) 
	{
		super();
		graphics.clear();
		switch(orientation) {
			case VERTICAL:
				if (margin > 0) {
					graphics.beginFill(0, 0);
					graphics.drawRect(0, 0, margin, length);
					graphics.endFill();
				}
				graphics.lineStyle(0, 0);
				graphics.moveTo(margin * 0.5, 0);
				graphics.lineTo(margin * 0.5, length);
			case HORIZONTAL:
				if (margin > 0) {
					graphics.beginFill(0, 0);
					graphics.drawRect(0, 0, length, margin);
					graphics.endFill();
				}
				graphics.lineStyle(0, 0);
				graphics.moveTo(0, margin * 0.5);
				graphics.lineTo(length, margin * 0.5);
		}
	}
	
}
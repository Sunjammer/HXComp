package com.furusystems.fl.gui.layouts;
import flash.display.DisplayObject;
import flash.display.DisplayObjectContainer;
import flash.display.Sprite;
import flash.events.Event;

/**
 * ...
 * @author Andreas Rønning
 */
class HBox extends LinearLayout
{
	public function new(stride:Float = -1)
	{
		super(HORIZONTAL);
		this.stride = stride;
	}
	
	public static function hbox(parent:DisplayObjectContainer, stride:Int = -1) {
		var hb = new HBox(stride);
		parent.addChild(hb);
		return hb;
	}
	
}
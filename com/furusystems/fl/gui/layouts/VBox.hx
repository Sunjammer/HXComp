package com.furusystems.fl.gui.layouts;
import flash.display.DisplayObject;
import flash.display.DisplayObjectContainer;
import flash.display.Sprite;
import flash.events.Event;

/**
 * ...
 * @author Andreas Rønning
 */
class VBox extends LinearLayout
{
	public function new(stride:Int = -1)
	{
		super(VERTICAL);
		this.stride = stride;
	}
	public static function vbox(parent:DisplayObjectContainer, stride:Int = -1) {
		var vb = new VBox(stride);
		parent.addChild(vb);
		return vb;
	}
	
}
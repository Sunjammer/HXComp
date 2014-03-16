package com.furusystems.fl.gui;
import flash.display.DisplayObject;
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
	
}
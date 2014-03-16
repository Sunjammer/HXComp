package com.furusystems.fl.gui;
import flash.display.DisplayObject;
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
	
}
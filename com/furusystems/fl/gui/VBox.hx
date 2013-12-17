package com.furusystems.fl.gui;
import flash.display.DisplayObject;
import flash.display.Sprite;
import flash.events.Event;

/**
 * ...
 * @author Andreas Rønning
 */
class VBox extends Sprite
{
	public var spacing:Float;
	public function new()
	{
		super();
		spacing = 3;
		addEventListener(Event.ADDED, onTreeChange);
		addEventListener(Event.REMOVED, onTreeChange);
	}
	private function onTreeChange(e:Event):Void
	{
		layout();
	}
	function layout():Void {
		var h:Float = 0;
		for (i in 0...numChildren) {
			getChildAt(i).y = h;
			h += getChildAt(i).height + spacing;
		}
	}
	override public function addChild(child:DisplayObject):DisplayObject
	{
		super.addChild(child);
		layout();
		return child;
	}
	override public function removeChild(child:DisplayObject):DisplayObject
	{
		super.removeChild(child);
		layout();
		return child;
	}
	override public function removeChildren(beginIndex:Int = 0, endIndex:Int = 2147483647):Void
	{
		super.removeChildren(beginIndex, endIndex);
		layout();
	}
	
}
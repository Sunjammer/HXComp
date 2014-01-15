package com.furusystems.fl.gui;
import flash.display.DisplayObject;
import flash.display.Sprite;
import flash.events.Event;

/**
 * ...
 * @author Andreas Rønning
 */
class HBox extends Sprite
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
		var w:Float = 0;
		for (i in 0...numChildren) {
			getChildAt(i).x = w;
			w += getChildAt(i).width + spacing;
		}
	}
	@:generic public function add<T:DisplayObject>(child:T):T
	{
		super.addChild(child);
		layout();
		return child;
	}
	@:generic public function remove<T:DisplayObject>(child:T):T
	{
		super.removeChild(child);
		layout();
		return child;
	}
	override public function addChild(child:DisplayObject):DisplayObject 
	{
		return add(child);
	}
	override public function removeChild(child:DisplayObject):DisplayObject 
	{
		return remove(child);
	}
	override public function removeChildren(beginIndex:Int = 0, endIndex:Int = 2147483647):Void
	{
		super.removeChildren(beginIndex, endIndex);
		layout();
	}
	
}
package com.furusystems.fl.gui.layouts;
import flash.display.DisplayObject;
import flash.display.Sprite;
import flash.events.Event;

/**
 * ...
 * @author Andreas Rønning
 */
class AbstractLayout extends Sprite
{
	var contents:Sprite;
	public function new()
	{
		super();
		addEventListener(Event.ADDED, onTreeChange);
		addEventListener(Event.REMOVED, onTreeChange);
	}
	private function onTreeChange(e:Event):Void
	{
		layout();
	}
	public function layout():Void {
		throw "Not implemented";
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
	
	override public function getChildAt(index:Int):DisplayObject 
	{
		return super.getChildAt(index);
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
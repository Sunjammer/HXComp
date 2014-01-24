package com.furusystems.fl.gui;
import flash.display.DisplayObject;
import flash.display.Sprite;
import flash.events.Event;

/**
 * ...
 * @author Andreas Rønning
 */
class LinearLayout extends Sprite
{
	public var spacing:Float;
	public var orientation:Orientation;
	public function new(?orientation:Orientation)
	{
		super();
		if (orientation == null) orientation = HORIZONTAL;
		this.orientation = orientation;
		spacing = 3;
		addEventListener(Event.ADDED, onTreeChange);
		addEventListener(Event.REMOVED, onTreeChange);
	}
	private function onTreeChange(e:Event):Void
	{
		layout();
	}
	public function layout():Void {
		var v:Float = 0;
		switch(orientation) {
			case VERTICAL:
				for (i in 0...numChildren) {
					getChildAt(i).y = v;
					v += getChildAt(i).height + spacing;
				}
			case HORIZONTAL:
				for (i in 0...numChildren) {
					getChildAt(i).x = v;
					v += getChildAt(i).width + spacing;
				}
				
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
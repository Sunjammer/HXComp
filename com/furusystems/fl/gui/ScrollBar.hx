package com.furusystems.fl.gui;
import flash.display.Sprite;
import flash.events.MouseEvent;
import fsignal.Signal;

/**
 * ...
 * @author ...
 */
class ScrollBar extends Sprite
{
	var size:Float;
	var _value:Float;
	public var orientation:Orientation;
	public var onChange:Signal;
	public function new(?orientation:Orientation) 
	{
		super();
		_value = 0;
		size = 0;
		onChange = new Signal();
		if (orientation == null) orientation = VERTICAL;
		this.orientation = orientation;
		addEventListener(MouseEvent.MOUSE_DOWN, onMouseDown);
		buttonMode = true;
		
	}
	
	private function onMouseDown(e:MouseEvent):Void 
	{
		stage.addEventListener(MouseEvent.MOUSE_UP, onMouseUp);
		stage.addEventListener(MouseEvent.MOUSE_MOVE, onMouseMove);
	}
	
	private function onMouseUp(e:MouseEvent):Void 
	{
		stage.removeEventListener(MouseEvent.MOUSE_UP, onMouseUp);
		stage.removeEventListener(MouseEvent.MOUSE_MOVE, onMouseMove);
	}
	
	private function onMouseMove(e:MouseEvent):Void 
	{
		switch(orientation) {
			case VERTICAL:
				value = Math.max(0, Math.min(mouseY / (size-10), 1));
			case HORIZONTAL:
				value = Math.max(0, Math.min(mouseX / (size-10), 1));
		}
	}
	
	public function setSize(value:Float):Void {
		size = value;
		redraw();
	}
	
	public function setValue(f:Float) 
	{
		_value = Math.max(0, Math.min(1, f));
		redraw();
	}
	
	function redraw() 
	{
		graphics.clear();
		graphics.lineStyle(0, 0);
		graphics.beginFill(0x808080);
		switch(orientation) {
			case VERTICAL:
				graphics.drawRect(0, 0, 10, size);
				graphics.endFill();
				graphics.beginFill(0xFFFFFF);
				graphics.drawRect(0, _value * (size-10), 10, 10);
			case HORIZONTAL:
				graphics.drawRect(0, 0, size, 10);
				graphics.endFill();
				graphics.beginFill(0xFFFFFF);
				graphics.drawRect(_value * (size-10), 0, 10, 10);
		}
	}
	
	function get_value():Float 
	{
		return _value;
	}
	
	function set_value(value:Float):Float 
	{
		_value = value;
		redraw();
		onChange.dispatch();
		return _value;
	}
	
	public var value(get_value, set_value):Float;
	
}
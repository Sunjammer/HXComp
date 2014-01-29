package com.furusystems.fl.gui;
import com.furusystems.flywheel.events.Signal1;
import flash.display.Sprite;
import flash.events.MouseEvent;

/**
 * ...
 * @author Andreas Rønning
 */
class Button extends Sprite
{
	var _label:String;

	public var onPress:Signal1<Button>;
	var labelTF:Label;
	var w:Int;
	var h:Int;
	public var data:Dynamic;
	public var highlit(get, set):Bool;
	var _highlit:Bool;
	var _isDown:Bool;
	public function new(label:String, w:Int, h:Int)
	{
		super();
		this.h = h;
		this.w = w;
		
		labelTF = new Label();
		addChild(labelTF);
		labelTF.width = w;
		labelTF.height = h;
		
		this.label = label;
		onPress = new Signal1<Button>();
		buttonMode = true;
		addEventListener(MouseEvent.MOUSE_DOWN, onMouseDown);
		addEventListener(MouseEvent.CLICK, onClick);
	}
	public function setData(d:Dynamic):Button {
		data = d;
		return this;
	}
	
	public function setEnabled(b:Bool):Button 
	{
		alpha = b?1:0.5;
		mouseEnabled = b;
		return this;
	}
	
	inline function get_highlit():Bool {
		return _highlit;
	}
	inline function set_highlit(b:Bool):Bool {
		_highlit = b;
		if (_isDown) drawDown();
		else drawUp();
		return _highlit;
	}
	
	private function onMouseDown(e:MouseEvent):Void
	{
		stage.addEventListener(MouseEvent.MOUSE_UP, onMouseUp);
		_isDown = true;
		drawDown();
	}
	
	private function onMouseUp(e:MouseEvent):Void
	{
		stage.removeEventListener(MouseEvent.MOUSE_UP, onMouseUp);
		_isDown = false;
		drawUp();
	}
	
	function drawUp()
	{
		graphics.clear();
		graphics.beginFill(0xFFFFFF);
		graphics.lineStyle(_highlit?2:0, 0);
		graphics.drawRect(0, 0, w, h);
		graphics.endFill();
	}
	function drawDown()
	{
		graphics.clear();
		graphics.beginFill(0xEEEEEE);
		graphics.lineStyle(_highlit?2:0, 0);
		graphics.drawRect(0, 0, w, h);
		graphics.endFill();
	}
	
	private function redraw():Void {
		labelTF.text = _label;
		labelTF.y = (h - labelTF.textHeight-3) * .5;
		
		drawUp();
	}
	
	private function onClick(e:MouseEvent):Void
	{
		onPress.dispatch(this);
	}
	
	function get_label():String
	{
		return _label;
	}
	
	function set_label(value:String):String
	{
		_label = value;
		redraw();
		return _label;
	}
	
	public var label(get_label, set_label):String;
	
}
package com.furusystems.fl.gui;
import com.furusystems.flywheel.events.Signal1;
import flash.display.Sprite;
import flash.events.MouseEvent;
import flash.geom.Rectangle;

/**
 * ...
 * @author Andreas Rønning
 */
class Button extends Sprite
{
	var _label:String;

	public var onPress:Signal1<Button>;
	var _labelTF:Label;
	var w:Int;
	var h:Int;
	public var data:Dynamic;
	public var highlit(get, set):Bool;
	var _highlit:Bool;
	var _isDown:Bool;
	public function new(label:String, w:Int = 80, h:Int = 20)
	{
		super();
		this.h = h;
		this.w = w;
		
		_labelTF = new Label();
		addChild(_labelTF);
		_labelTF.width = w;
		_labelTF.height = h;
		_labelTF.scrollRect = new Rectangle(0, 0, w, h);
		
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
	
	public function setEnabled(b:Bool, leaveMouseEnabled:Bool = false):Button 
	{
		alpha = b?1:0.5;
		if (!leaveMouseEnabled) mouseEnabled = b;
		if (b) {			
			addEventListener(MouseEvent.MOUSE_DOWN, onMouseDown);
			addEventListener(MouseEvent.CLICK, onClick);
			buttonMode = true;
		}else {
			removeEventListener(MouseEvent.MOUSE_DOWN, onMouseDown);
			removeEventListener(MouseEvent.CLICK, onClick);
			buttonMode = false;
		}
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
		if (value == null) value = "null";
		_label = value;
		var limit = w / 6;
		if (_label.length > limit) {
			_label = _label.substr(0, cast limit) + "...";
		}
		redraw();
		return _label;
	}
	
	public var label(get_label, set_label):String;
	
	function get_labelTF():Label 
	{
		return _labelTF;
	}
	
	public var labelTF(get_labelTF, null):Label;
	
}
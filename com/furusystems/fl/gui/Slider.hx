package com.furusystems.fl.gui;
import com.furusystems.flywheel.events.Signal1;
import flash.display.Graphics;
import flash.display.Shape;
import flash.display.Sprite;
import flash.events.MouseEvent;

/**
 * ...
 * @author Andreas Rønning
 */
class Slider extends Sprite
{
	public var length:Int;
	public var label:Label;
	public var value:Float;
	var sliderContainer:Sprite;
	var thumb:Sprite;
	var orientation:Orientation;
	public var max:Float;
	public var min:Float;
	public var previewLabel:Label = new Label("Value");
	public var onValueChange:Signal1<Float>;
	public var onValueSet:Signal1<Float>;
	private var _indicatorValue:Float = 0;
	private var roundValues:Bool = false;
	var indicatorGraphics:Shape;
	public function new(labelTxt:String = "Slider", length:Int = 100, min:Float = 0, max:Float = 1, defaultValue:Float = 0, ?orientation:Orientation, ?round:Bool)
	{
		super();
		if (orientation == null) orientation = Orientation.HORIZONTAL;
		if (round == null) round = false;
		onValueChange = new Signal1<Float>();
		onValueSet = new Signal1<Float>();
		this.max = max;
		this.min = min;
		this.length = length;
		this.roundValues = round;
		this.orientation = orientation;
		
		indicatorGraphics = new Shape();
		
		previewLabel.background = true;
		label = new Label();
		label.text = labelTxt;
		label.width = label.textWidth + 5;
		label.height = label.textHeight + 3;
		addChild(label);
		
		sliderContainer = new Sprite();
		addChild(sliderContainer);
		thumb = new Sprite();
		sliderContainer.addChild(thumb);
		thumb.graphics.beginFill(0xFFFFFF);
		thumb.graphics.lineStyle(0, 0);
		thumb.graphics.drawRect(0, 0, 9, 9);
		thumb.y = 1;
		thumb.buttonMode = true;
		thumb.addEventListener(MouseEvent.MOUSE_DOWN, onThumbDown);
		thumb.addEventListener(MouseEvent.MOUSE_OVER, showValue);
		
		sliderContainer.graphics.beginFill(0);
		switch(orientation) {
			case VERTICAL:
				sliderContainer.graphics.drawRect(3, 0, 5, length);
				sliderContainer.y = label.height;
				sliderContainer.x = (label.width-11) * .5;
			case HORIZONTAL:
				sliderContainer.graphics.drawRect(0, 3, length, 5);
				sliderContainer.x = label.width;
				sliderContainer.y = (label.height-11) * .5;
		}
		addChild(indicatorGraphics);
		addChild(previewLabel).visible = false;
		setValue(defaultValue);
	}
	
	private function showValue(e:MouseEvent):Void
	{
		previewLabel.visible = true;
		thumb.addEventListener(MouseEvent.MOUSE_OUT, hideValue);
	}
	
	private function hideValue(e:MouseEvent):Void
	{
		previewLabel.visible = false;
		thumb.removeEventListener(MouseEvent.MOUSE_OUT, hideValue);
	}
	
	private function onThumbDown(e:MouseEvent):Void
	{
		stage.addEventListener(MouseEvent.MOUSE_MOVE, onMouseMove);
		stage.addEventListener(MouseEvent.MOUSE_UP, onMouseUp);
		thumb.removeEventListener(MouseEvent.MOUSE_OVER, showValue);
		thumb.removeEventListener(MouseEvent.MOUSE_OUT, hideValue);
		previewLabel.visible = true;
	}
	
	private function onMouseUp(e:MouseEvent):Void
	{
		stage.removeEventListener(MouseEvent.MOUSE_MOVE, onMouseMove);
		stage.removeEventListener(MouseEvent.MOUSE_UP, onMouseUp);
		thumb.addEventListener(MouseEvent.MOUSE_OVER, showValue);
		previewLabel.visible = false;
		onValueSet.dispatch(value);
	}
	
	private function onMouseMove(e:MouseEvent):Void
	{
		if (orientation == HORIZONTAL) {
			setValueNorm(Math.max(0, Math.min(length, sliderContainer.mouseX)) / length);
		}else {
			setValueNorm(Math.max(0, Math.min(length, sliderContainer.mouseY)) / length);
		}
	}
	function setValueNorm(value:Float):Void {
		setValue(min + value * (max - min));
		onValueChange.dispatch(this.value);
	}
	public function setValue(value:Float):Void {
		this.value = roundValues?Math.round(value):value;
		if (orientation == HORIZONTAL) {
			thumb.x = valueToNorm(this.value) * (length - thumb.width);
		}else {
			thumb.y = valueToNorm(this.value) * (length - thumb.height);
		}
		previewLabel.x = thumb.x + 5;
		previewLabel.y = thumb.y - 5;
		previewLabel.text = ""+this.value;
	}
	inline function valueToNorm(inValue:Float):Float {
		return (inValue - min) / (max - min);
	}
	
	function get_indicatorValue():Float
	{
		return _indicatorValue;
	}
	
	function set_indicatorValue(value:Float):Float
	{
		value = Math.max(min, Math.min(max, value));
		drawIndicator(value);
		return _indicatorValue = value;
	}
	
	function drawIndicator(indicatorValue:Float)
	{
		var g:Graphics = indicatorGraphics.graphics;
		g.clear();
		g.lineStyle(2, 0xFFFFFF);
		switch(orientation) {
			case VERTICAL:
				g.moveTo(sliderContainer.x + 3, sliderContainer.y + length * valueToNorm(indicatorValue));
				g.lineTo(sliderContainer.x + 8, sliderContainer.y + length * valueToNorm(indicatorValue));
			case HORIZONTAL:
		}
	}
	
	public var indicatorValue(get_indicatorValue, set_indicatorValue):Float;
	
}
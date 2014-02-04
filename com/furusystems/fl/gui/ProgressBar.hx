package com.furusystems.fl.gui;
import flash.display.Sprite;
import flash.text.TextField;
import flash.text.TextFormat;
import flash.text.TextFormatAlign;

/**
 * ...
 * @author Michel de Brisis
 */
class ProgressBar extends Sprite
{		
	var mProgress:Float;	
	var w:Int;
	var h:Int;
	var text:TextField;
	
	public function new(w:Int = 150, h:Int = 30, showText:Bool = true)
	{
		super();
		mProgress = 0;			
		this.w = w;
		this.h = h;
		text = new TextField();
		text.width = w;
		text.height = h;
		var format:TextFormat = new TextFormat();
		format.align = TextFormatAlign.RIGHT;		
		text.defaultTextFormat = format;
		text.text = "0%";	
		text.visible = showText;
		addChild(text);
		drawBackGround();
		drawProgress();
	}
	
	public var showText(get, set):Bool;
	function get_showText():Bool { return text.visible; }
	function set_showText(value:Bool):Bool { text.visible = value; return text.visible; }
	
	public var progress(get, set):Float;
	function get_progress():Float { return mProgress; }
	function set_progress(value:Float) 
	{ 
		if (mProgress < value)
			drawBackGround();		
		mProgress = value; 
		drawProgress();		
		text.text = Math.floor(mProgress * 100) + "%";
		return mProgress; 
	}
	
	private function drawBackGround():Void
	{
		graphics.clear();
		graphics.beginFill(0xaaaaaa);
		graphics.drawRect(0, 0, w, h);
		graphics.endFill();
	}
	
	private function drawProgress():Void
	{
		graphics.beginFill(0xdddddd);
		graphics.drawRect(0, 0, w*mProgress, h);
		graphics.endFill();				
	}
}
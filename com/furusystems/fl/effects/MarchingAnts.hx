package com.furusystems.fl.effects;
import flash.display.BitmapData;
import flash.display.BlendMode;
import flash.display.Shape;
import flash.events.Event;
import flash.geom.Matrix;
import flash.geom.Rectangle;

/**
 * ...
 * @author Andreas Rønning
 */
class MarchingAnts extends Shape
{
	static var texture:BitmapData;
	static var mat:Matrix = new Matrix();
	var frameCount:Int;
	var rect:Rectangle;
	static function initTexture() 
	{
		texture = new BitmapData(4, 4, true, 0xFF000000);
		for (i in 0...texture.width) {
			texture.setPixel32(i, i, 0x00FFFFFF);
		}
	}
	public function new() 
	{
		super();
		if (texture == null) {
			initTexture();
		}
		rect = new Rectangle();
		frameCount = 0;
		addEventListener(Event.ENTER_FRAME, onEnterFrame);
		//blendMode = BlendMode.INVERT;
	}
	
	private function onEnterFrame(e:Event):Void 
	{
		graphics.clear();
		if (rect.size.length <= 0) return;
		frameCount++;
		mat.identity();
		mat.translate(frameCount, 0);
		graphics.lineStyle(1);
		graphics.lineBitmapStyle(texture, mat, true, false);
		graphics.beginFill(0, 0.05);
		graphics.drawRect(rect.x, rect.y, rect.width, rect.height);
	}
	public function draw(x:Int, y:Int, width:Int, height:Int):Void {
		rect.setTo(x, y, width, height);
	}
	
}
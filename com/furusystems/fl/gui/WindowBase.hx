package com.furusystems.fl.gui;
import com.furusystems.fl.gui.Label;
import flash.display.BlendMode;
import flash.display.DisplayObject;
import flash.display.Shape;
import flash.display.Sprite;
import flash.filters.DropShadowFilter;
import flash.geom.Rectangle;

/**
 * ...
 * @author Andreas Rønning
 */
class WindowBase extends Sprite
{
	var content:Sprite;
	var outline:Shape;
	var labelTF:Label;
	public var h:Int;
	public var w:Int;

	public function new(label:String, w:Int, h:Int)
	{
		super();
		this.h = h;
		this.w = w;
		graphics.beginFill(0xFFFFFF);
		graphics.drawRect(0, 0, w, h);
		graphics.endFill();
		
		content = new Sprite();
		//#if !debug
		content.scrollRect = new Rectangle(0, 0, w, h);
		//#end
		super.addChild(content);
		
		labelTF = new Label();
		labelTF.text = label;
		labelTF.width = labelTF.textWidth+4;
		labelTF.height = labelTF.textHeight + 4;
		labelTF.blendMode = BlendMode.INVERT;
		labelTF.x = w - labelTF.width;
		labelTF.x = w - labelTF.width;
		super.addChild(labelTF);
		
		outline = new Shape();
		outline.graphics.lineStyle(0, 0x555555);
		outline.graphics.drawRect(0, 0, w, h);
		outline.graphics.endFill();
		super.addChild(outline);
		
		filters = [new DropShadowFilter(2, 90, 0, 0.4, 16, 16)];
	}
	override public function addChild(child:DisplayObject):DisplayObject
	{
		return content.addChild(child);
	}
	override public function removeChild(child:DisplayObject):DisplayObject
	{
		return content.removeChild(child);
	}
	override public function removeChildren(beginIndex:Int = 0, endIndex:Int = 2147483647):Void
	{
		content.removeChildren(beginIndex, endIndex);
	}
	
}
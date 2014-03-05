package com.furusystems.fl.gui;
import flash.text.TextField;
import flash.text.TextFieldType;
import flash.text.TextFormat;
import flash.text.TextFormatAlign;

/**
 * ...
 * @author Andreas Rønning
 */
class Label extends TextField
{

	private static var DEFAULT_TF_CENTERED:TextFormat = new TextFormat("_sans", 10, 0,null,null,null,null,null,TextFormatAlign.CENTER);
	private static var DEFAULT_TF:TextFormat = new TextFormat("_sans", 10, 0);
	
	public var highlit(get, set):Bool;
	var _highlit:Bool;
	
	public function new(?text:String, ?w:Int, ?h:Int, centered:Bool = true, outline:Bool = false, allowInput:Bool = false, allowSelect:Bool = false)
	{
		super();
		defaultTextFormat = centered?DEFAULT_TF_CENTERED:DEFAULT_TF;
		
		mouseEnabled = allowInput || allowSelect;
		type = allowInput?TextFieldType.INPUT:TextFieldType.DYNAMIC;
		if (text != null) this.text = text;
		if (w != null) width = w;
		else width = textWidth+4;
		if (h != null) height = h;
		else height = textHeight + 4;
		if (outline) this.border = true;
	}
	
	inline function get_highlit():Bool {
		return _highlit;
	}
	inline function set_highlit(b:Bool):Bool {
		_highlit = b;
		//background = b;
		backgroundColor = b?0x808080:0xFFFFFF;
		return _highlit;
	}
	
}
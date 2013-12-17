package no.expology.utils.kps.gui;
import flash.text.TextField;
import flash.text.TextFieldAutoSize;
import flash.text.TextFormat;
import flash.text.TextFormatAlign;

/**
 * ...
 * @author Andreas Rønning
 */
class Label extends TextField
{

	private static var DEFAULT_TF:TextFormat = new TextFormat("_sans", 10, 0,null,null,null,null,null,TextFormatAlign.CENTER);
	public function new(?text:String, ?w:Int, ?h:Int) 
	{
		super();
		defaultTextFormat = DEFAULT_TF;
		
		mouseEnabled = false;
		if (text != null) this.text = text;
		if (w != null) width = w;
		else width = textWidth+4;
		if (h != null) height = h;
		else height = textHeight+4;
	}
	
}
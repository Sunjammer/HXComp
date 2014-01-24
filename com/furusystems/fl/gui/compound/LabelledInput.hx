package com.furusystems.fl.gui.compound;
import com.furusystems.fl.gui.Label;
import com.furusystems.fl.gui.LinearLayout;

/**
 * ...
 * @author ...
 */
class LabelledInput extends LinearLayout
{
	var valueField:Label;

	public function new(name:String, defaultValue:Dynamic) 
	{
		super(HORIZONTAL);
		add(new Label(name, 80, 20, true, true));
		valueField = add(new Label(defaultValue + "", 80, 20, true, true, true));
	}
	public var value(get, set):String;
	inline function get_value():String {
		return valueField.text;
	}
	inline function set_value(s:String):String {
		return valueField.text = s;
	}
	
}
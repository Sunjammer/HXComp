package com.furusystems.fl.gui.layouts;
import com.furusystems.fl.gui.compound.Viewport;
import flash.display.Sprite;
import flash.geom.Rectangle;

/**
 * ...
 * @author Andreas Rønning
 */

typedef ListViewData = {  }
 
class ListView<T> extends Viewport
{
	
	var data:Array<T>;
	var _listContainer:com.furusystems.fl.gui.layouts.VBox;
	
	var _selectedIndex(get, set):Int;

	public function new() 
	{
		super(100, 100);
		_listContainer = new VBox();
		setContent(_listContainer);
	}
	override public function setSize(w:Float, h:Float):Void 
	{
		super.setSize(w, h);
		
	}
	
	public var setData(data:Array<T>):Array<T> {
		this.data = data;
		redraw();
		return this.data;
	}
	
	public var selectedItem(get, set):T;
	
	function get_selectedIndex():Int 
	{
		return _selectedIndex;
	}
	
	function set_selectedIndex(value:Int):Int 
	{
		return _selectedIndex = value;
	}
	
}
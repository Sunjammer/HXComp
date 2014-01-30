package com.furusystems.fl.gui.compound;
import com.furusystems.fl.gui.Label;
import com.furusystems.flywheel.events.Signal1.Signal1;
import flash.display.Sprite;
import flash.events.MouseEvent;
import flash.filters.DropShadowFilter;

/**
 * ...
 * @author ...
 */
class Dropdown extends Sprite
{
	var selectedLabel:Label;
	var tempSelection:Label;
	var items:Array<String>;
	var itemListContainer:Sprite;
	public var onSelection:Signal1<String>;
	public function new(width:Int = 80, height:Int = 20, defaultText:String = "") 
	{
		super();
		onSelection = new Signal1<String>();
		items = [];
		selectedLabel = new Label(defaultText, width, height, true, true, false);
		selectedLabel.background = true;
		addChild(selectedLabel);
		addEventListener(MouseEvent.MOUSE_DOWN, onMouseDown);
		itemListContainer = new Sprite();
		itemListContainer.filters = [new DropShadowFilter(4, 90, 0, 0.2, 8, 8)];
	}
	
	private function onMouseDown(e:MouseEvent):Void 
	{
		stage.addEventListener(MouseEvent.MOUSE_MOVE, onMouseMove);
		stage.addEventListener(MouseEvent.MOUSE_UP, onMouseUp);
		buildList();
	}
	
	function buildList() 
	{
		itemListContainer.removeChildren();
		
		for (i in 0...items.length) {
			var l = new Label(items[i], 80, 20);
			l.background = true;
			l.y = i * 20;
			itemListContainer.addChild(l);
		}
		addChildAt(itemListContainer, 0).y = 20;
	}
	
	private function onMouseMove(e:MouseEvent):Void 
	{
		var pos = Math.floor(itemListContainer.mouseY / 20);
		if (pos < 0 || pos > items.length - 1) {
			tempSelection = null;
		}else {
			if (tempSelection != null) tempSelection.highlit = false;
			tempSelection = cast itemListContainer.getChildAt(pos);
			tempSelection.highlit = true;
		}
	}
	
	private function onMouseUp(e:MouseEvent):Void 
	{
		stage.removeEventListener(MouseEvent.MOUSE_MOVE, onMouseMove);
		stage.removeEventListener(MouseEvent.MOUSE_UP, onMouseUp);
		destroyList();
		if (tempSelection != null) {
			setSelection(tempSelection.text);
		}
	}
	
	function destroyList() 
	{
		removeChild(itemListContainer);
	}
	public function removeItem(str:String):Void {
		var i = items.length - 1;
		while (i-- > 0) {
			if (items[i] == str) {
				items.splice(i, 1);
				return;
			}
		}
	}
	public function addItem(str:String, setCurrent:Bool = false):Void {
		items.push(str);
		if(setCurrent) setSelection(str);
	}
	
	public function setSelection(str:String) 
	{
		selectedLabel.text = str;
		onSelection.dispatch(str);
	}
	
}
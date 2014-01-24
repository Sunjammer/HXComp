package com.furusystems.fl.gui.compound;
import com.furusystems.fl.gui.Button;
import com.furusystems.fl.gui.HBox;
import com.furusystems.fl.gui.LinearLayout;
import flash.display.Sprite;

/**
 * ...
 * @author ...
 */
using Lambda;
class TabbedLayout extends Sprite
{
	var currentTab:String;
	var buttons:Array<Button>;
	var tabLayouts:Array<LinearLayout>;
	var buttonRow:HBox;
	public function new(?tabs:Array<String>) 
	{
		super();
		buttonRow = new HBox();
		buttonRow.spacing = 0;
		addChild(buttonRow);
		buttons = [];
		tabLayouts = [];
		if(tabs!=null){
			for (t in tabs) {
				addTab(t);
			}
			if (tabs.length > 0) setTab(buttons[0]);
		}
	}
	
	public function addTab(id:String, makeCurrent:Bool = false):LinearLayout {
		var btn:Button;
		(btn = buttonRow.add(new Button(id, 60, 20))).onPress.add(setTab);
		buttons.push(btn);
		var layout = new LinearLayout(VERTICAL);
		tabLayouts.push(layout);
		if (makeCurrent) {
			setTab(btn);
		}
		return layout;
	}
	
	public function removeTab(id:String):Void {
		var i = buttons.length;
		while (i-- > 0) {
			if (buttons[i].label.toLowerCase() == id.toLowerCase()) {
				buttons.splice(i, 1);
				tabLayouts.splice(i, 1);
				if (buttons.length > 0) setTab(buttons[0]);
				return;
			}
		}
	}
	
	public function setTab(btn:Button):LinearLayout {
		for (button in buttons) {
			button.highlit = btn==button;
		}
		for (tab in tabLayouts) {
			if (contains(tab)) removeChild(tab);
		}
		var layout = tabLayouts[buttons.indexOf(btn)];
		addChild(layout).y = buttonRow.height;
		return layout;
	}
	public function getTab(index:Int):LinearLayout {
		return tabLayouts[index];
	}
	
}
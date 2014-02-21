package com.furusystems.fl.gui.compound;
import com.furusystems.fl.gui.Button;
import com.furusystems.fl.gui.HBox;
import com.furusystems.fl.gui.LinearLayout;
import com.furusystems.flywheel.events.Signal1;
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
	public var tabChanged:Signal1<Int>;
	public function new(?tabs:Array<String>) 
	{
		super();
		tabChanged = new Signal1<Int>();
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
	public function getNumTabs():Int {
		return buttons.length;
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
				buttonRow.remove(buttons[i]);
				if (tabLayouts[i].parent != null) tabLayouts[i].parent.removeChild(tabLayouts[i]);
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
		tabChanged.dispatch(buttons.indexOf(btn));
		return layout;
	}
	public function getTabContent(label:String):LinearLayout {
		label = label.toLowerCase();
		for (i in 0...buttons.length) {
			if (buttons[i].label.toLowerCase() == label) {
				return tabLayouts[i];
			}
		}
		return null;
	}
	
	public function getTab(label:String):Button{
		label = label.toLowerCase();
		for (i in 0...buttons.length) {
			if (buttons[i].label.toLowerCase() == label) {
				return buttons[i];
			}
		}
		return null;
	}
	
}
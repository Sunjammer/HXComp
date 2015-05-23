package com.furusystems.fl.gui.layouts.treeview;
import flash.display.Sprite;

/**
 * ...
 * @author Andreas Rønning
 */

typedef TreeViewNode = { name:String, parent:TreeViewNode, children:Iterable<TreeViewNode>};
 
class TreeViewItem extends Sprite {
	public var data:TreeViewNode;
	
	public var expanded(get, set):Bool;
	var _expanded:Bool = true;
	
	public var selected(get, set):Bool;
	var _selected:Bool = false;
	
	function get_selected():Bool {
		return _selected;
	}	
	function set_selected(b:Bool):Bool {
		_selected = b;
		return _selected;
	}
	
	function get_expanded():Bool {
		return _expanded;
	}	
	function set_expanded(b:Bool):Bool {
		_expanded = b;
		update();
		return _expanded;
	}
	
	public function new() {
		super();
	}
	
	public function setData(d:TreeViewNode) {
		data = d;
		update();
	}
	
	public function update() {
		
	}
}
 
class TreeView extends TreeViewItem
{
	public function new() 
	{
		super();
		data = null;
	}
	
}
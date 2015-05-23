package com.furusystems.fl.gui.layouts.treeview;
import com.furusystems.fl.gui.Label;
import com.furusystems.fl.gui.layouts.treeview.TreeView.TreeViewItem;
import flash.display.Sprite;
import flash.events.MouseEvent;

/**
 * ...
 * @author Andreas Rønning
 */

typedef TreeViewData<T> = { name:String, parent:T, children:Array<T>};
 
class TreeViewItem<T> extends Sprite {
	
	public var data:TreeViewData<T>;
	
	public var expanded(get, set):Bool;
	var _expanded:Bool = true;
	
	var treeView:TreeView<T>;
	
	var label:Label;
	var childContainer:Sprite;
	
	public function new() {
		super();
		label = new Label("Foo", 0, 0, false, true, false, false, true);
		childContainer = new Sprite();
		addChild(childContainer);
		addChild(label);
		doubleClickEnabled = true;
		addEventListener(MouseEvent.CLICK, onClick);
		addEventListener(MouseEvent.DOUBLE_CLICK, onDoubleClick);
	}
	
	private function onClick(e:MouseEvent):Void 
	{
		if (e.target == this) {
			treeView.selection = data;
		}
	}
	
	private function onDoubleClick(e:MouseEvent):Void 
	{
		if(e.target == this) expanded = !expanded;
	}
	
	function isSelected():Bool {
		return treeView.selection == data;
	}
	
	function get_expanded():Bool {
		return _expanded;
	}	
	function set_expanded(b:Bool):Bool {
		_expanded = b;
		update();
		return _expanded;
	}
	
	public function setTreeView(root:TreeView<T>) {
		treeView = root;
	}
	
	public function setData(d:TreeViewData<T>) {
		data = d;
		rebuild();
		update();
	}
	
	public function rebuild() 
	{
		childContainer.removeChildren();
		var offset:Float = height;
		for (c in data.children) {
			var n:TreeViewData<T> = cast c;
			var nv = new TreeViewItem<T>();
			nv.setTreeView(treeView);
			childContainer.addChild(nv);
			nv.setData(n);
			nv.y = offset;
			nv.x = 10;
			offset += nv.height;
		}
	}
	
	function getNodeForData(data:TreeViewData<T>):TreeViewItem<T> {
		if (data == null) return null;
		if (this.data == data) return this;
		for (i in 0...childContainer.numChildren) {
			var item:TreeViewItem<T> = cast childContainer.getChildAt(i);
			var r = item.getNodeForData(data);
			if (r != null) return r;
		}
		return null;
	}
	
	public function update() {
		var labelText = "";
		if (data.children.length > 0) {
			labelText += expanded?"+":"-";
		}
		label.text = labelText + "\t" + data.name;
		
		label.backgroundColor = isSelected() ? 0xbbbbbb : 0xffffff;
		label.background = isSelected();
		
		childContainer.visible = expanded;
	}
}

class TreeView<T> extends TreeViewItem<T>
{
	public var selection(get, set):TreeViewData<T>;
	var _selection:TreeViewData<T>;
	
	function get_selection():TreeViewData<T> {
		return _selection;
	}
	
	function set_selection(t:TreeViewData<T>):TreeViewData<T> {
		if (t == _selection) return _selection;
		var previousNode = getNodeForData(_selection);
		_selection = t;
		if(previousNode != null) previousNode.update();
		if (_selection != null) {
			var s = getNodeForData(_selection);
			if(s != null) s.update();
		}
		return _selection;
	}
	
	public function new() 
	{
		super();
		setTreeView(this);
		data = null;
	}
	
}
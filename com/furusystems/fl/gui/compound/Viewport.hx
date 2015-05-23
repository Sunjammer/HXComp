package com.furusystems.fl.gui.compound;
import com.furusystems.fl.gui.layouts.AbstractLayout;
import com.furusystems.fl.gui.ScrollBar;
import flash.display.DisplayObject;
import flash.display.Shape;
import flash.display.Sprite;
import flash.events.MouseEvent;
import flash.geom.Rectangle;

/**
 * Scrollrect with scrollbars
 * @author Andreas Rønning
 */
class Viewport extends Sprite
{
	var hbar:ScrollBar;
	var vbar:ScrollBar;
	var scrollContainer:Sprite;
	var contents:Sprite;
	var outline:Shape;
	public function new(rect:Rectangle) 
	{
		super();
		scrollContainer = new Sprite();
		contents = new Sprite();
		hbar = new ScrollBar(HORIZONTAL);
		vbar = new ScrollBar(VERTICAL);
		
		hbar.onChange.add(onScroll);
		vbar.onChange.add(onScroll);
		
		outline = new Shape();
		
		addChild(scrollContainer);
		scrollContainer.addChild(contents);
		addChild(hbar);
		addChild(vbar);
		addChild(outline);
		
		addEventListener(MouseEvent.MOUSE_WHEEL, onMouseWheel);
		
		setRect(rect);
	}
	
	function canScrollY():Bool {
		return contents.width > scrollContainer.scrollRect.width;
	}
	function canScrollX():Bool {
		return contents.height > scrollContainer.scrollRect.height;
	}
	
	function onMouseWheel(e:MouseEvent):Void 
	{
		if (!canScrollY()) return;
		vbar.setValue(vbar.value - e.delta * 0.025);
		onScroll();
	}
	
	function onScroll() 
	{
		var r = scrollContainer.scrollRect;
		
		if(canScrollX()){
			var xval = hbar.value;
			r.x = xval * (contents.width - r.width);
		}
		
		if(canScrollY()){
			var yval = vbar.value;
			r.y = yval * (contents.height - r.height);
		}
		scrollContainer.scrollRect = r;
	}
	
	public function setContent(c:DisplayObject):DisplayObject {
		contents.removeChildren();
		contents.addChild(c);
		hbar.setValue(0);
		vbar.setValue(0);
		hbar.enabled = canScrollX();
		vbar.enabled = canScrollY();
		return c;
	}
	
	public function setRect(r:Rectangle):Void {
		r.width -= 10;
		r.height -= 10;
		scrollContainer.scrollRect = r;
		
		graphics.clear();
		graphics.beginFill(0, 0);
		graphics.drawRect(0, 0, r.width, r.height);
		
		outline.graphics.clear();
		outline.graphics.lineStyle(0, 0);
		outline.graphics.drawRect(0, 0, r.width, r.height);
		
		hbar.setSize(r.width);
		hbar.y = r.height;
		vbar.setSize(r.height);
		vbar.x = r.width;
		
		outline.graphics.beginFill(0);
		outline.graphics.lineStyle();
		outline.graphics.drawRect(r.width + 1, r.height + 1, 10, 10);
		
		onScroll();
		
	}
	
}
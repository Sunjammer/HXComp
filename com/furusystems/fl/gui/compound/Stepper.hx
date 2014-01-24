package com.furusystems.fl.gui.compound;
import com.furusystems.fl.gui.Button;
import com.furusystems.fl.gui.HBox;
import com.furusystems.fl.gui.Label;
import com.furusystems.fl.gui.LinearLayout;
import com.furusystems.fl.gui.Orientation;
import com.furusystems.fl.gui.VBox;
import com.furusystems.flywheel.events.Signal2.Signal2;
import flash.display.Sprite;

/**
 * ...
 * @author ...
 */
class Stepper extends LinearLayout
{
	var label:Label;
	static inline var HEIGHT:Int = 16;
	public var increment:Float;
	public var max:Float;
	public var min:Float;
	public var value:Float;
	public var onChange:Signal2<Stepper, Float>;
	public function new(min:Float = -1000, max:Float = 1000, defaultValue:Float = 0, increment:Float = 1, ?orientation:Orientation) 
	{
		super(orientation);
		this.increment = increment;
		this.max = max;
		this.min = min;
		this.value = defaultValue;
		onChange = new Signal2<Stepper,Float>();
		
		add(new Button("-", HEIGHT, HEIGHT)).onPress.add(function(btn) { step( -1); } );
		add(new Button("+", HEIGHT, HEIGHT)).onPress.add(function(btn) { step( 1); });
		if (orientation == VERTICAL) {
			label = new Label(defaultValue + "", HEIGHT, 40,true,true);
		}else {
			label = new Label(defaultValue + "", 40, HEIGHT,true,true);
		}
		add(label);
		
	}
	function step(direction:Int):Void {
		var newValue = value + direction * increment;
		newValue = Math.max(min, Math.min(max, newValue));
		if(newValue!=value){
			value = newValue;
			label.text = value + "";
			onChange.dispatch(this, value);
		}
	}
	
}
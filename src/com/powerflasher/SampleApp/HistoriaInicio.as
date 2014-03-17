package com.powerflasher.SampleApp {
	/**
	 * @author Amiel Zuñiga
	 */
	import org.flixel.*;
	
	public class HistoriaInicio extends FlxState{
		private var texto:FlxText;
		private var t:Number;
		[Embed(source = "img/esc.png")] public static var esc:Class;
		private var teclaESC:FlxSprite = new FlxSprite(540,700);
		
		
		public function HistoriaInicio(){
        	super();
        }
		
		override public function create():void{	
			t=0;
			FlxG.mouse.show();
 			texto=new FlxText(0, 250, FlxG.width, "One day a little alien called Kang was traveling all over the space when suddenly...").setFormat(null, 30, 0xFFFFFF, "center");
		    add(texto);
			teclaESC.loadGraphic(esc, true, true, 56, 53, true);
			add(teclaESC);
		}
		
		override public function update():void{
			super.update();
			t+=FlxG.elapsed;
			if(t>=5){
				FlxG.switchState(new Historia());
			}
			if(FlxG.keys.pressed("ESCAPE")){
                 FlxG.switchState(new Historia());
            }
		}
		
	}
}
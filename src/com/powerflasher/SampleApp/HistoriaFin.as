package com.powerflasher.SampleApp {
	/**
	 * @author Amiel Zuñiga
	 */
	import org.flixel.*;
	
	public class HistoriaFin extends FlxState{
		private var texto:FlxText;
		private var t:Number;
		[Embed(source = "img/esc.png")] public static var esc:Class;
		private var teclaESC:FlxSprite = new FlxSprite(540,700);
		
		public function HistoriaFin(){
        	super();
        }
		
		override public function create():void{	
			t=0;
 			texto=new FlxText(0, 250, FlxG.width, "Now Kang is in the Earth and he needs to get back home...\n Can you help him?").setFormat(null, 30, 0xFFFFFF, "center");
		    add(texto);
			FlxG.mouse.show();
			teclaESC.loadGraphic(esc, true, true, 56, 53, true);
			add(teclaESC);
		}
		
		override public function update():void{
			super.update();
			t+=FlxG.elapsed;
			if(t>=5){
				FlxG.switchState(new Inicio());
			}
			if(FlxG.keys.pressed("ESCAPE")){
                 FlxG.switchState(new Inicio());
            }
		}
		
	}
}
package com.powerflasher.SampleApp {
	/**
	 * @author Amiel Zuñiga
	 */
	import org.flixel.*;
	
	public class GameOver extends FlxState{
		private var texto:FlxText;
		private var t:Number;
		[Embed(source="musica/win.mp3")] public var Music:Class;
		
		public function GameOver(){
        	super();
        }
		
		override public function create():void{	
 			t = 0;
			FlxG.play(Music, 1, false);
			FlxG.mouse.show();
			texto=new FlxText(0, 250, FlxG.width, "Game Over!").setFormat(null, 30, 0xFFFFFF, "center");
           	add(texto);
			texto=new FlxText(0, 350, FlxG.width, "Thank you for playing!").setFormat(null, 20, 0xFFFFFF, "center");
           	add(texto);
		}
		
		override public function update():void{
			super.update();
			t+=FlxG.elapsed;
			if(t>=4){
				FlxG.switchState(new Inicio());
			}
   		}
		
	}
}
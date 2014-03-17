package com.powerflasher.SampleApp {
	
	import org.flixel.FlxSprite;
	/**
	 * @author Johansson_Zuniga
	 */
	public class Pico extends FlxSprite{
		[Embed(source = "img/pico.png")] public static var picoSpriteSheet:Class;
		[Embed(source = "img/pico2.png")] public static var pico2SpriteSheet:Class;
		[Embed(source = "img/picoArriba.png")] public static var picoArribaSpriteSheet:Class;
		[Embed(source = "img/picoAbajo.png")] public static var picoAbajoSpriteSheet:Class;
		
		public function Pico(x:int, y:int, imagen:int){
			super(x,y);
			if(imagen==1){
				loadGraphic(pico2SpriteSheet, true, true, 30, 30, true);
			}
			else if (imagen==2){
				loadGraphic(picoSpriteSheet, true, true, 30, 30, true);
			}
			else if (imagen==3){
				loadGraphic(picoArribaSpriteSheet, true, true, 30, 30, true);
			}
			else{
				loadGraphic(picoAbajoSpriteSheet, true, true, 30, 30, true);
			}
			frame=10;
		}
	
	}
}

package com.powerflasher.SampleApp {
	/**
	 * @author Eros Esp�nola
	 */
	import org.flixel.FlxSprite;

	public class Misil extends FlxSprite{
		
		[Embed(source = "img/misil.png")] public static var jugadorSpriteSheet:Class;
		[Embed(source = "img/misil2.png")] public static var jugadorSpriteSheet2:Class;
		
		public function Misil(x:int, y:int, direccion:Number){
			super(x,y);
			if(direccion == 1){
				loadGraphic(jugadorSpriteSheet, true, true, 150, 23, true);
			}
			else if(direccion == 2){
				loadGraphic(jugadorSpriteSheet2, true, true, 150, 23, true);
			}
		}
		
	}
}

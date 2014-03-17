package com.powerflasher.SampleApp {
	/**
	 * @author Eros Esp�nola
	 */
	import org.flixel.FlxSprite;

	public class Jugador extends FlxSprite{
		
		[Embed(source = "img/alien.png")] public static var jugadorSpriteSheet:Class;
		public var vida:int;
		
		public function Jugador(x:int, y:int){
			super(x,y);
			vida = 3;
			loadGraphic(jugadorSpriteSheet, true, true, 50, 70, true);
			
			frame=8;
			
			addAnimation("derecha", [0,1,2,3,4,5,6,7],30,false);
			addAnimation("arriba", [16,17,18,17,16,0],10,false);			
			addAnimation("izquierda", [15,14,13,12,11,10,9,8],30,false);
			addAnimation("abajo", [18,17,16,0],20,false);
			addAnimation("pared", [19], 20, false);
			addAnimation("escalar", [18,17,16], 8, false);
		}
	}
}
package com.powerflasher.SampleApp {
	/**
	 * @author Eros Esp�nola
	 */
	import org.flixel.FlxSprite;

	public class Humo extends FlxSprite{
		
		[Embed(source = "img/Dinamita.png")] public static var jugadorSpriteSheet:Class;
		
		public function Humo(x:int, y:int){
			super(x,y);
			loadGraphic(jugadorSpriteSheet, true, true, 32, 32, true);
			addAnimation("bala", [1,2,3,4,5,6,7,8,9,10,11,12,13,1],60,false);
			
		}
	}
}
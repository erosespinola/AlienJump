package com.powerflasher.SampleApp {
	/**
	 * @author Eros Esp�nola
	 */
	import org.flixel.FlxSprite;

	public class Vida extends FlxSprite{
		
		[Embed(source = "img/alienvida2.png")] public static var jugadorSpriteSheet:Class;
		
		public function Vida(x:int, y:int){
			super(x,y);
			loadGraphic(jugadorSpriteSheet, true, true, 35, 21, true);
			scrollFactor.x=0;
			scrollFactor.y=0;
			frame=0;
		}
	}
}
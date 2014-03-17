package com.powerflasher.SampleApp {
	/**
	 * @author Eros Espinola
	 */
	import org.flixel.FlxSprite;
	
	public class Bala extends FlxSprite{
		[Embed(source = "img/bullet.png")] public static var jugadorSpriteSheet:Class;
		
		public function Bala(x:int, y:int, size:int, velx:int, vely:int){
			super(x,y);
			loadGraphic(jugadorSpriteSheet, true, true, 14, 14, true);
			velocity.x = velx;
			velocity.y = vely;
		}
	}
}
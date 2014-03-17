package com.powerflasher.SampleApp {
	
	import org.flixel.FlxSprite;

	public class Enemigo extends FlxSprite{
		public var vida:int;
		[Embed(source = "img/enemigo.png")] public static var jugadorSpriteSheet:Class;
		
		public function Enemigo(x:int, y:int){
			super(x,y);
			loadGraphic(jugadorSpriteSheet, true, true, 50, 70, true);
			vida = 5;
			frame=0;
			addAnimation("casco", [17,18,19,20,21], 5, false);
			addAnimation("derecha", [1,2,3,4,5,6,7,8],30,false);	
			addAnimation("izquierda", [16,15,14,13,12,11,10,9],30,false);
			
			
		}
	}
}
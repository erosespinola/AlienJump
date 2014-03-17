package com.powerflasher.SampleApp {
	/**
	 * @author Eros Esp�nola
	 */
	import org.flixel.FlxSprite;

	public class Tanque extends FlxSprite{
		
		[Embed(source = "img/tanque.png")] public static var jugadorSpriteSheet:Class;
		
		private var vida:int;
		
		public function Tanque(x:int, y:int, life:int){
			super(x,y);
			vida=life;
			loadGraphic(jugadorSpriteSheet, true, true, 250, 126, true);
		}
		
		public function reduceLife():void{
			vida = vida - 1;
		}
		
		public function getVida():int{
			return vida;
		}
		
		public function fire(x:int, y:int, size:int, velx:int, vely:int):Bala{
			var bala:Bala = new Bala(x,y,size,velx,vely);
			return bala;
		}
	}
}

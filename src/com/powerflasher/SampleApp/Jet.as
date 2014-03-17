package com.powerflasher.SampleApp {
	/**
	 * @author Eros Esp�nola
	 */
	import org.flixel.FlxSprite;

	public class Jet extends FlxSprite{
		
		[Embed(source = "img/Jet.png")] public static var jetSpriteSheet:Class;
		[Embed(source = "img/Jet2.png")] public static var jetSpriteSheet2:Class;
		
		private var vida:int;
		
		public function Jet(x:int, y:int, life:int, tipo:int){
			super(x,y);
			vida=life;
			if(tipo == 1){
				loadGraphic(jetSpriteSheet, true, true, 199, 135, true);
			}
			else if(tipo == 2){
				loadGraphic(jetSpriteSheet2, true, true, 199, 135, true);
			}
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

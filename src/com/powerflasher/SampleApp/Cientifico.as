package com.powerflasher.SampleApp {
	/**
	 * @author Eros Esp�nola
	 */
	import org.flixel.FlxSprite;

	public class Cientifico extends FlxSprite{
		
		[Embed(source = "img/cientifico_tile.png")] public static var jugadorSpriteSheet:Class;
		[Embed(source = "img/cientifico_tile2.png")] public static var jugadorSpriteSheet2:Class;
		
		
		public function Cientifico(x:int, y:int, type:int){
			super(x,y);
			if(type==1){
				loadGraphic(jugadorSpriteSheet, true, true, 57, 70, true);
			}
			else {
				loadGraphic(jugadorSpriteSheet2, true, true, 57, 70, true);
				
			}
			addAnimation("dispara", [0,1,2,3,4],30,false);
			
		}
		
		public function fire(x:int, y:int, size:int, velx:int, vely:int):Bala{
			var bala:Bala = new Bala(x,y,size,velx,vely);
			return bala;
		}
	}
}
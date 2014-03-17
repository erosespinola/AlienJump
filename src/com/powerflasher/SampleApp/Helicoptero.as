package com.powerflasher.SampleApp {
	/**
	 * @author Eros Esp�nola
	 */
	import org.flixel.FlxSprite;

	public class Helicoptero extends FlxSprite{
		
		[Embed(source = "img/helicoptero2.png")] public static var jugadorSpriteSheet2:Class;
		[Embed(source = "img/Helicoptero.png")] public static var jugadorSpriteSheet:Class;
		
			
		public function Helicoptero(x:int, y:int, type:int){
			super(x,y);
			if(type==1){
							loadGraphic(jugadorSpriteSheet, true, true, 200, 153, true);
				
			} else {
							loadGraphic(jugadorSpriteSheet2, true, true, 200, 153, true);
				
			}
			
			addAnimation("volar", [0,1],15,true);
			
		}
		
		public function fire(x:int, y:int, size:int, velx:int, vely:int):Bala{
			var bala:Bala = new Bala(x,y,size,velx,vely);
			return bala;
		}
		public function red(x:int, y:int, size:int, velx:int, vely:int):Red{
                        var red:Red = new Red(x,y,size,velx,vely,1);
                        return red;
                }
		
		
	}
}

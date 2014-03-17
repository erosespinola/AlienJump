package com.powerflasher.SampleApp {
	/**
	 * @author Amiel Zuniga
	 */
	import org.flixel.FlxSprite;

	public class Plataforma extends FlxSprite{
		
		[Embed(source = "img/movilnieve.png")] public static var platformSpriteSheet:Class;
		[Embed(source = "img/Plataforma_movil.png")] public static var platformSpriteSheet2:Class;
		
		
		public var vmax:Boolean;
		public var hmax:Boolean;
		
		public function Plataforma(x:int, y:int, type:int){ 
			super(x,y);
			vmax=true;
			hmax=true;
			if(type==1){
				loadGraphic(platformSpriteSheet, true, true, 116, 32, true);
				
			}else {
				loadGraphic(platformSpriteSheet2, true, true, 116, 32, true);
			}
			
		}
	}
}

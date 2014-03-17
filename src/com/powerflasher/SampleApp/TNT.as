package com.powerflasher.SampleApp {
	/**
	 * @author Amiel Zuniga
	 */
	import org.flixel.FlxSprite;
	/**
	 * @author ieiomeli
	 */
	public class TNT extends FlxSprite{
		
		[Embed(source = "img/TNT.png")] public static var itemSpriteSheet:Class;
		
		public function TNT(x:int, y:int){
			super(x,y);
			loadGraphic(itemSpriteSheet, true, true, 32, 32, true);
		}
		
		public function setPosicion(x:int, y:int):void{
			this.x=x;
			this.y=y;
		}
	}
}
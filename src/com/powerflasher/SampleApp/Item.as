package com.powerflasher.SampleApp {
	/**
	 * @author Amiel Zuniga
	 */
	import org.flixel.FlxSprite;
	/**
	 * @author ieiomeli
	 */
	public class Item extends FlxSprite{
		
		[Embed(source = "img/item.png")] public static var itemSpriteSheet:Class;
		
		public function Item(x:int, y:int){
			super(x,y);
			loadGraphic(itemSpriteSheet, true, true, 32, 32, true);


		}
	}
}

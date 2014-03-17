package com.powerflasher.SampleApp {
	/**
	 * @author Amiel Zuniga
	 */
	import org.flixel.FlxSprite;
	/**
	 * @author ieiomeli
	 */
	public class Sky extends FlxSprite{
		
		[Embed(source = "img/sky.png")] public static var sky:Class;
		
		
		public function Sky(x:int, y:int){
			super(x,y);
			loadGraphic(sky, true, true, 1280, 6400, true);

		}
	}
}

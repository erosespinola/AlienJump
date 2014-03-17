package com.powerflasher.SampleApp {
	/**
	 * @author Eros Esp�nola
	 */
	import org.flixel.FlxSprite;

	public class Heart extends FlxSprite{
		
		[Embed(source = "img/heart.png")] public static var heart:Class;
		
		public function Heart(x:int, y:int){
			super(x,y);
			loadGraphic(heart, true, true, 22, 22, true);
			scrollFactor.x=0;
			scrollFactor.y=0;
			frame=0;
		}
	}
}
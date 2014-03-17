
package com.powerflasher.SampleApp {
        /**
         * @author Eros Esp�nola
         */
        import org.flixel.FlxSprite;
        
        
        public class Red extends FlxSprite{
                [Embed(source = "img/Red.png")] public static var jugadorSpriteSheet:Class;
				[Embed(source = "img/Red2.png")] public static var jugadorSpriteSheet2:Class;
				
                
                public function Red(x:int, y:int, size:int, velx:int, vely:int, type:int){
                        super(x,y);
						if(type == 1){
                        	loadGraphic(jugadorSpriteSheet, true, true, size, size, true);
						}
						else if(type == 2){
							loadGraphic(jugadorSpriteSheet2, true, true, size, size, true);
						}
                        velocity.x = velx;
                        velocity.y = vely;
                        frame=43;
                        
                }
        }
}
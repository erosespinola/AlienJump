package com.powerflasher.SampleApp {

	import org.flixel.*;
	
	public class Creditos extends FlxState{
		
		private var texto:FlxText;
		
		public function Creditos(){
			super();
        }
		
		override public function create():void{	

			texto=new FlxText(0, 10, FlxG.width, "Credits").setFormat(null, 30, 0xFFFFFF, "center");
		    add(texto);
			
			FlxG.mouse.show();

			texto=new FlxText(0, 110, FlxG.width, "Programmers & Level Designers\nEros Espínola González\nAntonio Hernández Campos\nAmiel Johansson Zuñiga Sojo").setFormat(null, 21, 0xFFFFFF, "center");
		    add(texto);
			
			texto=new FlxText(0, 280, FlxG.width, "Game Art\nTiles by Ari Feldman\nCharacters by opengameart.org").setFormat(null, 21, 0xFFFFFF, "center");
		    add(texto);
			
			texto=new FlxText(0, 450, FlxG.width, "Music\nMusic by opengameart.org\nSound effects by opengameart.org").setFormat(null, 21, 0xFFFFFF, "center");
		    add(texto);		
			
			var boton:FlxButton =  new FlxButton(280, 700, "Main Menu", Menu);
			add(boton);
		}
		
		override public function update():void{
			super.update();
			
			if(FlxG.keys.pressed("ESCAPE")){
                 FlxG.switchState(new Inicio());
            }
		}
		
		public function Menu():void{
			FlxG.switchState(new Inicio());
		}
		
	}
}
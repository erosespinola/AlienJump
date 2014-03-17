package com.powerflasher.SampleApp {
	/**
	 * @author Amiel Zuñiga
	 */
	import org.flixel.*;
	
	public class Inicio extends FlxState{
		private var texto:FlxText;
		
		public function Inicio(){
        	super();
        }
		
		override public function create():void{	
 			texto=new FlxText(0, 250, FlxG.width, "Alien Jump!").setFormat(null, 30, 0xFFFFFF, "center");
		    var botonNivel1:FlxButton =  new FlxButton(FlxG.width / 2 - 40, FlxG.height / 2 - 960, "Nivel 1-1", IniciarNivel1);
			var botonNivel1_2:FlxButton =  new FlxButton(FlxG.width / 2 - 40, FlxG.height / 2 - 960 + 20, "Nivel 1-2", IniciarNivel1_2);
			var botonNivel2_1:FlxButton =  new FlxButton(FlxG.width / 2 - 40, FlxG.height / 2 - 960 + 40, "Nivel 2-1", IniciarNivel2_1);
			var botonNivel2_2:FlxButton =  new FlxButton(FlxG.width / 2 - 40, FlxG.height / 2 - 960 + 60, "Nivel 2-2", IniciarNivel2_2);
			var botonNivel3_1:FlxButton =  new FlxButton(FlxG.width / 2 - 40, FlxG.height / 2 - 960 + 80, "Nivel 3-1", IniciarNivel3_1);
			var botonNivel3_2:FlxButton =  new FlxButton(FlxG.width / 2 - 40, FlxG.height / 2 - 960 + 100, "Nivel 3-2", IniciarNivel3_2);
			var botonNivel4_1:FlxButton =  new FlxButton(FlxG.width / 2 - 40, FlxG.height / 2 - 960 + 120, "Nivel 4-1", IniciarNivel4_1);
			var botonNivel4_2:FlxButton =  new FlxButton(FlxG.width / 2 - 40, FlxG.height / 2 - 960 + 140, "Nivel 4-2", IniciarNivel4_2);
			var botonNivel5_1:FlxButton =  new FlxButton(FlxG.width / 2 - 40, FlxG.height / 2 - 960 + 160, "Nivel 5-1", IniciarNivel5_1);
			var botonNivel5_2:FlxButton =  new FlxButton(FlxG.width / 2 - 40, FlxG.height / 2 - 960 + 180, "Nivel 5-2", IniciarNivel5_2);
			
			var botonTeclas:FlxButton =  new FlxButton(FlxG.width / 2 - 40, FlxG.height / 2 - 960 + 280, "Buttons", Buttons);
			var botonCreditos:FlxButton =  new FlxButton(FlxG.width / 2 - 40, FlxG.height / 2 - 960 + 300, "Credits", Credits);
			
			FlxG.mouse.show();
			
			//FlxG.width / 2 - 40, FlxG.height / 2 - 260 + 20
			
           	add(texto);
			add(botonNivel1);
			add(botonNivel1_2);
			add(botonNivel2_1);
			add(botonNivel2_2);
			add(botonNivel3_1);
			add(botonNivel3_2);
			add(botonNivel4_1);
			add(botonNivel4_2);
			add(botonNivel5_1);
			add(botonNivel5_2);
			add(botonCreditos);
			add(botonTeclas);
		}
		
		override public function update():void{
			super.update();
   		}
		
		public function Credits():void{
			FlxG.switchState(new Creditos());
		}
		
		public function Buttons():void{
			FlxG.switchState(new Teclas());
		}
		
		public function IniciarNivel1():void{
			FlxG.switchState(new Nivel1());
		}
		
		public function IniciarNivel1_2():void{
			FlxG.switchState(new Nivel1_2());
		}
		
		public function IniciarNivel2_1():void{
			FlxG.switchState(new Nivel2_1());
		}
		
		public function IniciarNivel2_2():void{
			FlxG.switchState(new Nivel2_2());
		}

		public function IniciarNivel3_1():void{
			FlxG.switchState(new Nivel3_1());
		}
		
		public function IniciarNivel3_2():void{
			FlxG.switchState(new Nivel3_2());
		}
		
		public function IniciarNivel4_1():void{
			FlxG.switchState(new Nivel4_1());
		}
		
		public function IniciarNivel4_2():void{
			FlxG.switchState(new Nivel4_2());
		}
		
		public function IniciarNivel5_1():void{
			FlxG.switchState(new Nivel5_1());
		}
		
		public function IniciarNivel5_2():void{
			FlxG.switchState(new Animation_Level5());
		}
		
	}
}
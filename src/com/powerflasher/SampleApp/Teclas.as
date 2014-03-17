package com.powerflasher.SampleApp {

	import org.flixel.*;
	
	public class Teclas extends FlxState{
		
		[Embed(source = "img/up.png")] public static var up:Class;
		[Embed(source = "img/right.png")] public static var right:Class;
		[Embed(source = "img/left.png")] public static var left:Class;
		[Embed(source = "img/esc.png")] public static var esc:Class;
		[Embed(source = "img/p.png")] public static var p:Class;
		
		private var texto:FlxText;
		private var teclaUP:FlxSprite = new FlxSprite(10,100);
		private var teclaRIGHT:FlxSprite = new FlxSprite(10,200);
		private var teclaLEFT:FlxSprite = new FlxSprite(10,300);
		private var teclaP:FlxSprite = new FlxSprite(10,500);
		private var teclaESC:FlxSprite = new FlxSprite(10,600);
		
		private var teclaUP2:FlxSprite = new FlxSprite(10,400);
		private var teclaRIGHT2:FlxSprite = new FlxSprite(110,400);
		private var teclaLEFT2:FlxSprite = new FlxSprite(210,400);
		
		public function Teclas(){
			super();
        }
		
		override public function create():void{	
			FlxG.mouse.show();
			teclaUP.loadGraphic(up, true, true, 56, 53, true);
			add(teclaUP);
			teclaRIGHT.loadGraphic(right, true, true, 56, 53, true);
			add(teclaRIGHT);
			teclaLEFT.loadGraphic(left, true, true, 56, 53, true);
			add(teclaLEFT);
			teclaP.loadGraphic(p, true, true, 56, 53, true);
			add(teclaP);
			teclaESC.loadGraphic(esc, true, true, 56, 53, true);
			add(teclaESC);
			texto=new FlxText(0, 10, FlxG.width, "Buttons").setFormat(null, 30, 0xFFFFFF, "center");
		    add(texto);
			
			teclaUP2.loadGraphic(up, true, true, 56, 53, true);
			add(teclaUP2);
			teclaRIGHT2.loadGraphic(right, true, true, 56, 53, true);
			add(teclaRIGHT2);
			teclaLEFT2.loadGraphic(left, true, true, 56, 53, true);
			add(teclaLEFT2);
			
			texto=new FlxText(80, 110, FlxG.width, "Jump").setFormat(null, 21, 0xFFFFFF, "left");
		    add(texto);
			
			texto=new FlxText(80, 210, FlxG.width, "Right").setFormat(null, 21, 0xFFFFFF, "left");
		    add(texto);
			
			texto=new FlxText(80, 310, FlxG.width, "Left").setFormat(null, 21, 0xFFFFFF, "left");
		    add(texto);
			
			texto=new FlxText(10, 410, FlxG.width, "         +          or          Climb Walls").setFormat(null, 21, 0xFFFFFF, "left");
		    add(texto);
			
			texto=new FlxText(80, 510, FlxG.width, "Pause").setFormat(null, 21, 0xFFFFFF, "left");
		    add(texto);
			
			texto=new FlxText(80, 610, FlxG.width, "Main Menu").setFormat(null, 21, 0xFFFFFF, "left");
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
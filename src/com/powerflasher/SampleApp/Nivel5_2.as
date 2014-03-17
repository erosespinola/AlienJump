package com.powerflasher.SampleApp {
	import org.flixel.*;
	/**
	 * @author Amiel Zuniga
	 */
	public class Nivel5_2 extends FlxState{
		[Embed(source = "img/14.png")] public static var bricks:Class;
		
		[Embed(source = "map5_2_1.csv", mimeType = "application/octet-stream")] public static var mapa:Class;
		
		[Embed(source="musica/song 1.mp3")] public var Music:Class;
		[Embed(source="musica/jump.mp3")] public var Jump:Class;
		[Embed(source="musica/hurt.mp3")] public var Hurt:Class;
		[Embed(source="musica/TNT.mp3")] public var tnt:Class;
		
		private var sky:Sky;
		private var jugador:Jugador;
		private var enemy:Enemigo;
		private var map:FlxTilemap;
		private var red:Red;
		private var redes:FlxGroup;
		private var paused:Boolean;
		private var texto:FlxText;
		private var t : Number = 0;
		private var t2:Number = 0;
		private var t3:Number = 0;
		private var hmax:Boolean = true;
		
		private var vida:Vida;
		private var h1:Heart;
		private var h2:Heart;
		private var h3:Heart;
		private var vidas:FlxGroup;		
		
		private var tnt1:TNT;
		private var tnt2:TNT;
		private var tnt3:TNT;
		private var tnt4:TNT;
		private var tnt5:TNT;
		
		private var b1:Bala;
		private var b2:Bala;
		private var balas:FlxGroup;
		
		private var c1:Cientifico;
		private var c2:Cientifico;
		
		public function Nivel5_2(){
        	super();	
        }
		
		public function loser():void{
			FlxG.resetState();
		}
		
		public function winner():void{
			FlxG.switchState(new Fin());
		}
		
		override public function create():void{
            jugador = new Jugador(450,693);
			enemy = new Enemigo(100,698);
			
			c1=new Cientifico(20, 702, 1);
			c2=new Cientifico(500, 702, 2);
			
			b1 = new Bala(-15, -15, 10, 0, 0);
			b2 = new Bala(-15, -15, 10, 0, 0);
				
			balas = new FlxGroup();
			balas.add(b1);
			balas.add(b2);	
			
			FlxG.mouse.show();
				
			vidas = new FlxGroup();
			vida = new Vida(5,5);
			h1 = new Heart(40, 5);
			h2 = new Heart(65, 5);
			h3 = new Heart(90, 5);
			
			vidas.add(h3);
			vidas.add(h2);
			vidas.add(h1);
				
			red = new Red(-20,-20,0,0,0,0);
			redes = new FlxGroup();
			redes.add(red);
			
			tnt1 = new TNT(60, 380);
			tnt2 = new TNT(215, 450);
			tnt3 = new TNT(385, 420);
			tnt4 = new TNT(215, 170);
			tnt5 = new TNT(215, 60);
						
			map=new FlxTilemap();
			map.loadMap(new mapa(), bricks, 32, 32);
			
			map.setTileProperties(1, FlxObject.UP);
			
			map.setTileProperties(3, FlxObject.UP);
			map.setTileProperties(4, FlxObject.UP);
			map.setTileProperties(5, FlxObject.UP);
			map.setTileProperties(6, FlxObject.UP);
			map.setTileProperties(7, FlxObject.UP);
			
			FlxG.play(Music, 0.8, true);
			
			sky=new Sky(-320, -1000);
			
			paused = false;
			texto=new FlxText(0, 340, FlxG.width, "PAUSED GAME").setFormat(null, 65, 0xFFFFFF, "center");
			texto.kill();
			sky.scrollFactor.y=0.4;
			
			add(sky);
			add(map);
			add(redes);
			add(jugador);
			add(enemy);
			add(tnt1);
			add(tnt2);
			add(tnt3);
			add(tnt4);
			add(tnt5);
			add(c1);
			add(c2);
			add(vida);
			add(vidas);
			add(texto);
			tnt1.acceleration.y=1000;
		}
		
		
		public function fire_red(x:int, y:int, size:int, velx:int, vely:int):Red{
			var red:Red = new Red(x,y,size,velx,vely, 2);
			return red;
		}
		
		
		public function movimientoH():void{
			if(hmax && enemy.x<526){
				enemy.x+=1.5;
				enemy.play("derecha");
			}
			if(hmax && enemy.x>=526){
				hmax=false;
			}
			else if(!hmax &&enemy.x>0){
				enemy.x-=1.5;
				enemy.play("izquierda");
			}
			if(!hmax && enemy.x<=0){
				hmax=true;
			}
		}
		
		
		override public function update():void{
			if(FlxG.keys.justPressed("P"))
				paused = !paused;
			if(!paused)
				texto.kill();
			if(paused){
				texto.y=jugador.y-340;
				texto.revive();
				return;
			}
			
			t2+=FlxG.elapsed;
			if(t2 < 2.02 && t2 > 1){
				enemy.play("casco");
			}else if(t2>1.5){
				movimientoH();
			}
			
			
			
			super.update();
			
			if(FlxG.keys.pressed("RIGHT")&&jugador.x<590){
				jugador.x = jugador.x+2;
				jugador.play("derecha");
				
			}
			if(FlxG.keys.pressed("LEFT")&&jugador.x>0){
				jugador.x = jugador.x-2;
				jugador.play("izquierda");
				
			}
			if(FlxG.keys.justPressed("UP") && (FlxG.collide(jugador,map))){
				jugador.velocity.y = -380;
				jugador.y -= 30;
				jugador.play("arriba");	
				FlxG.play(Jump, .4, false);
			}
			
			if(FlxG.keys.justPressed("UP") && FlxG.overlap(jugador, tnt1)){
				jugador.velocity.y = -380;
				jugador.y -= 30;
				jugador.play("arriba");	
				FlxG.play(Jump, .4, false);
			}
			if(FlxG.keys.justPressed("UP") && FlxG.overlap(jugador, tnt2)){
				jugador.velocity.y = -380;
				jugador.y -= 30;
				jugador.play("arriba");	
				FlxG.play(Jump, .4, false);
			}
			if(FlxG.keys.justPressed("UP") && FlxG.overlap(jugador, tnt3)){
				jugador.velocity.y = -380;
				jugador.y -= 30;
				jugador.play("arriba");	
				FlxG.play(Jump, .4, false);
			}
			if(FlxG.keys.justPressed("UP") && FlxG.overlap(jugador, tnt4)){
				jugador.velocity.y = -380;
				jugador.y -= 30;
				jugador.play("arriba");	
				FlxG.play(Jump, .4, false);
			}
			if(FlxG.keys.justPressed("UP") && FlxG.overlap(jugador, tnt5)){
				jugador.velocity.y = -380;
				jugador.y -= 30;
				jugador.play("arriba");	
				FlxG.play(Jump, .4, false);
			}
			
			
			t3 += FlxG.elapsed;
			 
			if(t3>=4){
				b1 = c1.fire(c1.x+45, c1.y+30, 10, (jugador.x-c1.x), (jugador.y-c1.y));
				c1.play("dispara");
				b2 = c2.fire(c2.x-45, c2.y+30, 10, (jugador.x-c2.x), (jugador.y-c2.y));
				c2.play("dispara");
				balas.add(b1);
				balas.add(b2);
				add(b1);
				add(b2);
				t3=0;
			}
			
			t += FlxG.elapsed;
			if (t >= 2) {
				red = fire_red(enemy.x+10, enemy.y-30, 30, (jugador.x - enemy.x -20)/2, (jugador.y - enemy.y -20)/2);
				add(red);
				redes.add(red);
				t = 0;
			}
			
			if (FlxG.overlap(jugador, redes)) {
				vidas.getFirstAlive().kill();
				jugador.vida -=1;
				redes.kill();
				balas.kill();
				FlxG.play(Hurt, 1, false);
				if(jugador.vida==0){
					jugador.kill();
					FlxG.fade(0x000000,1,loser);
				}
			}
			
			if (FlxG.overlap(jugador, balas)) {
				vidas.getFirstAlive().kill();
				jugador.vida -=1;
				balas.kill();
				redes.kill();
				FlxG.play(Hurt, 1, false);
				if(jugador.vida==0){
					jugador.kill();
					FlxG.fade(0x000000,1,loser);
				}
			}
			
			if(FlxG.keys.pressed("ESCAPE")){
                 FlxG.switchState(new Inicio());
            }
			
			if(FlxG.overlap(tnt1, enemy)){
				tnt1.reset(-20, -20);
				tnt1.kill();
				enemy.vida -=1;
				FlxG.play(tnt, 1, false);
				if(enemy.vida==0){
					FlxG.fade(0xFFFFFF,0.5, winner);
				}
			}
			if(FlxG.overlap(tnt2, enemy)){
				tnt2.reset(-20, -20);
				tnt2.kill();
				enemy.vida -=1;
				FlxG.play(tnt, 1, false);
				if(enemy.vida==0){
					FlxG.fade(0xFFFFFF,0.5, winner);
				}
			}
			if(FlxG.overlap(tnt3, enemy)){
				tnt3.reset(-20, -20);
				tnt3.kill();
				enemy.vida -=1;
				if(enemy.vida==0){
					FlxG.play(tnt, 1, false);
					FlxG.fade(0xFFFFFF,0.5, winner);
				}
			}
			if(FlxG.overlap(tnt4, enemy)){
				tnt4.reset(-20, -20);
				tnt4.kill();
				enemy.vida -=1;
				FlxG.play(tnt, 1, false);
				if(enemy.vida==0){
					FlxG.fade(0xFFFFFF,0.5, winner);
				}
			}
			if(FlxG.overlap(tnt5, enemy)){
				tnt5.reset(-20, -20);
				tnt5.kill();
				enemy.vida -=1;
				FlxG.play(tnt, 1, false);
				if(enemy.vida==0){
					FlxG.fade(0xFFFFFF,0.5, winner);
				}
			}

			jugador.acceleration.y=1000;
			FlxG.collide(jugador,map);
			FlxG.collide(enemy,map);
			tnt1.acceleration.y=1000;
			FlxG.collide(tnt1,map);
			FlxG.collide(tnt1,jugador);
			tnt2.acceleration.y=1000;
			FlxG.collide(tnt2,map);
			FlxG.collide(tnt2,jugador);
			tnt3.acceleration.y=1000;
			FlxG.collide(tnt3,map);
			FlxG.collide(tnt3,jugador);
			tnt4.acceleration.y=1000;
			FlxG.collide(tnt4,map);
			FlxG.collide(tnt4,jugador);
			tnt5.acceleration.y=1000;
			FlxG.collide(tnt5,map);
			FlxG.collide(tnt5,jugador);
		}
	}
}
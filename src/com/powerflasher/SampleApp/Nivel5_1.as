package com.powerflasher.SampleApp {
	import org.flixel.*;

	public class Nivel5_1 extends FlxState{
		[Embed(source = "img/14.png")] public static var bricks:Class;
		[Embed(source = "map5_1_1.csv", mimeType = "application/octet-stream")] public static var mapa:Class;
		[Embed(source = "map5_1_2.csv", mimeType = "application/octet-stream")] public static var mapaPared:Class;

		[Embed(source="musica/song 1.mp3")] public var Music:Class;
		[Embed(source="musica/jump.mp3")] public var Jump:Class;
		[Embed(source="musica/hurt.mp3")] public var Hurt:Class;

		private var jugador:Jugador;
		private var fake:Jugador;
		private var map:FlxTilemap;
		private var mapWalls:FlxTilemap;
		private var helicoptero:Helicoptero;
		private var yhel:int = 2;
		private var t:Number = 0;
		private var t2:Number = 0;
		private var t3:Number = 1;
		private var t4:Number = 0;
		private var misil1:Bala;
		private var balas:FlxGroup;
		private var tanque:Tanque;
		private var bala1:Bala;
		private var bala2:Bala;
		private var bala3:Bala;
		private var plataforma:Plataforma;
		private var plataforma1:Plataforma;
		private var c1:Cientifico;
		private var c2:Cientifico;
		private var jet1:Jet;
		private var jet2:Jet;
		private var misil2:Misil;
		private var misil3:Misil;
		private var pico1:Pico;
		private var pico2:Pico;
		private var paused:Boolean = false;
		private var texto:FlxText;
		private var sky:Sky;
		private var item:Item;
		private var vida:Vida;
				private var h1:Heart;
				private var h2:Heart;
				private var h3:Heart;
				private var vidas:FlxGroup;	
		
		public function Nivel5_1(){
        	super();	
        }
		
		public function winner():void{
			FlxG.switchState(new Animation_Level5());
		}
		public function loser():void{
			FlxG.resetState();
		}
		
		override public function create():void{
            jugador = new Jugador(340,2445);
				
			fake = new Jugador(295,2460);	
			
			vidas = new FlxGroup();
			vida = new Vida(5,605);
			h1 = new Heart(40, 605);
			h2 = new Heart(65, 605);
			h3 = new Heart(90, 605);
			
			FlxG.mouse.show();
			
			vidas.add(h3);
			vidas.add(h2);
			vidas.add(h1);
			
			FlxG.play(Music, 0.8, true);
			
			plataforma = new Plataforma(300, 1696, 1);
			plataforma1 = new Plataforma(300, 1300, 1);	
			map=new FlxTilemap();
			balas = new FlxGroup();
			helicoptero = new Helicoptero(480, 2070, 1);
			helicoptero.play("volar");
			mapWalls=new FlxTilemap();
			map.loadMap(new mapa(), bricks, 32, 32);
			mapWalls.loadMap(new mapaPared(), bricks, 32, 32);
			misil1 = new Bala(0,0,0,0,0);
			misil2 = new Misil(-100, 700, 2);
			misil2.velocity.x = 1000;
			misil3 = new Misil(-100, 900, 2);
			misil3.velocity.x = 1000;
			tanque = new Tanque(280, 1890, 1);
			jet1 = new Jet(300, 1000, 1, 2);
			jet1.velocity.x = 1000;
			jet2 = new Jet(300, 500, 1, 2);
			jet2.velocity.x = 1000;
			pico1 = new Pico(290, 190, 2);
			pico2 = new Pico(290, 290, 2);
			item= new Item(240, 0);
			sky = new Sky(-320, -1000);
			
			map.setTileProperties(1, FlxObject.UP);
			map.setTileProperties(2, FlxObject.UP);
			map.setTileProperties(3, FlxObject.UP);
			map.setTileProperties(4, FlxObject.UP);
			map.setTileProperties(5, FlxObject.UP);
			map.setTileProperties(6, FlxObject.UP);
			map.setTileProperties(7, FlxObject.UP);
			
			bala1 = new Bala(-10,0,0,0,0); bala2 = new Bala(-10,0,0,0,0);
			bala3 = new Bala(-10,0,0,0,0);
			
			c1 = new Cientifico(8, 1472, 1);
			c2 = new Cientifico(8, 1344, 1);
			
			texto=new FlxText(0, 340, FlxG.width, "PAUSED GAME").setFormat(null, 65, 0xFFFFFF, "center");
            texto.kill();
			
			balas.add(misil1);
			
			add(sky);
			add(pico1);
			add(pico2);
			add(map);
			add(tanque);
			add(mapWalls);
			add(helicoptero);
			add(jugador);
			add(item);
			add(plataforma);
			add(plataforma1);
			add(c1);
			add(c2);
			add(jet1);
			add(jet2);
			add(misil2);
			add(misil3);
			add(vidas);
			add(vida);
			add(texto);
			
			FlxG.camera.follow(fake);
			FlxG.camera.y -= 595;
		}
		
		public function movimientoH(xo:int, xf:int, plataforma:Plataforma):void{
			if(plataforma.hmax && plataforma.x<xf){
				plataforma.x+=1.5;	
			}
			if(plataforma.hmax && plataforma.x>=xf){
				plataforma.hmax=false;
			}
			else if(!plataforma.hmax &&plataforma.x>xo){
				plataforma.x-=1.5;
			}
			if(!plataforma.hmax && plataforma.x<=xo){
				plataforma.hmax=true;
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
			super.update();
			jugador.acceleration.y = 1000;
			
			helicoptero.y += yhel;
	
			if(FlxG.keys.pressed("RIGHT")&& jugador.x<590){
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
			if(FlxG.keys.justPressed("UP") && (FlxG.collide(jugador,mapWalls))){
				jugador.velocity.y = -380;
				jugador.y -= 30;
				jugador.play("arriba");	
				FlxG.play(Jump, .4, false);
			}
			if(FlxG.keys.justPressed("UP") && (jugador.overlaps(plataforma) || jugador.overlaps(plataforma1))){
				jugador.velocity.y = -380;
				jugador.y -= 30;
				jugador.play("arriba");	
				FlxG.play(Jump, .4, false);
			}

			t+=FlxG.elapsed;
			t2+=FlxG.elapsed;
			if(t>=1){
				if(jugador.y <  2460 && jugador.y>2170){
					misil1 = helicoptero.fire(500,2215, 10,-300,300);
					add(misil1);
				}
				if(jugador.y<=2075 && jugador.y>1590){
					bala1 = tanque.fire(tanque.x+100,tanque.y,10,(jugador.x - tanque.x),(jugador.y-tanque.y));
				
					add(bala1);
					balas.add(bala1);
				}
				if(jugador.y<=1535 && jugador.y>1242 && jugador.x < 500){
					bala2 = c1.fire(c1.x, c1.y, 10, (jugador.x - c1.x),(jugador.y-c1.y));
					bala3 = c2.fire(c2.x, c2.y, 10, (jugador.x - c2.x),(jugador.y-c2.y));
					c1.play("dispara");
					c2.play("dispara");
					add(bala2);
					add(bala3);
					balas.add(bala2);
					balas.add(bala3);
				}
				t=0;
				
			}
			
			if(t2 > 2.0){
				jet1.x = -600;
				jet2.x = -100;
				misil2.x = -400;
				misil3.x = -200;
				t2 = 0;
			}
			
			if(misil1.overlaps(map)){
				misil1.x = 0;
				misil1.y = 0;
				misil1.kill();
			}
			
			if(FlxG.overlap(jugador, item)){
				item.kill();
            	FlxG.fade(0xFFFFFF, 1, winner);
            }
			
			if(FlxG.overlap(jugador, jet1)){
				vidas.getFirstAlive().kill();
				jugador.vida -=1;
				FlxG.play(Hurt, 1, false);
				if(jugador.vida==0){
					jugador.kill();
					FlxG.fade(0x000000,1,loser);
				}
			}
			
			if(FlxG.overlap(jugador, jet2)){
				vidas.getFirstAlive().kill();
				jugador.vida -=1;
				FlxG.play(Hurt, 1, false);
				if(jugador.vida==0){
					jugador.kill();
					FlxG.fade(0x000000,1,loser);
				}
			}
			
			if(FlxG.overlap(jugador, misil1)){
				misil1.kill();
				vidas.getFirstAlive().kill();
				jugador.vida -=1;
				FlxG.play(Hurt, 1, false);
				if(jugador.vida==0){
					jugador.kill();
					FlxG.fade(0x000000,1,loser);
				}
			}
			
			if(FlxG.overlap(jugador, misil2)){
				misil2.kill();
				vidas.getFirstAlive().kill();
				jugador.vida -=1;
				FlxG.play(Hurt, 1, false);
				if(jugador.vida==0){
					jugador.kill();
					FlxG.fade(0x000000,1,loser);
				}
			}
			
			if(FlxG.overlap(jugador, misil3)){
				misil3.kill();
				vidas.getFirstAlive().kill();
				jugador.vida -=1;
				FlxG.play(Hurt, 1, false);
				if(jugador.vida==0){
					jugador.kill();
					FlxG.fade(0x000000,1,loser);
				}
			}
			
			if(FlxG.overlap(jugador, balas)){
				balas.kill();
				vidas.getFirstAlive().kill();
				jugador.vida -=1;
				FlxG.play(Hurt, 1, false);
				if(jugador.vida==0){
					jugador.kill();
					FlxG.fade(0x000000,1,loser);
				}
			}
			
			if(FlxG.overlap(jugador, pico1) || FlxG.overlap(jugador, pico2)){
				vidas.getFirstAlive().kill();
				jugador.vida -=1;
				FlxG.play(Hurt, 1, false);
				if(jugador.vida==0){
					jugador.kill();
					FlxG.fade(0x000000,1,loser);
				}
			}
			
			if(jugador.overlaps(plataforma)){
				jugador.acceleration.y = 0;
				jugador.y = plataforma.y - 70;
				if(plataforma.hmax && plataforma.x<390){
					jugador.x+=1.5;	
				}
				if(!plataforma.hmax &&plataforma.x>90){
					jugador.x-=1.5;
				}
			}
			if(jugador.overlaps(plataforma1) && jugador.y < 1240){
				jugador.acceleration.y = 0;
				jugador.y = plataforma1.y - 70;
				if(plataforma1.hmax && plataforma1.x<450){
					jugador.x+=1.5;	
				}
				if(!plataforma1.hmax &&plataforma1.x>90){
					jugador.x-=1.5;
				}
			}
			
			t3+=FlxG.elapsed;
			if(t3>2.0){
				pico1.x=288;
				pico2.x=288;
				t3=0;
			}

			
			t4+=FlxG.elapsed;
			if(t4>2.0){
				pico1.x=320;
				pico2.x=320;
				t4=0;
			}
			
			if(FlxG.keys.pressed("ESCAPE")){
                 FlxG.switchState(new Inicio());
            }
			movimientoH(90, 390, plataforma);
			movimientoH(90, 450, plataforma1);
			FlxG.collide(jugador,map);
			FlxG.collide(jugador,mapWalls);	
			fake.y = jugador.y+80;
			yhel *= -1;
		}
	}
}
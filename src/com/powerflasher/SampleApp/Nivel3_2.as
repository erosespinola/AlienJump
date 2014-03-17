package com.powerflasher.SampleApp {
	import org.flixel.*;
	
	public class Nivel3_2 extends FlxState{
		[Embed(source = "img/13.png")] public static var bricks:Class;
		[Embed(source = "map3_2_1.csv", mimeType = "application/octet-stream")] public static var mapa:Class;
		[Embed(source = "map3_2_2.csv", mimeType = "application/octet-stream")] public static var mapaParedes:Class;
		[Embed(source="musica/song 3.mp3")] public var Music:Class;
		[Embed(source="musica/jump.mp3")] public var Jump:Class;
		[Embed(source="musica/hurt.mp3")] public var Hurt:Class;
		[Embed(source="musica/TNT.mp3")] public var tnt:Class;
		
		private var plataforma1:Plataforma;
		private var plataforma2:Plataforma;
		private var jugador:Jugador;
		private var fake:Jugador;
		private var jet:Jet;
		private var map:FlxTilemap;
		private var mapWall:FlxTilemap;
		private var t:Number = 0;
		private var caja1:TNT;
		private var caja2:TNT;
		private var caja3:TNT;
		private var direccion:Boolean = true;
		private var direccionV:Boolean = true;
		private var altura:Number = 0;
		private var paused:Boolean = false;
		private var texto:FlxText;
		private var sky:Sky;
		private var vida:Vida;
				private var h1:Heart;
				private var h2:Heart;
				private var h3:Heart;
				private var vidas:FlxGroup;
		
		public function Nivel3_2(){
        	super();
			
        }
		
		public function winner():void{
			FlxG.switchState(new Animation_Level3());
		}
		public function loser():void{
			FlxG.resetState();
		}
		
		override public function create():void{
			
            jugador = new Jugador(295,1295);
		    fake = new Jugador(295,1300);
			jet = new Jet(900, 1000, 3, 1);
			caja1 = new TNT(350, 928);
			caja2 = new TNT(350, 512);
			caja3 = new TNT(350, 256);
			caja1.acceleration.y = 1000;
			caja2.acceleration.y = 1000;
			caja3.acceleration.y = 1000;
			plataforma1 = new Plataforma(300, 800,1);
			plataforma1.acceleration.y = 0;
			plataforma2 = new Plataforma(150, 700,1);
			plataforma2.acceleration.y = 0;
			
			FlxG.mouse.show();
			
			vidas = new FlxGroup();
						vida = new Vida(5,605);
						h1 = new Heart(40,605);
						h2 = new Heart(65,605);
						h3 = new Heart(90,605);
						
						vidas.add(h3);
						vidas.add(h2);
						vidas.add(h1);
			
			plataforma1.allowCollisions = FlxObject.UP;
			plataforma2.allowCollisions = FlxObject.UP;
			sky=new Sky(-320, -1000);
			map=new FlxTilemap();
			map.loadMap(new mapa(), bricks, 32, 32);
		
			map.setTileProperties(6, FlxObject.UP);
			map.setTileProperties(7, FlxObject.UP);
			map.setTileProperties(8, FlxObject.UP);
			map.setTileProperties(9, FlxObject.UP);
			map.setTileProperties(11, FlxObject.UP);
			map.setTileProperties(12, FlxObject.UP);
			map.setTileProperties(14, FlxObject.UP);
			
			mapWall=new FlxTilemap();
			mapWall.loadMap(new mapaParedes(), bricks,32,32);
			texto=new FlxText(0, 340, FlxG.width, "PAUSED GAME").setFormat(null, 65, 0xFFFFFF, "center");
            texto.kill();

			sky.scrollFactor.y=0.4;
			
			FlxG.play(Music, 0.4, true);
			
			add(sky);
			add(map);
			add(mapWall);
			add(jugador);
			add(jet);
			add(caja1);
			add(caja2);
			add(caja3);
			add(plataforma1);
			add(plataforma2);
			add(vida);
			add(vidas);
			add(texto);
			
			FlxG.camera.y -= 600;
			
			FlxG.camera.follow(fake);
		}
		
		public function movimientoH():void{
			if(direccion && plataforma1.x<400){
				plataforma1.x+=1.5;
			}
			if(direccion && plataforma1.x>=400){
				direccion=false;
			}
			else if(!direccion &&plataforma1.x>100){
				plataforma1.x-=1.5;
			}
			if(!direccion && plataforma1.x<=100){
				direccion=true;
			}
		}
		
		public function movimientoV():void{
			if(direccionV && plataforma2.y<700){
				plataforma2.y+=1.5;	
			}
			if(direccionV && plataforma2.y>=700){
				direccionV=false;
			}
			if(!direccionV && plataforma2.y>500){
				plataforma2.y-=1.5;
			}
			if(!direccionV && plataforma2.y<=500){
				direccionV=true;
			}
		}
		
		public function movimientoJet():void{
			jet.velocity.x = -500;
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
			if(FlxG.keys.pressed("RIGHT")&&jugador.x<590){
				jugador.x = jugador.x+2;
				jugador.play("derecha");
			}
			if(FlxG.keys.pressed("LEFT")&&jugador.x>0){
				jugador.x = jugador.x-2;
				jugador.play("izquierda");
			}
			if(FlxG.keys.justPressed("UP") && (FlxG.collide(jugador,map) || FlxG.collide(jugador,plataforma1) || FlxG.collide(jugador,plataforma2) || FlxG.collide(jugador, mapWall))){
				jugador.velocity.y = -380;
				jugador.y -= 30;
				jugador.play("arriba");	
				FlxG.play(Jump, 0.4, false);
			}
			
			if(caja1.overlaps(jet)){
				jet.reduceLife();
				caja1.setPosicion(0,0);
				caja1.kill();
				FlxG.play(tnt, 1, false);
				if(jet.getVida()==0){
					jet.kill();
					FlxG.fade(0xFFFFFF,1,winner);
				}
				
			}
			if(caja2.overlaps(jet)){
				jet.reduceLife();
				caja2.setPosicion(0,0);
				caja2.kill();
				FlxG.play(tnt, 1, false);
				if(jet.getVida()==0){
					jet.kill();
					FlxG.fade(0xFFFFFF,1,winner);
				}
			}
			if(caja3.overlaps(jet)){
				jet.reduceLife();
				caja3.setPosicion(0,0);
				FlxG.play(tnt, 1, false);
				caja3.kill();
				if(jet.getVida()==0){
					jet.kill();
					FlxG.fade(0xFFFFFF,1,winner);
				}
			}
			if(FlxG.overlap(jugador,jet)){
				vidas.getFirstAlive().kill();
				jugador.vida -=1;
				FlxG.play(Hurt, 1, false);
				if(jugador.vida==0){
					jugador.kill();
					FlxG.fade(0x000000,1,loser);
				}
			}
			
			if(FlxG.collide(jugador,plataforma1)){
				jugador.velocity.y = 0;
				jugador.acceleration.y = 0;
				plataforma1.velocity.y = 0;
				plataforma1.acceleration.y=0;
				if(direccion && plataforma1.x<400){
					jugador.x+=1.5;
				}
				if(!direccion &&plataforma1.x>100){
					jugador.x-=1.5;
				}
				plataforma1.y=800;
				
			}
			plataforma1.y=800;
			
			if(FlxG.collide(jugador,plataforma2)){
				jugador.velocity.y = 0;
				jugador.acceleration.y = 0;
				plataforma2.velocity.y = 0;
				plataforma2.acceleration.y=0;
				if(direccionV && plataforma2.y<700){
					jugador.y+=1.5;	
				}
				if(!direccionV && plataforma2.y>500){
					jugador.y-=1.5;
				}
				
			}
			
			t+=FlxG.elapsed;
			
			if(t>=6.0){
				jet.x = 900;
				jet.y = 1000;
				if(altura == 1)
					jet.y = 350;
				if(altura == 2)
					jet.y = 650;
				t=0;
			}
			
			//==========
			//Altura del jet
			if(jugador.y < 350){
				altura = 1;
			}
			else if(jugador.y < 750){
				altura = 2;	
			}
			//==========
			//Cajas regresan a su lugar si no tocan al jefe
			if(FlxG.collide(caja1, map) && caja1.y != 928){
				caja1.setPosicion(340, 928);
				if(FlxG.collide(jugador, caja1)){
					caja1.setPosicion(260, 928);
				}
			}
			if(FlxG.collide(caja2, map) && caja2.y != 512){
				caja2.setPosicion(350, 512);
				if(FlxG.collide(jugador, caja2)){
					caja2.setPosicion(440, 512);
				}
			}
			if(FlxG.collide(caja3, map) && caja3.y != 256){
				caja3.setPosicion(350, 256);
				if(FlxG.collide(jugador, caja3)){
					caja3.setPosicion(440, 256);
				}
			}
			
			movimientoH();
			movimientoV();
			movimientoJet();
			FlxG.collide(jugador,map);	
			FlxG.collide(jugador,mapWall);	
			FlxG.collide(caja1,jugador);	
			FlxG.collide(caja2,jugador);	
			FlxG.collide(caja3,jugador);	
			FlxG.collide(caja1,map);
			FlxG.collide(caja2,map);
			FlxG.collide(caja3,map);
			
			FlxG.collide(jugador,plataforma1);
			FlxG.collide(jugador, plataforma2);
		
			jugador.acceleration.y = 1000;
			fake.y = jugador.y+100;
			if(FlxG.keys.pressed("ESCAPE")){
                 FlxG.switchState(new Inicio());
            }
			
		}
		
		
	}
}

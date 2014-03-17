package com.powerflasher.SampleApp {
	import org.flixel.*;
	/**
	 * @author Amiel Zuniga
	 */
	public class Nivel4_1 extends FlxState{
		[Embed(source = "img/13.png")] public static var bricks:Class;
		[Embed(source = "map4_1_1.csv", mimeType = "application/octet-stream")] public static var mapa:Class;
		[Embed(source = "map4_1_2.csv", mimeType = "application/octet-stream")] public static var mapaElastico:Class;
		[Embed(source = "map4_1_3.csv", mimeType = "application/octet-stream")] public static var mapaElasticoPro:Class;
		[Embed(source="musica/song 1.mp3")] public var Music:Class;
		[Embed(source="musica/jump.mp3")] public var Jump:Class;
		[Embed(source="musica/hurt.mp3")] public var Hurt:Class;
		
		private var jugador:Jugador;
		private var fake:Jugador;
		private var cientifico1:Cientifico;
		private var cientifico2:Cientifico;
		private var cientifico3:Cientifico;
		private var cientifico4:Cientifico;
		private var cientifico5:Cientifico;
		private var misil1:Misil;
		private var misil2:Misil;
		private var misil3:Misil;
		private var box1:TNT;
		private var t:Number = 0;
		private var t2:Number = 0;
		private var map:FlxTilemap;
		private var mapElasticPro:FlxTilemap;
		private var mapElastic:FlxTilemap;
		private var plataforma1:Plataforma;
		private var plataforma2:Plataforma;
		private var plataforma3:Plataforma;
		private var plataforma4:Plataforma;
		private var plataforma5:Plataforma;
		private var pico1:Pico;private var pico2:Pico;private var pico3:Pico;
		private var pico4:Pico;private var pico5:Pico;private var pico6:Pico; 
		private var bala1:Bala, bala2:Bala, bala3:Bala, bala4:Bala, bala5:Bala;
		private var balas:FlxGroup;
		private var texto:FlxText;
		private var paused:Boolean = false;
		private var sky:Sky;
		private var item:Item;
		private var vida:Vida;
				private var h1:Heart;
				private var h2:Heart;
				private var h3:Heart;
				private var vidas:FlxGroup;
		
		public function Nivel4_1(){
        	super();	
        }
		
		
		public function winner():void{
			FlxG.switchState(new Nivel4_2());
		}
		public function loser():void{
			FlxG.resetState();
		}
		
		override public function create():void{
            fake = new Jugador(295,2137);
			jugador = new Jugador(340,2132);
			
			vidas = new FlxGroup();
			vida = new Vida(5,660);
			h1 = new Heart(40,660);
			h2 = new Heart(65,660);
			h3 = new Heart(90,660);
			
			FlxG.mouse.show();
			
			vidas.add(h3);
			vidas.add(h2);
			vidas.add(h1);
			
			balas = new FlxGroup();
			sky=new Sky(-320, -1000);
			pico1 = new Pico(545,1472,4);
			pico2 = new Pico(577,1472,4);
			pico3 = new Pico(290,1346,3);
			pico4 = new Pico(194,1346,3);
			pico5 = new Pico(98,1346,3);
			pico6 = new Pico(2,1346,3);
			bala1=bala2=bala3=bala4=bala5=new Bala(-10,-10,10,0,0); 
			
			plataforma1 = new Plataforma(160, 1850,1);
			plataforma2 = new Plataforma(410, 1400,1);
			plataforma3 = new Plataforma(60, 225,1);
			plataforma4 = new Plataforma(430, 608,1);
			plataforma5 = new Plataforma(70, 512,1);
			
			cientifico1 = new Cientifico(70,2143,1);
			cientifico2 = new Cientifico(17, 1632,1);
			cientifico3 = new Cientifico(17, 1504,1);
			cientifico4 = new Cientifico(6, 669,1);
			cientifico5 = new Cientifico(80, 159,1);
			
			box1 = new TNT(50,2020);
			
			misil1 = new Misil(1500, 900,1);
			misil1.velocity.x = -1000;
			misil2 = new Misil(1400, 1025,1);
			misil2.velocity.x = -1000;
			misil3 = new Misil(1300, 1150,1);
			misil3.velocity.x = -1000;
						
			map=new FlxTilemap();
			map.loadMap(new mapa(), bricks, 32, 32);
			
			map.setTileProperties(14, FlxObject.UP);
			map.setTileProperties(6, FlxObject.UP);
			map.setTileProperties(7, FlxObject.UP);
			map.setTileProperties(8, FlxObject.UP);
			map.setTileProperties(9, FlxObject.UP);
			map.setTileProperties(10, FlxObject.UP);
			map.setTileProperties(11, FlxObject.UP);
			
			mapElastic=new FlxTilemap();
			mapElastic.loadMap(new mapaElastico(), bricks,32,32);
			
			mapElastic.setTileProperties(6, FlxObject.UP);
			mapElastic.setTileProperties(7, FlxObject.UP);	
			mapElastic.setTileProperties(11, FlxObject.UP);
			
			mapElasticPro=new FlxTilemap();
			mapElasticPro.loadMap(new mapaElasticoPro(), bricks,32,32);
			
			mapElasticPro.setTileProperties(6, FlxObject.UP);
			mapElasticPro.setTileProperties(7, FlxObject.UP);
			mapElasticPro.setTileProperties(11, FlxObject.UP);			

			texto=new FlxText(0, 340, FlxG.width, "PAUSED GAME").setFormat(null, 65, 0xFFFFFF, "center");
            texto.kill();
			item = new Item(240, 0);

			sky.scrollFactor.y=0.4;
			
			FlxG.play(Music, 0.8, true);

			add(sky);
			add(map);
			add(mapElasticPro);
			add(mapElastic);
			
			add(jugador);
			add(item);
			add(box1);
			add(misil1);
			add(misil2);
			add(misil3);
			
			add(pico1);
			add(pico2);
			add(pico3);
			add(pico4);
			add(pico5);
			add(pico6);
			
			add(plataforma1);
			add(plataforma2);
			add(plataforma3);
			add(plataforma4);
			add(plataforma5);
			add(cientifico1);
			add(cientifico2);
			add(cientifico3);
			add(cientifico4);
			add(cientifico5);
			
			add(vida);
			add(vidas);
			
			add(texto);
			
			FlxG.camera.follow(fake);
			FlxG.camera.y -= 650;			
		}
	
		public function movimientoV(yo:int, yf:int, plataforma:Plataforma):void{
			if(plataforma.vmax && plataforma.y<yf){
				plataforma.y+=1.5;	
			}
			if(plataforma.vmax && plataforma.y>=yf){
				plataforma.vmax=false;
			}
			else if(!plataforma.vmax &&plataforma.y>yo){
				plataforma.y-=1.5;
			}
			if(!plataforma.vmax && plataforma.y<=yo){
				plataforma.vmax=true;
			}
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
	
			if(FlxG.keys.pressed("RIGHT")&&jugador.x<590){
				jugador.x = jugador.x+2;
				jugador.play("derecha");
				
			}
			if(FlxG.keys.pressed("LEFT")&&jugador.x>0){
				jugador.x = jugador.x-2;
				jugador.play("izquierda");
				
			}
			if(FlxG.keys.justPressed("UP") && (FlxG.collide(jugador,map) || FlxG.collide(jugador,box1))){
				jugador.velocity.y = -380;
				jugador.y -= 30;
				jugador.play("arriba");	
				FlxG.play(Jump, .4, false);
				
			}
			if(FlxG.keys.justPressed("UP") &&(
				(jugador.overlaps(plataforma1)&& (jugador.y<=1793)) || 
				(jugador.overlaps(plataforma2)&& (jugador.y<=plataforma2.y-57)) || 
				(jugador.overlaps(plataforma4)&& (jugador.y<=551)) || 
				(jugador.overlaps(plataforma5)&& (jugador.y<=455)))){
				jugador.velocity.y = -380;
				jugador.y -= 30;
				jugador.play("arriba");	
				FlxG.play(Jump, .4, false);
			}
			if((FlxG.collide(jugador,mapElasticPro))){
				jugador.velocity.y = -900;
				jugador.y -= 80;
				jugador.play("arriba");	
				FlxG.play(Jump, .4, false);
			}	
			if((FlxG.collide(jugador,mapElastic))){
				jugador.velocity.y = -500;
				jugador.y -= 80;
				jugador.play("arriba");	
				FlxG.play(Jump, .4, false);
			}	
			if(FlxG.overlap(jugador, pico1) || 
				FlxG.overlap(jugador, pico2) ||
				FlxG.overlap(jugador, pico3) ||
				FlxG.overlap(jugador, pico4) ||
				FlxG.overlap(jugador, pico5) ||
				FlxG.overlap(jugador, pico6)){
				vidas.getFirstAlive().kill();
				jugador.vida -=1;
				FlxG.play(Hurt, 1, false);
				if(jugador.vida==0){
					jugador.kill();
					FlxG.fade(0x000000,1,loser);
				}
			}
			jugador.acceleration.y = 1000;
			
			if(jugador.overlaps(plataforma1)&& (jugador.y<=1793)){
				jugador.acceleration.y = 0;
				jugador.y = plataforma1.y - 70;
				if(plataforma1.hmax && plataforma1.x<420){
					jugador.x+=1.5;	
				}
				if(!plataforma1.hmax &&plataforma1.x>160){
					jugador.x-=1.5;
				}
			}
			if(jugador.overlaps(plataforma4)&& (jugador.y<=551)){
				jugador.acceleration.y = 0;
				jugador.y = plataforma4.y - 70;
				if(plataforma4.hmax && plataforma4.x<430){
					jugador.x+=1.5;	
				}
				if(!plataforma4.hmax &&plataforma4.x>70){
					jugador.x-=1.5;
				}
			}
			if(jugador.overlaps(plataforma5) && (jugador.y<=455)){
				jugador.acceleration.y = 0;
				jugador.y = plataforma5.y - 70;
				if(plataforma5.hmax && plataforma5.x<430){
					jugador.x+=1.5;	
				}
				if(!plataforma5.hmax &&plataforma5.x>70){
					jugador.x-=1.5;
				}
			}

			if(jugador.overlaps(plataforma2)&& (jugador.y<=plataforma2.y-57)){
				jugador.acceleration.y = 0;
				jugador.y = plataforma2.y - 70;
			}
			cientifico5.x = plataforma3.x + 35;
			
			t+=FlxG.elapsed;
			if(t>2){
				misil1.x = 1500;
				misil2.x = 1400;
				misil3.x = 1300;
				t=0;
			}
			
			t2+=FlxG.elapsed;
			if(t2>2){		
				if(jugador.y > 2000){
					bala1=cientifico1.fire(cientifico1.x+40, cientifico1.y+20, 10, 500, 0);
					cientifico1.play("dispara");
					add(bala1);
					
				}
				if(jugador.y < 1980 && jugador.y > 1370){
					bala2=cientifico2.fire(cientifico2.x+45, cientifico2.y+30, 10, (jugador.x-cientifico2.x), (jugador.y-cientifico2.y));
										cientifico2.play("dispara");
					
					bala3=cientifico3.fire(cientifico3.x+45, cientifico3.y+30, 10, (jugador.x-cientifico3.x), (jugador.y-cientifico3.y));
										cientifico3.play("dispara");
					
					add(bala2);
					add(bala3);
				}		
				if(jugador.y < 730 && jugador.y > 443){			
					bala4=cientifico4.fire(cientifico4.x+45, cientifico4.y+30, 10, (jugador.x-cientifico4.x), (jugador.y-cientifico4.y));
										cientifico4.play("dispara");
					
					add(bala4);
				}			
				if(jugador.y < 545){
					bala5=cientifico5.fire(cientifico5.x+45, cientifico5.y+30, 10, (jugador.x-cientifico5.x), (jugador.y-cientifico5.y));
										cientifico5.play("dispara");
					
					add(bala5);
				}
				balas.add(bala1);
				balas.add(bala2);
				balas.add(bala3);
				balas.add(bala4);
				balas.add(bala5);
				t2=0;
			}
			
			if(FlxG.overlap(jugador,balas)){
				balas.kill();
				vidas.getFirstAlive().kill();
				jugador.vida -=1;
				FlxG.play(Hurt, 1, false);
				if(jugador.vida==0){
					jugador.kill();
					FlxG.fade(0x000000,1,loser);
				}
			}
			if(FlxG.overlap(jugador,misil1)||FlxG.overlap(jugador,misil2)||FlxG.overlap(jugador,misil3)){
				vidas.getFirstAlive().kill();
				jugador.vida -=1;
				FlxG.play(Hurt, 1, false);
				if(jugador.vida==0){
					jugador.kill();
					FlxG.fade(0x000000,1,loser);
				}
			}
			if(FlxG.overlap(jugador, item)){
				item.kill();
				FlxG.fade(0xFFFFFF,1,winner);
			}
			movimientoV(1400, 1700, plataforma2);
			movimientoH(160, 420, plataforma1);
			movimientoH(60, 430, plataforma3);
			movimientoH(70, 430, plataforma4);
			movimientoH(70, 430, plataforma5);
			box1.acceleration.y = 1000;
			FlxG.collide(jugador,map);	
			FlxG.collide(jugador,mapElastic);	
			FlxG.collide(jugador,mapElasticPro);
			FlxG.collide(jugador, box1);
			FlxG.collide(box1, mapElastic);
			FlxG.collide(box1, map);
			fake.y = jugador.y;
			if(FlxG.keys.pressed("ESCAPE")){
                 FlxG.switchState(new Inicio());
            }
		}
	}
}
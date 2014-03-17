package com.powerflasher.SampleApp {
	import org.flixel.*;
	/**
	 * @author Amiel Zuniga
	 */
	public class Nivel3_1 extends FlxState{
		[Embed(source = "img/13.png")] public static var bricks:Class;		
		[Embed(source = "map3_1_1.csv", mimeType = "application/octet-stream")] public static var mapa:Class;
		[Embed(source = "map3_1_2.csv", mimeType = "application/octet-stream")] public static var mapaParedes:Class;
		[Embed(source = "map3_1_3.csv", mimeType = "application/octet-stream")] public static var mapaElastico:Class;
		[Embed(source="musica/song 3.mp3")] public var Music:Class;
		[Embed(source="musica/jump.mp3")] public var Jump:Class;
		[Embed(source="musica/hurt.mp3")] public var Hurt:Class;

		private var jugador:Jugador;
		private var fake:Jugador;
		
		private var cientifico1:Cientifico;
		private var cientifico2:Cientifico;
		private var box1:TNT;
		private var map:FlxTilemap;
		private var mapWalls:FlxTilemap;
		private var mapElastic:FlxTilemap;
		private var plataforma1:Plataforma;
		private var plataforma2:Plataforma;
		private var vmax:Boolean = true;
		private var hmax:Boolean = true;
		private var t:Number = 0;
		private var bala1:Bala;
		private var bala2:Bala;
		private var bala3:Bala;
		private var bala4:Bala;
		private var paused:Boolean = false;
		private var texto:FlxText;
		private var item:Item;
		private var sky:Sky;
		private var vida:Vida;
				private var h1:Heart;
				private var h2:Heart;
				private var h3:Heart;
				private var vidas:FlxGroup;
		
		public function Nivel3_1(){
        	super();	
        }
		
		public function winner():void{
			FlxG.switchState(new Nivel3_2());
		}
		public function loser():void{
			FlxG.resetState();
		}
          
		
		override public function create():void{
            jugador = new Jugador(0,1745);
			fake = new Jugador(295,1750);
			cientifico1 = new Cientifico(560, 1104,2);
			cientifico2 = new Cientifico(60, 1407,1);
			box1 = new TNT(50,1800);
			plataforma1 = new Plataforma(40, 980,1);
			plataforma2 = new Plataforma(522, 1170,1);
			item=new Item(240, 32);
			sky= new Sky(-320, -1000);
			
			FlxG.mouse.show();
			
			vidas = new FlxGroup();
						vida = new Vida(5,554);
						h1 = new Heart(40,554);
						h2 = new Heart(65,554);
						h3 = new Heart(90,554);
						
						vidas.add(h3);
						vidas.add(h2);
						vidas.add(h1);
			
			bala1 = new Bala(-15,0,0,0,0);
			bala2 = new Bala(-15,0,0,0,0);
			bala3 = new Bala(-15,0,0,0,0);
			bala4 = new Bala(-15,0,0,0,0);
						
			map=new FlxTilemap();
			map.loadMap(new mapa(), bricks, 32, 32);
			map.setTileProperties(14, FlxObject.UP);
			map.setTileProperties(6, FlxObject.UP);
			map.setTileProperties(7, FlxObject.UP);
			map.setTileProperties(8, FlxObject.UP);
			map.setTileProperties(9, FlxObject.UP);
			map.setTileProperties(10, FlxObject.UP);
			map.setTileProperties(11, FlxObject.UP);
			mapWalls=new FlxTilemap();
			mapWalls.loadMap(new mapaParedes(), bricks,32,32);
			mapElastic=new FlxTilemap();
			mapElastic.loadMap(new mapaElastico(), bricks,32,32);
			mapElastic.setTileProperties(2, FlxObject.UP);
			mapElastic.setTileProperties(3, FlxObject.UP);
			mapElastic.setTileProperties(5, FlxObject.UP);			
			texto=new FlxText(0, 340, FlxG.width, "PAUSED GAME").setFormat(null, 65, 0xFFFFFF, "center");
            texto.kill();
			sky.scrollFactor.y=0.4;
			
			FlxG.play(Music, 0.4, true);
			
			add(sky);
			add(map);
			add(mapWalls);
			
			add(mapElastic);
			add(jugador);
			add(item);
			add(box1);
			add(plataforma1);
			add(plataforma2);
			add(cientifico1);
			add(cientifico2);
			add(vida);
						add(h1);
						add(h3);
						add(h2);
			add(texto);
						
			FlxG.camera.follow(fake);
			FlxG.camera.y -= 550;
		}
		
		public function movimientoV():void{
			if(vmax && plataforma2.y<1200){
				plataforma2.y+=1.5;
				cientifico1.y=plataforma2.y-66;
			}
			if(vmax && plataforma2.y>=1200){
				vmax=false;
			}
			if(!vmax && plataforma2.y>900){
				plataforma2.y-=1.5;
				cientifico1.y=plataforma2.y-66;
			}
			if(!vmax && plataforma2.y<=900){
				vmax=true;
			}
		}
		
		public function movimientoH():void{
			if(hmax && plataforma1.x<160){
				plataforma1.x+=1.5;	
			}
			if(hmax && plataforma1.x>=160){
				hmax=false;
			}
			else if(!hmax &&plataforma1.x>20){
				plataforma1.x-=1.5;
			}
			if(!hmax && plataforma1.x<=20){
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
			super.update();
			
			 if(FlxG.overlap(jugador,item)){
				item.kill();
                        	FlxG.fade(0xFFFFFF, 1, winner);
            }
			if(FlxG.keys.pressed("RIGHT")&&jugador.x<590){
				jugador.x = jugador.x+2;
				jugador.play("derecha");
			}
			if(FlxG.keys.pressed("LEFT")&&jugador.x>0){
				jugador.x = jugador.x-2;
				jugador.play("izquierda");
			}
			if(FlxG.keys.justPressed("UP") &&(jugador.overlaps(plataforma1) || jugador.overlaps(plataforma2))){
				jugador.velocity.y = -380;
				jugador.y -= 30;
				jugador.play("arriba");	
				FlxG.play(Jump, 0.4, false);
			}
			if(FlxG.keys.justPressed("UP") && (FlxG.collide(jugador,map) || FlxG.collide(jugador,box1))){
				jugador.velocity.y = -380;
				jugador.y -= 30;
				jugador.play("arriba");	
				FlxG.play(Jump, 0.4, false);
			}
			if((FlxG.collide(jugador,mapElastic))){
				jugador.velocity.y = -500;
				jugador.y -= 80;
				jugador.play("arriba");	
				FlxG.play(Jump, 0.4, false);
			}	
			
			jugador.acceleration.y = 1000;
			
			if(jugador.overlaps(plataforma1)){
				jugador.acceleration.y = 0;
				jugador.y = plataforma1.y - 70;
				if(hmax && plataforma1.x<160){
					jugador.x+=1.5;	
				}
				if(!hmax &&plataforma1.x>20){
					jugador.x-=1.5;
				}
			}
			if(jugador.overlaps(plataforma2)){
				jugador.acceleration.y = 0;
				jugador.y = plataforma2.y - 70;
			}
			
			t+=FlxG.elapsed;
			
			if(t>=1.5 && jugador.y < 1410 && jugador.y > 600){
				
				if(jugador.y>539){
					bala4 = bala3;
					bala3 = bala2;
					bala2 = bala1;
					bala1 = cientifico1.fire(cientifico1.x,cientifico1.y,10,(jugador.x - cientifico1.x),(jugador.y-cientifico1.y));
					cientifico1.play("dispara");
					add(bala1);
					add(bala2);
					add(bala3);
					add(bala4);
				}
				
				
				t=0;
			}
			if(t>=1.5 && jugador.y >= 1410){
				bala4 = bala3;
				bala3 = bala2;
				bala2 = bala1;
				bala1 = cientifico2.fire(cientifico2.x+50,cientifico2.y+20,10,(jugador.x - cientifico2.x),(jugador.y-cientifico2.y));
				cientifico2.play("dispara");
				
				add(bala1);
				add(bala2);
				add(bala3);
				add(bala4);
				
				t=0;
			}
			
			if(FlxG.overlap(jugador,bala1)||FlxG.overlap(jugador,bala2)||FlxG.overlap(jugador,bala3)||FlxG.overlap(jugador,bala4)){
				vidas.getFirstAlive().kill();
				jugador.vida -=1;
				FlxG.play(Hurt, 1, false);
				bala1.kill();
				bala2.kill();
				bala3.kill();
				bala4.kill();
				if(jugador.vida==0){
					jugador.kill();
					FlxG.fade(0x000000,1,loser);
				}
				
			}
			
			movimientoH();
			movimientoV();
			box1.acceleration.y = 1000;
			FlxG.collide(jugador,map);	
			FlxG.collide(jugador,mapWalls);	
			FlxG.collide(jugador,mapElastic);
			FlxG.collide(jugador, box1);
			FlxG.collide(box1, mapWalls);
			FlxG.collide(box1, map);
			if(jugador.y > 538){
				fake.y = jugador.y + 60;
				
			}
			if(FlxG.keys.pressed("ESCAPE")){
                 FlxG.switchState(new Inicio());
            }
		}
	}
}

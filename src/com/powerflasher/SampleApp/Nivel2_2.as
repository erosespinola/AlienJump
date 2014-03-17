package com.powerflasher.SampleApp {
	/**
	 * @author Eros Esp�nola
	 */
	import org.flixel.*;
	
	public class Nivel2_2 extends FlxState{
		[Embed(source = "img/2.png")] public static var bricks:Class;
		
		[Embed(source = "map2_2_1.csv", mimeType = "application/octet-stream")] public static var mapa:Class;
		[Embed(source = "map2_2_2.csv", mimeType = "application/octet-stream")] public static var mapaElastico:Class;
		[Embed(source = "map2_2_3.csv", mimeType = "application/octet-stream")] public static var mapaCajas:Class;
		[Embed(source="musica/song 2.mp3")] public var Music:Class;
		[Embed(source="musica/jump.mp3")] public var Jump:Class;
		[Embed(source="musica/hurt.mp3")] public var Hurt:Class;
		[Embed(source="musica/TNT.mp3")] public var tnt:Class;
		
		private var jugador:Jugador;
		private var tanque:Tanque;
		private var sky:Sky;
		private var mapTNT:FlxTilemap;
		private var map:FlxTilemap;
		private var mapElastic:FlxTilemap;
		
		private var t:Number = 0;
		private var hmax:Boolean = true;
		private var box1:TNT;
		private var box2:TNT;
		
		private var bala1:Bala;
		private var bala2:Bala;
		private var bala3:Bala;
		private var bala4:Bala;
		private var texto:FlxText;
		private var paused:Boolean = false;
		
		private var vida:Vida;
				private var h1:Heart;
				private var h2:Heart;
				private var h3:Heart;
				private var vidas:FlxGroup;
		
		public function Nivel2_2(){
        	super();
        }
		
		public function winner():void{
			FlxG.switchState(new Animation_Level2());
		}
		public function loser():void{
			FlxG.resetState();
		}
		
		override public function create():void{
            jugador = new Jugador(30,690);
			tanque = new Tanque(350, 644, 2);
			sky=new Sky(-320, -1000);
			box1 = new TNT(128, 90);
			box2 = new TNT(504, 90);
			
			FlxG.mouse.show();
			
			bala1 = new Bala(-10,-10,0,0,0);
			bala2 = new Bala(-10,-10,0,0,0);
			bala3 = new Bala(-10,-10,0,0,0);
			bala4 = new Bala(-10,-10,0,0,0);
			
			vidas = new FlxGroup();
						vida = new Vida(5,5);
						h1 = new Heart(40,5);
						h2 = new Heart(65,5);
						h3 = new Heart(90,5);
						
						vidas.add(h3);
						vidas.add(h2);
						vidas.add(h1);
			
			mapTNT=new FlxTilemap();
			mapTNT.loadMap(new mapaCajas(), bricks, 32, 32);
			map=new FlxTilemap();
			map.loadMap(new mapa(), bricks, 32, 32);
			mapElastic=new FlxTilemap();
			mapElastic.loadMap(new mapaElastico(), bricks,32,32);
			
			mapTNT.setTileProperties(16, FlxObject.UP);
			mapTNT.setTileProperties(17, FlxObject.UP);
			
			mapElastic.setTileProperties(13, FlxObject.UP);
			mapElastic.setTileProperties(11, FlxObject.UP);
			mapElastic.setTileProperties(6, FlxObject.UP);
			
			texto=new FlxText(0, 340, FlxG.width, "PAUSED GAME").setFormat(null, 65, 0xFFFFFF, "center");
            texto.kill();
			
			sky.scrollFactor.y=0.4;
			
			FlxG.play(Music, 0.6, true);
			
			add(sky);	
			add(map);
			add(mapElastic);
			add(mapTNT);
			add(jugador);
			add(tanque);
			add(box1);
			add(box2);
			
			add(vida);
						add(h1);
						add(h3);
						add(h2);
			add(texto);
		}
		
		public function movimientoH():void{
			if(hmax && tanque.x<358){
				tanque.x+=1.5;
			}
			if(hmax && tanque.x>=358){
				hmax=false;
			}
			else if(!hmax &&tanque.x>32){
				tanque.x-=1.5;
			}
			if(!hmax && tanque.x<=32){
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
			if(FlxG.keys.pressed("RIGHT")){
				jugador.x = jugador.x+2;
				jugador.play("derecha");
			}
			if(FlxG.keys.pressed("LEFT")){
				jugador.x = jugador.x-2;
				jugador.play("izquierda");
			}
			if(FlxG.keys.justPressed("UP") && (FlxG.collide(jugador,map))){
				jugador.velocity.y = -380;
				jugador.y -= 30;
				jugador.play("arriba");	
				FlxG.play(Jump, 0.4, false);
			}
			if(FlxG.keys.justPressed("UP") && (FlxG.collide(jugador,mapTNT))){
				jugador.velocity.y = -380;
				jugador.y -= 30;
				jugador.play("arriba");	
				FlxG.play(Jump, 0.4, false);
			}
			if(FlxG.keys.justPressed("UP") && (FlxG.overlap(jugador,box1))){
				jugador.velocity.y = -380;
				jugador.y -= 30;
				jugador.play("arriba");	
				FlxG.play(Jump, 0.4, false);
			}
			if(FlxG.keys.justPressed("UP") && (FlxG.overlap(jugador,box2))){
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
			if(box1.overlaps(tanque)){
				tanque.reduceLife();
				box1.setPosicion(0,0);
				box1.kill();
				FlxG.play(tnt, 1, false);
				if(tanque.getVida()==0){
					tanque.kill();
					bala1.kill();
					bala2.kill();
					bala3.kill();
					bala4.kill();
					
					FlxG.fade(0xFFFFFF, 1, winner);
				}
			}
			if(box2.overlaps(tanque)){
				tanque.reduceLife();
				box2.setPosicion(0,0);
				box2.kill();
				FlxG.play(tnt, 1, false);
				if(tanque.getVida()==0){
					tanque.kill();
					bala1.kill();
					bala2.kill();
					bala3.kill();
					bala4.kill();
					
					FlxG.fade(0xFFFFFF, 1, winner);
				}
			}
			
			if(FlxG.collide(box1, map)){
				box1.setPosicion(128, 90);
				if(FlxG.collide(box1,jugador)){
					box1.setPosicion(100, 90);
				}
			}
			if(FlxG.collide(box2, map)){
				box2.setPosicion(504, 90);
				if(FlxG.collide(box2,jugador)){
					box1.setPosicion(400, 90);
				}
			}
			t+=FlxG.elapsed;
			if(t>=1.5){
				bala4 = bala3;
				bala3 = bala2;
				bala2 = bala1;
				bala1 = tanque.fire(tanque.x+100,tanque.y,10,(jugador.x - tanque.x),(jugador.y-tanque.y));
				
				add(bala1);
				add(bala2);
				add(bala3);
				add(bala4);
				t=0;
			}
			if(FlxG.overlap(jugador,tanque)){
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
if(FlxG.keys.pressed("ESCAPE")){
                 FlxG.switchState(new Inicio());
            }
			FlxG.collide(jugador,map);	
			FlxG.collide(jugador,mapElastic);		
			FlxG.collide(box1, mapTNT);
			FlxG.collide(box2, mapTNT);
			FlxG.collide(jugador, box1);
			FlxG.collide(jugador, box2);
			FlxG.collide(jugador,mapTNT);
			jugador.acceleration.y = 1000;
			box1.acceleration.y = 1000;
			box2.acceleration.y = 1000;
		}
	}
}

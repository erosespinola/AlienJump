package com.powerflasher.SampleApp{
	import org.flixel.*;
	/**
	 * @author Eros Esp�nola
	 */
	public class Nivel1 extends FlxState{
		[Embed(source = "img/brick_tiles_1.png")] public static var bricks:Class;
		[Embed(source = "map1_1_1.csv", mimeType = "application/octet-stream")] public static var mapa:Class;
		[Embed(source = "map1_1_2.csv", mimeType = "application/octet-stream")] public static var mapaElastico:Class;
		[Embed(source="musica/song 3.mp3")] public var Music:Class;
		[Embed(source="musica/jump.mp3")] public var Jump:Class;
		[Embed(source="musica/hurt.mp3")] public var Hurt:Class;
		

		
		private var cientifico:Cientifico;
		private var bala:Bala;
		private var misil:Bala;
		private var texto:FlxText;
		private var jugador:Jugador;
		private var fake:Jugador;
		private var helicopeto:Helicoptero;
		private var paused:Boolean=false;
		private var cielo:Sky;
		private var yhel:int=2;
		private var item:Item;
		private var map:FlxTilemap;
		private var mapElastic:FlxTilemap;
		private var t:Number = 0;
		private var vida:Vida;
		private var h1:Heart;
		private var h2:Heart;
		private var h3:Heart;
		private var vidas:FlxGroup;
		
		public function Nivel1(){
        	super();
        }
		
		override public function create():void{
            jugador = new Jugador(0,1155);
			fake= new Jugador(295, 1160);
			
			cientifico=new Cientifico(350, 1182,2);
			cielo= new Sky(-320, -1000);
			helicopeto = new Helicoptero(350, 400,1);
			helicopeto.play("volar");
			
			vidas = new FlxGroup();
			vida = new Vida(5,565);
			h1 = new Heart(40, 565);
			h2 = new Heart(65, 565);
			h3 = new Heart(90, 565);
			
			FlxG.mouse.show();
			
			vidas.add(h3);
			vidas.add(h2);
			vidas.add(h1);
			
			item = new Item(208, 0);
			
			bala = new Bala(0,0,0,0,0);
			misil = new Bala(0,0,0,0,0);
			
			map=new FlxTilemap();
			map.loadMap(new mapa(), bricks, 32, 32);

			map.setTileProperties(14, FlxObject.UP);
			map.setTileProperties(15, FlxObject.UP);
			
			mapElastic=new FlxTilemap();
			mapElastic.loadMap(new mapaElastico(), bricks,32,32);
			
			mapElastic.setTileProperties(8, FlxObject.UP);
			mapElastic.setTileProperties(6, FlxObject.UP);
			texto=new FlxText(0, 340, FlxG.width, "PAUSED GAME").setFormat(null, 65, 0xFFFFFF, "center");
            texto.kill();
			misil = helicopeto.fire(390, 540, 10,-300,300);
			
			cielo.scrollFactor.y=0.4;
			
			add(cielo);
			add(map);
			add(mapElastic);
			add(jugador);
			add(item);
			add(cientifico);
			add(helicopeto);
			add(vida);
			add(h1);
			add(h3);
			add(h2);
			add(texto);
			
			FlxG.camera.follow(fake);
			FlxG.camera.y -= 560;
			FlxG.play(Music, .4, true);
			
			
		}

		public function winner():void{
			FlxG.switchState(new Nivel1_2());
		}

		public function loser():void{
			FlxG.resetState();
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
			helicopeto.y += yhel;
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
			if(FlxG.keys.pressed("ESCAPE")){
                 FlxG.switchState(new Inicio());
            }
			if((FlxG.collide(jugador,mapElastic))){
				jugador.velocity.y = -500;
				jugador.y -= 80;
				jugador.play("arriba");	
				FlxG.play(Jump, 0.4, false);
				
			}
			
			t+=FlxG.elapsed;
			if(t>=1.5){
				bala = cientifico.fire(350,1200,10,-300,0);
				cientifico.play("dispara");
				add(bala);
				if(jugador.y <800 && jugador.y>600){
					misil = helicopeto.fire(390, 540, 10,-300,300);
					add(misil);
				}
				t=0;
			}
			if(FlxG.overlap(jugador, bala) || FlxG.overlap(jugador, misil)){
				vidas.getFirstAlive().kill();
				jugador.vida -=1;
				FlxG.play(Hurt, 1, false);
				bala.kill();
				misil.kill();
				if(jugador.vida==0){
					jugador.kill();	
					FlxG.fade(0x000000, 1, loser);
				}
			}
			if(bala.x < 80){
				bala.kill();
			}
			if(misil.y > 1000){
				misil.kill();
			}
			if(FlxG.overlap(jugador, item)){
				item.kill();
				FlxG.fade(0xFFFFFF, 0.5, winner);
            }
			FlxG.collide(jugador,map);	
			FlxG.collide(jugador,mapElastic);		
			jugador.acceleration.y = 1000;
			yhel *= -1;
			if(jugador.y >= 538){
				fake.y = jugador.y+60;
			}
		}
		
		
	}
}

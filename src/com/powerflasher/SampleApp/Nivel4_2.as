package com.powerflasher.SampleApp {
	/**
	 * @author Amiel Zúñiga
	 */
	import org.flixel.*;

	public class Nivel4_2 extends FlxState {
		[Embed(source = "img/13.png")] public static var bricks : Class;

		[Embed(source = "map4_2_3.csv", mimeType = "application/octet-stream")] public static var mapaWalls : Class;
		[Embed(source = "map4_2_1.csv", mimeType = "application/octet-stream")] public static var mapa : Class;
		[Embed(source = "map4_2_2.csv", mimeType = "application/octet-stream")]public static var mapaElastico : Class;
		[Embed(source="musica/song 1.mp3")] public var Music:Class;
		[Embed(source="musica/jump.mp3")] public var Jump:Class;
		[Embed(source="musica/hurt.mp3")] public var Hurt:Class;
		[Embed(source="musica/TNT.mp3")] public var tnt:Class;
		
		private var paused:Boolean;
		
		private var jugador : Jugador;
		private var tanque : Tanque;
		private var map : FlxTilemap;
		private var mapWalls : FlxTilemap;
		private var mapElastic : FlxTilemap;
		private var t : Number = 0;
		private var t2 : Number = 0;
		private var t3 : Number = 0;
		private var pico1 : Pico;
		private var pico2 : Pico;
		private var pico3 : Pico;
		private var pico4 : Pico;
		private var picos : FlxGroup;
		private var box1 : TNT;
		private var box2 : TNT;
		private var box3 : TNT;
		private var box4 : TNT;
		private var boxes : FlxGroup;
		private var balai : Bala;
		private var bala : Bala;
		private var balad : Bala;
		private var balas : FlxGroup;
		private var tmax : Boolean = true;
		private var texto:FlxText;
		private var sky:Sky;
		
		private var vida:Vida;
				private var h1:Heart;
				private var h2:Heart;
				private var h3:Heart;
				private var vidas:FlxGroup;		


		public function Nivel4_2() {
			super();
		}

		override public function create() : void {
			jugador = new Jugador(556, 0);
			tanque = new Tanque(150, 644, 4);
	
			vidas = new FlxGroup();
			vida = new Vida(5,5);
			h1 = new Heart(40, 5);
			h2 = new Heart(65, 5);
			h3 = new Heart(90, 5);
			
			FlxG.mouse.show();
			
			vidas.add(h3);
			vidas.add(h2);
			vidas.add(h1);
			
			sky = new Sky(-320, -1000);
			box1 = new TNT(128, 64);
			box2 = new TNT(480, 64);
			box3 = new TNT(96, 256);
			box4 = new TNT(512, 256);
			
			FlxG.play(Music, 0.8, true);
			
			box1.acceleration.y=1000;
			box2.acceleration.y=1000;
			box3.acceleration.y=1000;
			box4.acceleration.y=1000;
			boxes = new FlxGroup();
			boxes.add(box1);
			boxes.add(box2);
			boxes.add(box3);
			boxes.add(box4);

			bala = new Bala(-15, 0, 0, 0, 0);
			balai = new Bala(-15, 0, 0, 0, 0);
			balad = new Bala(-15, 0, 0, 0, 0);
			balas = new FlxGroup();
			balas.add(bala);
			balas.add(balai);
			balas.add(balad);

			pico1 = new Pico(512, 320, 4);
			pico2 = new Pico(544, 320, 4);
			pico3 = new Pico(32, 320, 4);
			pico4 = new Pico(64, 320, 4);
			picos = new FlxGroup();
			picos.add(pico1);
			picos.add(pico2);
			picos.add(pico3);
			picos.add(pico4);

			map = new FlxTilemap();
			map.loadMap(new mapa(), bricks, 32, 32);
			
			map.setTileProperties(14, FlxObject.UP);
			
			
			//cielo = new sky(0, 0);
			mapWalls = new FlxTilemap();
			mapWalls.loadMap(new mapaWalls(), bricks, 32, 32);
			mapWalls.setTileProperties(13, FlxObject.UP);
			mapWalls.setTileProperties(11, FlxObject.UP);
			mapWalls.setTileProperties(6, FlxObject.UP);
			mapWalls.setTileProperties(14, FlxObject.UP);
			
			mapElastic = new FlxTilemap();
			mapElastic.loadMap(new mapaElastico(), bricks, 32, 32);
			mapElastic.setTileProperties(13, FlxObject.UP);
			mapElastic.setTileProperties(11, FlxObject.UP);
			mapElastic.setTileProperties(6, FlxObject.UP);


			paused = false;
			texto=new FlxText(0, 340, FlxG.width, "PAUSED GAME").setFormat(null, 65, 0xFFFFFF, "center");
			texto.kill();
			
			sky.scrollFactor.y=0.4;

			add(sky);
			add(picos);
			add(mapWalls);
			add(map);
			add(mapElastic);
			add(jugador);
			add(tanque);
			add(boxes);
			add(balas);
			
			add(vida);
			add(vidas);
			
			add(texto);

			//FlxG.worldBounds = new FlxRect(0, 0, 640, 800);
		}


		public function winner():void{
			FlxG.switchState(new Animation_Level4());
		}
		
		public function loser():void{
			FlxG.resetState();
		}


		public function movimientoH() : void {
            if (tmax && tanque.x < 348) {
                    tanque.x += 1;
            }
            if (tmax && tanque.x >= 348) {
                    tmax = false;
            }
            if (!tmax && tanque.x > 32) {
                    tanque.x -= 1;
            }
            if (!tmax && tanque.x <= 32) {
                    tmax = true;
            }
		}


		override public function update() : void {
			
			if(FlxG.keys.justPressed("P"))
				paused = !paused;
			if(!paused)
				texto.kill();
			if(paused){
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
			if(FlxG.keys.justPressed("UP") && FlxG.collide(jugador,map)){
				jugador.velocity.y = -380;
				jugador.y -= 30;
				jugador.play("arriba");	
			}
			if(FlxG.keys.justPressed("UP") && FlxG.overlap(jugador,box1)){
				jugador.velocity.y = -380;
				jugador.y -= 30;
				jugador.play("arriba");	
				FlxG.play(Jump, .4, false);
			}
			if(FlxG.keys.justPressed("UP") && FlxG.overlap(jugador,box2)){
				jugador.velocity.y = -380;
				jugador.y -= 30;
				jugador.play("arriba");	
				FlxG.play(Jump, .4, false);
			}
			if(FlxG.keys.justPressed("UP") && FlxG.overlap(jugador,box3)){
				jugador.velocity.y = -380;
				jugador.y -= 30;
				jugador.play("arriba");	
				FlxG.play(Jump, .4, false);
			}
			if(FlxG.keys.justPressed("UP") && FlxG.overlap(jugador,box4)){
				jugador.velocity.y = -380;
				jugador.y -= 30;
				jugador.play("arriba");	
				FlxG.play(Jump, .4, false);
			}
			if(FlxG.keys.justPressed("UP") && FlxG.collide(jugador,mapWalls)){
				jugador.velocity.y = -380;
				jugador.y -= 30;
				jugador.play("arriba");	
				FlxG.play(Jump, .4, false);
			}

			if ((FlxG.collide(jugador, mapElastic))) {
				jugador.velocity.y = -500;
				jugador.y -= 80;
				jugador.play("arriba");
				FlxG.play(Jump, .4, false);
			}

			jugador.acceleration.y = 1000;

			if (FlxG.overlap(box1, tanque)) {
				box1.kill();
				tanque.reduceLife();
				FlxG.play(tnt, 1, false);
			}

			if (FlxG.overlap(box2, tanque)) {
				box2.kill();
				tanque.reduceLife();
				FlxG.play(tnt, 1, false);
			}

			if (FlxG.overlap(box3, tanque)) {
				box3.kill();
				tanque.reduceLife();
				FlxG.play(tnt, 1, false);
			}
			if (FlxG.overlap(box4, tanque)) {
				box4.kill();
				tanque.reduceLife();
				FlxG.play(tnt, 1, false);
			}


			if (tanque.getVida() == 0) {
				tanque.kill();
				balas.kill();
				FlxG.fade(0xFFFFFF,1,winner);
			}
			
			if(FlxG.collide(box1, map)){
				box1.reset(128, 64);
			}
			if(FlxG.collide(box2, map)){
				box2.reset(480, 64);
			}
			if(FlxG.collide(box3, map)){
				box3.reset(96, 256);
			}
			if(FlxG.collide(box4, map)){
				box4.reset(512, 256);
			}

			t += FlxG.elapsed;
			if (t >= 1.5) {
				bala = tanque.fire(tanque.x + 100, tanque.y, 10, (jugador.x - tanque.x), (jugador.y - tanque.y));
				balai = tanque.fire(tanque.x + 100, tanque.y, 10, (jugador.x - tanque.x - 175), (jugador.y - tanque.y));
				balad = tanque.fire(tanque.x + 100, tanque.y, 10, (jugador.x - tanque.x + 275), (jugador.y - tanque.y));
				add(bala);
				add(balai);
				add(balad);
				balas.add(bala);
				balas.add(balai);
				balas.add(balad);
				t = 0;
			}
			if (FlxG.overlap(jugador,tanque)) {
				vidas.getFirstAlive().kill();
				jugador.vida -=1;
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
				FlxG.play(Hurt, 1, false);
				if(jugador.vida==0){
					jugador.kill();
					FlxG.fade(0x000000,1,loser);
				}
			}

			t2 += FlxG.elapsed;
			if (t2 > 1.5) {
				t2 = 0;
			}
			if (t2 == 0) {
				pico1.kill();
				pico2.kill();
				pico3.kill();
				pico4.kill();
			}

			t3 += FlxG.elapsed;
			if (t3 > 3) {
				t3 = 0;
			}
			if (t3 == 0) {
				pico1.revive();
				pico2.revive();
				pico3.revive();
				pico4.revive();
			}

			if (FlxG.overlap(jugador, picos)) {
				vidas.getFirstAlive().kill();
				jugador.vida -=1;
				FlxG.play(Hurt, 1, false);
				if(jugador.vida==0){
					jugador.kill();
					FlxG.fade(0x000000,1,loser);
				}
			}			
			
			
			movimientoH();
			
			if(FlxG.keys.pressed("ESCAPE")){
                 FlxG.switchState(new Inicio());
            }
			
			FlxG.collide(jugador, map);
			FlxG.collide(jugador, mapWalls);
			FlxG.collide(boxes, map);
			FlxG.collide(boxes, mapWalls);
			FlxG.collide(jugador, mapElastic);
			FlxG.collide(jugador, boxes);
			FlxG.collide(box3, box4);
			FlxG.overlap(jugador, balas);
				
			
		}

	}
}

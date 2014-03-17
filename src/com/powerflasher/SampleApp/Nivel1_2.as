package com.powerflasher.SampleApp{
        import org.flixel.*;
        /**
         * @author Eros Esp�nola
         */
        public class Nivel1_2 extends FlxState{
                [Embed(source = "img/brick_tiles_1.png")] public static var bricks:Class;
                [Embed(source = "map1_2_1.csv", mimeType = "application/octet-stream")] public static var mapa:Class;
                [Embed(source = "map1_2_2.csv", mimeType = "application/octet-stream")] public static var mapaElastico:Class;
                [Embed(source="musica/song 3.mp3")] public var Music:Class;
				[Embed(source="musica/jump.mp3")] public var Jump:Class;
				[Embed(source="musica/hurt.mp3")] public var Hurt:Class;
				[Embed(source="musica/TNT.mp3")] public var tnt:Class;
				
                private var helicoptero:Helicoptero;
                private var bala1:Bala;
                private var bala2:Bala;
                private var bala3:Bala;
                private var bala4:Bala;
                private var cielo:Sky;
                private var red:Red;
                private var jugador:Jugador;
				private var fake:Jugador;
                private var map:FlxTilemap;
                private var mapElastic:FlxTilemap;
                private var t:Number = 0;
                private var caja:TNT;
				private var yhel:int=2;
                private var paused:Boolean;
                private var texto:FlxText;
				private var vida:Vida;
				private var h1:Heart;
				private var h2:Heart;
				private var h3:Heart;
				private var vidas:FlxGroup;
                
                public function Nivel1_2(){
                super();
                        
        }
		public function winner():void{
			FlxG.switchState(new Animation_Level1());
		}
		public function loser():void{
			FlxG.resetState();
		}
                
                override public function create():void{
            			jugador = new Jugador(295,1150);
						fake = new Jugador(295,1150);
						cielo = new Sky(-320, -1000);
                        helicoptero=new Helicoptero(100, 900, 2);
                        helicoptero.play("volar");
                        bala1 = new Bala(-10, -10, 0, 0, 0);
                        bala2 = new Bala(-10, -10, 0, 0, 0);
                        bala3 = new Bala(-10, -10, 0, 0, 0);
                        bala4 = new Bala(-10, -10, 0, 0, 0);
                        red = new Red(0,0,0,0,0,1);
                        caja = new TNT(200, 90);
                        caja.acceleration.y = 1000;
						
						FlxG.mouse.show();
                        
                        vidas = new FlxGroup();
						vida = new Vida(5,505);
						h1 = new Heart(40, 505);
						h2 = new Heart(65, 505);
						h3 = new Heart(90, 505);
						
						vidas.add(h3);
						vidas.add(h2);
						vidas.add(h1);
						
                        map=new FlxTilemap();
                        map.loadMap(new mapa(), bricks, 32, 32);

                        map.setTileProperties(14, FlxObject.UP);
                        map.setTileProperties(15, FlxObject.UP);
                        
                        mapElastic=new FlxTilemap();
                        mapElastic.loadMap(new mapaElastico(), bricks,32,32);
                        
                        mapElastic.setTileProperties(7, FlxObject.UP);
                        mapElastic.setTileProperties(9, FlxObject.UP);
                        mapElastic.setTileProperties(11, FlxObject.UP);
                        
                        paused = false;
                        texto=new FlxText(0, 340, FlxG.width, "PAUSED GAME").setFormat(null, 65, 0xFFFFFF, "center");
                        texto.kill();
                        
						cielo.scrollFactor.y=0.4;
						
						FlxG.play(Music, 0.4, true);
						
						add(cielo);
                        add(map);
                        add(mapElastic);
                        add(jugador);
                        add(helicoptero);
                        add(caja);
						add(vida);
						add(h1);
						add(h3);
						add(h2);
                        add(texto);
                        
                        FlxG.camera.follow(fake);
						FlxG.camera.y -= 500;
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
						helicoptero.y += yhel;
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
								FlxG.play(Jump, 0.4, false);
								
                        }
                        if((FlxG.collide(jugador,mapElastic))){
                                jugador.velocity.y = -500;
                                jugador.y -= 100;
                                jugador.play("arriba"); 
								FlxG.play(Jump, 0.4, false);
								
                        }
                        if(FlxG.overlap(jugador, bala1) || FlxG.overlap(jugador, bala2) || FlxG.overlap(jugador, bala3) ||FlxG.overlap(jugador, bala4) ||FlxG.overlap(jugador, red)){
                                jugador.vida-=1;
								vidas.getFirstAlive().kill();
								FlxG.play(Hurt, 1, false);
                                bala1.kill();
                                bala2.kill();
                                bala3.kill();
                                bala4.kill();
                                red.kill();
								if(jugador.vida==0){
									jugador.kill();	
									FlxG.fade(0x000000, 1, loser);
								}
                        }
                        //Helicoptero sigue al personaja hacia arriba
                        if(jugador.y < helicoptero.y + 70 && jugador.y > 450){
                                helicoptero.y -=3;
                        }
                        //Helicoptero sigue al personaja hacia arriba
                        if(jugador.y < helicoptero.y - 150 && jugador.y < 350){
                                helicoptero.y -=3;
                        }
                        //Helicoptero sigue al personaje hacia abajo
                        if(jugador.y > helicoptero.y + 70 && ((jugador.y > 450 && jugador.y < 1000) || jugador.y < 350)){
                                helicoptero.y +=3;
                        }
                        if(FlxG.collide(caja, helicoptero)){
                                helicoptero.kill();
                                caja.kill();
								bala1.kill();
                                bala2.kill();
                                bala3.kill();
                                bala4.kill();
								FlxG.play(tnt, 1, false);
                                FlxG.fade(0xFFFFFF,0.5, winner);
                        }
                        
                        t+=FlxG.elapsed;
                        
                        //Mueve el helicoptero en diagonal en la parte superior
                        if(jugador.x <550 && jugador.y < 350){
                                if(helicoptero.x > 0){
                                        helicoptero.x -=2;
                                }
                                if(helicoptero.y >350){
                                        helicoptero.y -=1;
                                }
                        }
                        
                        //Lanza la red
                        if(jugador.x > 520 && jugador.y > 350 && jugador.y < 450 && t>=1.0){
                                red = helicoptero.red(300,helicoptero.y,70,300,0);
                                add(red);
                        }
                        

                        if(t>=1.0 && (helicoptero.y >450 || helicoptero.y < 400)){
                                bala4 = bala3;
                                bala3 = bala2;
                                bala2 = bala1;
                                bala1 = helicoptero.fire(helicoptero.x + 160,helicoptero.y + 140,10,(jugador.x - helicoptero.x) -120,(jugador.y-helicoptero.y)- 110);
                                
                                add(bala1);
                                add(bala2);
                                add(bala3);
                                add(bala4);
                        }
                        if(t>=1.0){
                                t=0;
                        }
                        if(FlxG.keys.pressed("ESCAPE")){
                 FlxG.switchState(new Inicio());
            }
                        FlxG.collide(jugador,map);      
                        FlxG.collide(jugador,mapElastic);
                        FlxG.collide(caja,map);
                        FlxG.collide(caja,mapElastic);
                        FlxG.collide(caja, jugador);    
                        yhel *= -1;
								
                        jugador.acceleration.y = 1000;
						fake.y = jugador.y+250;
                }
        }
}
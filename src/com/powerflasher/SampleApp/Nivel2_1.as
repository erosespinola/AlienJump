package com.powerflasher.SampleApp {
        import org.flixel.*;
        /**
         * @author Eros Esp�nola
         */
        public class Nivel2_1 extends FlxState{
                [Embed(source = "img/11.png")] public static var bricks:Class;
                [Embed(source = "map2_1_1.csv", mimeType = "application/octet-stream")] public static var mapa:Class;
                [Embed(source = "map2_1_2.csv", mimeType = "application/octet-stream")] public static var mapaParedes:Class;
                [Embed(source="musica/song 2.mp3")] public var Music:Class;
				[Embed(source="musica/jump.mp3")] public var Jump:Class;
				[Embed(source="musica/hurt.mp3")] public var Hurt:Class;
                
                private var jugador:Jugador;
				private var fake:Jugador;
                private var cientifico:Cientifico;
                private var cientifico2:Cientifico;
                private var bala:Bala;
                private var bala2:Bala;
                private var box1:TNT;
                private var pico1:Pico;
                private var pico2:Pico;
                private var pico3:Pico;
                private var pico4:Pico;
                private var picos:FlxGroup;
                public var hmax:Boolean=true;
                public var vmax:Boolean=true;
                private var plataforma1:Plataforma; 
                private var plataforma2:Plataforma;
                private var map:FlxTilemap;
                private var mapWalls:FlxTilemap;
                private var balas:FlxGroup;
                private var t:Number = 0;
                private var t2:Number = 0;
                private var t3:Number = 0;
                private var t4:Number = 0;
                private var paused:Boolean;
                private var texto:FlxText;
				private var sky:Sky;
				private var item:Item;
				
				private var vida:Vida;
				private var h1:Heart;
				private var h2:Heart;
				private var h3:Heart;
				private var vidas:FlxGroup;
                
                public function Nivel2_1(){
                super();        
        }
                
				public function winner():void{
					FlxG.switchState(new Nivel2_2());
				}
				
				public function loser():void{
					FlxG.resetState();
				}
                
                override public function create():void{

                        jugador = new Jugador(295,1495);
                        fake = new Jugador(295,1500);
                        plataforma1 = new Plataforma(384, 608,2);
                        plataforma2 = new Plataforma(0, 648,2);
                		item = new Item(272, 0);
						sky=new Sky(-320, -1000);
                        
						FlxG.mouse.show();
						
						vidas = new FlxGroup();
						vida = new Vida(5,605);
						h1 = new Heart(40, 605);
						h2 = new Heart(65, 605);
						h3 = new Heart(90, 605);
						
						vidas.add(h3);
						vidas.add(h2);
						vidas.add(h1);
						
                        map=new FlxTilemap();
                        map.loadMap(new mapa(), bricks, 32, 32);
                        
                        map.setTileProperties(2, FlxObject.UP);
                        map.setTileProperties(3, FlxObject.UP);
                        map.setTileProperties(5, FlxObject.UP);
                        
                        
                        mapWalls=new FlxTilemap();
                        mapWalls.loadMap(new mapaParedes(), bricks,32,32);
                        
                        
                        box1 = new TNT(140,1536);
                        
                        
                        
                        cientifico = new Cientifico(480, 1503,2);
                        cientifico2 = new Cientifico(32, 590,1);
                        
                        balas = new FlxGroup();
                        
                        bala= new Bala(-15,-10, 10, 0, 0);
                        bala2= new Bala(-15,-10, 10, 0, 0);
                        
                        balas.add(bala);
                        balas.add(bala2);
                        
                        plataforma1.allowCollisions=FlxObject.UP;
                        plataforma2.allowCollisions=FlxObject.UP;
                        
                        pico1=new Pico(256,192,2);
                        pico2=new Pico(256,288,2);
                        pico3=new Pico(352,256,1);
                        pico4=new Pico(352,352,1);
                        
                        picos = new FlxGroup();
                        picos.add(pico1);
                        picos.add(pico2);
                        picos.add(pico3);
                        picos.add(pico4);
                        
                        paused = false;
                        texto=new FlxText(0, 340, FlxG.width, "PAUSED GAME").setFormat(null, 65, 0xFFFFFF, "center");
                        texto.kill();
                        
						sky.scrollFactor.y=0.4;
						
						FlxG.play(Music, 0.6, true);
						
						add(sky);
                        add(picos);
                        add(map);
                        add(mapWalls);
                        add(jugador);
						add(item);
                        add(box1);
                        add(plataforma1);
                        add(plataforma2);
                        add(cientifico);
                        add(cientifico2);
                        add(balas);
						
						add(vida);
						add(h1);
						add(h3);
						add(h2);
						
                        add(texto);
                        
                        
                        FlxG.camera.follow(fake);
                        FlxG.camera.y-=600;
                }

                
                public function movimientoH():void{
                        if(hmax && plataforma1.x<448){
                                plataforma1.x+=1.5;
                        }
                        if(hmax && plataforma1.x>=448){
                                hmax=false;
                        }
                        if(!hmax &&plataforma1.x>164){
                                plataforma1.x-=1.5;
                        }
                        if(!hmax && plataforma1.x<=164){
                                hmax=true;
                        }
                }

                
                public function movimientoV():void{
                        if(vmax && plataforma2.y<960){
                                plataforma2.y+=1.5;
                                cientifico2.y=plataforma2.y-66;
                        }
                        if(vmax && plataforma2.y>=960){
                                vmax=false;
                        }
                        if(!vmax && plataforma2.y>648){
                                plataforma2.y-=1.5;
                                cientifico2.y=plataforma2.y-66;
                        }
                        if(!vmax && plataforma2.y<=648){
                                vmax=true;
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
                        if(FlxG.keys.justPressed("UP") && (FlxG.collide(jugador,map))){
                                jugador.velocity.y = -380;
                                jugador.y -= 30;
                                jugador.play("arriba"); 
								FlxG.play(Jump, 0.4, false);
                        }
                        if(FlxG.keys.justPressed("UP") && ((FlxG.collide(jugador,box1))|| (FlxG.collide(jugador, mapWalls)))){
                                jugador.velocity.y = -380;
                                jugador.y -= 30;
                                jugador.play("arriba"); 
								FlxG.play(Jump, 0.4, false);
                        }
                        if(FlxG.keys.justPressed("UP") && jugador.overlaps(plataforma1)){
                                jugador.velocity.y = -380;
                                jugador.y -= 32;
                                jugador.play("arriba"); 
								FlxG.play(Jump, 0.4, false);
                        }
                        
                        if(jugador.overlaps(plataforma1)){
                                jugador.y=537;
                                if(hmax && plataforma1.x<448)
                                        jugador.x+=1.5;
                                if(!hmax &&plataforma1.x>164)
                                        jugador.x-=1.5;
                                jugador.acceleration.y = 0;
                        }
                        t+=FlxG.elapsed;
                        if(t>=1.5){
							if(jugador.y > 1371){
								bala = cientifico.fire(470,1514,10,-250,0);
								cientifico.play("dispara");
                                add(bala);
                                t=0;
                                balas.add(bala); 
							}
                        }
						
						if(bala.overlaps(mapWalls)){
							bala.kill();
						}
						if(bala2.overlaps(map) || bala2.overlaps(mapWalls)){
							bala2.kill();
						}
                        
                        if(jugador.y>550 &&jugador.y<1100){
                                t2+=FlxG.elapsed;
                                if(t2>=1.2){
                                        bala2 = cientifico2.fire(cientifico2.x+50,cientifico2.y+20,10,(jugador.x-cientifico2.x)/2,(jugador.y-cientifico2.y)/2);
                                        cientifico2.play("dispara");
										add(bala2);
                                        t2=0;
                                        balas.add(bala2);
                                }
                        }
                        
                        if(FlxG.overlap(jugador,balas)){
							vidas.getFirstAlive().kill();
							jugador.vida -=1;
							FlxG.play(Hurt, 1, false);
							balas.kill();
                        	if(jugador.vida==0){
								jugador.kill();	
								FlxG.fade(0x000000, 1, loser);
							}
                        }
                        
                        if(FlxG.overlap(jugador,plataforma2)){
                                jugador.y=plataforma2.y-71;
                                jugador.acceleration.y=0;
                        }
                        
                        if(FlxG.overlap(jugador,picos)){
							vidas.getFirstAlive().kill();
							jugador.vida -=1;
							FlxG.play(Hurt, 0.4, false);
							if(jugador.vida==0){
								jugador.kill();	
								FlxG.fade(0x000000, 1, loser);
							}
                        }
                        
                        
                        t3+=FlxG.elapsed;
                        if(t3>1.8){
                                t3=0;
                        }
                        if(t3==0){
                                pico1.x=224;
                                pico2.x=224;
                                pico3.x=387;
                                pico4.x=387;
                        }
                        
                        t4+=FlxG.elapsed;
                        if(t4>3.8){
                                t4=0;
                        }
                        if(t4==0){
                                pico1.x=256;
                                pico2.x=256;
                                pico3.x=352;
                                pico4.x=352;
                        }
                        
                        if(FlxG.overlap(jugador,item)){
							item.kill();
                        	FlxG.fade(0xFFFFFF, 1, winner);
                        }
                        
                        this.movimientoH();
                        this.movimientoV();
                        
                        
                        FlxG.collide(jugador,map);      
                        FlxG.collide(jugador,mapWalls); 
                        FlxG.collide(jugador, box1);
                        FlxG.collide(box1, map);
                        FlxG.collide(box1, mapWalls);
                        FlxG.collide(box1, cientifico);
                        FlxG.collide(cientifico, mapWalls);
                        
                        FlxG.overlap(jugador, plataforma1);
                        FlxG.overlap(jugador, balas);
                        FlxG.overlap(jugador, picos);   
                        jugador.acceleration.y = 1000;
                        plataforma1.y=608; 
						if(jugador.y>537){
							fake.y = jugador.y+60;     
						}
						if(FlxG.keys.pressed("ESCAPE")){
                 FlxG.switchState(new Inicio());
            }
                }
        }
}

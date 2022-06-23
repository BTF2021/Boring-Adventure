package;

import flixel.FlxG;
import flixel.FlxState;
import flixel.FlxSprite;
import flixel.FlxObject;
import flixel.group.FlxSpriteGroup;
import flixel.graphics.FlxGraphic;
import flixel.animation.FlxAnimation;
import flixel.util.FlxColor;
import flixel.util.FlxTimer;
import flixel.ui.FlxBar;
import flixel.text.FlxText;
import flixel.math.FlxMath;
import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;
import flixel.system.FlxSound;

class PlayState extends FlxState
{
    var bg:FlxSprite;

	var cat:FlxSprite;              
	var fesh:FlxSprite;             //Pestele
	var feshsupr:FlxSprite;         //Superul
	var fs:Int = 0;                 //Procentul superului
	var f:Bool = true;              //Pentru Super

	var fenyx:FlxSprite;            //Grifonul LOL

	var fe:Bool = true;               //Pentru peste
	var kell:Bool = true;            //Grifonul e mort sau viu?

	var up:FlxSprite;                 //Controalele up, respectiv down
	var down:FlxSprite;

	var attack:FlxBar;               //Butonul de atac. Acesta reprezinta si cooldown barul
	var shoot:Bool = true;
    var Super:FlxSprite;
    var speed:Float;
	//var lives:FlxText;

	var helthBar:FlxBar;

	var ded:Bool = false;
	var died:FlxText;
	var score:FlxText;           //Textul pentru scor
	var p:Float = 0;             //Scor
	var timer:FlxText;
	var timr:Float = 0;
	var hnum:FlxText;

	var cloud:FlxSprite;
	var cloud2:FlxSprite;
	var cloud3:FlxSprite;
    var skysc:FlxSprite;
	var skysc2:FlxSprite;
	var skysc3:FlxSprite;

	var back:FlxSprite;
    var backText:FlxText;

	override public function create()
	{
		super.create();
		bg = new FlxSprite().makeGraphic(FlxG.width, FlxG.height, FlxColor.CYAN);
		bg.alpha = 1;
		add(bg);

        cloud = new FlxSprite().loadGraphic(AssetPaths.Cloud__png, false, 200, 125);
		cloud.y = FlxG.random.int(25, 45);
		cloud.x = -200;
		//add(cloud);                                                                        Vreau sa fac pisica sa treaca prin nor, deci am mutat linia de cod

		skysc = new FlxSprite().loadGraphic(AssetPaths.Skyscrapper__png, false, 154, 409);
		skysc.y = 720 - 409;
		skysc.x = -200;
		add(skysc);

		skysc2 = new FlxSprite().loadGraphic(AssetPaths.Skyscrapper__png, false, 154, 409);
		skysc2.y = 720 - 409;
		skysc2.x = -200;
		add(skysc2);

		skysc3 = new FlxSprite().loadGraphic(AssetPaths.Skyscrapper__png, false, 154, 409);
		skysc3.y = 720 - 409;
		skysc3.x = -200;
		add(skysc3);

		cloud2 = new FlxSprite().loadGraphic(AssetPaths.Cloud__png, false, 200, 125);
		cloud2.y = FlxG.random.int(25, 45);
		cloud2.x = -200;
		add(cloud2);

		cloud3 = new FlxSprite().loadGraphic(AssetPaths.Cloud__png, false, 200, 125);
		cloud3.y = FlxG.random.int(25, 45);
		cloud3.x = -200;
		add(cloud3);



		cat = new FlxSprite().loadGraphic(AssetPaths.catSheet__png, true, 200, 128);
		cat.animation.add("Flying", [0, 1], 2, true);
		cat.animation.play("Flying");
		cat.x = 5;
		cat.screenCenter(Y);
		cat.health = 5;                                                                       //Viata
		add(cat);

		add(cloud);                                                                           //Arata iesit din peisaj

        fenyx = new FlxSprite().loadGraphic(AssetPaths.FenyxSheet__png, true, 200, 123);
		fenyx.animation.add("Flying", [0, 1], 2,true);
		fenyx.animation.play("Flying");
		add(fenyx);
		fenyx.kill();

		fesh = new FlxSprite().loadGraphic(AssetPaths.Fesh__png, false, 120, 68);
		fesh.x = -500;
		fesh.y = cat.y;
		add(fesh);
		fesh.kill();

		feshsupr = new FlxSprite().loadGraphic(AssetPaths.FeshSchool__png, false, 279, 720);
		feshsupr.x = -500;
		feshsupr.y = 0;
		add(feshsupr);
		feshsupr.kill();

		up = new FlxSprite().loadGraphic(AssetPaths.Up__png, true, 103, 102);
		up.animation.add("Default", [0], 1, false);
		up.animation.add("Pressed", [1], 1, false);
        up.x = 25;
		up.y = Main.gameHeight - 210;//510;
		add(up);

		down = new FlxSprite().loadGraphic(AssetPaths.Down__png, true, 103, 102);
		down.animation.add("Default", [0], 1, false);
		down.animation.add("Pressed", [1], 1, false);
        down.x = 25;
		down.y = Main.gameHeight - 120; //600;
		add(down);

		Super = new FlxSprite().loadGraphic(AssetPaths.SuperButton__png, true, 70, 67);
		Super.animation.add("0", [0], 1, false);
		Super.animation.add("1", [1], 1, false);
		Super.animation.add("2", [2], 1, false);
		Super.animation.add("3", [3], 1, false);
		Super.animation.add("4", [4], 1, false);
		Super.x = Main.gameWidth - 340; //940
		Super.y = Main.gameHeight - 70; //670
		add(Super);

		Super.health = 0;                                        //Nu e viata, e cooldown
		speed = 1.1;

		attack = new FlxBar(Main.gameWidth - 250, Main.gameHeight - 240, TOP_TO_BOTTOM, 250, 248, Super, "health", 0, speed).createImageBar(AssetPaths.Shoot__png, AssetPaths.Shoot0Copy__png);//.loadGraphic(AssetPaths.Shoot__png, false, 250, 248);
        attack.x = Main.gameWidth - 250; //1030
		attack.y = Main.gameHeight - 240; //480
		attack.alpha = 0.7;
		add(attack);

		timer = new FlxText(95, 40);
		timer.size = 20;
		timer.color = 0x000000;
		add(timer);

		helthBar = new FlxBar(100, 20, LEFT_TO_RIGHT, 150, 20, cat, "health", 0, 5).createFilledBar(FlxColor.GRAY, 0xFFE50D0D, true, FlxColor.BLACK);
		helthBar.stopTrackingParent(100, 20);
		add(helthBar);

		hnum = new FlxText(165, 15);
		hnum.size = 20;
		hnum.color = 0x000000;
		add(hnum);

		score = new FlxText(100, 60);
		score.size = 20;
		score.color = 0x000000;
		add(score);

		died = new FlxText();
		died.size = 20;
		died.color = 0x000000;
		add(died);
		died.kill();

		back = new FlxSprite(20, 20).makeGraphic(60, 40, 0xff6689ff);
        add(back);
        backText = new FlxText(40, 19);
        backText.size = 35;
        backText.color = 0xFF000000;
        backText.text = "<";
        add(backText);

		new FlxTimer().start(0.005, GameTimer, 0);
		new FlxTimer().start(0.005, CoolTimer, 0);
	}

	override public function update(elapsed:Float)
	{
		super.update(elapsed);
		helthBar.updateBar();
		hnum.text = Std.string(cat.health);
		timer.text = 'Timp: ' + Std.string(timr);
		score.text = 'Scor: ' + Std.string(p);
		if(up.overlaps(cat) || down.overlaps(cat))         //Butoanele devin transparente
		{
			up.alpha = 0.2;
			down.alpha = 0.2;
		}
		else
		{
			up.alpha = 1;
            down.alpha = 1;
		}

		switch(fs)                                        //Super
	    {
			case 0:
				Super.animation.play("0");
			case 1:
                Super.animation.play("1");
			case 2:
		        Super.animation.play("2");
			case 3:
		        Super.animation.play("3");
			case 4:
		        Super.animation.play("4");
		}
        
		for (touch in FlxG.touches.list)
		{
		    if(touch.pressed)                              //Functia si animatia butoanelor de movement
			{
				if(touch.overlaps(up))
				{
					if (cat.y > 0) cat.y = cat.y - 10;
					up.animation.play("Pressed");
				}
				else if(touch.overlaps(down))
				{
					if (cat.y < 592) cat.y = cat.y + 10;
					down.animation.play("Pressed");
				}
			}
			else
			{
				up.animation.play("Default");
				down.animation.play("Default");
			}	
		
            if(touch.overlaps(attack) && touch.justPressed && shoot && !ded)        //Shoot
		    {
			    shoot = false;
			    //attack.alpha = 0.05;
			    MA();
				Super.health = 1.1;
			    //new FlxTimer().start(Super.health, function(tmr:FlxTimer) 
			    //{
				    //shoot = true;
				    //attack.alpha = 0.7;
			    //}, 1);
		    }

		    if(touch.overlaps(Super) && touch.justPressed && fs == 4 && !ded)       //Super
		    {
               feshSch();
			   fs = 0;
		    }
			if (touch.overlaps(back) && touch.justReleased)
			{
				//FlxG.mouse.visible = true;
				openSubState(new PauseSubState());
				//FlxG.switchState(new PauseSubState());
			}
	   }


		if (cloud.x <= -200)
		{
			cloud.kill();                               //despawn si resuscitarea a norului
			if (FlxG.random.bool(0.5))
			{
				cloud.revive();
				cloud.x = 1600;
				cloud.y = FlxG.random.int(25, 125);
			}
		}
		else
		{
			cloud.x = cloud.x - 8;                       //Movementul pentru nor
		}
		if (cloud2.x <= -200)                           //Acelasi lucru ca si mai sus
		{
			cloud2.kill();
			if (FlxG.random.bool(0.5))
			{
				cloud2.revive();
				cloud2.x = 1600;
				cloud2.y = FlxG.random.int(25, 125);
			}
		}
		else
		{
			cloud2.x = cloud2.x - 8;
		}
		if (cloud3.x <= -200)                           //Acelasi lucru ca si mai sus
		{
			cloud3.kill();
			if (FlxG.random.bool(0.5))
			{
				cloud3.revive();
				cloud3.x = 1600;
				cloud3.y = FlxG.random.int(25, 125);
			}
		}
		else
		{
			cloud3.x = cloud3.x - 8;
		}


		if (skysc.x <= -200)                           //Acelasi lucru ca si mai sus dar pentru zgarienor
		{
			skysc.kill();
			if (FlxG.random.bool(0.5))
			{
				skysc.revive();
				skysc.x = 1600;
				skysc.y = FlxG.random.int(720 - 409, 720 - 204);        
			}
		}
		else
		{
			skysc.x = skysc.x - 8;
		}
		if (skysc2.x <= -200)                           //Acelasi lucru ca si mai sus dar pentru zgarienor
		{
			skysc2.kill();
			if (FlxG.random.bool(0.5))
			{
				skysc2.revive();
				skysc2.x = 1600;
				skysc2.y = FlxG.random.int(720 - 409, 720 - 204);        
			}
		}
		else
		{
			skysc2.x = skysc2.x - 8;
		}
		if (skysc3.x <= -200)                           //Acelasi lucru ca si mai sus dar pentru zgarienor
		{
			skysc3.kill();
			if (FlxG.random.bool(0.5))
			{
				skysc3.revive();
				skysc3.x = 1600;
				skysc3.y = FlxG.random.int(720 - 409, 720 - 204);        
			}
		}
		else
		{
			skysc3.x = skysc3.x - 8;
		}


        if(fesh.isOnScreen() && fe)            //Movementul pentru peste
		{
			fesh.x = fesh.x + Main.gameWidth / (speed + (speed / 60)*40) / 60;
			//fe = true;
		}
		else 
		{
			fesh.kill();
			fesh.x = -500;
			//fe = false;
		}

		if(feshsupr.isOnScreen() && f)            //Movementul pentru Super
		{
			feshsupr.x = feshsupr.x + Main.gameWidth / 60;
			//f = true;
		}
		else 
		{
			feshsupr.kill();
			feshsupr.x = -500;
			//f = false;
		}

		if(kell && !ded)                                      //Chestii generale pentru inamici
		{
            if(FlxG.random.bool(1.2))                            //Apare inamicul
			{
				fenyx.revive();
				fenyx.x = Main.gameWidth - 1;
				fenyx.y = FlxG.random.int(123, 597);
				kell = false;
			}
		}
		else
		{
			if (!ded) fenyx.x = fenyx.x - Main.gameWidth / 2.5 / 60;                       //Movementul pentru inamici. Trebuia sa-l pun ca sa nu mai scada nr de vieti
			if(fesh.overlaps(fenyx) || feshsupr.overlaps(fenyx))                   //Pestele a atins inamicul
			{
                kell = true;
				fenyx.kill();
				fenyx.x = 1280;
				if (fs < 4) fs++;
				p ++;
			} 
			else if (!fesh.overlaps(fenyx) && !ded && !feshsupr.overlaps(fenyx) && fenyx.overlaps(cat) || !fenyx.isOnScreen())     //Inamicul a atins pisica sau a trecut pe langa pisica
			{
				kell = true;
				fenyx.kill();
				fenyx.x = 1280;
				cat.health --;
			}
		}

		if(cat.health <= 0 && !ded)                                                       //Ai murit
		{
			cat.kill();
			up.kill();
			down.kill();
			attack.kill();
			fesh.kill();
			Super.kill();
			ded = true;
			died.revive();
            died.text = "Ai murit. Atinge ecranul sa te joci din nou";
			died.screenCenter();
			fenyx.x = 1240;                                                 //Nu mai scade nr de vieti
			if (p > FlxG.save.data.BestScr)
			{
				FlxG.save.data.BestScr = p;
				FlxG.save.flush();
			}
		}
		for (touch in FlxG.touches.list)
		if(touch.justReleased && ded)                                            //Joaca din nou
		{
				ded = false;
				died.kill();
				cat.revive();
				cat.screenCenter(Y);
			    up.revive();
			    down.revive();
			    attack.revive();
			    Super.revive();
				cat.health = 5;
				fs = 0;
				p = 0;
				timr = 0;
		}
	}
	function MA()                                //Functia pentru butonul de atac
	{
		fesh.revive();
		fesh.y = cat.y + 30;
		fesh.x = 10;
		//fe = true;
	}
	function feshSch()                              //Functia pentru Super
	{
		feshsupr.revive();
		feshsupr.x = 35;
		//f = true;
	}
	function GameTimer(timer:FlxTimer):Void
	{
		if (!ded)
		{
			timr = timr + 0.01;
			var a:Float = (timr / 0.01) % 100;
			Math.fround(a);
			if(a/60 >= 1) timr = timr + 0.40;   //Finally, an accurate stopwatch
			timr = FlxMath.roundDecimal(timr, 2);
		}
	}
	function CoolTimer(timer:FlxTimer):Void
	{
		if (!ded && Super.health > 0.01)
		{
			Super.health = Super.health - 0.01;
			//var b:Float = (Super.health / 0.01) % 100;
			//Math.fround(b);
			//if(b == 0) Super.health = Super.health - 0.40;          
			Super.health = FlxMath.roundDecimal(Super.health, 2);
			trace(Super.health);
		}
		if (Super.health <= 0.01)
		{
			shoot = true;
			//attack.alpha = 0.7;
			Super.health = 0;
		}
	}
}

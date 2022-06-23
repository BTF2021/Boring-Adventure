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
import flixel.text.FlxText;
import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;
import flixel.system.FlxSound;

class PlayState extends FlxState
{
    var bg:FlxSprite;

	var cat:FlxSprite;
	var fesh:FlxSprite;
	var feshsupr:FlxSprite;
	var fs:Int = 0;                 //Procentul superului
	var f:Bool = true;              //Pentru Super

	var fenyx:FlxSprite;

	var fe:Bool = true;               //For peste
	var kell:Bool = true;

	var up:FlxSprite;
	var down:FlxSprite;

	var attack:FlxSprite;
	var shoot:Bool = true;
    var Super:FlxSprite;

	var lives:FlxText;
	var helth:Int = 5;
	var ded:Bool = false;
	var died:FlxText;
	var score:FlxText;
	var p:Float = 0;

	var cloud:FlxSprite;
	var cloud2:FlxSprite;
    var skysc:FlxSprite;
	var skysc2:FlxSprite;

	override public function create()
	{
		super.create();
		bg = new FlxSprite().makeGraphic(FlxG.width, FlxG.height, FlxColor.CYAN);
		bg.alpha = 1;
		add(bg);

        cloud = new FlxSprite().loadGraphic(AssetPaths.Cloud__png, false, 200, 125);
		cloud.y = 25;
		cloud.x = FlxG.random.int(25, 45);
		//add(cloud);                                                                        Vreau sa fac pisica sa treaca prin nor, deci am mutat linia de cod

		skysc = new FlxSprite().loadGraphic(AssetPaths.Skyscrapper__png, false, 154, 409);
		skysc.y = 720 - 409;
		skysc.x = 1600;
		add(skysc);

		skysc2 = new FlxSprite().loadGraphic(AssetPaths.Skyscrapper__png, false, 154, 409);
		skysc2.y = 720 - 409;
		skysc2.x = 1600;
		add(skysc2);

		cloud2 = new FlxSprite().loadGraphic(AssetPaths.Cloud__png, false, 200, 125);
		cloud2.y = FlxG.random.int(25, 45);
		cloud2.x = 1600;
		add(cloud2);



		cat = new FlxSprite().loadGraphic(AssetPaths.cat__png, false, 200, 128);
		cat.x = 5;
		cat.screenCenter(Y);
		add(cat);

		add(cloud);                                                                           //Arata iesit din peisaj

        fenyx = new FlxSprite().loadGraphic(AssetPaths.Fenyx__png, false, 200, 123);
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
		up.y = 510;
		add(up);

		down = new FlxSprite().loadGraphic(AssetPaths.Down__png, true, 103, 102);
		down.animation.add("Default", [0], 1, false);
		down.animation.add("Pressed", [1], 1, false);
        down.x = 25;
		down.y = 600;
		add(down);

        attack = new FlxSprite().loadGraphic(AssetPaths.Shoot__png, false, 250, 248);
        attack.x = 1030;
		attack.y = 480;
		attack.alpha = 0.7;
		add(attack);

		Super = new FlxSprite().loadGraphic(AssetPaths.SuperButton__png, true, 50, 48);
		Super.animation.add("0", [0], 1, false);
		Super.animation.add("1", [1], 1, false);
		Super.animation.add("2", [2], 1, false);
		Super.animation.add("3", [3], 1, false);
		Super.animation.add("4", [4], 1, false);
		Super.x = 940;
		Super.y = 670;
		add(Super);

		lives = new FlxText(25, 0);
		lives.size = 20;
		lives.color = 0x000000;
		add(lives);

		score = new FlxText(25, 20);
		score.size = 20;
		score.color = 0x000000;
		add(score);

		died = new FlxText();
		died.size = 20;
		died.color = 0x000000;
		add(died);

		died.kill();
	}

	override public function update(elapsed:Float)
	{
		super.update(elapsed);
		lives.text = 'Vieti: ' + Std.string(helth);
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
			    attack.alpha = 0.05;
			    MihaiAlexandru();
			    new FlxTimer().start(1.8, function(tmr:FlxTimer) 
			    {
				    shoot = true;
				    attack.alpha = 0.7;
			    }, 1);
		    }

		    if(touch.overlaps(Super) && touch.justPressed && fs == 4 && !ded)       //Super
		    {
               feshSch();
			   fs = 0;
		    }
	   }


		if (cloud.x <= -200)
		{
			cloud.kill();                               //despawn si resuscitarea a norului
			if (FlxG.random.bool(10))
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
			if (FlxG.random.bool(10))
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

		if (skysc.x <= -200)                           //Acelasi lucru ca si mai sus dar pentru zgarienor
		{
			skysc.kill();
			if (FlxG.random.bool(10))
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
			if (FlxG.random.bool(10))
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


        if(fesh.isOnScreen() && fe)            //Movementul pentru peste
		{
			fesh.x = fesh.x + 10;
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
			feshsupr.x = feshsupr.x + 20;
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
				fenyx.x = 1280;
				fenyx.y = FlxG.random.int(123, 597);
				kell = false;
			}
		}
		else
		{
			if (!ded) fenyx.x = fenyx.x - 12;                       //Movementul pentru inamici. Trebuia sa-l pun ca sa nu mai scada nr de vieti
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
				helth --;
			}
		}

		if(helth <= 0 && !ded)                                                       //Ai murit
		{
			cat.kill();
			up.kill();
			down.kill();
			attack.kill();
			Super.kill();
			ded = true;
			died.revive();
            died.text = "Ai murit. Atinge ecranul sa te joci din nou";
			died.screenCenter();
			fenyx.x = 1240;                                                 //Nu mai scade nr de vieti
		}
		for (touch in FlxG.touches.list)
		if(touch.justPressed && ded)                                            //Joaca din nou
		{
				ded = false;
				died.kill();
				cat.revive();
				cat.screenCenter(Y);
			    up.revive();
			    down.revive();
			    attack.revive();
			    Super.revive();
				helth = 5;
				fs = 0;
				p = 0;
		}
	}
	function MihaiAlexandru()                      //Functia pentru butonul de atac
	{
		//Nu, nu este 12, sau p, e...
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
}

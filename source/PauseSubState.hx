package;

import flixel.FlxState;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxSubState;
import flixel.text.FlxText;
import flixel.util.FlxColor;
import flixel.util.FlxTimer;
import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;

class PauseSubState extends FlxSubState
{
    var paused:FlxText;
    var bg:FlxSprite;

	var resume:FlxSprite;
	var resumeText:FlxText;
	var restart:FlxSprite;
	var restartText:FlxText;
	var giveUp:FlxSprite;
	var giveUpText:FlxText;
    var marker:FlxSprite;

    var canBeClicked:Bool = false;
    var n:Float = 0.15;

    override public function create():Void
    {
        super.create();

        bg = new FlxSprite().makeGraphic(FlxG.width, FlxG.height, FlxColor.BLACK);
		bg.alpha = 0;
		add(bg);

        marker = new FlxSprite(500, Main.gameHeight).makeGraphic(290, 150, FlxColor.CYAN);
        add(marker);

        paused = new FlxText(545, -80);
        paused.size = 40;
        paused.color = FlxColor.BLACK;
        paused.text = 'Pauza';
        paused.screenCenter(X);
        add(paused);

        resume = new FlxSprite(500, Main.gameHeight + 130).makeGraphic(270, 130, 0xff6689ff);
        resume.screenCenter(X);
        add(resume);
        resumeText = new FlxText(535, Main.gameHeight + 130);
        resumeText.size = 40;
        resumeText.color = 0xFF000000;
        resumeText.text = "Revenire";
        resumeText.screenCenter(X);
        add(resumeText);

        restart = new FlxSprite(500, Main.gameHeight + 130).makeGraphic(270, 130, 0xff6689ff);
        restart.screenCenter(X);
        add(restart);
        restartText = new FlxText(515, Main.gameHeight + 130);
        restartText.size = 25;
        restartText.color = 0xFF000000;
        restartText.text = "Incearca din nou";
        restartText.screenCenter(X);
        add(restartText);

        giveUp = new FlxSprite(500, Main.gameHeight + 130).makeGraphic(270, 130, 0xff6689ff);
        giveUp.screenCenter(X);
        add(giveUp);
        giveUpText = new FlxText(545, Main.gameHeight + 130);
        giveUpText.size = 40;
        giveUpText.color = 0xFF000000;
        giveUpText.text = "Iesire";
        giveUpText.screenCenter(X);
        add(giveUpText);

        /*FlxTween.angle(paused, paused.angle, -2, 2, {ease: FlxEase.quartInOut});
        new FlxTimer().start(2, function(tmr:FlxTimer)
        {
            if (paused.angle == -2)
                FlxTween.angle(paused, paused.angle, 2, 2, {ease: FlxEase.quartInOut});    //planned to animate the "paused" text, but the game throws out a "Null object reference" error
            else
                FlxTween.angle(paused, paused.angle, -2, 2, {ease: FlxEase.quartInOut});
        }, 0);*/

        transitioning();
    }

    function transitioning()
    {
        new FlxTimer().start(n, function(tmr:FlxTimer)
        {
            FlxTween.tween(paused, {y: 20}, n-0.1, {ease: FlxEase.quartInOut});

            FlxTween.tween(resume, {y: 120}, n-0.1, {ease: FlxEase.quartInOut});
            FlxTween.tween(resumeText, {y: 165}, n-0.1, {ease: FlxEase.quartInOut});
            FlxTween.tween(restart, {y: 260}, n-0.05, {ease: FlxEase.quartInOut});
            FlxTween.tween(restartText, {y: 305}, n-0.05, {ease: FlxEase.quartInOut});
            FlxTween.tween(giveUp, {y: 400}, n, {ease: FlxEase.quartInOut});
            FlxTween.tween(giveUpText, {y: 445}, n, {ease: FlxEase.quartInOut});

            new FlxTimer().start(n, function(tmr:FlxTimer) {canBeClicked = true;}, 1);
        }, 1);
    }

    override public function update(elapsed:Float):Void
    {
        super.update(elapsed);
        #if !mobile
        if(FlxG.mouse.overlaps(resume) && canBeClicked) 
        {
            marker.x = resume.x - 10;
            marker.y = resume.y - 10;
            if(FlxG.mouse.justPressed)
            {
                new FlxTimer().start(n, function(tmr:FlxTimer) 
                {
                    marker.kill();
                    FlxTween.tween(paused, {y: -80}, n-0.1, {ease: FlxEase.quartInOut});

                    FlxTween.tween(resume, {y: Main.gameHeight + 130}, n, {ease: FlxEase.quartInOut});
                    FlxTween.tween(resumeText, {y: Main.gameHeight + 130}, n, {ease: FlxEase.quartInOut});
                    FlxTween.tween(restart, {y: Main.gameHeight + 130}, n-0.05, {ease: FlxEase.quartInOut});
                    FlxTween.tween(restartText, {y: Main.gameHeight + 130}, n-0.05, {ease: FlxEase.quartInOut});
                    FlxTween.tween(giveUp, {y: Main.gameHeight + 130}, n-0.1, {ease: FlxEase.quartInOut});
                    FlxTween.tween(giveUpText, {y: Main.gameHeight + 130}, n-0.1, {ease: FlxEase.quartInOut});

                    new FlxTimer().start(n, function(tmr:FlxTimer) {close();}, 1);
                }, 1);
            }
        }
        if(FlxG.mouse.overlaps(restart) && canBeClicked)
        { 
            marker.x = restart.x - 10;
            marker.y = restart.y - 10;
            if(FlxG.mouse.justPressed) FlxG.switchState(new PlayState());
        }
        if(FlxG.mouse.overlaps(giveUp) && canBeClicked)
        {
            marker.x = giveUp.x - 10;
            marker.y = giveUp.y - 10;
            if(FlxG.mouse.justPressed)
            {
                if (FlxG.save.data.sistemThundMay && FlxG.save.data.sistemInvert)FlxG.save.data.sistemInvert = false;     //Why should Inverted mode and Thunder Mayhem be both activated
                FlxG.save.flush();
                FlxG.switchState(new MainMenuState());
            }
        }
        #else
        for (touch in FlxG.touches.list)
        {
            if(touch.overlaps(resume) && canBeClicked) 
            {
            marker.x = resume.x - 10;
            marker.y = resume.y - 10;
            if(touch.justPressed)
            {
                new FlxTimer().start(0.3, function(tmr:FlxTimer) 
                {
                    marker.kill();
                    FlxTween.tween(paused, {y: -80}, 0.1, {ease: FlxEase.quartInOut});

                    FlxTween.tween(resume, {y: Main.gameHeight + 130}, 0.3, {ease: FlxEase.quartInOut});
                    FlxTween.tween(resumeText, {y: Main.gameHeight + 130}, 0.3, {ease: FlxEase.quartInOut});
                    FlxTween.tween(restart, {y: Main.gameHeight + 130}, 0.2, {ease: FlxEase.quartInOut});
                    FlxTween.tween(restartText, {y: Main.gameHeight + 130}, 0.2, {ease: FlxEase.quartInOut});
                    FlxTween.tween(giveUp, {y: Main.gameHeight + 130}, 0.1, {ease: FlxEase.quartInOut});
                    FlxTween.tween(giveUpText, {y: Main.gameHeight + 130}, 0.1, {ease: FlxEase.quartInOut});

                    new FlxTimer().start(0.15, function(tmr:FlxTimer) {close();}, 1);
                }, 1);
            }
            }
            if(touch.overlaps(restart) && canBeClicked)
            { 
                marker.x = restart.x - 10;
                marker.y = restart.y - 10;
                if(touch.justPressed)
                {
                FlxG.switchState(new PlayState());
                }
            }
            if(touch.overlaps(giveUp) && canBeClicked)
            {
                marker.x = giveUp.x - 10;
                marker.y = giveUp.y - 10;
                if(touch.justPressed)
                {
                    if (FlxG.save.data.sistemThundMay && FlxG.save.data.sistemInvert)FlxG.save.data.sistemInvert = false;     //Why should Inverted mode and Thunder Mayhem be both activated
                    FlxG.save.flush();
                    FlxG.switchState(new TitleState());
                }
            }
        }
        #end
    }
}
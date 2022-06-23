package;

import flixel.FlxState;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.text.FlxText;
import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;
import flixel.system.FlxSound;
import flixel.util.FlxColor;
import flixel.util.FlxTimer;

class MainMenuState extends FlxState
{
    var bg:FlxSprite;
    var play:FlxSprite;
    var char:FlxSprite;
    var shop:FlxSprite;
    var credits:FlxSprite;

    var ver:FlxText;
    var best:FlxText;

    var canBeClicked:Bool = false;

    override public function create():Void
    {
        super.create();
        bg = new FlxSprite().loadGraphic(AssetPaths.MenuBg__png, false, FlxG.width, FlxG.height);
        bg.screenCenter();
        bg.x = bg.x - 50;
        add(bg);

        play = new FlxSprite(0, Main.gameHeight).loadGraphic(AssetPaths.PlayButton__png, true, 173, 88);
        play.screenCenter(X);
        play.animation.add("Defaul", [0], 1, false);
		play.animation.add("Pressed", [1], 1, false);
        add(play);

        char = new FlxSprite(-152).loadGraphic(AssetPaths.CharButton__png, true, 152, 296);
        char.screenCenter(Y);
        char.animation.add("Defaul", [0], 1, false);
		char.animation.add("Pressed", [1], 1, false);
        char.color = 0x7F7F7F;
        add(char);

        shop = new FlxSprite(-146).loadGraphic(AssetPaths.ShopButton__png, true, 146, 104);
        shop.screenCenter(Y);
        shop.y = shop.y + 208;
        shop.animation.add("Defaul", [0], 1, false);
		shop.animation.add("Pressed", [1], 1, false);
        shop.color = 0x7F7F7F;
        add(shop);

        credits = new FlxSprite(Main.gameWidth, Main.gameHeight - 148).loadGraphic(AssetPaths.CreditsButton__png, false, 253, 128);
        credits.color = 0x7F7F7F;
        add(credits);

        ver = new FlxText(20, Main.gameHeight);
        ver.size = 20;
        ver.color = 0xFFFFFFFF;
        ver.text = "Ver " + TitleState.gameVer;
        add(ver);

        best = new FlxText(0, Main.gameHeight);
        best.size = 20;
        best.color = 0xFF000000;
        best.text = "Record: " + Std.string(FlxG.save.data.BestScr);
        best.screenCenter(X);
        add(best);

        transition1();
    }
    function transition1()
    {
        new FlxTimer().start(0.5, function(tmr:FlxTimer)
        {
            //FlxTween.tween(best, {y: Main.gameHeight}, 0.15, {ease: FlxEase.quartInOut});
            FlxTween.tween(ver, {y: Main.gameHeight - 30}, 0.2, {ease: FlxEase.quartInOut});

            FlxTween.tween(play, {y: Main.gameHeight - 130}, 0.1, {ease: FlxEase.quartInOut});
            FlxTween.tween(best, {y: Main.gameHeight - 40}, 0.1, {ease: FlxEase.quartInOut});
            FlxTween.tween(char, {x: 20}, 0.1, {ease: FlxEase.quartInOut});
            FlxTween.tween(shop, {x: 20}, 0.1, {ease: FlxEase.quartInOut});
            FlxTween.tween(credits, {x: Main.gameWidth - 273}, 0.1, {ease: FlxEase.quartInOut});
        }, 1);
        new FlxTimer().start(0.5, function(tmr:FlxTimer) {canBeClicked = true;}, 1);
    }

    override public function update(elapsed:Float):Void
    {
        super.update(elapsed);
        for (touch in FlxG.touches.list)
        {
            if(touch.justPressed && touch.overlaps(play) && canBeClicked)
            {    
                play.animation.play("Pressed");
                new FlxTimer().start(0.001, function(tmr:FlxTimer) {FlxG.switchState(new PlayState());}, 1);
            }
            if(touch.justPressed && touch.overlaps(credits) && canBeClicked)
            {    
                trace("Thanks for showing support. Funny TikTok Person unlocked");
                FlxG.save.data.CharSkin = 4;
                FlxG.save.flush();
            }
        }
    }
}
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

    var CharSelector:FlxSprite;
    var CharText:FlxText;
    var SkinSelector:FlxSprite;
    var SkinText:FlxText;

    var lock:FlxSprite;
    var lock1:FlxSprite;
    var lock2:FlxSprite;
    var lock3:FlxSprite;

    var lock4:FlxSprite;
    var lock5:FlxSprite;
    var lock6:FlxSprite;

    var back:FlxSprite;
    var backText:FlxText;

    var buy:FlxSprite;
    public var buyItem:Int = 0;
    var buyText:FlxText;

    var ver:FlxText;
    var best:FlxText;
    var tab:Int = 0;

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
        play.animation.add("Default", [0], 1, false);
		play.animation.add("Pressed", [1], 1, false);
        add(play);

        char = new FlxSprite(-152).loadGraphic(AssetPaths.CharButton__png, true, 152, 296);
        char.screenCenter(Y);
        char.animation.add("Default", [0], 1, false);
		char.animation.add("Pressed", [1], 1, false);
        add(char);

        shop = new FlxSprite(-146).loadGraphic(AssetPaths.ShopButton__png, true, 146, 104);
        shop.screenCenter(Y);
        shop.y = shop.y + 208;
        shop.animation.add("Default", [0], 1, false);
		shop.animation.add("Pressed", [1], 1, false);
        add(shop);

        credits = new FlxSprite(Main.gameWidth, Main.gameHeight - 148).loadGraphic(AssetPaths.CreditsButton__png, false, 253, 128);
        add(credits);

        CharSelector = new FlxSprite(60, Main.gameHeight).loadGraphic(AssetPaths.CharSelect__png, false, 253, 128);  //100
        add(CharSelector);
        CharText = new FlxText(20, Main.gameHeight);
        CharText.size = 20;
        CharText.color = 0xFF000000;
        CharText.text = "Caractere";
        CharText.x = CharSelector.x + CharSelector.width / 2;
        add(CharText);

        SkinSelector = new FlxSprite(0, Main.gameHeight);
        switch (FlxG.save.data.Characters)
        {
            case 1:
                SkinSelector.loadGraphic(AssetPaths.CatSkinSelect__png, false, 253, 128);
            
        }
        SkinSelector.screenCenter(X);
        SkinSelector.x = SkinSelector.x + 350;
        add(SkinSelector);
        SkinText = new FlxText(20, Main.gameHeight);
        SkinText.size = 20;
        SkinText.color = 0xFF000000;
        SkinText.text = "Skinuri";
        SkinText.x = SkinSelector.x + SkinSelector.width / 2;
        add(SkinText);

        lock = new FlxSprite(CharSelector.x + 130, CharSelector.y).loadGraphic(AssetPaths.Locked__png, false, 130, 130);
        add(lock);
        if (FlxG.save.data.c21 == 1) lock.kill();
        lock1 = new FlxSprite(CharSelector.x + 260, CharSelector.y).loadGraphic(AssetPaths.Locked__png, false, 130, 130);
        add(lock1);
        if (FlxG.save.data.c31 == 1) lock1.kill();
        lock2 = new FlxSprite(CharSelector.x + 390, CharSelector.y).loadGraphic(AssetPaths.Locked__png, false, 130, 130);
        add(lock2);
        if (FlxG.save.data.c41 == 1) lock2.kill();
        lock3 = new FlxSprite(CharSelector.x + 520, CharSelector.y).loadGraphic(AssetPaths.Locked__png, false, 130, 130);
        add(lock3);
        if (FlxG.save.data.c51 == 1) lock3.kill();

        lock4 = new FlxSprite(SkinSelector.x + 130, SkinSelector.y).loadGraphic(AssetPaths.Locked__png, false, 130, 130);
        add(lock4);
        lock5 = new FlxSprite(SkinSelector.x + 260, SkinSelector.y).loadGraphic(AssetPaths.Locked__png, false, 130, 130);
        add(lock5);
        lock6 = new FlxSprite(SkinSelector.x + 390, SkinSelector.y).loadGraphic(AssetPaths.Locked__png, false, 130, 130);
        add(lock6);
        switch (FlxG.save.data.Characters)
        {
            case 1:
                if (FlxG.save.data.s12 == 1) lock4.kill();
		        if (FlxG.save.data.s13 == 1) lock5.kill();
		        if (FlxG.save.data.s14 == 1) lock6.kill();
            case 2:
                if (FlxG.save.data.s22 == 1) lock4.kill();
                if (FlxG.save.data.s23 == 1) lock5.kill();
                if (FlxG.save.data.s24 == 1) lock6.kill();
            case 3:
                if (FlxG.save.data.s32 == 1) lock4.kill();
                if (FlxG.save.data.s33 == 1) lock5.kill();
                if (FlxG.save.data.s34 == 1) lock6.kill();
            case 4:
                if (FlxG.save.data.s42 == 1) lock4.kill();
                if (FlxG.save.data.s43 == 1) lock5.kill();
                if (FlxG.save.data.s44 == 1) lock6.kill();
            case 5:
                if (FlxG.save.data.s52 == 1) lock4.kill();
                if (FlxG.save.data.s53 == 1) lock5.kill();
                if (FlxG.save.data.s54 == 1) lock6.kill();
        }

        buy = new FlxSprite(20, Main.gameHeight - 81).loadGraphic(AssetPaths.BuyButton__png, false, 90, 61);
        buy.screenCenter(X);
        add(buy);
        buy.kill();
        buyText = new FlxText(buy.x, Main.gameHeight);
        buyText.screenCenter(X);
        add(buyText);
        buyText.kill();

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

        back = new FlxSprite(20, 20).makeGraphic(60, 40, 0xff6689ff);
        add(back);
        backText = new FlxText(40, 19);
        backText.size = 35;
        backText.color = 0xFF000000;
        backText.text = "<";
        add(backText);
        back.kill();
        backText.kill();

        transition();
    }
    function transition()
    {
        if (tab == 0)
        {
            new FlxTimer().start(0.1, function(tmr:FlxTimer)
            {
            //FlxTween.tween(best, {y: Main.gameHeight}, 0.15, {ease: FlxEase.quartInOut});
            FlxTween.tween(ver, {y: Main.gameHeight - 30}, 0.2, {ease: FlxEase.quartInOut});

            FlxTween.tween(play, {y: Main.gameHeight - 130}, 0.1, {ease: FlxEase.quartInOut});
            FlxTween.tween(best, {y: Main.gameHeight - 40}, 0.1, {ease: FlxEase.quartInOut});
            FlxTween.tween(char, {x: 20}, 0.1, {ease: FlxEase.quartInOut});
            FlxTween.tween(shop, {x: 20}, 0.1, {ease: FlxEase.quartInOut});
            FlxTween.tween(credits, {x: Main.gameWidth - 273}, 0.1, {ease: FlxEase.quartInOut});
            }, 1);
            new FlxTimer().start(0.1, function(tmr:FlxTimer) {canBeClicked = true;}, 1);
        }
        else if (tab == 1)
        {
            back.revive();
            backText.revive();
            FlxTween.tween(CharSelector, {y: Main.gameHeight - 170}, 0.1, {ease: FlxEase.quartInOut});
            FlxTween.tween(CharText, {y: CharSelector.y - 40}, 0.1, {ease: FlxEase.quartInOut});
            FlxTween.tween(SkinSelector, {y: Main.gameHeight - 170}, 0.1, {ease: FlxEase.quartInOut});
            FlxTween.tween(SkinText, {y: SkinSelector.y - 40}, 0.1, {ease: FlxEase.quartInOut});
        }
    }

    override public function update(elapsed:Float):Void
    {
        super.update(elapsed);
        for (touch in FlxG.touches.list)
        {
            if(touch.justPressed && touch.overlaps(back) && canBeClicked && tab != 0)
            {    
                FlxG.save.data.devChange = false;
                DefaultData.Savestate();
                FlxG.save.flush();
                tab = 0;
                back.kill();
                backText.kill();
                CharSelector.y = Main.gameHeight;
                CharText.y = Main.gameHeight;
                SkinSelector.y = Main.gameHeight;
                SkinText.y = Main.gameHeight;
                buy.kill();
                buyText.kill();
                transition();
            }
            if(touch.justPressed && touch.overlaps(play) && canBeClicked && tab == 0)
            {    
                play.animation.play("Pressed");
                FlxG.save.data.devChange = false;
                DefaultData.Savestate();
                new FlxTimer().start(0.001, function(tmr:FlxTimer) {FlxG.switchState(new PlayState());}, 1);
            }
            if(touch.justPressed && touch.overlaps(credits) && canBeClicked && tab == 0)
            {    
                trace("Thanks for showing support. Funny TikTok Person unlocked");
                FlxG.save.data.s14 = 1;
                FlxG.save.flush();
            }
            if(touch.justPressed && touch.overlaps(char) && canBeClicked && tab == 0)
            {    
                char.animation.play("Pressed");
                FlxG.save.data.devChange = false;
                DefaultData.Savestate();
                tab = 1;
                buyItem = 0;
                play.y = Main.gameHeight;
                play.screenCenter(X);

                char.x = -152;
                char.screenCenter(Y);

                shop.x = -146;
                shop.screenCenter(Y);
                shop.y = shop.y + 208;

                credits.x = Main.gameWidth;
                credits.y = Main.gameHeight - 148;

                best.screenCenter(X);
                best.y = Main.gameHeight;
                new FlxTimer().start(0.001, function(tmr:FlxTimer) {char.animation.play("Default"); transition();}, 1);
            }
            if(touch.justPressed && touch.overlaps(CharSelector) && canBeClicked && tab == 1)
            {    
                FlxG.save.data.devChange = false;
                buy.kill();
                buyText.kill();
                buyItem = 0;
                DefaultData.Savestate();
                if (touch.x >= CharSelector.x && touch.x <= CharSelector.x + 130) 
                {
                    FlxG.save.data.Characters = 1;
                    SkinSelector.loadGraphic(AssetPaths.CatSkinSelect__png, false, 253, 128);
                }
                else if (touch.x >= CharSelector.x + 131 && touch.x <= CharSelector.x + 260) 
                {
                    if (FlxG.save.data.c21 == 1) 
                    {
                        FlxG.save.data.Characters = 2;
                        
                    }
                    else
                    {
                        buyItem = 4;
                        buy.revive();
                        buyText.revive();
                        buyText.text = "100";
                        buyText.screenCenter(X);
                    }
                }
                else if (touch.x >= CharSelector.x + 261 && touch.x <= CharSelector.x + 390)
                {
                    if (FlxG.save.data.c31 == 1)
                    {
                        FlxG.save.data.Characters = 3;
                        
                    }
                    else
                    {
                        buyItem = 8;
                        buy.revive();
                        buyText.revive();
                        buyText.text = "200";
                        buyText.screenCenter(X);
                    }
                }
                else if (touch.x >= CharSelector.x + 391 && touch.x <= CharSelector.x + 520)
                {
                    if (FlxG.save.data.c41 == 1)
                    {
                        FlxG.save.data.Characters = 4;
                        
                    }
                    else
                    {
                        buyItem = 12;
                        buyText.revive();
                        buyText.text = "200";
                        buyText.screenCenter(X);
                        buy.revive();
                    }
                }
                else if (touch.x >= CharSelector.x + 521 && touch.x <= CharSelector.x + 650)
                {
                    if (FlxG.save.data.c51 == 1)
                    {
                        FlxG.save.data.Characters = 5;
                        
                    }
                    else
                    {
                        buyItem = 16;
                        buy.revive();
                        buyText.revive();
                        buyText.text = "250";
                        buyText.screenCenter(X);
                    }
                }
                FlxG.save.flush();
                //trace(FlxG.save.data.Characters);
            }
            if(touch.justPressed && touch.overlaps(SkinSelector) && canBeClicked && tab == 1)
            {    
                FlxG.save.data.devChange = false;
                buy.kill();
                buyText.kill();
                buyItem = 0;
                DefaultData.Savestate();
                if (touch.x >= SkinSelector.x && touch.x <= SkinSelector.x + 130)FlxG.save.data.CharSkin = 1;
                else if (touch.x >= SkinSelector.x + 131 && touch.x <= SkinSelector.x + 260)
                {
                    switch (FlxG.save.data.Characters)
                    {
                        case 1:
                            if (FlxG.save.data.s12 == 1) FlxG.save.data.CharSkin = 2;
                            else
                            {
                                buyItem = 1;
                                buy.revive();
                                buyText.revive();
                                buyText.text = "50";
                                buyText.screenCenter(X);
                            }
                        case 2:
                            if (FlxG.save.data.s22 == 1) FlxG.save.data.CharSkin = 2;
                            else
                            {
                                buyItem = 5;
                                buy.revive();
                                buyText.revive();
                                buyText.text = "50";
                                buyText.screenCenter(X);
                            }
                        case 3:
                            if (FlxG.save.data.s32 == 1) FlxG.save.data.CharSkin = 2;
                            else
                            {
                                buyItem = 9;
                                buy.revive();
                                buyText.revive();
                                buyText.text = "100";
                                buyText.screenCenter(X);
                            }
                        case 4:
                            if (FlxG.save.data.s42== 1) FlxG.save.data.CharSkin = 2;
                            else
                            {
                                buyItem = 13;
                                buy.revive();
                                buyText.revive();
                                buyText.text = "75";
                                buyText.screenCenter(X);
                            }
                        case 5:
                            if (FlxG.save.data.s52 == 1) FlxG.save.data.CharSkin = 2;
                            else
                            {
                                buyItem = 17;
                                buy.revive();
                                buyText.revive();
                                buyText.text = "150";
                                buyText.screenCenter(X);
                            }
                   }
                }
                else if (touch.x >= SkinSelector.x + 261 && touch.x <= SkinSelector.x + 390)
                {
                    switch (FlxG.save.data.Characters)
                    {
                        case 1:
                            if (FlxG.save.data.s13 == 1) FlxG.save.data.CharSkin = 3;
                            else
                            {
                                buyItem = 2;
                                buy.revive();
                                buyText.revive();
                                buyText.text = "75";
                                buyText.screenCenter(X);
                            }
                        case 2:
                            if (FlxG.save.data.s23 == 1) FlxG.save.data.CharSkin = 3;
                            else
                            {
                                buyItem = 6;
                                buy.revive();
                                buyText.revive();
                                buyText.text = "75";
                                buyText.screenCenter(X);
                            }
                        case 3:
                            if (FlxG.save.data.s33 == 1) FlxG.save.data.CharSkin = 3;
                            else
                            {
                                buyItem = 10;
                                buy.revive();
                                buyText.revive();
                                buyText.text = "100";
                                buyText.screenCenter(X);
                            }
                        case 4:
                            if (FlxG.save.data.s43 == 1) FlxG.save.data.CharSkin = 3;
                            else
                            {
                                buyItem = 14;
                                buy.revive();
                                buyText.revive();
                                buyText.text = "100";
                                buyText.screenCenter(X);
                            }
                        case 5:
                            if (FlxG.save.data.s53 == 1) FlxG.save.data.CharSkin = 3;
                            else
                            {
                                buyItem = 18;
                                buy.revive();
                                buyText.revive();
                                buyText.text = "175";
                                buyText.screenCenter(X);
                            }
                    }
                }
                else if (touch.x >= SkinSelector.x + 391 && touch.x <= SkinSelector.x + 520)
                {
                    switch (FlxG.save.data.Characters)
                    {
                        case 1:
                            if (FlxG.save.data.s14 == 1) FlxG.save.data.CharSkin = 4;
                        case 2:
                            if (FlxG.save.data.s24 == 1) FlxG.save.data.CharSkin = 4;
                            else
                            {
                                buyItem = 7;
                                buy.revive();
                                buyText.revive();
                                buyText.text = "100";
                                buyText.screenCenter(X);
                            }
                        case 3:
                            if (FlxG.save.data.s34 == 1) FlxG.save.data.CharSkin = 4;
                            else
                            {
                                buyItem = 11;
                                buy.revive();
                                buyText.revive();
                                buyText.text = "100";
                                buyText.screenCenter(X);
                            }
                        case 4:
                            if (FlxG.save.data.s44 == 1) FlxG.save.data.CharSkin = 4;
                            else
                            {
                                buyItem = 15;
                                buy.revive();
                                buyText.revive();
                                buyText.text = "125";
                                buyText.screenCenter(X);
                            }
                        case 5:
                            if (FlxG.save.data.s54 == 1) FlxG.save.data.CharSkin = 4;
                            else
                            {
                                buyItem = 19;
                                buy.revive();
                                buyText.revive();
                                buyText.text = "250";
                                buyText.screenCenter(X);
                            }
                    }
                }
                FlxG.save.flush();
                //trace(FlxG.save.data.CharSkin);
            }
            if(touch.justPressed && touch.overlaps(buy) && canBeClicked && tab == 1 && buyItem >= 1 && buyItem <= 19)
            {
                FlxG.save.data.devChange = false;
                DefaultData.Savestate();
                switch (buyItem)
                {
                    case 1:
                        if (FlxG.save.data.s12 == 0) FlxG.save.data.s12s = 1;
                        FlxG.save.data.CharSkin = 2;
                        buy.kill();
                        buyText.kill();
                    case 2:
                        if (FlxG.save.data.s13 == 0) FlxG.save.data.s13 = 1;
                        FlxG.save.data.CharSkin = 3;
                        buy.kill();
                        buyText.kill();
                    case 3:
                        if (FlxG.save.data.s14 == 0) FlxG.save.data.s14 = 1;
                        FlxG.save.data.CharSkin = 4;
                        buy.kill();
                        buyText.kill();
                    case 4:
                        if (FlxG.save.data.c21 == 0) FlxG.save.data.c21 = 1;
                        FlxG.save.data.Characters = 2;
                        FlxG.save.data.CharSkin = 2;
                        lock.kill();
                        buy.kill();
                        buyText.kill();
                    case 5:
                        if (FlxG.save.data.s22 == 0) FlxG.save.data.s22 = 1;
                        FlxG.save.data.CharSkin = 2;
                        buy.kill();
                        buyText.kill();
                    case 6:
                        if (FlxG.save.data.s23 == 0) FlxG.save.data.s23 = 1;
                        FlxG.save.data.CharSkin = 3;
                        buy.kill();
                        buyText.kill();
                    case 7:
                        if (FlxG.save.data.s24 == 0) FlxG.save.data.s24 = 1;
                        FlxG.save.data.CharSkin = 4;
                        buy.kill();
                        buyText.kill();
                    case 8:
                        if (FlxG.save.data.c31 == 0) FlxG.save.data.c31 = 1;
                        FlxG.save.data.Characters = 3;
                        FlxG.save.data.CharSkin = 1;
                        lock1.kill();
                        buy.kill();
                        buyText.kill();
                    case 9:
                        if (FlxG.save.data.s32 == 0) FlxG.save.data.s32 = 1;
                        FlxG.save.data.CharSkin = 2;
                        buy.kill();
                        buyText.kill();
                    case 10:
                        if (FlxG.save.data.s33 == 0) FlxG.save.data.s33 = 1;
                        FlxG.save.data.CharSkin = 3;
                        buy.kill();
                        buyText.kill();
                    case 11:
                        if (FlxG.save.data.s34 == 0) FlxG.save.data.s34 = 1;
                        FlxG.save.data.CharSkin = 4;
                        buy.kill();
                        buyText.kill();
                    case 12:
                        if (FlxG.save.data.c41 == 0) FlxG.save.data.c41 = 1;
                        FlxG.save.data.Characters = 4;
                        FlxG.save.data.CharSkin = 1;
                        lock2.kill();
                        buy.kill();
                        buyText.kill();
                    case 13:
                        if (FlxG.save.data.s42 == 0) FlxG.save.data.s42 = 1;
                        FlxG.save.data.CharSkin = 2;
                        buy.kill();
                        buyText.kill();
                    case 14:
                        if (FlxG.save.data.s43 == 0) FlxG.save.data.s43 = 1;
                        FlxG.save.data.CharSkin = 3;
                        buy.kill();
                        buyText.kill();
                    case 15:
                        if (FlxG.save.data.s44 == 0) FlxG.save.data.s44 = 1;
                        FlxG.save.data.CharSkin = 4;
                        buy.kill();
                        buyText.kill();
                    case 16:
                        if (FlxG.save.data.c51 == 0) FlxG.save.data.c51 = 1;
                        FlxG.save.data.Characters = 5;
                        FlxG.save.data.CharSkin = 1;
                        lock3.kill();
                        buy.kill();
                        buyText.kill();
                    case 17:
                        if (FlxG.save.data.s52 == 0) FlxG.save.data.s52 = 1;
                        FlxG.save.data.CharSkin = 2;
                        buy.kill();
                        buyText.kill();
                    case 18:
                        if (FlxG.save.data.s53 == 0) FlxG.save.data.s53 = 1;
                        FlxG.save.data.CharSkin = 3;
                        buy.kill();
                        buyText.kill();
                    case 19:
                        if (FlxG.save.data.s54 == 0) FlxG.save.data.s54 = 1;
                        FlxG.save.data.CharSkin = 4;
                        buy.kill();
                        buyText.kill();
                }
            }
        }
        lock.x = CharSelector.x + 130;
        lock.y = CharSelector.y;

        lock1.x = CharSelector.x + 260;
        lock1.y = CharSelector.y;

        lock2.x = CharSelector.x + 390;
        lock2.y = CharSelector.y;

        lock3.x = CharSelector.x + 520;
        lock3.y = CharSelector.y;

        lock4.x = SkinSelector.x + 130;
        lock4.y = SkinSelector.y;

        lock5.x = SkinSelector.x + 260;
        lock5.y = SkinSelector.y;

        lock6.x = SkinSelector.x + 390; 
        lock6.y = SkinSelector.y;

        switch (FlxG.save.data.Characters)
        {
            case 1:
                if (FlxG.save.data.s12 == 1) lock4.kill();
                else lock4.revive();
		        if (FlxG.save.data.s13 == 1) lock5.kill();
                else lock5.revive();
		        if (FlxG.save.data.s14 == 1) lock6.kill();
                else lock6.revive();
            case 2:
                if (FlxG.save.data.s22 == 1) lock4.kill();
                else lock4.revive();
                if (FlxG.save.data.s23 == 1) lock5.kill();
                else lock5.revive();
                if (FlxG.save.data.s24 == 1) lock6.kill();
                else lock6.revive();
            case 3:
                if (FlxG.save.data.s32 == 1) lock4.kill();
                else lock4.revive();
                if (FlxG.save.data.s33 == 1) lock5.kill();
                else lock5.revive();
                if (FlxG.save.data.s34 == 1) lock6.kill();
                else lock6.revive();
            case 4:
                if (FlxG.save.data.s42 == 1) lock4.kill();
                else lock4.revive();
                if (FlxG.save.data.s43 == 1) lock5.kill();
                else lock5.revive();
                if (FlxG.save.data.s44 == 1) lock6.kill();
                else lock6.revive();
            case 5:
                if (FlxG.save.data.s52 == 1) lock4.kill();
                else lock4.revive();
                if (FlxG.save.data.s53 == 1) lock5.kill();
                else lock5.revive();
                if (FlxG.save.data.s54 == 1) lock6.kill();
                else lock6.revive();
        }
    }
}
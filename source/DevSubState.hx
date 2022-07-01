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

class DevSubState extends FlxSubState
{
    var bg:FlxSprite;
    var bg2:FlxSprite;
    var paused:FlxText;
    var warning:FlxText;

    var noclip:FlxText;
    var ErandomTy:FlxText;
    var EType:FlxText;
    var Supr:FlxText;
    var atk:FlxText;
    var cooldwn:FlxText;
    var pE:FlxText;

    var back:FlxSprite;
    var backText:FlxText;

    override public function create():Void
    {
        super.create();

        bg = new FlxSprite().makeGraphic(FlxG.width, FlxG.height, FlxColor.BLACK);
        bg.alpha = 0.25;
		add(bg);

        bg2 = new FlxSprite().makeGraphic(FlxG.width - 20, FlxG.height - 400, 0xff6689ff);
        bg2.x = bg2.x + 10;
        bg2.y = FlxG.height - 300;
		add(bg2);

        paused = new FlxText(545, 50);
        paused.size = 40;
        paused.color = FlxColor.WHITE;
        paused.text = 'Dev Panel';
        paused.screenCenter(X);
        add(paused);

        warning = new FlxText(545, bg2.y - 45);
        warning.size = 25;
        warning.color = FlxColor.WHITE;
        if (!FlxG.save.data.devChange) warning.text = 'ATENTIE!! Modificarea oricaror valori rezulta in pierderea scorului si a banilor';
        else warning.text = 'Valori modificate. Scor si bani pierduti';
        warning.screenCenter(X);
        add(warning);

        noclip = new FlxText(bg2.x + 10, bg2.y + 50);
        noclip.size = 30;
        if (!FlxG.save.data.NoClip) 
        {
            noclip.color = FlxColor.BLACK;
            noclip.text = 'God mode';
        }
        else 
        {
            noclip.color = FlxColor.RED;
            noclip.text = 'God mode activat';
        }
        noclip.screenCenter(X);
        add(noclip);

        ErandomTy = new FlxText(bg2.x + 10, bg2.y + 90);
        ErandomTy.size = 30;
        if (FlxG.save.data.randomType) 
        {
            ErandomTy.color = FlxColor.BLACK;
            ErandomTy.text = 'Tipul inamicilor:Aleatoriu';
        }
        else
        {
            ErandomTy.color = FlxColor.RED;
            ErandomTy.text = 'Tipul inamicilor:Setat';
        }
        ErandomTy.screenCenter(X);
        add(ErandomTy);

        EType = new FlxText(ErandomTy.x + ErandomTy.width + 20, bg2.y + 90);
        EType.size = 30;
        EType.color = FlxColor.BLACK;
        switch (FlxG.save.data.playEType)
        {
            case 1:
                EType.text = 'mic';
            case 2:
                EType.text = 'mediu';
            case 3:
                EType.text = 'mare';
        }
        add(EType);
        if (FlxG.save.data.randomType) EType.kill();

        Supr = new FlxText(bg2.x + 10, bg2.y + 130);
        Supr.size = 30;
        if (!FlxG.save.data.playSuper) 
        {
            Supr.color = FlxColor.BLACK;
            Supr.text = 'Instant Super';
        }
        else 
        {
            Supr.color = FlxColor.RED;
            Supr.text = 'Instant Super activat';
        }
        Supr.screenCenter(X);
        add(Supr);

        atk = new FlxText(bg2.x + 10, bg2.y + 170);
        atk.size = 30;
        atk.color = FlxColor.BLACK;
        switch (FlxG.save.data.playAtk)
        {
            case 50:
                atk.text = 'Atac: 50';
            case 100:
                atk.text = 'Atac: 100';
            case 150:
                atk.text = 'Atac: 150';
        }
        switch (FlxG.save.data.Characters)
        {
            case 1:
                if (FlxG.save.data.playAtk != 100) atk.color = FlxColor.RED;
            case 2:
                if (FlxG.save.data.playAtk != 50) atk.color = FlxColor.RED;
            case 3:
                if (FlxG.save.data.playAtk != 50) atk.color = FlxColor.RED;
            case 4:
                if (FlxG.save.data.playAtk != 100 && FlxG.save.data.playAtk != 150) atk.color = FlxColor.RED;
            case 5:
                if (FlxG.save.data.playAtk != 50) atk.color = FlxColor.RED;
            
        }
        atk.screenCenter(X);
        add(atk);

        cooldwn = new FlxText(bg2.x + 10, bg2.y + 210);
        cooldwn.size = 30;
        cooldwn.color = FlxColor.BLACK;
        cooldwn.text = 'Cooldown: ' + Std.string(FlxG.save.data.playCool);
        switch (FlxG.save.data.Characters)
        {
            case 1:
                if (FlxG.save.data.playCool != 0.9) atk.color = FlxColor.RED;
            case 2:
                if (FlxG.save.data.playCool != 0.4) atk.color = FlxColor.RED;
            case 3:
                if (FlxG.save.data.playCool != 0.2) atk.color = FlxColor.RED;
            case 4:
                if (FlxG.save.data.playCool != 0.5 && FlxG.save.data.playAtk != 0.2) atk.color = FlxColor.RED;
            case 5:
                if (FlxG.save.data.playCool != 0.7) atk.color = FlxColor.RED;
        }
        cooldwn.screenCenter(X);
        add(cooldwn);

        pE = new FlxText(bg2.x + 10, bg2.y + 250);
        pE.size = 30;
        pE.color = FlxColor.BLACK;
        switch (FlxG.save.data.playEnemy)
        {
            case 1:
                pE.text = 'Sanse grifoni: 1%';
                pE.color = FlxColor.RED;
            case 1.2:
                pE.text = 'Sanse grifoni: Default';
            case 10:
                pE.text = 'Sanse grifoni: 10%';
                pE.color = FlxColor.RED;
            case 25:
                pE.text = 'Sanse grifoni: 25%';
                pE.color = FlxColor.RED;
            case 50:
                pE.text = 'Sanse grifoni: 50%';
                pE.color = FlxColor.RED;
            case 75:
                pE.text = 'Sanse grifoni: 75%';
                pE.color = FlxColor.RED;
            case 100:
                pE.text = 'Sanse grifoni: 100%';
                pE.color = FlxColor.RED;
        }
        pE.screenCenter(X);
        add(pE);

        back = new FlxSprite(bg2.x + 10, bg2.y + 10).makeGraphic(60, 40,FlxColor.CYAN);
        add(back);
        backText = new FlxText(bg2.x + 20, bg2.y + 9);
        backText.size = 35;
        backText.color = 0xFF000000;
        backText.text = "<";
        add(backText);
    }

    override public function update(elapsed:Float):Void
    {
        super.update(elapsed);
        if (FlxG.save.data.devChange)
        {
            warning.text = 'Valori modificate. Scor si bani pierduti';
            warning.screenCenter(X);
        }
        for (touch in FlxG.touches.list)
        {
            if (touch.overlaps(back) && touch.justReleased)
            {
                FlxG.save.flush();
                close();
            }
            if (touch.overlaps(noclip) && touch.justReleased)
            {
                FlxG.save.data.devChange = true;
                FlxG.save.data.NoClip = !FlxG.save.data.NoClip;
                if (!FlxG.save.data.NoClip) 
                {
                    noclip.color = FlxColor.BLACK;
                    noclip.text = 'God mode';
                }
                else 
                {
                    noclip.color = FlxColor.RED;
                    noclip.text = 'God mode activat';
                }
                noclip.screenCenter(X);
            }
            if (touch.overlaps(ErandomTy) && touch.justReleased)
            {
                FlxG.save.data.devChange = true;
                FlxG.save.data.randomType = !FlxG.save.data.randomType;
                if (FlxG.save.data.randomType) 
                {
                    ErandomTy.color = FlxColor.BLACK;
                    ErandomTy.text = 'Tipul inamicilor:Aleatoriu';
                    ErandomTy.screenCenter(X);
                    EType.kill();
                }
                else 
                {
                    ErandomTy.color = FlxColor.RED;
                    ErandomTy.text = 'Tipul inamicilor:Setat';
                    ErandomTy.screenCenter(X);
                    EType.x = ErandomTy.x + ErandomTy.width + 20;
                    EType.y = bg2.y + 90;
                    EType.revive();
                }
            }
            if (touch.overlaps(EType) && touch.justReleased && !FlxG.save.data.randomType)
            {
                FlxG.save.data.devChange = true;
                if (FlxG.save.data.playEType <= 3) FlxG.save.data.playEType ++;
                else FlxG.save.data.playEType = 1;
                switch (FlxG.save.data.playEType)
                {
                    case 1:
                        EType.text = 'mic';
                    case 2:
                        EType.text = 'mediu';
                    case 3:
                        EType.text = 'mare';
                }
            }
            if (touch.overlaps(Supr) && touch.justReleased)
            {
                FlxG.save.data.devChange = true;
                FlxG.save.data.playSuper = !FlxG.save.data.playSuper;
                if (!FlxG.save.data.playSuper) 
                {
                    Supr.color = FlxColor.BLACK;
                    Supr.text = 'Instant Super';
                }
                else 
                {
                    Supr.color = FlxColor.RED;
                    Supr.text = 'Instant Super activat';
                }
                Supr.screenCenter(X);
            }
            if (touch.overlaps(atk) && touch.justReleased)
            {
                FlxG.save.data.devChange = true;
                switch (FlxG.save.data.playAtk)
                {
                    case 50:
                        FlxG.save.data.playAtk = 100;
                        atk.text = 'Atac: 100';
                        atk.screenCenter(X);
                    case 100:
                        FlxG.save.data.playAtk = 150;
                        atk.text = 'Atac: 150';
                        atk.screenCenter(X);
                    case 150:
                        FlxG.save.data.playAtk = 50;
                        atk.text = 'Atac: 50';
                        atk.screenCenter(X);
                }
                atk.color = FlxColor.RED;
            }
            if (touch.overlaps(cooldwn) && touch.justReleased)
            {
                FlxG.save.data.devChange = true;
                if (FlxG.save.data.playCool < 1.2) FlxG.save.data.playCool = FlxG.save.data.playCool + 0.1;
                else FlxG.save.data.playCool = 0.1;
                cooldwn.color = FlxColor.RED;
                cooldwn.text = 'Cooldown: ' + Std.string(FlxG.save.data.playCool);
                cooldwn.screenCenter(X);
            }
            if (touch.overlaps(pE) && touch.justReleased)
            {
                FlxG.save.data.devChange = true;
                pE.color = FlxColor.RED;
                switch (FlxG.save.data.playEnemy)
                {
                    case 1:
                        FlxG.save.data.playEnemy = 1.2;
                        pE.text = 'Sanse grifoni: Default';
                    case 1.2:
                        FlxG.save.data.playEnemy = 10;
                        pE.text = 'Sanse grifoni: 10%';
                    case 10:
                        FlxG.save.data.playEnemy = 25;
                        pE.text = 'Sanse grifoni: 25%';
                    case 25:
                        FlxG.save.data.playEnemy = 50;
                        pE.text = 'Sanse grifoni: 50%';
                    case 50:
                        FlxG.save.data.playEnemy = 75;
                        pE.text = 'Sanse grifoni: 75%';
                    case 75:
                        FlxG.save.data.playEnemy = 100;
                        pE.text = 'Sanse grifoni: 100%';
                    case 100:
                        FlxG.save.data.playEnemy = 1;
                        pE.text = 'Sanse grifoni: 1%';
                }
                pE.screenCenter(X);
            }
        }
    }
}
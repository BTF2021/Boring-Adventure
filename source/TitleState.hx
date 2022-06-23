package;

import flixel.FlxG;
import flixel.FlxState;
import flixel.FlxSprite;
import flixel.text.FlxText;
import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;
import flixel.system.FlxSound;
import flixel.util.FlxColor;
import flixel.util.FlxTimer;

class TitleState extends FlxState
{
    var bg:FlxSprite;
    var me:FlxText;
    var title:FlxText;
    var press:FlxText;
    var best:FlxText;

    public static var gameVer:String = "0.1.0";
    var ver:FlxText;

    override public function create()
    {
        super.create();

        DefaultData.Savestate();

        bg = new FlxSprite().makeGraphic(FlxG.width, FlxG.height, FlxColor.CYAN);
        bg.screenCenter();
        add(bg);

        me = new FlxText(0, Main.gameHeight - 80);
        me.size = 40;
        me.color = 0xFF000000;
        me.text = 'Ceva creat de BTF si Vulturul_Plesuv';
        me.screenCenter(X);
        add(me);

        title = new FlxText(0, 20);
        title.size = 40;
        title.color = 0xFF000000;
        title.text = 'Boring adventure';
        title.screenCenter(X);
        add(title);

        press = new FlxText(0, 360);
        press.size = 40;
        press.color = 0xFF000000;
        press.text = 'Atinge ecranul sa te joci';
        press.screenCenter(X);
        add(press);

        best = new FlxText(0, 400);
        best.size = 40;
        best.color = 0xFF000000;
        best.text = "Record: " + Std.string(FlxG.save.data.BestScr);
        best.screenCenter(X);
        add(best);

        ver = new FlxText(20, 690);
        ver.size = 20;
        ver.color = 0xFF000000;
        ver.text = "Ver " + gameVer;
        add(ver);

        FlxTween.angle(me, me.angle, -2, 2, {ease: FlxEase.quartInOut});
        FlxTween.angle(title, title.angle, -2, 2, {ease: FlxEase.quartInOut});
        FlxTween.angle(press, press.angle, -2, 2, {ease: FlxEase.quartInOut});
        FlxTween.angle(best, best.angle, -2, 2, {ease: FlxEase.quartInOut});

        new FlxTimer().start(2, function(tmr:FlxTimer)
        {
            if (me.angle == -1)
                FlxTween.angle(me, me.angle, 1, 2, {ease: FlxEase.quartInOut});
            else
                FlxTween.angle(me, me.angle, -1, 2, {ease: FlxEase.quartInOut});
        }, 0);
        new FlxTimer().start(2, function(tmr:FlxTimer)
        {
            if (title.angle == -1)
                FlxTween.angle(title, title.angle, 1, 2, {ease: FlxEase.quartInOut});
            else
                FlxTween.angle(title, title.angle, -1, 2, {ease: FlxEase.quartInOut});
        }, 0);
        new FlxTimer().start(2, function(tmr:FlxTimer)
        {
            if (press.angle == -1)
                FlxTween.angle(press, press.angle, 1, 2, {ease: FlxEase.quartInOut});
            else
                FlxTween.angle(press, press.angle, -1, 2, {ease: FlxEase.quartInOut});
        }, 0);
        new FlxTimer().start(2, function(tmr:FlxTimer)
        {
            if (best.angle == -1)
                FlxTween.angle(best, best.angle, 1, 2, {ease: FlxEase.quartInOut});
            else
                FlxTween.angle(best, best.angle, -1, 2, {ease: FlxEase.quartInOut});
        }, 0);

    }
    override public function update(elapsed:Float)
    {
        super.update(elapsed);
        for (touch in FlxG.touches.list)
        {
            if (touch.justPressed)
            { 
                if(!touch.overlaps(title))
                {
                    me.y = Main.gameHeight - 80; //640;
                    title.y = 40;
                    press.y = 360;
                    FlxG.switchState(new PlayState());
                }
                else if (touch.overlaps(title))
                {
                    title.text = 'Super pisica';
                    title.screenCenter(X);
                }
            }
        }
    }
}
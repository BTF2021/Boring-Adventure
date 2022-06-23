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

    override public function create()
    {
        super.create();

        bg = new FlxSprite().makeGraphic(FlxG.width, FlxG.height, FlxColor.CYAN);
        bg.screenCenter();
        add(bg);

        me = new FlxText(0, 760);
        me.size = 40;
        me.color = 0xFF000000;
        me.y = 660;
        me.text = 'Ceva creat de Bogdan si Iosif';
        me.screenCenter(X);
        add(me);

        title = new FlxText(0, -80);
        title.size = 40;
        title.color = 0xFF000000;
        title.y = 20;
        title.text = 'Super pisica';
        title.screenCenter(X);
        add(title);

        press = new FlxText(0, 760);
        press.size = 40;
        press.color = 0xFF000000;
        press.y = 360;
        press.text = 'Atinge sa te joci';
        press.screenCenter(X);
        add(press);

        FlxTween.angle(me, me.angle, -2, 2, {ease: FlxEase.quartInOut});
        FlxTween.angle(title, title.angle, -2, 2, {ease: FlxEase.quartInOut});
        FlxTween.angle(press, press.angle, -2, 2, {ease: FlxEase.quartInOut});

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

    }
    override public function update(elapsed:Float)
    {
        super.update(elapsed);
        for (touch in FlxG.touches.list)
        {
            if (touch.justPressed)
            { 
                if(!touch.overlaps(title) && !touch.overlaps(me))
                {
                    me.y = 640;
                    title.y = 40;
                    press.y = 360;
                    FlxG.switchState(new PlayState());
                }
                else if (touch.overlaps(title))
                {
                    title.text = 'Boring Adventure';
                    title.screenCenter(X);
                }
                else if (touch.overlaps(me)) me.text = 'Ceva creat de BTF si Vulturul_Plesuv';
            }
        }
    }
}
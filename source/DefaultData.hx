import openfl.Lib;
import flixel.FlxG;

class DefaultData
{
	public static function Savestate()               //Pentru uz mai tarziu
	{
		if (FlxG.save.data.BestScr == null) FlxG.save.data.BestScr = 0;

		if (FlxG.save.data.Characters == null && FlxG.save.data.Characters <= 0 && FlxG.save.data.Characters >= 6) FlxG.save.data.Characters = 1;
		if (FlxG.save.data.CharSkin == null) FlxG.save.data.CharSkin = 1;

        if (FlxG.save.data.devChange == null) FlxG.save.data.devChange = false;
		if (FlxG.save.data.NoClip == null) FlxG.save.data.NoClip = false;
		if (FlxG.save.data.randomType == null) FlxG.save.data.randomType = true;
		if (FlxG.save.data.playEType == null) FlxG.save.data.playEType = 2;
		if (FlxG.save.data.playSuper == null) FlxG.save.data.playSuper = false;
		if (FlxG.save.data.playAtk == null) FlxG.save.data.playAtk = 50;
		if (FlxG.save.data.playCool == null) FlxG.save.data.playCool = 1;
		if (FlxG.save.data.playEnemy == null) FlxG.save.data.playEnemy = 1.2;


		if (FlxG.save.data.s12 == null) FlxG.save.data.s12 = 0;
		if (FlxG.save.data.s13 == null) FlxG.save.data.s13 = 0;
		if (FlxG.save.data.s14 == null) FlxG.save.data.s14 = 0;

		if (FlxG.save.data.c21 == null) FlxG.save.data.c21 = 0;
 		if (FlxG.save.data.s22 == null) FlxG.save.data.s22 = 0;
		if (FlxG.save.data.s23 == null) FlxG.save.data.s23 = 0;
		if (FlxG.save.data.s24 == null) FlxG.save.data.s24 = 0;
		
		if (FlxG.save.data.c31 == null) FlxG.save.data.c31 = 0;
		if (FlxG.save.data.s32 == null) FlxG.save.data.s32 = 0;
		if (FlxG.save.data.s33 == null) FlxG.save.data.s33 = 0;
		if (FlxG.save.data.s34 == null) FlxG.save.data.s34 = 0;

		if (FlxG.save.data.c41 == null) FlxG.save.data.c41 = 0;
		if (FlxG.save.data.s42 == null) FlxG.save.data.s42 = 0;
		if (FlxG.save.data.s43 == null) FlxG.save.data.s43 = 0;
		if (FlxG.save.data.s44 == null) FlxG.save.data.s44 = 0;

		if (FlxG.save.data.c51 == null) FlxG.save.data.c51 = 0;
		if (FlxG.save.data.s52 == null) FlxG.save.data.s52 = 0;
		if (FlxG.save.data.s53 == null) FlxG.save.data.s53 = 0;
		if (FlxG.save.data.s54 == null) FlxG.save.data.s54 = 0;
	}
}
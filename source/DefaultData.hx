import openfl.Lib;
import flixel.FlxG;

class DefaultData
{
	public static function Savestate()               //Pentru uz mai tarziu
	{
		if (FlxG.save.data.BestScr == null) FlxG.save.data.BestScr = 0;
		if (FlxG.save.data.Characters == null) FlxG.save.data.Characters = 1;
		if (FlxG.save.data.CharSkin == null) FlxG.save.data.CharSkin = 1;
	}
}
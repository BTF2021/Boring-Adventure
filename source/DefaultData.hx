import openfl.Lib;
import flixel.FlxG;

class DefaultData
{
	public static function Savestate()               //for later use
	{
		if (FlxG.save.data.BestScr == null) FlxG.save.data.BestScr = 0;
	}
}
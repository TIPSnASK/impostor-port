// nuts!
import flixel.ui.FlxBar;
import flixel.text.FlxText;
import flixel.text.FlxTextAlign;
import flixel.text.FlxTextBorderStyle;
import flixel.group.FlxTypedSpriteGroup;

static var timerGroup:FlxTypedSpriteGroup;
var timeTxt:FlxText;
var timeBarBG:FlxSprite;
var timeBar:FlxBar;

function create() {
        timerGroup = new FlxTypedSpriteGroup();

        timeTxt = new FlxText(42 + (FlxG.width / 2) - 585, 20, 400, PlayState.SONG.meta.displayName.toUpperCase(), 32);
        timeTxt.setFormat(Paths.font("vcr.ttf"), 14, 0xFFFFFFFF, FlxTextAlign.LEFT, FlxTextBorderStyle.OUTLINE, 0xFF000000);
        timeTxt.borderSize = 1;
        timeBarBG = new FlxSprite().loadGraphic(Paths.image('ui/timeBar'));
        timeBarBG.setPosition(timeTxt.x, timeTxt.y + (timeTxt.height / 4));
        timerGroup.add(timeBarBG);
        
        timeBar = new FlxBar(timeBarBG.x + 4, timeBarBG.y + 4, FlxTextAlign.LEFT_TO_RIGHT, Std.int(timeBarBG.width - 8), Std.int(timeBarBG.height - 8), this, '', 0, 1);
        timeBar.createFilledBar(0xFF2e412e, 0xFF44d844);
        timeBar.numDivisions = 1200;
        timerGroup.add(timeBar);
        timeTxt.x += 5;
        timeTxt.y += 6;
        timerGroup.add(timeTxt);
        timerGroup.cameras = [camHUD];
        add(timerGroup);
}

function postUpdate() {
    if (curStep > 0) timeBar.percent = (FlxG.sound.music.time / FlxG.sound.music.length) * 100;
}
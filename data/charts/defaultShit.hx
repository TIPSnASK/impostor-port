// boobies
import flixel.text.FlxTextBorderStyle;
import openfl.utils.Assets;

// function create() splashOffsets = [45, downscroll ? 0 : 25];
function onSongStart() {
	var camInfo:FlxCamera = new FlxCamera();
	camInfo.bgColor = 0x00000000;
	FlxG.cameras.add(camInfo, false);
	var info = Assets.getText(Paths.file('songs/' + PlayState.SONG.meta.name + '/info.txt')).split("\n");

	var bg:FlxSprite = new FlxSprite(-475, FlxG.height / 3).makeGraphic(475, 100, 0x46FFFFFF);
	var songTXT:FlxText = new FlxText(-465, bg.y + 10, 0, info[0], 25);
	var musicianTXT:FlxText = new FlxText(-465, bg.y + bg.height - 45, 0, info[1], 25);

	for (i in [songTXT, musicianTXT]) {
		i.borderStyle = FlxTextBorderStyle.OUTLINE;
		i.borderColor = 0xFF000000;
		i.borderSize = 2;
	}

	for (i in [bg, songTXT, musicianTXT]) {
		i.cameras = [camInfo];
		add(i);
	}

	for (i in [bg, songTXT, musicianTXT]) FlxTween.tween(i, {x: i.x + 475}, 2, {ease: FlxEase.quintOut, onComplete: function() FlxTween.tween(i, {x: i.x - 475}, 1, {ease: FlxEase.quintIn, startDelay: 2}).onComplete = function() remove(i)});
}
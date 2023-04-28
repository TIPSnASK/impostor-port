// shut up vsc

import funkin.game.cutscenes.MP4Handler;
import funkin.backend.assets.ModsFolder;

var cutsceneCamera:FlxCamera;
function create() {
	FlxG.camera.alpha = 0.001;
	camHUD.alpha = 0.001;
	canPause = false;

	cutsceneCamera = new FlxCamera();
	cutsceneCamera.bgColor = 0;
	FlxG.cameras.add(cutsceneCamera, false);

	preloadVideo = new MP4Handler();
	preloadVideo.canvasWidth = cutsceneCamera.width;
	preloadVideo.canvasHeight = cutsceneCamera.height;

	video = new MP4Handler();
	video.canvasWidth = cutsceneCamera.width;
	video.canvasHeight = cutsceneCamera.height;

	videoSprite = new FlxSprite();
	videoSprite.cameras = [cutsceneCamera];
	videoSprite.antialiasing = true;
	add(videoSprite);
	videoSprite.alpha = 0.001;
	preloadVideo.playMP4('mods/' + ModsFolder.currentModFolder + '/videos/ingame/ejected.mp4', false, videoSprite, false, false, true);
}

function postCreate() {
	camOverlay.alpha = 0.001;
}

function onSongStart() {
	video.playMP4('mods/' + ModsFolder.currentModFolder + '/videos/ingame/ejected.mp4', false, videoSprite, false, false, true);
	video.skippable = false;
	videoSprite.alpha = 1;
}

function stepHit() {
	switch(curStep) {
		case 256:
			canPause = true;
			videoSprite.alpha = 0.001;
			cutsceneCamera.alpha = 0.001;
			FlxG.camera.alpha = 1;
			camHUD.alpha = 1;
			camOverlay.alpha = 1;
			if (FlxG.save.data.flashingLights) camOverlay.flash();
		case 2816:
			if (FlxG.save.data.flashingLights) camOverlay.flash();
			camOverlay.fade(0xFF000000, 4);
			FlxTween.tween(dad, {y: dad.y + 500}, 4, {ease: FlxEase.quintIn});
			FlxTween.tween(gf, {y: gf.y + 500}, 4, {ease: FlxEase.quintIn});
			FlxTween.tween(boyfriend, {y: boyfriend.y + 500}, 4, {ease: FlxEase.quintIn});
	}
}
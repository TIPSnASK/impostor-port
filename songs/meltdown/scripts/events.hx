// shut up vsc

import funkin.game.cutscenes.MP4Handler;
import funkin.backend.assets.ModsFolder;

var cutsceneCamera:FlxCamera;
function create() {
    cutsceneCamera = new FlxCamera();
    cutsceneCamera.bgColor = 0;
    FlxG.cameras.add(cutsceneCamera, false);

    video = new MP4Handler();
    video.canvasWidth = cutsceneCamera.width;
    video.canvasHeight = cutsceneCamera.height;

    videoSprite = new FlxSprite();
    videoSprite.cameras = [cutsceneCamera];
    videoSprite.antialiasing = true;
    add(videoSprite);
    // load the video on create instead of having it load at the end of meltdown
    videoSprite.alpha = 0.001;
    video.skippable = false;
    video.playMP4('mods/' + ModsFolder.currentModFolder + '/videos/ingame/meltdown.mp4', false, videoSprite, false, false, true);
}

function onSongStart() flash();
function beatHit() {
    if (curBeat % 8 == 0) {
        if (curBeat >= 1 && curBeat <= 24) flash();
        if (curBeat >= 136 && curBeat <= 184) flash();
        if (curBeat >= 264 && curBeat <= 288) flash();
    }

    if (curBeat % 4 == 0) {
        if (curBeat >= 32 && curBeat <= 128) flash();
        if (curBeat >= 192 && curBeat <= 256) flash();
    }

    if (curBeat == 289) {
        video.playMP4('mods/' + ModsFolder.currentModFolder + '/videos/ingame/meltdown.mp4', false, videoSprite, false, false, true);
        videoSprite.alpha = 1;
        video.finishCallback = function() {
            cutsceneCamera.visible = false;
            camGame.visible = false;
            camHUD.visible = false;
            camOverlay.visible = false;
        };
    }
}

function flash() {
    if (FlxG.save.data.flashingLights) FlxG.camera.flash(0x55FF0000, 0.4, null, true);
    FlxG.camera.zoom += 0.015;
    camHUD.zoom += 0.03;
}
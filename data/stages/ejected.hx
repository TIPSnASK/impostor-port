// uhh a lot of shit, this is a hx job i think? instead of xml yk

import flixel.addons.display.FlxBackdrop;

// var cloudScroll:FlxTypedGroup;
// var farClouds:FlxTypedGroup;
// var middleBuildings:Array<FlxSprite>;
// var rightBuildings:Array<FlxSprite>;
// var leftBuildings:Array<FlxSprite>;
var fgCloud:FlxSprite;
var speedLines:FlxBackdrop;
var imNotFuckingDoingThat:Float = 1325;

function create() {
    FlxG.camera.angleFix = true;
    camHUD.angleFix = true;
    bfCam = [imNotFuckingDoingThat + 750, 550];
    dadCam = [imNotFuckingDoingThat + 0, 550];
    defaultCamZoom = 0.45;
    boyfriend.setPosition(imNotFuckingDoingThat + 1008.6, 100);
    gf.setPosition(imNotFuckingDoingThat + 114.4, 78.45);
    dad.setPosition(imNotFuckingDoingThat + -775.75, 274.3);
    gf.scrollFactor.set(0.7, 0.7);

    if (!FlxG.save.data.lowQuality) {
        var sky:FlxSprite = new FlxSprite(-2372.25, -4181.7).loadGraphic(Paths.image('stages/ejected/sky'));
        sky.antialiasing = true;
        sky.updateHitbox();
        sky.scrollFactor.set(0, 0);
        add(sky);

        fgCloud = new FlxSprite(-2660.4, 0).loadGraphic(Paths.image('stages/ejected/fgClouds'));
        fgCloud.antialiasing = true;
        fgCloud.updateHitbox();
        fgCloud.scrollFactor.set(0.2, 0.2);
        fgCloud.velocity.y = -5;
        add(fgCloud);

        var buildings:FlxSprite = new FlxSprite();
        buildings.frames = Paths.getSparrowAtlas('stages/ejected/ejectedbuildings');
        buildings.animation.addByPrefix('idle', 'ejectedshit', 24, true);
        buildings.animation.play('idle');
        buildings.scale.set(6, 6);
        buildings.updateHitbox();
        buildings.scrollFactor.set(0.5, 0.5);
        buildings.screenCenter();
        buildings.x += 500;
        buildings.y += 500;
        add(buildings);

        speedLines = new FlxBackdrop(Paths.image('stages/ejected/speedLines'));
        speedLines.antialiasing = true;
        speedLines.updateHitbox();
        speedLines.scrollFactor.set(1.3, 1.3);
        speedLines.alpha = 0.3;
        speedLines.velocity.y = -9000;
    } else {
        var sky:FlxSprite = new FlxSprite(-2372.25, -3000).loadGraphic(Paths.image('lowquality/stages/ejected/sky'));
        sky.antialiasing = true;
        sky.updateHitbox();
        sky.scrollFactor.set(0.05, 0.05);
        sky.velocity.y = -10;
        add(sky);

        var buildings:FlxBackdrop = new FlxBackdrop(Paths.image('lowquality/stages/ejected/buildings'), 0x10, 0, -1500);
        buildings.scale.set(6, 6);
        buildings.updateHitbox();
        buildings.scrollFactor.set(0.5, 0.5);
        buildings.screenCenter();
        buildings.x += 1250;
        add(buildings);
        buildings.velocity.y = -10000000000;
    }
}

function postCreate() {
    if (!FlxG.save.data.lowQuality) {
        add(speedLines);

        if (FlxG.save.data.ambients) {
            var overlay1:FlxSprite = new FlxSprite().loadGraphic(Paths.image('stages/ejected/overlay'));
            overlay1.alpha = 0.25;
            overlay1.blend = 0;
            overlay1.cameras = [camOverlay];
            add(overlay1);
            overlay1.velocity.y = -5;

            var overlay2:FlxSprite = new FlxSprite(0, 1440).loadGraphic(Paths.image('stages/ejected/overlay'));
            overlay2.color = 0xFF000000;
            overlay2.flipY = true;
            overlay2.blend = 9;
            overlay2.cameras = [camOverlay];
            add(overlay2);
            overlay2.velocity.y = -7.5;
        }
    }
}

function postUpdate(elapsed:Float) {
    if (curSection != null)
        defaultCamZoom = curSection.mustHitSection ? 0.75 : 0.45;

    FlxG.camera.shake(0.0025, 0.1);
    camHUD.shake(0.0025, 0.1);
    camHUD.y = Math.sin((Conductor.songPosition / 1000) * (Conductor.bpm / 60) * 1.0) * 15;
    camHUD.angle = Math.sin((Conductor.songPosition / 1200) * (Conductor.bpm / 60) * -1.0) * 1.2;
    FlxG.camera.angle = -Math.sin((Conductor.songPosition / 1200) * (Conductor.bpm / 60) * -1.0) * 0.75;
}

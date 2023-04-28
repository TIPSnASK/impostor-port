// shut up vsc

import flixel.input.mouse.FlxMouseEventManager;

function create() {
    if (FlxG.save.data.lowQuality == true) {
        for (object in stage.stageSprites) {
            object.kill();
            object.destroy();
            remove(object);
        }
        var back:FlxSprite = new FlxSprite(-1150, -935).loadGraphic(Paths.image('lowquality/stages/airship/back'));
        back.scale.set(3, 3);
        back.updateHitbox();
        insert(members.indexOf(gf), back);
    }
}

function postCreate() {
    bg8.blend = 0;

    if (PlayState.SONG.meta.name == 'oversight') henry.visible = false;
}

function henryTeleport() {
    trace("diknbalz");
}
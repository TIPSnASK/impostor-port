// boobzzz

function create() {
    if (FlxG.save.data.lowQuality == true) {
        for (object in stage.stageSprites) {
            object.kill();
            object.destroy();
            remove(object);
        }
        var back:FlxSprite = new FlxSprite(-500, 58).loadGraphic(Paths.image('lowquality/stages/mira/back'));
        back.scale.set(2.5, 2.5);
        back.updateHitbox();
        insert(members.indexOf(gf), back);
    }
}
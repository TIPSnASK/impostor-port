// boobies

var front:FlxSprite;

function create() {
    if (FlxG.save.data.lowQuality == true) {
        for (object in stage.stageSprites) {
            object.kill();
            object.destroy();
            remove(object);
        }
        var back:FlxSprite = new FlxSprite(-1030, -825).loadGraphic(Paths.image('lowquality/stages/polus/back'));
        back.scale.set(2.5, 2.5);
        back.updateHitbox();
        insert(members.indexOf(gf), back);
    }
    
    if (PlayState.SONG.meta.name == 'sabotage' || PlayState.SONG.meta.name == 'meltdown') {
        speaker.visible = true;
        gf.alpha = 0.001;
    }
    
    if (PlayState.SONG.meta.name == 'meltdown') {
        gf.alpha = 1;
        for (i in [bfdead, crowd2])
            i.visible = true;
    }
}

function postCreate() {
    if (PlayState.SONG.meta.name == 'meltdown' && FlxG.save.data.lowQuality) {
        front = new FlxSprite(-900, 150).loadGraphic(Paths.image('lowquality/stages/polus/front'));
        front.scrollFactor.set(1.5, 1.5);
        add(front);
    }

    if (!FlxG.save.data.lowQuality && FlxG.save.data.ambients) {
        var overlay1:FlxSprite = new FlxSprite().makeGraphic(1280, 720, 0xFFA200FF);
        overlay1.alpha = 0.1;
        overlay1.blend = 0;
        overlay1.cameras = [camOverlay];
        add(overlay1);
    }
}

function beatHit() {
    if (PlayState.SONG.meta.name == 'meltdown' && FlxG.save.data.lowQuality) {
        FlxTween.cancelTweensOf(front, "y");
        front.y = 175;
        FlxTween.tween(front, {y: 150}, 0.75, {ease: FlxEase.quintOut});
    }
}
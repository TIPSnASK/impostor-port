// swordcube more like goated coder, fixed some shit tho

var bubblyBitch:FlxSprite;
var greenFuck:Character;
var boyFuck:Character;

var ldSpeaker:FlxSprite;
var bfvent:FlxSprite;

function postCreate() {
    ldSpeaker = stage.getSprite("ldSpeaker");
    bfvent = stage.getSprite("bfvent");

    bubblyBitch = new FlxSprite(-300, -150).makeGraphic(FlxG.width * 2, FlxG.height * 2, 0xFF000000);
    greenFuck = new Character(dad.x, dad.y, "blackpostor");
    boyFuck = new Character(boyfriend.x, boyfriend.y, "whitebf", true);

    for (i in [bubblyBitch, greenFuck, boyFuck]) {
        i.alpha = 0.001;
        add(i);
    }
}

function stepHit(step) {
    switch(step) {
        case 512, 768, 800, 816, 832, 1104, 1136, 1168, 1188, 1196, 1208, 1440: // lights on
            for (i in [bubblyBitch, greenFuck, boyFuck]) FlxTween.tween(i, {alpha: 0.001}, 0.5, {ease: FlxEase.cubeOut});

        case 256, 640, 784, 808, 1088, 1120, 1152, 1184, 1192, 1200, 1216, 1472: // lights off 👻
            if (FlxG.save.data.flashingLights)
                FlxG.camera.flash(0xFFFFFFFF, 0.5);
            
            bubblyBitch.alpha = 1;
            for (i in [greenFuck, boyFuck]) FlxTween.tween(i, {alpha: 1}, 0.5, {ease: FlxEase.cubeOut});

        case 1600:
            for (i in [bubblyBitch, greenFuck, boyFuck, camHUD, boyfriend, gf]) i.visible = false;
            
            if (!Options.lowMemoryMode) {
                ldSpeaker.animation.play("boom", true);
                bfvent.animation.play("vent", true);
                for (i in [ldSpeaker, bfvent]) i.alpha = 1;
            }

            dad.playAnim("liveReaction", true);

        case 1632: 
            camGame.visible = false;
    }
}

var anims = ["singLEFT", "singDOWN", "singUP", "singRIGHT"];

function onDadHit(event:NoteHitEvent) {
    if (!PlayState.opponentMode) (event.note.strumTime >= 141176) ? event.cancel() : greenFuck.playAnim(anims[event.note.noteData], true);
    else boyFuck.playAnim(anims[event.note.noteData], true);
}

function onPlayerHit(event:NoteHitEvent) {
    if (!PlayState.opponentMode) boyFuck.playAnim(anims[event.note.noteData], true);
    else (event.note.strumTime >= 141176) ? event.cancel() : greenFuck.playAnim(anims[event.note.noteData], true);
}
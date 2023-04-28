function beatHit() {
    switch (curBeat) {
        case 144, 384: flash();
        case 204:
            dad.playAnim('hey', true, "LOCK");
            gf.playAnim('scared', true);
            gf.alpha = 1;
    }

    if (curBeat % 8 == 0) {
        if (curBeat >= 16 && curBeat <= 128) flash();
        if (curBeat >= 160 && curBeat <= 184) flash();
        if (curBeat >= 208 && curBeat <= 368) flash();
    }
}

function flash() {
    if (FlxG.save.data.flashingLights) {
        FlxG.camera.flash(0x55FF0000, 0.4, null, true);
        FlxG.camera.zoom += 0.015;
        camHUD.zoom += 0.03;
    }
}
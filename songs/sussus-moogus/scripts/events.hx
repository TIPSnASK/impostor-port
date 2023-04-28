function beatHit() {
    switch (curBeat) {
        case 95, 288, 304, 319: flash();
    }

    if (curBeat % 2 == 0) {
        if (curBeat >= 94 && curBeat <= 158) flash();
        if (curBeat >= 318 && curBeat <= 382) flash();
    }
}

function flash() {
    if (FlxG.save.data.flashingLights) {
        FlxG.camera.flash(0x55FF0000, 0.4, null, true);
        FlxG.camera.zoom += 0.015;
        camHUD.zoom += 0.03;
    }
}
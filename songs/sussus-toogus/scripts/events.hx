// TODO: on curStep 1546 those are hey notes uhh yeah

function onSongStart() FlxTween.tween(camHUD, {alpha: 0}, 0.7);

function stepHit() {
    switch (curStep) {
        case 112, 120:
            addZoom();
            dad.playAnim('bopL', true);
        case 116, 124:
            addZoom();
            dad.playAnim('bopR', true);
        case 127: FlxTween.tween(camHUD, {alpha: 1}, 0.7);
        case 240, 244, 248, 252, 368, 372, 376, 380, 496, 500, 504, 508, 624, 628, 632, 636, 880, 884, 888, 892, 1264, 1268, 1272, 1276: addZoom();
        case 896:
            FlxTween.tween(camHUD, {alpha: 0}, 0.5);
            var sax = stage.getSprite('saxguy');
            sax.animation.play('bop', true);
            sax.alpha = 1;
            sax.setPosition(-700, 275);
            FlxTween.tween(sax, {x: sax.x + 2050}, 12.8, {onComplete: function () {
                remove(sax);
                FlxTween.tween(camHUD, {alpha: 1}, 0.5);
            }});
    }
}

function addZoom() {
    FlxG.camera.zoom += 0.015;
	camHUD.zoom += 0.03;
}
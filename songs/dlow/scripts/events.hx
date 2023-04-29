// boobies

return; // this isn't even close to done, i'll work on it later when motivated

var extraZoom:Float = 0; // implement later?

var WHYISITASEPARATESPRITESHEET:Character;
function postCreate() {
	WHYISITASEPARATESPRITESHEET = new Character(boyfriend.x, boyfriend.y, 'bfshock', boyfriend.isPlayer);
	insert(members.indexOf(boyfriend), WHYISITASEPARATESPRITESHEET);
	WHYISITASEPARATESPRITESHEET.alpha = 0.001;
}

function stepHit() {
	switch (curStep) {
		case 68, 76, 84, 92, 100, 108:
			FlxG.camera.zoom += 0.006;
			camHUD.zoom += 0.013;
		case 96:
			extraZoom = 0.04;
			// camZoomingInterval = 1;
		case 104:
			extraZoom = 0.08;
		case 110:
			alterCamBop(0, 100);
		case 111:
			extraZoom = 0.15;
		case 112:
			FlxG.camera.zoom += 0.01;
			camHUD.zoom += 0.03;
		case 127:
			extraZoom = 0;
		case 128:
			cameraTwist(0.1, 0.6);
		case 129:
			alterCamBop(1.2, 1);
		case 272, 278, 284, 304, 310, 316, 336, 342, 348, 368, 374, 380:
			FlxG.camera.zoom += 0.01;
			camHUD.zoom += 0.02;
		case 384:
			cameraTwist(0, 0);
		case 400:
			extraZoom = 0.05;
		case 416:
			extraZoom = 0;
		// continue at 0:36

	}

	if (curStep == 1424) {
		if (FlxG.save.data.flashingLights) camOverlay.flash();
		boyfriend.alpha = 0;
		WHYISITASEPARATESPRITESHEET.alpha = 1;
		WHYISITASEPARATESPRITESHEET.playAnim('idle', true);
		dad.playAnim('death', true);
	}
}
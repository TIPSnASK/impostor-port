function onSongStart() flash();

function beatHit() {
	switch (curBeat) {
		case 64, 192, 256, 384:
			defaultCamZoom = 0.8;
			bfCam = [1950, 1150];
			dadCam = [1450, 1150];
		case 128, 672:
			defaultCamZoom = 0.7;
			bfCam = [1725, 1100];
			dadCam = [1725, 1100];
		case 124, 126: flash();
		case 224, 320, 544:
			defaultCamZoom = 0.8;
			bfCam = [1725, 1100];
			dadCam = [1725, 1100];
		case 479, 608:
			defaultCamZoom = 0.9;
			bfCam = [1725, 1200];
			dadCam = [1725, 1200];
	}
    
	if (curBeat % 8 == 0 && curBeat <= 712) flash();
}

function flash() {
	FlxG.camera.flash(0x55FF0000, 0.4, null, true);
	FlxG.camera.zoom += 0.015;
	camHUD.zoom += 0.03;
}
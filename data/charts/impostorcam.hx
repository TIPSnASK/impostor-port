static var noteCamStrength:Float = 1;
static var bfCam:Array<Float> = [0,0];
static var dadCam:Array<Float> = [0,0];
static var camMovement:Bool = true;

function postCreate() {
	if (stage.stageXML != null && stage.stageXML.get("bfcam") != null && stage.stageXML.get("dadcam") != null) {
		bfCam = [for(s in stage.stageXML.get("bfcam").split(',')) Std.parseFloat(s)];
		dadCam = [for(s in stage.stageXML.get("dadcam").split(',')) Std.parseFloat(s)];
	} else {
		bfCam = [boyfriend.x+boyfriend.width/1.5-(boyfriend.width/2), boyfriend.y+boyfriend.height/1.5];
		dadCam = [dad.x+dad.width/1.5, dad.y+dad.height/1.5];
	}
}

function onCameraMove(event:CamMoveEvent) {
	event.cancel();

	if (curCameraTarget==1) {
		// FlxG.camera.focusOn(FlxPoint.get(bfCam[0], bfCam[1]));
		camFollow.setPosition(bfCam[0], bfCam[1]);
	} else if (curCameraTarget==0) {
		// FlxG.camera.focusOn(FlxPoint.get(dadCam[0], dadCam[1]));
		camFollow.setPosition(dadCam[0], dadCam[1]);
	}

	switch(strumLines.members[curCameraTarget].characters[0].getAnimName()) {
		case "singLEFT": camFollow.x -= 25*noteCamStrength;
		case "singDOWN": camFollow.y += 25*noteCamStrength;
		case "singUP": camFollow.y -= 25*noteCamStrength;
		case "singRIGHT": camFollow.x += 25*noteCamStrength;
	}
}
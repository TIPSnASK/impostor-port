static var noteCamStrength:Float = 1;

function postUpdate() {
	switch(strumLines.members[curCameraTarget].characters[0].getAnimName()) {
		case "singLEFT": camFollow.x -= 25*noteCamStrength;
		case "singDOWN": camFollow.y += 25*noteCamStrength;
		case "singUP": camFollow.y -= 25*noteCamStrength;
		case "singRIGHT": camFollow.x += 25*noteCamStrength;
	}
}
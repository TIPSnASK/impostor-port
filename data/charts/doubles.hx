// boobies

var lastNoteDad = {
	time: -9999999,
	data: -1
};

var lastNote = {
	time: -9999999,
	data: -1
};

static var bfColor:FlxColor = 0xFF00FFFF;
static var dadColor:FlxColor = 0xFFFF0000;
static var disableDoublesDad:Bool = false;
static var disableDoublesBf:Bool = false;

var shit = ["singLEFT", "singDOWN", "singUP", "singRIGHT"];

function onPlayerHit(event:NoteHitEvent) {
	if (event.note.isSustainNote) return;

	if (!PlayState.opponentMode) {
		var doDouble = (event.note.strumTime - lastNote.time) <= 2 && event.note.noteData != lastNote.data;
		lastNote.time = event.note.strumTime;
		lastNote.data = event.note.noteData;

		if(doDouble && !disableDoublesBf)
			doGhostAnim(boyfriend, bfColor).playAnim(shit[event.note.noteData], true);
	} else {
		var doDouble = (event.note.strumTime - lastNoteDad.time) <= 2 && event.note.noteData != lastNoteDad.data;
		lastNoteDad.time = event.note.strumTime;
		lastNoteDad.data = event.note.noteData;

		if(doDouble && !disableDoublesDad)
			doGhostAnim(dad, dadColor).playAnim(shit[event.note.noteData], true);
	}
}

function onDadHit(event:NoteHitEvent) {
	if (event.note.isSustainNote) return;
	
	if (!PlayState.opponentMode) {
		var doDouble = (event.note.strumTime - lastNoteDad.time) <= 2 && event.note.noteData != lastNoteDad.data;
		lastNoteDad.time = event.note.strumTime;
		lastNoteDad.data = event.note.noteData;

		if(doDouble && !disableDoublesDad)
			doGhostAnim(dad, dadColor).playAnim(shit[event.note.noteData], true);
	} else {
		var doDouble = (event.note.strumTime - lastNote.time) <= 2 && event.note.noteData != lastNote.data;
		lastNote.time = event.note.strumTime;
		lastNote.data = event.note.noteData;

		if(doDouble && !disableDoublesBf)
			doGhostAnim(boyfriend, bfColor).playAnim(shit[event.note.noteData], true);
	}
}

function doGhostAnim(char:Character, color:FlxColor) {
	var trail:Character = new Character(char.x, char.y, char.curCharacter, char.isPlayer); // ez fix (u forgot char.isPlayer)
	trail.color = color;
	insert(members.indexOf(char), trail);
	trail.blend = 0;
	FlxTween.tween(trail, {alpha: 0}, 1, {ease: FlxEase.quintOut}).onComplete = function() {
		trail.kill();
		remove(trail, true);
	};
	return trail;
}

var black:Character;

function postCreate() {
    lightoverlayDK.blend = 0;
    mainoverlayDK.blend = 0;
    defeatDKoverlay.blend = 0;

    black = new Character(1600, 650, "blackdk");
	insert(members.indexOf(gf), black);
}

/*
var anims = ["singLEFT", "singDOWN", "singUP", "singRIGHT"];
function onDadHit(event:NoteHitEvent) {
	if (event.noteType == "lava") {
        black.playAnim(anims[event.note.notedata], true);
	}
}
*/
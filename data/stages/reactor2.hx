// boobies

function create() {
	if (Options.lowMemoryMode) {
		for (object in stage.stageSprites) {
			object.kill();
			object.destroy();
			remove(object);
		}
		var back:FlxSprite = new FlxSprite(500, 205).loadGraphic(Paths.image('lowquality/stages/reactor/back'));
		back.scale.set(1.65, 1.65);
		back.updateHitbox();
		insert(members.indexOf(gf), back);
	}
}

function postCreate() {
	if (!Options.lowMemoryMode && FlxG.save.data.ambients) {
		var overlay1:FlxSprite = new FlxSprite().makeGraphic(1280, 720, 0xFFFF5900);
		overlay1.alpha = 0.15;
		overlay1.blend = 0;
		overlay1.cameras = [camOverlay];
		add(overlay1);
	}
}
import funkin.editors.ui.UIState;

function update() {
	if (FlxG.keys.justPressed.THREE) FlxG.switchState(new UIState(true, 'editors/UICharacterEditor'));
	if (FlxG.keys.justPressed.TWO) FlxG.switchState(new UIState(true, 'editors/UIStagePosEditor'));
}
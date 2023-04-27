// god this is gonna be painful

import flixel.addons.display.FlxBackdrop;
import funkin.options.OptionsMenu;
// import funkin.menus.credits.CreditsMain;

var optionShits:Array<String> = ['Story Mode', 'Freeplay', 'Gallery', 'Credits', 'Options', 'Shop', 'Innersloth'];
var menuShits:FlxTypedGroup;
var starFG:FlxBackdrop;
var starBG:FlxBackdrop;
var redImpostor:FlxSprite;
var greenImpostor:FlxSprite;
var vignette:FlxSprite;
var glowyThing:FlxSprite;
var canPress:Bool = true;
function postCreate() {
	for (i in members) remove(i);

	FlxG.mouse.visible = true;

	starFG = new FlxBackdrop(Paths.image('menus/starFG'), 1, 1, true, true);
	starFG.updateHitbox();
	starFG.antialiasing = true;
	starFG.velocity.x = -15;
	add(starFG);

	starBG = new FlxBackdrop(Paths.image('menus/starBG'), 1, 1, true, true);
	starBG.updateHitbox();
	starBG.antialiasing = true;
	starBG.velocity.x = -5;
	add(starBG);

	redImpostor = new FlxSprite(350, -160);
	redImpostor.frames = Paths.getSparrowAtlas('menus/redMenu');
	redImpostor.animation.addByPrefix('idle', 'red idle', 24, true);
	redImpostor.animation.addByPrefix('select', 'red select', 24, false);
	redImpostor.animation.play('idle');
	redImpostor.antialiasing = true;
	redImpostor.updateHitbox();
	redImpostor.active = true;
	redImpostor.scale.set(0.7, 0.7);
	redImpostor.scrollFactor.set();
	add(redImpostor);

	greenImpostor = new FlxSprite(-300, -60);
	greenImpostor.frames = Paths.getSparrowAtlas('menus/greenmenu');
	greenImpostor.animation.addByPrefix('idle', 'green idle', 24, true);
	greenImpostor.animation.addByPrefix('select', 'green select', 24, false);
	greenImpostor.animation.play('idle');
	greenImpostor.antialiasing = true;
	greenImpostor.updateHitbox();
	greenImpostor.active = true;
	greenImpostor.scale.set(0.7, 0.7);
	greenImpostor.scrollFactor.set();
	add(greenImpostor);

	vignette = new FlxSprite(0, 0).loadGraphic(Paths.image('menus/vignette'));
	vignette.antialiasing = true;
	vignette.updateHitbox();
	vignette.active = false;
	vignette.scrollFactor.set();
	add(vignette);

	glowyThing = new FlxSprite(361, 438).loadGraphic(Paths.image('menus/buttonglow'));
	glowyThing.antialiasing = true;
	glowyThing.scale.set(0.51, 0.51);
	glowyThing.updateHitbox();
	glowyThing.active = false;
	glowyThing.scrollFactor.set();
	glowyThing.visible = false;
	add(glowyThing);

	var logo:FlxSprite = new FlxSprite(0, 100);
	logo.frames = Paths.getSparrowAtlas('menus/logoBumpin');
	logo.animation.addByPrefix('bump', 'logo bumpin', 24, false);
	logo.screenCenter();
	logo.updateHitbox();
	logo.antialiasing = true;
	logo.scale.set(0.65, 0.65);
	logo.y -= 160;
	add(logo);

	menuShits = new FlxTypedGroup();
	add(menuShits);

	for (i in 0...optionShits.length) {
		var testButton:FlxSprite = new FlxSprite(0, 130);
		var shit = (i > 3) ? 'Buttons_UI' : 'Big_Buttons_UI';
		testButton.ID = i;
		testButton.frames = Paths.getSparrowAtlas('menus/' + shit);
		testButton.animation.addByPrefix('idle', optionShits[i] + ' Button', 24, true);
		testButton.animation.addByPrefix('hover', optionShits[i] + ' Select', 24, true);
		testButton.animation.play('idle');
		testButton.antialiasing = true;
		testButton.scale.set(0.50 ,0.50);
		testButton.updateHitbox();
		testButton.screenCenter(0x01);
		testButton.scrollFactor.set();
		switch(i) { // hi brian :)
			case 0: testButton.setPosition(400, 475);
			case 1: testButton.setPosition(633, 475);
			case 2: testButton.setPosition(400, 580);
			case 3: testButton.setPosition(633, 580);
			case 4: testButton.setPosition(455, 640);
			case 5: testButton.setPosition(590, 640);
			case 6: testButton.setPosition(725, 640);
		}
		menuShits.add(testButton);
	}
	add(menuShits);
	remove(menuItems);
	FlxG.camera.target = null;
}

function update(elapsed:Float) {
	if (FlxG.keys.justPressed.EIGHT) FlxG.resetState();

	for (i in menuShits.members) {
		if (FlxG.mouse.overlaps(i) && canPress) {
			i.animation.play('hover', false);
			if ((FlxG.keys.justPressed.ENTER) || (FlxG.mouse.justPressed)) {
				if (!FlxG.keys.justPressed.ENTER) {
					selectedSomethin = true;
					CoolUtil.playMenuSFX(1);
				}
				for (v in [starFG, starBG])
					FlxTween.tween(v, {y: v.y + 500}, 1, {ease: FlxEase.quadInOut, startDelay: v == starFG ? 0 : 0.2});
				for (v in [redImpostor, greenImpostor]) {
					v.animation.play('select', true);
					FlxTween.tween(v, {y: v.y + 800}, 0.7, {ease: FlxEase.quadInOut, startDelay: 0.25});
				}
				FlxG.camera.fade(0xFF000000, 0.7, false);
				new FlxTimer().start(1, function(tmr:FlxTimer) {
					switch(optionShits[i.ID]) {
						case 'Story Mode':
							FlxG.switchState(new StoryMenuState());
						case 'Freeplay':
							FlxG.switchState(new FreeplayState());
						case 'Credits':
							// FlxG.switchState(new CreditsMain());
						case 'Options':
							FlxG.switchState(new OptionsMenu(false));
					}
				});
			}
		}
		else {i.animation.play('idle', false);}
	}
}

function onChangeItem(event:MenuChangeEvent) event.cancel(false);

function onSelectItem(event:NameEvent) event.cancel(false);
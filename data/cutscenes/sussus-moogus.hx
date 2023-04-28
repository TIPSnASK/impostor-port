import flixel.util.FlxTimer;
import flixel.group.FlxTypedSpriteGroup;
import flixel.text.FlxTextBorderStyle;
import flixel.text.FlxTextAlign;
import funkin.system.Conductor;

var camDialogue:FlxCamera;
var bg:FlxSprite;
var dadPort:FlxSprite;
var bfPort:FlxSprite;
var bubbles:Array<FlxTypedSpriteGroup> = [];
var curCharacter:String = '';
var curEmote:String = '';
var dialogueList:Array<String> = [];
var curDialogue:Int = 0;
var ipad:FlxSprite;
var canPressEnter:Bool = false;
var lastCurDialogue:Int = -1;
function create() {
    dialogueList = awesomeDialogue(Paths.file('songs/' + PlayState.SONG.song.toLowerCase() + '/dialogue.txt'));

    camDialogue = new FlxCamera();
    camDialogue.bgColor = 0x00000000;
    FlxG.cameras.add(camDialogue, false);

    bg = new FlxSprite().makeGraphic(FlxG.width, FlxG.height, 0xFF000000);
    bg.cameras = [camDialogue];
    add(bg);
    FlxTween.tween(bg, {alpha: 0}, 2, {ease: FlxEase.quintIn}).onComplete = function() {
        bg.makeGraphic(FlxG.width, FlxG.height, 0xFFFFFFFF);
        FlxTween.tween(bg, {alpha: 0.5}, 1, {ease: FlxEase.quintOut}).onComplete = setupDialogue();
    };
}

function setupDialogue() {
    dadPort = new FlxSprite(0, 0);
    dadPort.frames = Paths.getSparrowAtlas('dialogue/red');
    for (i in ['happy', 'mad', 'nervous', 'neutral', 'q', 'sad']) dadPort.animation.addByPrefix(i, 'RI ' + i, 24, false);
    dadPort.cameras = [camDialogue];
    dadPort.animation.play('happy', true);
    dadPort.screenCenter();
    dadPort.x -= 298;
    dadPort.y += 307*6;
    dadPort.alpha = 0.00001;
    add(dadPort);
    FlxTween.tween(dadPort, {alpha: 1}, 1.25, {ease: FlxEase.quintOut});
    FlxTween.tween(dadPort, {y: dadPort.y-(307*6)}, 1, {ease: FlxEase.quintOut});

    bfPort = new FlxSprite(0, 0);
    bfPort.frames = Paths.getSparrowAtlas('dialogue/boyfriend');
    for (i in ['angry', 'happy', 'mad', 'neutral', 'q', 'realization', 'sad', 'uwu']) bfPort.animation.addByPrefix(i, 'BF ' + i, 24, false);
    bfPort.cameras = [camDialogue];
    bfPort.animation.play('happy', true);
    bfPort.screenCenter();
    bfPort.x += 298;
    bfPort.y += 307*6;
    bfPort.alpha = 0.00001;
    add(bfPort);
    FlxTween.tween(bfPort, {alpha: 1}, 1.25, {ease: FlxEase.quintOut});
    FlxTween.tween(bfPort, {y: bfPort.y-(307*6.1)}, 1, {ease: FlxEase.quintOut});

    gfPort = new FlxSprite(0, 0);
    gfPort.frames = Paths.getSparrowAtlas('dialogue/gf');
    for (i in ['glint', 'happy', 'mad', 'neutral', 'q', 'suspect']) gfPort.animation.addByPrefix(i, 'GF ' + i, 24, false);
    gfPort.cameras = [camDialogue];
    gfPort.animation.play('happy', true);
    gfPort.screenCenter();
    gfPort.y += 307*6;
    gfPort.alpha = 0.00001;
    add(gfPort);
    FlxTween.tween(gfPort, {alpha: 1}, 1.25, {ease: FlxEase.quintOut});
    FlxTween.tween(gfPort, {y: gfPort.y-(307*6.2)}, 1, {ease: FlxEase.quintOut});

    ipad = new FlxSprite(0, 0);
    ipad.frames = Paths.getSparrowAtlas('dialogue/dialogueBox');
    var charList:Array<String> = ['bf', 'gf', 'red', 'gc', 'gi', 'y', 'wi', 'maroon', 'grey', 'pink', 'pi', 'war', 'jelq'];
    for (i in 0...charList.length) ipad.animation.addByIndices(charList[i], 'dialog frame', [i], "", 24);
    ipad.screenCenter();
    ipad.y += 307*4;
    ipad.cameras = [camDialogue];
    add(ipad);
    FlxTween.tween(ipad, {y: ipad.y-(307*3)}, 1, {ease: FlxEase.quintOut});

    cleanUp();
    nextDialogue();
}

function nextDialogue() {
    var bubbleGroup:FlxTypedSpriteGroup = new FlxTypedSpriteGroup();
    bubbleGroup.cameras = [camDialogue];

    var bubble:FlxSprite = new FlxSprite(0, 0).loadGraphic(Paths.image('dialogue/bubble'));
    bubble.screenCenter();
    bubble.x += 15;
    bubbleGroup.add(bubble);

    var icon:FlxSprite = new FlxSprite(bubble.x - 10, bubble.y - 25).loadGraphic(Paths.image('icons/impostor'), 150, 150);
    icon.animation.add('icon', [for(i in 0...icon.frames.frames.length) i], 0, false, false);
    icon.animation.play('icon', true);
    icon.scale.set(0.85, 0.85);
    icon.centerOffsets();
    bubbleGroup.add(icon);

    var nameText:FlxText = new FlxText(icon.x + 120, icon.y + 27, Std.int(FlxG.width * 0.6), curCharacter.charAt(0).toUpperCase() + curCharacter.substr(curCharacter.length - (curCharacter.length-1)), 28);
    nameText.setFormat(Paths.font("liberbold.ttf"), 30, 0xFFFFFFFF, FlxTextAlign.LEFT, FlxTextBorderStyle.OUTLINE, 0xFF000000);
    nameText.borderSize = 3;
    bubbleGroup.add(nameText);

    var dialogueText:FlxText = new FlxText(nameText.x, nameText.y + 42.5, Std.int(FlxG.width * 0.6), dialogueList[curDialogue], 28);
    dialogueText.setFormat(Paths.font("liber.ttf"), 26, 0xFF000000, FlxTextAlign.LEFT);
    dialogueText.color = 0xFF000000;
    bubbleGroup.add(dialogueText);
    add(bubbleGroup);
    bubbles.push(bubbleGroup);
    switch(curCharacter) {
        default:
            dadPort.animation.play(curEmote, true);
            icon.loadGraphic(Paths.image('icons/impostor'), 150, 150);
            icon.animation.add('icon', [for(i in 0...icon.frames.frames.length) i], 0, false, false);
            icon.animation.play('icon', true);
            icon.scale.set(0.85, 0.85);
            icon.centerOffsets();
        case 'gf':
            gfPort.animation.play(curEmote, true);
            icon.loadGraphic(Paths.image('icons/gf'), 150, 150);
            icon.animation.add('icon', [for(i in 0...icon.frames.frames.length) i], 0, false, false);
            icon.animation.play('icon', true);
            icon.scale.set(0.85, 0.85);
            icon.centerOffsets();
        case 'bf':
            bfPort.animation.play(curEmote, true);
            icon.loadGraphic(Paths.image('icons/bf'), 150, 150);
            icon.animation.add('icon', [for(i in 0...icon.frames.frames.length) i], 0, false, false);
            icon.animation.play('icon', true);
            icon.scale.set(0.85, 0.85);
            icon.centerOffsets();
    }
    if (bubbles.length == 1) {
        bubbleGroup.y += 177*10;
        FlxTween.tween(bubbleGroup, {y: bubbleGroup.y-(177*9)}, 1, {ease: FlxEase.quintOut});
    } else {
        bubbleGroup.y += 177;
        bubbles[curDialogue-1].y += bubble.height + 3;
        if (bubbles.length > 1) remove(bubbles[curDialogue-2]);
    }
    ipad.animation.play(curCharacter, true);
    lastCurDialogue = curDialogue;
    curDialogue ++;
    canPressEnter = true;
    cleanUp();
}

function cleanUp() {
    dialogueList = awesomeDialogue(Paths.file('songs/' + PlayState.SONG.song.toLowerCase() + '/dialogue.txt'));
    var splitName:Array<String> = dialogueList[curDialogue].split(":");
    trace(splitName);
    curCharacter = splitName[1];
    curEmote = splitName[2];
    dialogueList[curDialogue] = StringTools.trim(dialogueList[curDialogue].substr(curCharacter.length + 3 + curEmote.length));
    trace(dialogueList[curDialogue]);
}

function update(elapsed:Float) {
    if (dialogueList[curDialogue] != null) {
        if ((FlxG.keys.justPressed.ENTER) && (canPressEnter)) {
            cleanUp();
            nextDialogue();
        }
    }
    
    if (FlxG.keys.justPressed.ESCAPE || (FlxG.keys.justPressed.ENTER && dialogueList[curDialogue] == null)) close();
}

function awesomeDialogue(path:String) {
    var shit = Assets.getText(path);
    shit += '\n:red:mad:this text should not be visible';
    return shit.split('\n');
}
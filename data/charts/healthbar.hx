//penis
function postCreate() {
    if (dad != null && dad.xml != null && dad.xml.exists("color"))
        for (i in [scoreTxt, accuracyTxt, missesTxt])
            i.color = CoolUtil.getColorFromDynamic(dad.xml.get("color"));

    healthBar.createFilledBar(
        (dad != null && dad.xml != null && dad.xml.exists("color")) ? CoolUtil.getColorFromDynamic(dad.xml.get("color")) : 0xFFFF0000,
        (boyfriend != null && boyfriend.xml != null && boyfriend.xml.exists("color")) ? CoolUtil.getColorFromDynamic(boyfriend.xml.get("color")) : 0xFF66FF33
    );
}
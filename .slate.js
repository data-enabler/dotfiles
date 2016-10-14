var lastOp = "";
var lastWin = -1;
var counter = 0;

var fullscreen = [
	slate.operation("move", {
		"x" : "screenOriginX",
		"y" : "screenOriginY",
		"width" : "screenSizeX",
		"height" : "screenSizeY"
	})
];

var leftGen = function(yOffset, ySize) {
	return [
		slate.operation("move", {
			"x" : "screenOriginX",
			"y" : "screenOriginY + screenSizeY * " + yOffset,
			"width" : "screenSizeX / 2",
			"height" : "screenSizeY * " + ySize
		}),
		slate.operation("move", {
			"x" : "screenOriginX",
			"y" : "screenOriginY + screenSizeY * " + yOffset,
			"width" : "screenSizeX * 2/3",
			"height" : "screenSizeY * " + ySize
		}),
		slate.operation("move", {
			"x" : "screenOriginX",
			"y" : "screenOriginY + screenSizeY * " + yOffset,
			"width" : "screenSizeX / 3",
			"height" : "screenSizeY * " + ySize
		})
	];
};

var rightGen = function(yOffset, ySize) {
	return [
		slate.operation("move", {
			"x" : "screenOriginX + screenSizeX * 1/2",
			"y" : "screenOriginY + screenSizeY * " + yOffset,
			"width" : "screenSizeX / 2",
			"height" : "screenSizeY * " + ySize
		}),
		slate.operation("move", {
			"x" : "screenOriginX + screenSizeX * 1/3",
			"y" : "screenOriginY + screenSizeY * " + yOffset,
			"width" : "screenSizeX * 2/3",
			"height" : "screenSizeY * " + ySize
		}),
		slate.operation("move", {
			"x" : "screenOriginX + screenSizeX * 2/3",
			"y" : "screenOriginY + screenSizeY * " + yOffset,
			"width" : "screenSizeX / 3",
			"height" : "screenSizeY * " + ySize
		})
	];
};

var middleGen = function(yOffset) {
	return [
		slate.operation("move", {
			"x" : "screenOriginX",
			"y" : "screenOriginY + screenSizeY * " + yOffset,
			"width" : "screenSizeX",
			"height" : "screenSizeY * 1/2"
		}),
		slate.operation("move", {
			"x" : "screenOriginX + screenSizeX * 1/3",
			"y" : "screenOriginY + screenSizeY * " + yOffset,
			"width" : "screenSizeX * 1/3",
			"height" : "screenSizeY * 1/2"
		})
	];
};

var prevScreen = [ slate.operation("throw", { "screen": "prev" }) ];
var nextScreen = [ slate.operation("throw", { "screen": "next" }) ];

var bind = function(trigger, operations) {
	slate.bind(trigger, function(win) {
		if (lastOp != trigger || lastWin != win.pid()) {
			counter = 0;
		}
		win.doOperation(operations[counter]);
		counter = (counter + 1) % operations.length;
		lastOp = trigger;
		lastWin = win.pid();
	});
};

//bind("j:alt;cmd", leftGen(0, 1));
bind("pad4:alt;cmd", leftGen(0, 1));
//bind("u:alt;cmd", leftGen(0, 0.5));
bind("pad7:alt;cmd", leftGen(0, 0.5));
//bind("n:alt;cmd", leftGen(0.5, 0.5));
bind("pad1:alt;cmd", leftGen(0.5, 0.5));
//bind("k:alt;cmd", rightGen(0, 1));
bind("pad6:alt;cmd", rightGen(0, 1));
//bind("o:alt;cmd", rightGen(0, 0.5));
bind("pad9:alt;cmd", rightGen(0, 0.5));
//bind(",:alt;cmd", rightGen(0.5, 0.5));
bind("pad3:alt;cmd", rightGen(0.5, 0.5));
//bind("i:alt;cmd", middleGen(0));
bind("pad8:alt;cmd", middleGen(0));
//bind("m:alt;cmd", middleGen(0.5));
bind("pad2:alt;cmd", middleGen(0.5));
bind("return:alt;cmd", fullscreen);
bind("left:alt;cmd", prevScreen);
bind("right:alt;cmd", nextScreen);

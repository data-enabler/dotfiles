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

var middleGen = function(yOffset, ySize) {
	return [
		slate.operation("move", {
			"x" : "screenOriginX",
			"y" : "screenOriginY + screenSizeY * " + yOffset,
			"width" : "screenSizeX",
			"height" : "screenSizeY * " + ySize
		}),
		slate.operation("move", {
			"x" : "screenOriginX + screenSizeX * 1/3",
			"y" : "screenOriginY + screenSizeY * " + yOffset,
			"width" : "screenSizeX * 1/3",
			"height" : "screenSizeY * " + ySize
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

bind("j:ctrl;cmd", leftGen(0, 1));
bind("pad4:alt;cmd", leftGen(0, 1));
bind("u:ctrl;cmd", leftGen(0, 0.5));
bind("pad7:alt;cmd", leftGen(0, 0.5));
bind("n:ctrl;cmd", leftGen(0.5, 0.5));
bind("pad1:alt;cmd", leftGen(0.5, 0.5));
bind("k:ctrl;cmd", rightGen(0, 1));
bind("pad6:alt;cmd", rightGen(0, 1));
bind("o:ctrl;cmd", rightGen(0, 0.5));
bind("pad9:alt;cmd", rightGen(0, 0.5));
bind(",:ctrl;cmd", rightGen(0.5, 0.5));
bind("pad3:alt;cmd", rightGen(0.5, 0.5));
bind(".:ctrl;cmd", middleGen(0, 1));
bind("pad5:alt;cmd", middleGen(0, 1));
bind("i:ctrl;cmd", middleGen(0, 0.5));
bind("pad8:alt;cmd", middleGen(0, 0.5));
bind("m:ctrl;cmd", middleGen(0.5, 0.5));
bind("pad2:alt;cmd", middleGen(0.5, 0.5));
bind("return:alt;cmd", fullscreen);
bind("left:alt;cmd", prevScreen);
bind("left:ctrl;cmd", prevScreen);
bind("right:alt;cmd", nextScreen);
bind("right:ctrl;cmd", nextScreen);

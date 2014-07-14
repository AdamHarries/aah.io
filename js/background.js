var t = new Trianglify({noiseIntensity: 0,cellsize: 75});
function height() {
	return Math.max(
		document.body.scrollHeight, document.documentElement.scrollHeight,
		document.body.offsetHeight, document.documentElement.offsetHeight,
		document.body.clientHeight, document.documentElement.clientHeight
	);
};
function redraw(){
	var pattern = t.generate(document.body.clientWidth, height());
	document.body.setAttribute('style', 'background-image: '+pattern.dataUrl);
};
window.onresize = function(){
	redraw();
};
redraw();
var newCanvas = document.createElement("canvas");
newCanvas.id = "confetti_canvas";
document.body.appendChild(newCanvas);
browser.runtime.onMessage.addListener((request, sender, sendResponse) => {
	if (request === "confetti") {
		var oldScript = document.getElementById("script-confetti");
		if (oldScript) {
			oldScript.parentNode.removeChild(oldScript);
		}
		var newScript = document.createElement("script");
		newScript.innerHTML = "addConfetti();"
		document.head.appendChild(newScript);
	}
});

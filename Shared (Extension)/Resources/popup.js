function activateConfetti(tabs) {
	var tabPromise = browser.tabs.getCurrent();
	tabPromise.then(tab => {
		browser.tabs.sendMessage(tab.id, "confetti");
	});
}

document.getElementById("btn-confetti").addEventListener("click", activateConfetti);
var tabPromise = browser.tabs.getCurrent();
tabPromise.then(tab => {
	if (!tab.url) {
		document.getElementById("btn-confetti").disabled = true;
	}
});

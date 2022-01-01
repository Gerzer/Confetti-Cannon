//
//  ViewController.swift
//  Shared (App)
//
//  Created by Gabriel Jacoby-Cooper on 12/22/21.
//

import WebKit

#if os(iOS)
import UIKit
typealias PlatformViewController = UIViewController
#elseif os(macOS) // os(iOS)
import Cocoa
import SafariServices
typealias PlatformViewController = NSViewController
#endif // os(macOS)

let extensionBundleIdentifier = "com.gerzer.confetticannon.extension"

class ViewController: PlatformViewController, WKNavigationDelegate, WKScriptMessageHandler {
	
	@IBOutlet var webView: WKWebView!
	
	override func viewDidLoad() {
		super.viewDidLoad()
		self.webView.navigationDelegate = self
		
		#if os(iOS)
		self.webView.scrollView.isScrollEnabled = false
		#endif // os(iOS)
		
		self.webView.configuration.userContentController.add(self, name: "controller")
		self.webView.loadFileURL(
			Bundle.main.url(
				forResource: "Main",
				withExtension: "html"
			)!,
			allowingReadAccessTo: Bundle.main.resourceURL!
		)
	}
	
	func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
		#if os(iOS)
		webView.evaluateJavaScript("show('ios')")
		#elseif os(macOS) // os(iOS)
		webView.evaluateJavaScript("show('mac')")
		SFSafariExtensionManager.getStateOfSafariExtension(withIdentifier: extensionBundleIdentifier) { (state, error) in
			guard let state = state, error == nil else {
				return
			}
			DispatchQueue.main.async {
				webView.evaluateJavaScript("show('mac', \(state.isEnabled))")
			}
		}
		#endif // os(macOS)
	}
	
	func userContentController(_ userContentController: WKUserContentController, didReceive message: WKScriptMessage) {
		#if os(macOS)
		if message.body as! String != "open-preferences" {
			return
		}
		SFSafariApplication.showPreferencesForExtension(withIdentifier: extensionBundleIdentifier) { error in
			guard error == nil else {
				return
			}
			DispatchQueue.main.async {
				NSApplication.shared.terminate(nil)
			}
		}
		#endif // os(macOS)
	}
	
}

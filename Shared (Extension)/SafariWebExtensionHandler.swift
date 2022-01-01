//
//  SafariWebExtensionHandler.swift
//  Shared (Extension)
//
//  Created by Gabriel Jacoby-Cooper on 12/22/21.
//

import SafariServices

let SFExtensionMessageKey = "message"

class SafariWebExtensionHandler: NSObject, NSExtensionRequestHandling {
	
	func beginRequest(with context: NSExtensionContext) {
		let item = context.inputItems[0] as! NSExtensionItem
		let message = item.userInfo?[SFExtensionMessageKey]
		print("Received message from browser.runtime.sendNativeMessage: \(message ?? "nil")")
		let response = NSExtensionItem()
		response.userInfo = [
			SFExtensionMessageKey: [
				"Response to": message
			]
		]
		context.completeRequest(returningItems: [response], completionHandler: nil)
	}
	
}

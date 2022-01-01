//
//  AppDelegate.swift
//  macOS (App)
//
//  Created by Gabriel Jacoby-Cooper on 12/22/21.
//

import Cocoa

@main
class AppDelegate: NSObject, NSApplicationDelegate {
	
	func applicationShouldTerminateAfterLastWindowClosed(_ sender: NSApplication) -> Bool {
		return true
	}
	
}

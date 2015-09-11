//
//  AppDelegate.swift
//  SpeakText
//
//  Created by Avjinder Singh Sekhon on 9/10/15.
//  Copyright (c) 2015 Avjinder Singh Sekhon. All rights reserved.
//

import Cocoa

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {


    var mainWindowController: MainWindowController?

    func applicationDidFinishLaunching(aNotification: NSNotification) {
        // Insert code here to initialize your application
        var controller = MainWindowController()
        controller.showWindow(self)
        mainWindowController = controller
    }

    
    func applicationWillTerminate(aNotification: NSNotification) {
        // Insert code here to tear down your application
    }


}


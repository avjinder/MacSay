//
//  MainWindowController.swift
//  SpeakText
//
//  Created by Avjinder Singh Sekhon on 9/10/15.
//  Copyright (c) 2015 Avjinder Singh Sekhon. All rights reserved.
//

import Cocoa

class MainWindowController: NSWindowController, NSSpeechSynthesizerDelegate, NSWindowDelegate, NSTableViewDataSource, NSTableViewDelegate{
    
    //MARK: - @IBOutlets
    @IBOutlet weak var textToSpeak: NSTextField!
    @IBOutlet weak var stopSpeakingButton: NSButton!
    @IBOutlet weak var startSpeakingButton: NSButton!
    @IBOutlet weak var myTable: NSTableView!
    
    //MARK: - Member variables
    var isStarted: Bool = false{
        //called whenever the value is changed
        didSet{
            updateButtons()
        }
    }
    
    var voicesNormal: [String] = [String]()
    
    let defSpeaker = NSSpeechSynthesizer.defaultVoice()
    let speechSynth: NSSpeechSynthesizer = NSSpeechSynthesizer()
    let voices:[String] = NSSpeechSynthesizer.availableVoices() as! [String]
    
    
    

    //MARK: - @IBActions
    @IBAction func stopSpeakingText(stopButton: NSButton){
        if isStarted{
            speechSynth.stopSpeaking()
            isStarted = false
        }
        
    }
    
    
    @IBAction func speakText(button: NSButton){
        
        voiceNameForIdentifier(NSSpeechSynthesizer.defaultVoice())
        if count(textToSpeak.stringValue) != 0 {
            isStarted = true
            speechSynth.startSpeakingString(textToSpeak.stringValue)
        }
        
    }
    
    //MARK: - Member Methods
    
    func voiceNameForIdentifier(voice: String) -> String?{
        if let attributes = NSSpeechSynthesizer.attributesForVoice(voice){
            return attributes[NSVoiceName] as? String
        }
        else{
            return nil
        }
    }
    

    func updateButtons(){
        if isStarted{
           startSpeakingButton.enabled = false
            stopSpeakingButton.enabled = true
        }
        else{
            startSpeakingButton.enabled = true
            stopSpeakingButton.enabled = false
        }
        
    }

    //MARK: - Overriden Methods
    override func windowDidLoad() {
        super.windowDidLoad()
        myTable.setDataSource(self)
        myTable.setDelegate(self)
        updateButtons()
        speechSynth.delegate = self
        
        for voice in voices{
            var trueVoice: String? = voiceNameForIdentifier(voice)
            voicesNormal.append(trueVoice!)
        }

        // Implement this method to handle any initialization after your window controller's window has been loaded from its nib file.
    }
    
    override var windowNibName: String?{
        return "MainWindowController"
    }
    
    //MARK: - NSSpeechSynthesizerDelegate
    func speechSynthesizer(sender: NSSpeechSynthesizer, didFinishSpeaking finishedSpeaking: Bool) {
//        textToSpeak.stringValue = ""
        isStarted = false
    }
    //MARK: - NSWindowDelegate
    func windowShouldClose(sender: AnyObject) -> Bool {
        return !speechSynth.speaking
    }
    
//    func windowWillResize(sender: NSWindow, toSize frameSize: NSSize) -> NSSize {
//        //height must be twice the width
//        var myHeight: CGFloat = frameSize.height
//        let mySize = NSSize(width: myHeight*2, height: myHeight)
//        return mySize
//    }
    
   //MARK: - NSTableViewDataSource
    func numberOfRowsInTableView(tableView: NSTableView) -> Int {
        return voices.count
    }
    func tableView(tableView: NSTableView, objectValueForTableColumn tableColumn: NSTableColumn?, row: Int) -> AnyObject? {
        return voicesNormal[row]
    }

    //MARK: - NSTableViewDelegate
    func tableViewSelectionDidChange(notification: NSNotification) {
        let row = myTable.selectedRow
        let voice = voices[row]
        speechSynth.setVoice(voice)
    }
    
}


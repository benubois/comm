//
//  ViewController.swift
//  Comm
//
//  Created by ben on 9/16/15.
//  Copyright (c) 2015 Ben Ubois. All rights reserved.
//

import Foundation
import Cocoa

class ViewController: NSViewController, NSTextViewDelegate {

    @IBOutlet var listOne: NSTextView!
    @IBOutlet var listTwo: NSTextView!
    @IBOutlet var output: NSTextView!
    
    @IBOutlet weak var countOne: NSTextField!
    @IBOutlet weak var countTwo: NSTextField!
    @IBOutlet weak var countOutput: NSTextField!
    
    @IBOutlet weak var copyButton: NSButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        listOne.delegate = self
        listTwo.delegate = self
        
        copyButton.target = self
        copyButton.action = "copy:"
    }

    func textDidChange(notification: NSNotification) {
        if let object = notification.object as? NSTextView {
            if object == listOne || object == listTwo {
                if let listOneText = listOne.string, listTwoText = listTwo.string {
                    update(listOneText, stringTwo: listTwoText)
                }
            }
        }
    }
    
    func update(stringOne: String, stringTwo: String) {
        let setOne = stringToSet(stringOne)
        let setTwo = stringToSet(stringTwo)
        let common = setOne.intersect(setTwo)
        let commonString = common.joinWithSeparator("\n")
        output.string = commonString
        
        countOne.stringValue = "\(setOne.count)"
        countTwo.stringValue = "\(setTwo.count)"
        countOutput.stringValue = "\(common.count)"
    }
    
    func stringToSet(string: String) -> Set<String> {
        let array = string.componentsSeparatedByString("\n")
        let formattedStrings = array.filter({ $0 != "" }).flatMap({$0.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceAndNewlineCharacterSet())})
        let set = Set(formattedStrings)
        return set
    }
    
    func copy(obj:AnyObject?) {
        if let outputText = output.string {
            let pasteBoard = NSPasteboard.generalPasteboard()
            pasteBoard.clearContents()
            pasteBoard.writeObjects([outputText])
        }
    }

}


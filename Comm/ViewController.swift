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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        listOne.delegate = self
        listTwo.delegate = self
    }

    func textDidChange(notification: NSNotification) {
        if let object = notification.object as? NSTextView {
            if object == listOne || object == listTwo {
                if let listOneText = listOne.string, listTwoText = listTwo.string {
                    comm(listOneText, stringTwo: listTwoText)
                }
            }
        }
    }
    
    func comm(stringOne: String, stringTwo: String) {
        let setOne = stringToSet(stringOne)
        let setTwo = stringToSet(stringTwo)
        let common = setOne.intersect(setTwo)
        let commonString = "\n".join(common)
        output.string = commonString
    }
    
    func stringToSet(string: String) -> Set<String> {
        let array = string.componentsSeparatedByString("\n")
        let set = Set(array)
        return set
    }

}


//
//  ViewController.swift
//  TriggersExample-Swift
//
//  Created by Grzegorz Krukiewicz-Gacek on 23.12.2014.
//  Copyright (c) 2014 Estimote Inc. All rights reserved.
//

import UIKit

class ViewController: UIViewController, ESTNearableManagerDelegate {
    @IBOutlet var showPopBtn: UIButton!
    
    @IBOutlet var infoLbl: UILabel!
    @IBOutlet var calibrateBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    @IBAction func onPopupBtnPressed(sender: UIButton) {
        
        var popView = PopupViewController (nibName: "PopupView" , bundle : nil)
        
        var popController = UIPopoverController(contentViewController: popView)
        
        popController.popoverContentSize = CGSize(width: 600, height: 600)
        
        popController.presentPopoverFromRect(sender.frame , inView: self.view , permittedArrowDirections: UIPopoverArrowDirection.allZeros, animated: true)
    }
    
}


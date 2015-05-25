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
    @IBOutlet var hiddenView: UILabel!
    @IBOutlet var infoLbl: UILabel!
    @IBOutlet var calibrateBtn: UIButton!
    @IBOutlet var imageView: UIImageView!

    
    private var savedStableState: [String : (x:Int , y:Int, z:Int)] = Dictionary()
    private var nearableManager: ESTNearableManager! = nil
    private var nearables : [ESTNearable]  = []
    private let nh = NearableHelper.self
    private var isCalibrated = false;
    
    
    let imgBag = UIImage(named: "sticker_bag")
    let imgDoor = UIImage(named: "sticker_door")
    let imgFridge = UIImage(named: "sticker_fridge")
    let imgPTC = UIImage(named: "ptc")
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        imageView.image = imgPTC
        nearableManager = ESTNearableManager()
        nearableManager.delegate = self
        nearableManager.startRangingForType(ESTNearableType.All)
        
    }
    

    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    @IBAction func onPopupBtnPressed(sender: UIButton) {
        
        var popView = PopupViewController (nibName: "PopupView" , bundle : nil)
        
        var popController = UIPopoverController(contentViewController: popView)
        
        popController.popoverContentSize = CGSize(width: 600, height: 600)
        
        popController.presentPopoverFromRect(hiddenView.frame , inView: self.view , permittedArrowDirections: UIPopoverArrowDirection.Down, animated: true)
    }
    
    
    //nearableManagerDelegates
    func nearableManager(manager: ESTNearableManager!,
        didRangeNearables nearables: [AnyObject]!,
        withType type: ESTNearableType) {
            
            self.nearables = nearables as! Array <ESTNearable>
            var n = nearables as! Array <ESTNearable>
            var anyMoved = false
            for (s,e) in savedStableState {
                if isCalibrated {
                    if var moved = nh.hasStickerMoved(s, currentNearableArr : self.nearables , savedNearableArr : savedStableState ){  //if moving item is in savedStableState
                        if moved {
                            var text = ""
                            switch s {
                            case "9b3cd4460c56565e":
                                imageView.image = imgFridge
                            case "d59a7be8987f28a4" :
                                imageView.image = imgDoor
                            case "8b386da476667197" :
                                imageView.image = imgBag
                            case "9b3cd4460c56565e" :
                                imageView.image = imgBag
                            case "7830f21de0035fe3" :
                                imageView.image = imgDoor
                            default :
                                print("new item found : \(s)");
                            }
                            
                            infoLbl.text = nh.getNameFromId(s);
                            anyMoved = true;
                            break ; // break out of loop to prevent flashing
                        }
                    }
                    else {//if the moving item is not in savedStableState
                        infoLbl.text = "moving label not in savedStableState"
                    }
                }
            }
            
            if !anyMoved {
                infoLbl.text = "nothing is moving"
                imageView.image = imgPTC
                
            }
            
    }
    @IBAction func onCalibrationClicked(sender: AnyObject) {
        for n in nearables{
            savedStableState[n.identifier] = (n.xAcceleration, n.yAcceleration, n.zAcceleration)
        }
        infoLbl.text = "calibrated with \(nearables.count) items"
        
        if (nearables.count > 0 ) {
            isCalibrated = true
        }
    }
}


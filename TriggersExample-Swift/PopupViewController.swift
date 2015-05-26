//
//  PopupViewController.swift
//  TriggersExample-Swift
//
//  Created by Mike Chen on 5/25/15.
//  Copyright (c) 2015 Estimote Inc. All rights reserved.
//

import UIKit
import MediaPlayer

class PopupViewController :UIViewController {
    
    var moviePlayer : MPMoviePlayerController?
    
    @IBOutlet var closeBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        playVideo()
    }
    
    @IBAction func closePopup(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: {})
    }
    
    private func playVideo() {
        if let
            url = NSBundle.mainBundle().URLForResource("video", withExtension: "m4v"),
            moviePlayer = MPMoviePlayerController(contentURL: url) {
                self.moviePlayer = moviePlayer
                moviePlayer.view.frame = self.view.bounds
                moviePlayer.prepareToPlay()
                moviePlayer.scalingMode = .AspectFill
                self.view.addSubview(moviePlayer.view)
        } else {
            debugPrintln("Ops, something wrong when playing video.m4v")
        }
    }
}


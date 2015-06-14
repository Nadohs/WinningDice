
//
//  ViewController.swift
//  WinningDice
//
//  Created by Rich on 6/13/15.
//  Copyright (c) 2015 NadohsInc. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    
    
    let synth = AVSpeechSynthesizer()
    var myUtterance = AVSpeechUtterance(string: "")
    
    
    func readText(text:String){
        myUtterance = AVSpeechUtterance(string:text)
        myUtterance.rate = 0.15
        synth.speakUtterance(myUtterance)
    }

    @IBOutlet weak var rollLabel: UILabelOverlay!
    
    var diceType = ["4","6", "8", "10", "12", "20"];
    
    var index = -1;
    
    var timer = NSTimer()
    var isRunning = false;
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addPressGesture()
    }
    
    
    
    
    func startTimer(){
        isRunning = true;
        timer = NSTimer.scheduledTimerWithTimeInterval(2.0, target: self, selector: Selector("runTimer"), userInfo: nil, repeats: true)
    }
    
    
    
    func runTimer(){
        if !isRunning{
            return;
        }
        
        index++;
        if index >= diceType.count{
            index = 0;
        }
        
        readText("D " + diceType[index])
        
    }
    
    
    
    func endTimer(){
        
        let max = UInt32(diceType[index].toInt()!)
        let random = arc4random() % max + 1;
        readText("roll is \(random)")
        
        isRunning = false;
        timer.invalidate()
        self.rollLabel.text = "Type: " + diceType[index] + " Roll: " + "\(random)"
    }
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    

    func addPressGesture(){
        let longPressRecognizer = UILongPressGestureRecognizer(target: self, action: "longPressed:")
        self.view.addGestureRecognizer(longPressRecognizer)
    }
    
    

    func longPressed(g: UILongPressGestureRecognizer){
        switch g.state{
        case UIGestureRecognizerState.Began:
            startTimer();
        case .Ended, .Cancelled:
            endTimer();
        default:
            println("")
        }
        if g.state == UIGestureRecognizerState.Began{
            
        }
        println("longpressed")
    }
    
    
}//class close bracket



class UILabelOverlay: UILabel{
    override func hitTest(point: CGPoint, withEvent event: UIEvent?) -> UIView? {
        let hitView = super.hitTest(point, withEvent: event)
        if hitView == self{
            return nil;
        }else{
            return hitView;
        }
    }
}

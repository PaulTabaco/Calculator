//
//  ViewController.swift
//  retro-calculator
//
//  Created by paul on 16.12.15.
//  Copyright © 2015 Training. All rights reserved.
//

import UIKit
import AVFoundation // added for sound

class ViewController: UIViewController {


    enum Operation:String {
        case Divide = "/"
        case Multiply = "*"
        case Substract = "-"
        case Add = "+"
        case Empty = "Empty"
        
    }
    
    var btnSound:AVAudioPlayer!
    
    var runningNumber = ""
    var leftValStr = ""
    var rightVarStr = ""
    var currentOperation:Operation = Operation.Empty
    var result = ""

    
    
    // OUTLETS
    @IBOutlet weak var outputLbl:UILabel!
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let path = NSBundle.mainBundle().pathForResource("btn", ofType: "wav")
        let soundURL = NSURL (fileURLWithPath: path!)
        
        do {
            try btnSound = AVAudioPlayer(contentsOfURL: soundURL)
            btnSound.prepareToPlay()
            
        } catch let err as NSError {
            print(err.debugDescription)
        }
    }
    
    @IBAction func numberPressed (btn:UIButton!) {
        playSound()
        runningNumber += "\(btn.tag)"
        outputLbl.text = runningNumber
    }


    @IBAction func onDividePressed(sender: AnyObject) {
        processOperation(Operation.Divide)
    }

    @IBAction func onMultiplyPressed(sender: AnyObject) {
        processOperation(Operation.Multiply)
    }
    
    @IBAction func onSubtractPressed(sender: AnyObject) {
        processOperation(Operation.Substract)
    }
 
    @IBAction func onAddPressed(sender: AnyObject) {
        processOperation(Operation.Add)
    }

    @IBAction func onEqualPressed(sender: AnyObject) {
        processOperation(currentOperation)
    }
    
    func processOperation (op:Operation) {
        playSound()
        
        if currentOperation != Operation.Empty {
            // кнопки действия уже нажимались
            
            if runningNumber != "" {
                rightVarStr = runningNumber
                runningNumber = ""
                
                if currentOperation == Operation.Multiply {
                    result = "\(Double(leftValStr)! * Double(rightVarStr)!)"
                } else if currentOperation == Operation.Divide {
                    result = "\(Double(leftValStr)! / Double(rightVarStr)!)"
                } else if currentOperation == Operation.Add {
                    result = "\(Double(leftValStr)! + Double(rightVarStr)!)"
                } else if currentOperation == Operation.Substract {
                    result = "\(Double(leftValStr)! - Double(rightVarStr)!)"
                }
            }
            
            leftValStr = result
            outputLbl.text = result
            currentOperation = op
            
        } else {
            // Значит это кнопка операции нажата впервые
            leftValStr = runningNumber
            runningNumber = ""
            currentOperation = op
        }
        
        
    }
    
    func playSound() {
        if btnSound.playing {
            btnSound.stop()
        }
        btnSound.play()
    }
    
}
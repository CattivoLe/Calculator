//
//  ViewController.swift
//  Калькулятор
//
//  Created by Александр Омельчук on 26.08.2018.
//  Copyright © 2018 Александр Омельчук. All rights reserved.
//

import UIKit
import AVFoundation
import AudioToolbox

class ViewController: UIViewController {

    
    @IBOutlet weak var displayResult: UILabel!
    
    
    var stillTyping = false
    var dotIsPlaced = false
    var firstOperand: Double = 0
    var secondOperand: Double = 0
    var operationSign: String = ""
    
    var currentInput: Double {
        get {
            return Double (displayResult.text!)!
        }
        set {
            displayResult.text = "\(newValue)"
            stillTyping = false
        }
    }
    
    
    
    @IBAction func numberPressed(_ sender: UIButton) {
        AudioServicesPlaySystemSound(SystemSoundID(1104))
        let number = sender.currentTitle!
        print(number)
        
        if stillTyping {
            if (displayResult.text?.count)! < 10 {
                displayResult.text = displayResult.text! + number
            }
        } else {
            displayResult.text = number
            stillTyping = true
        }
    }
    
    
    
    @IBAction func twoOperandSignPressed(_ sender: UIButton) {
        AudioServicesPlaySystemSound(SystemSoundID(1104))
        operationSign = sender.currentTitle!
        firstOperand = currentInput
        stillTyping = false
        dotIsPlaced = false
    }
    
    
    
    func operateWhisTwoOperands (operation: (Double, Double) -> Double) {
        currentInput = operation (firstOperand, secondOperand)
        stillTyping = false
    }
    
    
    
    @IBAction func EqualitySignPressed(_ sender: UIButton) {
        AudioServicesPlaySystemSound(SystemSoundID(1104))
        
        dotIsPlaced = false
        
        if stillTyping {
            secondOperand = currentInput
        }
        switch operationSign {
        case "+":
            operateWhisTwoOperands {$0 + $1}
        case "-":
            operateWhisTwoOperands {$0 - $1}
        case "×":
            operateWhisTwoOperands {$0 * $1}
        case "÷":
            operateWhisTwoOperands {$0 / $1}
        default: return
        }
    }
    
    
    @IBAction func clearButtonPressed(_ sender: UIButton) {
        AudioServicesPlaySystemSound(SystemSoundID(1104))
        displayResult.text = "0"
        firstOperand = 0
        secondOperand = 0
        operationSign = ""
        currentInput = 0
        stillTyping = false
        dotIsPlaced = false
    }
    
    @IBAction func plusMinusButtonPressed(_ sender: UIButton) {
        AudioServicesPlaySystemSound(SystemSoundID(1104))
        currentInput = -currentInput
    }
    
    @IBAction func persentButtonPressed(_ sender: UIButton) {
        AudioServicesPlaySystemSound(SystemSoundID(1104))
        if firstOperand == 0 {
            currentInput = currentInput / 100
        } else {
            secondOperand = firstOperand * currentInput / 100
        }
        displayResult.text = displayResult.text! + "%"
        stillTyping = false
    }
    
    @IBAction func corenButtonPressed(_ sender: UIButton) {
        AudioServicesPlaySystemSound(SystemSoundID(1104))
        currentInput = sqrt (currentInput)
    }
    
    @IBAction func pointButtonPressed(_ sender: UIButton) {
        AudioServicesPlaySystemSound(SystemSoundID(1104))
        if stillTyping && !dotIsPlaced {
            displayResult.text = displayResult.text! + "."
            dotIsPlaced = true
        } else if !stillTyping && !dotIsPlaced {
            displayResult.text = "0."
        }
    }
}

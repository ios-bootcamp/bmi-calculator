//
//  ViewController.swift
//  BMI Calculator
//
//  Created by student12 on 2/2/19.
//  Copyright © 2019 pedro. All rights reserved.
//

import UIKit

extension String {
    func toDouble() -> Double? {
        return NumberFormatter().number(from: self)?.doubleValue
    }
    
    var isDouble: Bool {
        return NumberFormatter().number(from: self)?.doubleValue != nil
    }
}

class ViewController: UIViewController {

    var weightKg: Double = 0 {
        didSet {
            if oldValue != weightKg {
                weightLb = weightKg * 2.205
            }
        }
    }
    
    var weightLb: Double = 0 {
        didSet {
            if oldValue != weightLb {
                weightKg = weightLb / 2.205
            }
        }
    }
    
    var heighIn: Double = 0 {
        didSet {
            if oldValue != heighIn {
                heighCm = heighIn * 2.54
            }
        }
    }
    
    var heighCm: Double = 0 {
        didSet {
            if oldValue != heighCm {
                heighIn = heighCm / 2.54
            }
        }
    }
    
    var bmi: Double = 0 {
        didSet {
            switch bmi {
                case 0..<19:
                    resultLabel.textColor = .blue
                    messageLabel.textColor = .blue
                    messageLabel.text = "Underweight"
                case 19..<25:
                    resultLabel.textColor = .green
                    messageLabel.textColor = .green
                    messageLabel.text = "Healthy"
                case 25..<30:
                    resultLabel.textColor = .yellow
                    messageLabel.textColor = .yellow
                    messageLabel.text = "Overweight"
                case 30..<40:
                    resultLabel.textColor = .orange
                    messageLabel.textColor = .orange
                    messageLabel.text = "Obese"
                case 40...:
                    resultLabel.textColor = .red
                    messageLabel.textColor = .red
                    messageLabel.text = "Extremely Obese"
                default:
                    resultLabel.textColor = .black
                    messageLabel.textColor = .black
                    messageLabel.text = ""
            }
            
            resultLabel.text = String(format: "%.1f", bmi)
        }
    }
    
    @IBOutlet weak var resultLabel: UILabel!
    @IBOutlet weak var weightText: UITextField!
    @IBOutlet weak var heightText: UITextField!
    @IBOutlet weak var messageLabel: UILabel!
    @IBOutlet weak var weightSelector: UISegmentedControl!
    @IBOutlet weak var heightSelector: UISegmentedControl!
    
    @IBAction func weightSelectorChange(_ sender: Any) {
        if !(weightText.text?.isEmpty)! && weightText.text!.isDouble {
            if weightSelector.selectedSegmentIndex == 0 {
                weightText.text = String(format: "%.2f", weightText.text!.toDouble()! / 2.205)
            } else {
                weightText.text = String(format: "%.0f", weightText.text!.toDouble()! * 2.205)
            }
        }
    }
    
    @IBAction func heightSeletorChange(_ sender: Any) {
        if !(heightText.text?.isEmpty)! && heightText.text!.isDouble {
            if heightSelector.selectedSegmentIndex == 0 {
                heightText.text = String(format: "%.2f", (heightText.text!.toDouble()! * 2.54) / 100)
            } else {
                heightText.text = String(format: "%.2f", (heightText.text!.toDouble()! * 100) / 2.54)
            }
        }
    }
    
    @IBAction func calculateButton(_ sender: Any) {
        if weightText.text!.isEmpty || !weightText.text!.isDouble {
            weightText.text = "0"
        }
        
        if heightText.text!.isEmpty || !heightText.text!.isDouble {
            heightText.text = "0"
        }
        
        if weightSelector.selectedSegmentIndex == 0 {
            weightKg = weightText.text!.toDouble()!
        } else {
            weightLb = weightText.text!.toDouble()!
        }
    
        if heightSelector.selectedSegmentIndex == 0 {
            heighCm = heightText.text!.toDouble()!
        } else {
            heighIn = heightText.text!.toDouble()!
        }
        
        bmi = heighCm != 0 ? weightKg / (heighCm * heighCm) : 0
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }


}


//
//  ViewController.swift
//  Tips
//
//  Created by Kyle Pickering on 9/7/14.
//  Copyright (c) 2014 Kyle Pickering. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    

    @IBOutlet weak var billField: UITextField!
    @IBOutlet weak var tipControl: UISegmentedControl!
    @IBOutlet weak var tipLabel: UILabel!
    @IBOutlet weak var tipView: UIView!
    @IBOutlet weak var totalLabel: UILabel!
    @IBOutlet weak var totalView: UIView!
    
    var detailsVisible = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        tipLabel.text = "$0.00"
        totalLabel.text = "$0.00"
        
        billField.becomeFirstResponder()
        
        tipView.alpha = 0
        totalView.alpha = 0
        tipControl.alpha = 0
        
        var billFrame = billField.frame;
        billFrame.origin.y = 140;
        billField.frame = billFrame;
        
        var tipFrame = tipView.frame;
        tipFrame.origin.y += 10;
        tipView.frame = tipFrame;
        
        var totalFrame = totalView.frame;
        totalFrame.origin.y += 10;
        totalView.frame = totalFrame;
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func onEditingChanged(sender: AnyObject) {
        
        var tipPercentages = [0.15, 0.2, 0.25]
        var tipPercentage = tipPercentages[tipControl.selectedSegmentIndex]
        
        var billAmount = NSString(string: billField.text).doubleValue
        var tipAmount = billAmount * tipPercentage
        var totalAmount = billAmount + tipAmount
        
        if billAmount > 0 {
            if detailsVisible == false {
                UIView.animateWithDuration(0.4, animations: {
                    var billFrame = self.billField.frame;
                    billFrame.origin.y = 20;
                    self.billField.frame = billFrame;
                })
                
                UIView.animateWithDuration(0.2, delay: 0.2, options: .CurveLinear, animations: {
                    var tipFrame = self.tipView.frame;
                    tipFrame.origin.y -= 10;
                    self.tipView.frame = tipFrame;
                    
                    var totalFrame = self.totalView.frame;
                    totalFrame.origin.y -= 10;
                    self.totalView.frame = totalFrame;
                    
                    self.tipView.alpha = 1
                    self.totalView.alpha = 1
                    self.tipControl.alpha = 1
                    
                    }, completion: {
                        (finished: Bool) in
                    })
                detailsVisible = true
            }
        } else {
            UIView.animateWithDuration(0.4, animations: {
                self.tipView.alpha = 0
                self.totalView.alpha = 0
                self.tipControl.alpha = 0
                
                var billFrame = self.billField.frame;
                billFrame.origin.y = 140;
                self.billField.frame = billFrame;
                
                var tipFrame = self.tipView.frame;
                tipFrame.origin.y += 10;
                self.tipView.frame = tipFrame;
                
                var totalFrame = self.totalView.frame;
                totalFrame.origin.y += 10;
                self.totalView.frame = totalFrame;
            })
            detailsVisible = false
        }
        
        tipLabel.text = "$\(tipAmount)"
        totalLabel.text = "$\(totalAmount)"
        
        tipLabel.text = String(format:"$%.2f", tipAmount)
        totalLabel.text = String(format:"$%.2f", totalAmount)
    }

    @IBAction func onTap(sender: AnyObject) {
        view.endEditing(true)
    }
}


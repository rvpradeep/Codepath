//
//  ViewController.swift
//  tipcalc
//
//  Created by Pradeep Vairamani on 12/22/16.
//  Copyright © 2016 Pradeep Vairamani. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet var mainView: UIView!
    @IBOutlet weak var billField: UITextField!
    @IBOutlet weak var tipLabel: UILabel!
    @IBOutlet weak var splitLabel: UILabel!
    @IBOutlet weak var amtController: UISegmentedControl!
    @IBOutlet weak var spinnerController: UIStepper!
    @IBOutlet weak var amtPerPerson: UILabel!
    @IBOutlet weak var totalLabel: UILabel!
    let gradientLayer = CAGradientLayer()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        billField.becomeFirstResponder()
        gradientLayer.frame = self.view.bounds
        let color1 = UIColor(red: 0.15, green: 0.67, blue: 0.66, alpha: 1.0).cgColor as CGColor
        let color2 = UIColor(red: 0, green: 0.0, blue: 1.0, alpha: 0.5).cgColor as CGColor
        gradientLayer.colors = [color1, color2]
        //        gradientLayer.locations = [0.0, 0.25, 0.75, 1.0]
//        self.view.layer.addSublayer(gradientLayer)
        self.view.layer.insertSublayer(gradientLayer, at: 0)
        
        let defaults = UserDefaults.standard
        let defaultVal = defaults.value(forKey: "default_tip")
        if(defaultVal != nil){
            let intDefaultVal = defaults.value(forKey: "default_tip") as! Int
            amtController.selectedSegmentIndex = intDefaultVal

        }
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        mainView.endEditing(false)
        let defaults = UserDefaults.standard
        let defaultVal = defaults.value(forKey: "default_tip")
        if(defaultVal != nil){
            let intDefaultVal = defaults.value(forKey: "default_tip") as! Int
            amtController.selectedSegmentIndex = intDefaultVal
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func onSpinnerChange(_ sender: Any) {
        OnBillChange(sender)
        mainView.endEditing(true)
    }

    @IBAction func onSegmentChange(_ sender: Any) {
        OnBillChange(sender)
        mainView.endEditing(true)
    }
    @IBAction func OnBillChange(_ sender: Any) {
        let tipValuesArray = [15.0, 20.0, 25.0]
        let billValue = Double(billField.text!) ?? 0
        let tipPercentatge = tipValuesArray[amtController.selectedSegmentIndex]
        let tipValue = (billValue * tipPercentatge)/100
        tipLabel.text = String(format: "$%.2f", tipValue)
        let totalValue = billValue + tipValue
        totalLabel.text = String(format: "$%.2f", totalValue)
        
        // Logic to split bill
        let noSplits = Int(spinnerController.value)
        if (noSplits == 1) {
            splitLabel.text = String("Not splitting the bill with anyone ")
        }
        else{
            splitLabel.text = "Splitting the bill among " + String(noSplits) + " people"
        }
        let perPersonVal = Double(totalValue/Double(noSplits))
        amtPerPerson.text = String(format: "$%.2f", perPersonVal)
        
        
    }
    
}


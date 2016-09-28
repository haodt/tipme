//
//  ViewController.swift
//  tipme
//
//  Created by Hao on 9/29/16.
//  Copyright © 2016 Hao. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var billField: UITextField!
    
    @IBOutlet weak var tipLabel: UILabel!
    
    @IBOutlet weak var totalLabel: UILabel!
    
    @IBOutlet weak var tipControl: UISegmentedControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let defaults = UserDefaults.standard;
        let percentage = defaults.integer(forKey:"percentage");
        
        tipControl.selectedSegmentIndex = percentage;
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func onTap(_ sender: AnyObject) {
        view.endEditing(true);
    }

    @IBAction func calculate(_ sender: AnyObject) {
        
        let percentages = [0.18,0.2,0.25];
        let bill = Double(billField.text!) ?? 0;
        let tip = bill * percentages[tipControl.selectedSegmentIndex];
        let total = bill + tip;
        
        tipLabel.text = String.init(format: "$%.2f",tip);
        totalLabel.text = String.init(format: "$%.2f",total);
    }
}


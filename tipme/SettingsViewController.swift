//
//  SettingsViewController.swift
//  tipme
//
//  Created by Hao on 9/29/16.
//  Copyright © 2016 Hao. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController {

    @IBOutlet weak var defaultControl: UISegmentedControl!
    
    var percentages = [0.8,0.2,0.25];
    var percentageKey = "percentage";
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let defaults = UserDefaults.standard;
        let percentage = defaults.integer(forKey:percentageKey);
        
        defaultControl.selectedSegmentIndex = percentage;
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func setDefaultPercentage(_ sender: AnyObject) {
        let defaults = UserDefaults.standard;
        
        defaults.set(defaultControl.selectedSegmentIndex,forKey:percentageKey);
        defaults.synchronize();
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

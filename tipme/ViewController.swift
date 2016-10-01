//
//  ViewController.swift
//  tipme
//
//  Created by Hao on 9/29/16.
//  Copyright © 2016 Hao. All rights reserved.
//

import UIKit

class ViewController: UIViewController,UITableViewDelegate, UITableViewDataSource{

    @IBOutlet weak var tableHistory: UITableView!
    
    @IBOutlet weak var billField: UITextField!
    
    @IBOutlet weak var saveButton: UIButton!
    
    @IBOutlet weak var tipLabel: UILabel!
    
    @IBOutlet weak var totalLabel: UILabel!
    
    @IBOutlet weak var tipControl: UISegmentedControl!
    
    let savedText = "Saved";
    
    let notSavedText = "Save to history";
    
    let percentages = [0.18,0.2,0.25];
    
    let TippedsKey = "Tippeds";
    
    var tippeds = [Tipped]();
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tippeds.count;
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell = Bundle.main.loadNibNamed("TipCellTableViewCell", owner: self, options:nil)?.first as! TipCellTableViewCell,
            tipped = tippeds[indexPath.row];
        
        cell.percentLabel.text = String.init(format:"%.0f",tipped.percent)+" %";
        cell.tippedLabel.text = self.getFormatter().string(from:NSNumber.init(value:tipped.tipped));
    
        return cell;
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        // Nothing to do
    }
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        let defaults = UserDefaults.standard;
        let percentage = defaults.integer(forKey:"percentage"),
            prevbill = defaults.string(forKey:"prevbill"),
            lastedit = defaults.double(forKey: "lastedit"),
            now  = NSDate().timeIntervalSince1970;
        
        tipControl.selectedSegmentIndex = percentage;

        let bill = Double(prevbill!) ?? 0;

        if((now - lastedit) < 1*60 && bill > 0){
            billField.text = prevbill;
            calculate({} as AnyObject);
        }
        
        
        tippeds = defaults.object(forKey: TippedsKey) as? [Tipped] ?? [Tipped]();
        
        tableHistory.delegate = self;
        tableHistory.dataSource = self;
        tableHistory.reloadData();
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated);
        ThemeManager.apply(view:self.view);
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated);
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated);
        billField.becomeFirstResponder();
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func getFormatter()->NumberFormatter{
        let fmt = NumberFormatter();
        fmt.numberStyle = .currency;
        fmt.formatterBehavior = .behavior10_4;
        fmt.locale = Locale(identifier:"vi_VN");
        return fmt;
    }
    
    @IBAction func onSave(_ sender: UIButton) {
        let bill = Double(billField.text!) ?? 0;
        let tip = bill * percentages[tipControl.selectedSegmentIndex];
        let total = bill + tip;
        
        if(saveButton.titleLabel?.text != savedText && bill > 0){
            saveButton.setTitle(savedText, for: UIControlState.normal)
            
            let tipped = Tipped(
                percent:percentages[tipControl.selectedSegmentIndex] * 100,
                bill:bill,
                tipped:tip,
                total:total
            );

            tippeds.insert(tipped,at:0);
            tableHistory.reloadData();
            
            let defaults = UserDefaults.standard,
                serialized = Tipped.jsonArray(array: tippeds);
            
            let data = serialized.data(using: .utf8)!,
                json = try? JSONSerialization.jsonObject(with: data) as? [Any];
            // TODO : parse json
            if(json != nil){
                Tipped.parseJson(items: json)
            }
            //defaults.set(tippeds, forKey: TippedsKey);
        }
    }
    
    @IBAction func onReset(_ sender: UIButton) {
        billField.text = "";
        saveButton.setTitle(notSavedText, for: UIControlState.normal)
        calculate({} as AnyObject);
    }

    @IBAction func onTap(_ sender: AnyObject) {
        view.endEditing(true);
    }

    @IBAction func calculate(_ sender: AnyObject) {
        
        let bill = Double(billField.text!) ?? 0;
        let tip = bill * percentages[tipControl.selectedSegmentIndex];
        let total = bill + tip;
        
        let defaults = UserDefaults.standard;
        let lastedit = NSDate().timeIntervalSince1970;
        
        defaults.set(billField.text,forKey:"prevbill");
        defaults.set(lastedit,forKey:"lastedit");
        
        tipLabel.text = self.getFormatter().string(from:NSNumber.init(value:tip));
        totalLabel.text = self.getFormatter().string(from:NSNumber.init(value:total));
        
        
    }
}


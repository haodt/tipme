//
//  TipCellTableViewCell.swift
//  tipme
//
//  Created by Hao on 10/1/16.
//  Copyright © 2016 Hao. All rights reserved.
//

import UIKit

struct Tipped {
    var percent:Double!
    var bill:Double!
    var tipped:Double!
    var total:Double!
    
    static func jsonArray(array : [Tipped]) -> String{
        return "[" + array.map {$0.jsonRepresentation}.joined(separator: ",") + "]"
    }
    
    var jsonRepresentation : String {
        return "{\"percent\":\"\(percent)\",\"bill\":\"\(bill)\",\"tipped\":\"\(tipped)\",\"total\":\"\(total)\"}"
    }
    
    static func parseJson(items: [Any]??) -> Array<Tipped>{
        var list: Array<Tipped> = []
        var b:Tipped = Tipped();
        
        if let data = items as? [[String:Any]]{
            for item in data{
                
                if let p = item["percent"] as? String {
                
                    print(Double(p));
                    
                }
                
                list.append(b)
            }
        }
        //print(list,items);
        return list
    }
}

class TipCellTableViewCell: UITableViewCell {
    
    @IBOutlet weak var percentLabel: UILabel!

    @IBOutlet weak var tippedLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

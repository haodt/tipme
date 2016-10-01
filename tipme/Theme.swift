//
//  Theme.swift
//  tipme
//
//  Created by Hao on 10/1/16.
//  Copyright © 2016 Hao. All rights reserved.
//

import Foundation

import UIKit

let SelectedThemeKey = "theme"

enum Theme : Int{
    
    case Default, Dark
    
    var tint: UIColor {
        switch self {
        case .Default:
            return UIColor(red: 87.0/255.0, green: 188.0/255.0, blue: 95.0/255.0, alpha: 1.0)
        case .Dark:
            return UIColor.white;
        }
    }
    
    var inverse: UIColor {
        switch self {
        case .Default:
            return UIColor.gray;
        case .Dark:
            return UIColor(red: 33.0/255.0, green: 88.0/255.0, blue: 39.0/255.0, alpha: 1.0)
        }
    }
    
    var  background: UIColor {
        switch self {
        case .Default:
            return UIColor.white;
        case .Dark:
            return UIColor(red: 87.0/255.0, green: 188.0/255.0, blue: 95.0/255.0, alpha: 1.0)
        }
    }
}

struct ThemeManager {
    
    static func apply(view:UIView) {
        let theme = current();
        UIApplication.shared.delegate?.window??.tintColor = theme.tint;
        
        view.backgroundColor = theme.background;
        for v in view.subviews {
            if let label = v as? UILabel {
                label.textColor = theme.tint;
            }
            if(v.tag == 1){
                v.backgroundColor = theme.inverse;
            }
        }
    }
    
    static func change(key:Int){
    
        let defaults = UserDefaults.standard;
        
        var storing = key;
        
        if(storing < 0 || storing > 2){
            storing = 1;
        }
        
        defaults.set(storing,forKey:SelectedThemeKey);
    
    }
    
    static func current() -> Theme {
        let defaults = UserDefaults.standard;
        let stored = defaults.integer(forKey:SelectedThemeKey);
        
        if(stored > 0 && stored < 2){
            return Theme(rawValue:stored)!;
        }
        
        return .Default;
    }
    
}

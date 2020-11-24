//
//  CountDownFullTimeStyle.swift
//  Pods
//
//  Created by Martin Kluska on 01.06.16.
//
//

import Foundation

/// Foramtes the time in full style. Prepared for the full string countdown
class CountDownFullTimeStyle: CountDownFullStyle {
    
    /**
     Sets the time separator
     
     - parameter formatter:
     */
    override func setup(formatter: CountDownBaseFormatter) {
        super.setup(formatter: formatter)
        
        // ensure the correct time separator
        formatter.timeSeparator = " "
    }
    
    /**
     Checks if the components value can be formated. Only seconds are alowed to be zero
     
     - parameter component:
     - parameter value:
     
     - returns:
     */
    override func canFormatComponent(component: CountDownFormatComponent, value: Int) -> Bool {
        return component == .second || super.canFormatComponent(component: component, value: value)
    }
}

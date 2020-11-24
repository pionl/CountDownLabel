//
//  CountDownISOTimeStyle.swift
//  Pods
//
//  Created by Martin Kluska on 01.06.16.
//
//

import Foundation

/// Foramtes the time in full style. Prepared for the full string countdown
class CountDownISOTimeStyle: CountDownStyleProtocol {
    
    /**
     Sets the time separator
     
     - parameter formatter:
     */
    func setup(formatter: CountDownBaseFormatter) {
        
        // ensure the correct time separator
        formatter.timeSeparator = ":"
        
        // if we have a full style, we will add a 'and' separator
        if formatter.dateStyle == .Full {
            formatter.dateTimeSeparator = CountDownBundle.localizedString(key: "date_time_separator_full_to_iso")
        }
    }
    
    /**
     All values can be returned for a time
     
     - parameter component:
     - parameter value:
     
     - returns:
     */
    func canFormatComponent(component: CountDownFormatComponent, value: Int) -> Bool {
        return true
    }
    
    /**
     Formates the value into 2 digits string
     
     - parameter component:
     - parameter value:
     
     - returns:
     */
    func format(component: CountDownFormatComponent, value: Int) -> String {
        return String(format: "%02d", value)
    }
}

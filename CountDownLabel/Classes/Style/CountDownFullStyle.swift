//
//  CountDownFullStyle.swift
//  Pods
//
//  Created by Martin Kluska on 01.06.16.
//
//

import Foundation

class CountDownFullStyle: CountDownStyleProtocol {
    
    /**
     Does nothing
     
     - parameter formatter:
     */
    func setup(formatter: CountDownBaseFormatter) {
       
    }
    
    /**
     Checks if the components value is not null
     
     - parameter compontent:
     - parameter value:
     
     - returns:
     */
    func canFormatComponent(component compontent: CountDownFormatComponent, value: Int) -> Bool {
        return value != 0
    }
    
    /**
     Formates the values into string component with the value
     
     - parameter component:
     - parameter value:
     
     - returns:
     */
    func format(component: CountDownFormatComponent, value: Int) -> String {
        // get the key
        let key = localizedKeyFor(component: component)
        
        // must include the stringdict
        let format = CountDownBundle.localizedString(key: key)
        
        // format the localized string with given value
        return String.localizedStringWithFormat(format, value)
    }
    
    /**
     Parsers the localized key from the component
     
     - parameter component:
     
     - returns:
     */
    func localizedKeyFor(component: CountDownFormatComponent) -> String {
        return component.rawValue;
    }
}

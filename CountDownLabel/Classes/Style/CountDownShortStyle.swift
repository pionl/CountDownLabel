//
//  CountDownShortStyle.swift
//  Pods
//
//  Created by Martin Kluska on 01.06.16.
//
//

import Foundation

/// Renders the short variant of the full style

class CountDownShortStyle: CountDownFullStyle {
    
    /**
     Setup the short variant for the localized key
     
     - parameter component:
     
     - returns: 
     */
    override func localizedKeyFor(component: CountDownFormatComponent) -> String {
        return super.localizedKeyFor(component: component) + "_short"
    }
}

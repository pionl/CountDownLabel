//
//  CountDownBundle.swift
//  Pods
//
//  Created by Martin Kluska on 30.05.16.
//
//

import Foundation

/// Enables loading the count down bundle
class CountDownBundle: NSObject {
    
    /// Returns the shared bundle
    static let shared = CountDownBundle()
    
    /// Holds the current bundle for the resources
    var resourcesBundle: Bundle?
    
    override init() {
        super.init()
        
        // must load the frameowkr bundle
        let frameworkBundle = Bundle(for: self.classForCoder)
        
        // we must get the bundle with resources
        let path = frameworkBundle.path(forResource: "CountDownLabel", ofType: "bundle")
        
        // we must load the bundle
        resourcesBundle = Bundle(path: path!)!
    }
    
    /**
     Returns the resources bundle
     
     - returns:
     */
    static func resourceBundle() -> Bundle {
        return shared.resourcesBundle!
    }
    
    /**
     Returns the localized string from the bundle
     
     - parameter key:
     
     - returns:
     */
    static func localizedString(key: String) -> String {
        return NSLocalizedString(key, bundle: CountDownBundle.resourceBundle(), comment: "")
    }
}

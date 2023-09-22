//
//  UIApplication.swift
//  EPLPlus
//
//  Created by Cooper Jacob on 22/9/2023.
//

import Foundation
import SwiftUI


extension UIApplication {
    
    func endEditing() {
        sendAction (#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
    
}
 

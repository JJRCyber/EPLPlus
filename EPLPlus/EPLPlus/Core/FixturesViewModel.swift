//
//  FixturesViewModel.swift
//  EPLPlus
//
//  Created by Cooper Jacob on 20/9/2023.
//

import Foundation


final class FixturesViewModel: BaseViewModel {
    
    @Published var matchday: Int = 1
    @Published var animate: Bool = false
    
    func decrementMatchday() {
        if matchday > 1 {
            matchday -= 1
        }
    }
    
    func incrementMatchday() {
        if matchday < 40 {
            matchday += 1
        }
    }
    
}

//
//  BaseViewModel.swift
//  EPLPlus
//
//  Created by Cooper Jacob on 20/9/2023.
//

import Foundation

// BaseViewModel that most viewModels inherit from
// Declares instance of FootballDataManager and bool for loading state
class BaseViewModel: ObservableObject {
    let footballDataManager = FootballDataAPIManager.instance
    @Published var isLoading: Bool = true
    
}

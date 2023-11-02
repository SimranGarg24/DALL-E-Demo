//
//  SettingsViewModel.swift
//  DALL-E
//
//  Created by Saheem Hussain on 12/10/23.
//

import Foundation
import OpenAIKit

class SettingsViewModel: ObservableObject {
    
    @Published var lowResSelected: Bool = false
    @Published var medResSelected: Bool = true
    @Published var highResSelected: Bool = false
    
    func selectLowRes() {
        lowResSelected = true
        medResSelected = false
        highResSelected = false
    }
    
    func selectMedRes() {
        lowResSelected = false
        medResSelected = true
        highResSelected = false
    }
    
    func selectHighRes() {
        lowResSelected = false
        medResSelected = false
        highResSelected = true
    }
    
    func getselectedButton(resolution: ImageResolutions) {
        switch resolution {
        case .small:
            selectLowRes()
        case .medium:
            selectMedRes()
        case .large:
            selectHighRes()
        }
    }
}

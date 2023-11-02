//
//  DALL_EApp.swift
//  DALL-E
//
//  Created by 10683830 on 24/12/22.
//

import SwiftUI

@main
struct DALLEApp: App {
    
    init() {
        UIView.appearance(whenContainedInInstancesOf: [UIAlertController.self]).tintColor = .purple
    }
    var body: some Scene {
        WindowGroup {
            TabItem()
        }
    }
}

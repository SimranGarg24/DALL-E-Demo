//
//  TabView.swift
//  DALL-E
//
//  Created by Saheem Hussain on 06/10/23.
//

import SwiftUI

struct TabItem: View {
    var body: some View {
        
        TabView {
            ContentView()
                 .tabItem {
                     Label("Create", systemImage: "pencil.tip")
                 }
            
            EditImageView()
                .tabItem {
                    Label("Edit", systemImage: "pencil")
                }
            
            VariationView()
                .tabItem {
                    Label("Variation", systemImage: "pencil.and.outline")
                }
        }
    }
}

struct TabItem_Previews: PreviewProvider {
    static var previews: some View {
        TabItem()
    }
}

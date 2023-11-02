//
//  SlectionComponent.swift
//  DALL-E
//
//  Created by Saheem Hussain on 11/10/23.
//

import SwiftUI

struct SlectionComponent: View {
    
    var title: String
    var isSelected: Bool
    var action: () -> Void
    
    var body: some View {
        
        HStack {
            Button {
                action()
            } label: {
                if isSelected {
                    Image(systemName: "checkmark.circle.fill")
                        .foregroundColor(.purple)
                } else {
                    Image(systemName: "circle")
                        .foregroundColor(.purple)
                }
            }
            
            Text(title)
        }
        .padding(.top, 4)
    }
}

struct SlectionComponent_Previews: PreviewProvider {
    static var previews: some View {
        SlectionComponent(title: "Low", isSelected: true, action: {})
    }
}

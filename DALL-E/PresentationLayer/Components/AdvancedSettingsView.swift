//
//  AdvancedSettingsView.swift
//  DALL-E
//
//  Created by Saheem Hussain on 12/10/23.
//

import SwiftUI

struct AdvancedSettingsView: View {
    
    @Binding var isPresent: Bool
    
    var body: some View {
        
        VStack(alignment: .leading) {
            Text("Advanced Settings")
                .bold()
                .padding(.top, 24)
            
            Button {
                isPresent.toggle()
            } label: {
                HStack {
                    Text("Choose Settings")
                        .foregroundColor(.secondary)
                    
                    Spacer()
                    
                    Image(systemName: "chevron.down")
                        .foregroundColor(.black)
                }
                .padding()
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .background(Color.gray.opacity(0.2))
            .cornerRadius(12)
            .padding(.top, 4)
        }
    }
}

struct AdvancedSettingsView_Previews: PreviewProvider {
    static var previews: some View {
        AdvancedSettingsView(isPresent: Binding.constant(false))
    }
}

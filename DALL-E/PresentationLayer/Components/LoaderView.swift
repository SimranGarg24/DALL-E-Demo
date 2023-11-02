//
//  LoaderView.swift
//  DALL-E
//
//  Created by Saheem Hussain on 12/10/23.
//

import SwiftUI

struct LoaderView: View {
    var body: some View {
        
        VStack {
            
            HStack {
                
//                Text("Generating AI Images")
//                    .padding(.trailing)
//                    .font(.headline)
                
                ProgressView()
                    .progressViewStyle(CircularProgressViewStyle(tint: .purple))
                    .scaleEffect(2)
            }
            .padding(32)
            .background(Color.white)
            .cornerRadius(12)
            
//
//
            
        }
        .toolbar(.hidden, for: .tabBar)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(.black.opacity(0.8))
    }
}

struct LoaderView_Previews: PreviewProvider {
    static var previews: some View {
        LoaderView()
    }
}

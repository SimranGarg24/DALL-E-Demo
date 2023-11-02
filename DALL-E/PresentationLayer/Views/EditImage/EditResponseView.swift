//
//  EditResponseView.swift
//  DALL-E
//
//  Created by Saheem Hussain on 12/10/23.
//

import SwiftUI

struct EditResponseView: View {
    
    @ObservedObject var viewModel: EditImageViewModel
    
    var body: some View {
        if let imageArray = viewModel.imageArray {
            
            ZStack {
                VStack {
                    ResultView(imageArray: imageArray)
                        .toolbar(.hidden, for: .tabBar)
                    
                    ButtonView(title: "Regenerate") {
                        viewModel.generateImage()
                    }
                    .padding()
                }
                
                if viewModel.isImageLoading {
                    LoaderView()
                }
            }
            .toolbar(.hidden, for: .tabBar)
            .onDisappear {
                viewModel.originalImg = nil
                viewModel.maskImg = nil
                viewModel.text = String()
                viewModel.numberOfImages = 1
                viewModel.resolution = .medium
            }
        }
    }
}

struct EditResponseView_Previews: PreviewProvider {
    static var previews: some View {
        EditResponseView(viewModel: EditImageViewModel())
    }
}

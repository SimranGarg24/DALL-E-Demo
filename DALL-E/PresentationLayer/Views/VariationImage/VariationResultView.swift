//
//  VariationResultView.swift
//  DALL-E
//
//  Created by Saheem Hussain on 12/10/23.
//

import SwiftUI

struct VariationResultView: View {
    
    @ObservedObject var viewModel: VariationViewModel
    
    var body: some View {
        if let imageArray = viewModel.imageArray {
            
            ZStack {
                VStack {
                    ResultView(imageArray: imageArray)
                        .toolbar(.hidden, for: .tabBar)
                    
                    ButtonView(title: "Regenerate") {
                        if let image = viewModel.image {
                            viewModel.variation(image: image)
                        }
                    }
                    .padding()
                }
                
                if viewModel.isImageLoading {
                    LoaderView()
                }
            }
            .toolbar(.hidden, for: .tabBar)
            .onDisappear {
                viewModel.image = nil
                viewModel.numberOfImages = 1
                viewModel.resolution = .medium
            }
        }
    }
}

struct VariationResultView_Previews: PreviewProvider {
    static var previews: some View {
        VariationResultView(viewModel: VariationViewModel())
    }
}

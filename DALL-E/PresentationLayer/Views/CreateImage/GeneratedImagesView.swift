//
//  GeneratedImagesView.swift
//  DALL-E
//
//  Created by Saheem Hussain on 10/10/23.
//

import SwiftUI

struct GeneratedImagesView: View {
    
    @Environment (\.dismiss) var dismiss
    @ObservedObject var viewModel: ContentViewModel
    
    var body: some View {
        
        if let imageArray = viewModel.imageArray {
            
            ZStack {
                VStack {
                    
                    ResultView(imageArray: imageArray)
                    
                    HStack {
                        
                        ButtonView(title: "Edit Input", action: {
                            viewModel.fromEdit = true
                            dismiss()
                        })
                        
                        ButtonView(title: "Regenerate", action: {
                            if !viewModel.text.trimmingCharacters(in: .whitespaces).isEmpty {
                                viewModel.generateImage()
                            }
                        })
                    }
                    .padding()
                }
                
                if viewModel.isImageLoading {
                    LoaderView()
                }
            }
            .navigationTitle("Result")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar(.hidden, for: .tabBar)
            .onDisappear {
                if !viewModel.fromEdit {
                    viewModel.text = String()
                    viewModel.styleSelected = .noStyle
                    viewModel.resolution = .medium
                    viewModel.noOfImages = 1
                } else {
                    viewModel.fromEdit = false
                }
            }
            
        }
            
    }
}

struct GeneratedImagesView_Previews: PreviewProvider {
    static var previews: some View {
        GeneratedImagesView(viewModel: ContentViewModel())
    }
}

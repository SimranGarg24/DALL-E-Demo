//
//  VariationView.swift
//  DALL-E
//
//  Created by Saheem Hussain on 10/10/23.
//

import SwiftUI

struct VariationView: View {
    
    @StateObject var viewModel = VariationViewModel()
    
    var body: some View {
        
        NavigationStack {
            ZStack {
                VStack(alignment: .leading) {
                    
                    Text("Generate Variation of Image!!!")
                        .font(.largeTitle)
                        .bold()
                        .padding(.leading, 4)
                    
                    PhotoView(image: $viewModel.image)
                    
                    AdvancedSettingsView(isPresent: $viewModel.presentSheet)
                    
                    Spacer()
                    
                    ButtonView(title: "Generate") {
                        
                        if let image = viewModel.image {
                            viewModel.variation(image: image)
                        } else {
                            viewModel.error = "Please select an image"
                            viewModel.isPresented = true
                        }
                    }
                    .padding(.horizontal, 4)
                }
                .padding()
                
                if viewModel.isImageLoading {
                    LoaderView()
                }
            }
            .alert(viewModel.error ?? "", isPresented: $viewModel.isPresented) {
                Button("OK", role: .cancel) { }
            }
            .sheet(isPresented: $viewModel.presentSheet) {
                SettingsView(resolution: $viewModel.resolution, numberOfImages: $viewModel.numberOfImages)
                    .presentationDetents([.height(260)])
            }
            .navigationDestination(isPresented: $viewModel.navigate) {
                VariationResultView(viewModel: viewModel)
            }
        }
    }
    
}

struct VariationView_Previews: PreviewProvider {
    static var previews: some View {
        VariationView()
    }
}

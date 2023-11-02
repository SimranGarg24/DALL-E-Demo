//
//  EditImageView.swift
//  DALL-E
//
//  Created by Saheem Hussain on 10/10/23.
//

import SwiftUI

struct EditImageView: View {
    
    @StateObject var viewModel = EditImageViewModel()
    @FocusState var isFocus: Bool
    
//    @State private var image: Image?
//    @State private var imageData = Data()
    
    var body: some View {
        
        NavigationStack {
            ZStack {
                
                ScrollView(showsIndicators: false) {
                    
                    VStack(alignment: .leading) {
                        
                        Text("Edit Images!!")
                            .font(.largeTitle)
                            .bold()
                            .padding(.top)
                        
                        Text("Add image")
                            .bold()
                            .padding(.top)
                            .padding(.leading, 4)
                        
//                        if viewModel.maskImg == nil {
                            PhotoView(image: $viewModel.originalImg)
                                .padding(.top, 4)
                                .onChange(of: viewModel.originalImg, perform: { newImg in
                                    if newImg != nil {
                                        viewModel.isnavigate = true
                                    }
                                })
//                        }
                        
                        Text("Enter prompt")
                            .bold()
                            .padding(.top)
                            .padding(.leading, 4)
                        
                        TextEditorView(title: "Describe whole image..",
                                       textLimit: viewModel.textLimit,
                                       text: $viewModel.text,
                                       isFocused: _isFocus)
                        
                        AdvancedSettingsView(isPresent: $viewModel.presentSheet)
                            .padding(.bottom)
                        
                        ButtonView(title: "Generate") {
                            isFocus = false
                            viewModel.generateImage()
                            
                        }
                        .padding(.top)
                    }
                    .padding()
                }
                .onTapGesture {
                    isFocus = false
                }
                
                if viewModel.isImageLoading {
                    LoaderView()
                    
                }
            }
            .sheet(isPresented: $viewModel.presentSheet) {
                SettingsView(resolution: $viewModel.resolution, numberOfImages: $viewModel.numberOfImages)
                    .presentationDetents([.height(260)])
            }
            .alert(viewModel.error ?? "", isPresented: $viewModel.isPresented) {
                Button("OK", role: .cancel) { }
            }
            .navigationDestination(isPresented: $viewModel.navigate) {
                EditResponseView(viewModel: viewModel)
                
            }
            .navigationDestination(isPresented: $viewModel.isnavigate, destination: {
                CreateMaskView(viewModel: viewModel)
            })
        }
        
    }
}

struct EditImageView_Previews: PreviewProvider {
    static var previews: some View {
        EditImageView()
    }
}

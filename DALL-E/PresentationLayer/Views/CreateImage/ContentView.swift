//
//  ContentView.swift
//  DALL-E
//
//  Created by 10683830 on 24/12/22.
//

import SwiftUI

struct ContentView: View {
    
    @StateObject var viewModel = ContentViewModel()
    @FocusState var isFocus: Bool
    
    var body: some View {
        
        NavigationStack {
            
            ZStack {
                VStack {
                    
                    ScrollView(showsIndicators: false) {
                        
                        VStack(alignment: .leading) {
                            
                            Text("Turn Words into Art!!")
                                .font(.largeTitle)
                                .bold()
                                .padding(.top)
                            
                            Text("Enter Prompt")
                                .bold()
                                .padding(.top)
                            
                            TextEditorView(title: "What do you want to create?",
                                           textLimit: viewModel.textLimit,
                                           text: $viewModel.text,
                                           isFocused: _isFocus)
                            
                            HStack(alignment: .bottom) {
                                Text("Choose Style")
                                    .bold()
                                
                                Spacer()
                                
                                Button {
                                    viewModel.presentStyleView()
                                } label: {
                                    Text("See All")
                                        .font(.system(size: 15))
                                        .underline(pattern: .dot)
                                }

                            }.padding(.top)
                            
                            ScrollView(.horizontal, showsIndicators: false) {
                                LazyHStack(spacing: 20) {
                                    
                                    ForEach(0..<7, id: \.self) { index in

                                        Button {
                                            viewModel.styleSelected = ImageStyle.data[index].style
                                        } label: {
                                            StyleView(imageStyle: ImageStyle.data[index],
                                                      styleSelected: viewModel.styleSelected)
                                        }
                                    }
                                }
                                .padding(1)
                            }
                            
                            AdvancedSettingsView(isPresent: $viewModel.presentSheet)
                            
                        }
                    }
                    .padding(.horizontal, 4)
                    
                    Spacer()
                    
                    ButtonView(title: "Generate", action: {
                        isFocus = false
                        viewModel.generateImage()
                    })
                }
                .padding(20)
                .onTapGesture {
                    isFocus = false
                }
                
                if viewModel.isImageLoading {
                    LoaderView()
                }
                
            }
            .navigationBarTitleDisplayMode(.inline)
            .alert(viewModel.error ?? "", isPresented: $viewModel.isPresented) {
                Button("OK", role: .cancel) { }
            }
            .sheet(isPresented: $viewModel.presentSheet) {
                SettingsView(resolution: $viewModel.resolution, numberOfImages: $viewModel.noOfImages)
                    .presentationDetents([.height(260)])
            }
            .sheet(isPresented: $viewModel.presentStyleSheet) {
                StyleListView(viewModel: viewModel)
                    .presentationDetents([.medium, .large])
            }
            .navigationDestination(isPresented: $viewModel.nextScreen) {
                GeneratedImagesView(viewModel: viewModel)
            }
        }

    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            ContentView()
        }
    }
}

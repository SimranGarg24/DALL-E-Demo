//
//  SettingsView.swift
//  DALL-E
//
//  Created by Saheem Hussain on 11/10/23.
//

import SwiftUI
import OpenAIKit

struct SettingsView: View {
    
    @StateObject var viewModel = SettingsViewModel()
    @Binding var resolution: ImageResolutions
    @Binding var numberOfImages: Int
    
    var body: some View {
        
        VStack {
//            RoundedRectangle(cornerRadius: 4)
//                .frame(width: 30, height: 6)
//                .foregroundColor(.purple)
//                .padding()
//                .padding(.top)
            
            Text("Advanced Settings")
                .bold()
                .padding(.vertical)
                .padding(.top)
            
            Divider()
            
            VStack(alignment: .leading) {
                
                Text("Image Resolution")
                    .bold()
                    .padding(.horizontal)
                
                HStack {
                    
                    SlectionComponent(title: Resolution.low.rawValue, isSelected: viewModel.lowResSelected) {
                        resolution = .small
                        viewModel.selectLowRes()
                    }
                    
                    Spacer()
                    
                    SlectionComponent(title: Resolution.medium.rawValue, isSelected: viewModel.medResSelected) {
                        resolution = .medium
                        viewModel.selectMedRes()
                    }
                    
                    Spacer()
                    
                    SlectionComponent(title: Resolution.high.rawValue, isSelected: viewModel.highResSelected) {
                        resolution = .large
                        viewModel.selectHighRes()
                    }
                    
                }
                .padding(.horizontal)
                
                HStack(alignment: .bottom) {
                    
                    Text("Number of Images")
                        .bold()
                    
                    Spacer()
                    
                    Button {
                        if numberOfImages > 1 {
                            numberOfImages -= 1
                        }
                    } label: {
                        Image(systemName: "minus.circle.fill")
                            .foregroundColor(.gray)
                    }
                    
                    Text("\(numberOfImages)")
                    
                    Button {
                        if numberOfImages < 10 {
                            numberOfImages += 1
                        }
                    } label: {
                        Image(systemName: "plus.circle.fill")
                            .foregroundColor(.purple)
                    }

                }
                .padding()
                .padding(.top)
                
            }
            .padding()
            
            Spacer()
        }
        .onAppear {
            viewModel.getselectedButton(resolution: resolution)
        }
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView(resolution: Binding.constant(.medium), numberOfImages: Binding.constant(1))
    }
}

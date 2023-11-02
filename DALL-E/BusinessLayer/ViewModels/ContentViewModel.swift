//
//  ContentViewModel.swift
//  DALL-E
//
//  Created by Saheem Hussain on 06/10/23.
//

import SwiftUI
import OpenAIKit

final class ContentViewModel: ObservableObject {
    
    @Published var text = String()
    @Published var noOfImages = 1
    @Published var resolution: ImageResolutions = .medium
    @Published var styleSelected: Style = .noStyle
    
    @Published var imageArray: [UIImage]?
    @Published var error: String?
    
    @Published var isPresented: Bool = false
    @Published var isImageLoading: Bool = false
    @Published var presentSheet = false
    @Published var presentStyleSheet = false
    @Published var nextScreen = false
    @Published var fromEdit = false
    
    var textLimit: Int = 200
    let openai = OpenAIKitManager.shared
    
    func generateImage() {

        if !text.trimmingCharacters(in: .whitespaces).isEmpty {
            isImageLoading = true
            error = nil
            isPresented = false
            
            Task {
                let result = await openai.generateImage(promt: generatePrompt(),
                                                        resolution: resolution, numberOfImages: noOfImages)
                DispatchQueue.main.async {
                    if let imageArray = result.0 {
                        self.imageArray = imageArray
                        self.nextScreen = true
                    } else if let error = result.1 {
                        self.imageArray = result.0
                        self.error = error.error.message
                        self.isPresented = true
                    }
                    self.isImageLoading = false
                }
            }
        } else {
            isPresented = true
            error = "Please enter prompt."
        }
        
    }
    
    func generatePrompt() -> String {
        
        if styleSelected == .noStyle {
            return text
        } else {
            return "\(text) \(styleSelected.rawValue)"
        }
    }
    
    func presentSettingsView() {
        presentSheet.toggle()
    }
    
    func presentStyleView() {
        presentStyleSheet.toggle()
    }

    func sortImageStyles() {
        if let index = ImageStyle.data.firstIndex(where: { $0.style == styleSelected }) {
            let data = ImageStyle.data.remove(at: index)
            ImageStyle.data.insert(data, at: 1)
        }
    }
}

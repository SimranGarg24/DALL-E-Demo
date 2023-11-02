//
//  EditImageViewModel.swift
//  DALL-E
//
//  Created by Saheem Hussain on 10/10/23.
//

import Foundation
import SwiftUI
import OpenAIKit

class EditImageViewModel: ObservableObject {
    
    @Published var text = String()
    @Published var numberOfImages: Int = 1
    @Published var resolution: ImageResolutions = .medium
    
    @Published var originalImg: UIImage?
    @Published var maskImg: UIImage?
    
    @Published var imageArray: [UIImage]?
    @Published var error: String?
    @Published var isImageLoading: Bool = false
    
    @Published var isPresented: Bool = false
    @Published var presentSheet: Bool = false
    @Published var navigate: Bool = false
    @Published var isnavigate: Bool = false
    
    var textLimit = 200
    let openai = OpenAIKitManager.shared
    
    func editImage(image: UIImage, mask: UIImage, prompt: String) {
        
        isImageLoading = true
        error = nil
        isPresented = false
        
        Task {
            let result = await openai.editImage(image: image, mask: mask,
                                                prompt: prompt, numberOfImages: numberOfImages, resolution: resolution)
            DispatchQueue.main.async {
                if let imageArray = result.0 {
                    self.imageArray = imageArray
                    self.navigate = true
                } else if let error = result.1 {
                    self.imageArray = result.0
                    self.error = error.error.message
                    self.isPresented = true
                    self.navigate = false
                }
                self.isImageLoading = false
            }
        }
    }
    
    func generateImage() {
        
        if originalImg == nil {
            error = "Please select an image to edit"
            isPresented = true
            
        } else if !text.trimmingCharacters(in: .whitespaces).isEmpty {
            if let image = originalImg, let mask = maskImg {
                editImage(image: image, mask: mask, prompt: text)
            }
        }
    }
    
}

//
//  VariationViewModel.swift
//  DALL-E
//
//  Created by Saheem Hussain on 10/10/23.
//

import Foundation
import SwiftUI
import OpenAIKit

class VariationViewModel: ObservableObject {
    
    @Published var imageArray: [UIImage]?
    @Published var error: String?
    
    @Published var numberOfImages: Int = 1
    @Published var resolution: ImageResolutions = .medium
    @Published var image: UIImage?
    
    @Published var presentSheet: Bool = false
    @Published var isImageLoading: Bool = false
    @Published var isPresented: Bool = false
    @Published var navigate: Bool = false
    
    let openai = OpenAIKitManager.shared
    
    func variation(image: UIImage) {
        
        isImageLoading = true
        error = nil
        isPresented = false
        
        Task {
            let result = await openai.variation(image: image, numberOfImages: numberOfImages, resolution: resolution)
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
}

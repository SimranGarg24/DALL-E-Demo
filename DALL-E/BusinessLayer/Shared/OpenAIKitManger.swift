//
//  OpenAIKitManger.swift
//  DALL-E
//
//  Created by Saheem Hussain on 10/10/23.
//

import Foundation
import SwiftUI
import OpenAIKit

class OpenAIKitManager {
    
    let openai = OpenAI(Configuration(
        organizationId: "Personal",
        apiKey: <#Your_API_Key#>
    ))
    
    static let shared = OpenAIKitManager()
    private init() {}
    
    func generateImage(promt: String, resolution: ImageResolutions,
                       numberOfImages: Int) async -> ([UIImage]?, OpenAIErrorResponse?) {
        
        do {
            let params = ImageParameters(prompt: promt, numberofImages: numberOfImages,
                                         resolution: .medium, responseFormat: .base64Json)
            let result = try await openai.createImage(parameters: params)
            
            var imageArray: [UIImage] = []
            
            for data in result.data {
                let image = try openai.decodeBase64Image(data.image)
                imageArray.append(image)
            }
            return (imageArray, nil)
            
        } catch {
            print(String(describing: error))
            if let error = error as? OpenAIErrorResponse {
                return (nil, error)
            }
            
            return (nil, nil)
        }
        
    }
    
    func generateImageUrl(promt: String, resolution: ImageResolutions,
                          numberOfImages: Int) async -> ([String]?, OpenAIErrorResponse?) {
        
        do {
            let params = ImageParameters(prompt: promt, numberofImages: numberOfImages,
                                         resolution: resolution, responseFormat: .url)
            let result = try await openai.createImage(parameters: params)
            var imageUrlArray: [String] = []
            
            for data in result.data {
                imageUrlArray.append(data.image)
            }
            return (imageUrlArray, nil)
        } catch {
            print(String(describing: error))
            if let error = error as? OpenAIErrorResponse {
                return (nil, error)
            }
            
            return (nil, nil)
        }
    }
    
    func editImage(image: UIImage, mask: UIImage, prompt: String, numberOfImages: Int,
                   resolution: ImageResolutions) async -> ([UIImage]?, OpenAIErrorResponse?) {
        
        do {
            let params = try ImageEditParameters(image: image, mask: mask, prompt: prompt,
                                                 numberOfImages: numberOfImages, resolution: resolution,
                                                 responseFormat: .base64Json)
            let result = try await openai.generateImageEdits(parameters: params)
            var imageArray: [UIImage] = []
            
            for data in result.data {
                let image = try openai.decodeBase64Image(data.image)
                imageArray.append(image)
            }
            return (imageArray, nil)
        } catch {
            print(String(describing: error))
            if let error = error as? OpenAIErrorResponse {
                return (nil, error)
            }
            
            return (nil, nil)
        }
    }
    
    func editImageUrl(image: UIImage, mask: UIImage, prompt: String, numberOfImages: Int,
                      resolution: ImageResolutions) async -> ([String]?, OpenAIErrorResponse?) {
        
        do {
            let params = try ImageEditParameters(image: image, mask: mask, prompt: prompt,
                                                 numberOfImages: numberOfImages, resolution: resolution,
                                                 responseFormat: .url)
            let result = try await openai.generateImageEdits(parameters: params)
            var imageUrlArray: [String] = []
            
            for data in result.data {
                imageUrlArray.append(data.image)
            }
            return (imageUrlArray, nil)
        } catch {
            print(String(describing: error))
            if let error = error as? OpenAIErrorResponse {
                return (nil, error)
            }
            
            return (nil, nil)
        }
    }
    
    func variation(image: UIImage, numberOfImages: Int,
                   resolution: ImageResolutions) async -> ([UIImage]?, OpenAIErrorResponse?) {
        
        do {
            let params = try ImageVariationParameters(image: image, numberOfImages: numberOfImages,
                                                      resolution: resolution, responseFormat: .base64Json)
            let result = try await openai.generateImageVariations(parameters: params)
            
            var imageArray: [UIImage] = []
            
            for data in result.data {
                let image = try openai.decodeBase64Image(data.image)
                imageArray.append(image)
            }
            return (imageArray, nil)
            
        } catch {
            print(String(describing: error))
            if let error = error as? OpenAIErrorResponse {
                return (nil, error)
            }
            
            return (nil, nil)
        }
    }

}

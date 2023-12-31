//
//  PhotosPickerViewModel.swift
//  DALL-E
//
//  Created by Saheem Hussain on 10/10/23.
//

import Foundation

import SwiftUI
import PhotosUI

class PhotosPickerViewModel: ObservableObject {
    
    // MARK: - Properties
    @Published var image: UIImage?
    @Published var data: Data?
    @Published var imageSelection: PhotosPickerItem? {
        didSet {
            if let imageSelection {
                Task {
                    try await loadTransferable(from: imageSelection)
                }
            }
        }
    }
    
    func loadTransferable(from imageSelection: PhotosPickerItem?) async throws {
        
        do {
            if let data = try await imageSelection?.loadTransferable(type: Data.self) {
                await MainActor.run {
                    self.data = data
                    if let uiImage = UIImage(data: data) {
                        self.image = uiImage
                    }
                }
            }
        } catch {
            print(error.localizedDescription)
            await MainActor.run {
                image = nil
                data = nil
            }
        }
    }
}

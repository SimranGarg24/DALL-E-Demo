//
//  ImagePickerView.swift
//  DALL-E
//
//  Created by Saheem Hussain on 02/11/23.
//

import SwiftUI
import UIKit

struct ImagePickerView: UIViewControllerRepresentable {
    
    typealias UIViewControllerType = UIImagePickerController
    
    var sourceType: UIImagePickerController.SourceType = .photoLibrary
    @Binding var image: UIImage?
    @Binding var isPresented: Bool
    
    func makeUIViewController(context: Context) -> UIImagePickerController {
        let pickerController = UIImagePickerController()
        pickerController.sourceType = sourceType
        pickerController.allowsEditing = true
        pickerController.delegate = context.coordinator
        return pickerController
    }
    
    func updateUIViewController(_ uiViewController: UIImagePickerController, context: Context) {
        
    }
    
    func makeCoordinator() -> ImagePickerViewCoordinator {
        return ImagePickerViewCoordinator(image: $image, isPresented: $isPresented)
    }

}

class ImagePickerViewCoordinator: NSObject, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    
    @Binding var image: UIImage?
    @Binding var isPresented: Bool
    
    init(image: Binding<UIImage?>, isPresented: Binding<Bool>) {
        self._image = image
        self._isPresented = isPresented
    }
    
    func imagePickerController(_ picker: UIImagePickerController,
                               didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
//        if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
//            self.image = image
//        }
        
        if let image = info[.editedImage] as? UIImage {
            self.image = image
        }
        
        self.isPresented = false
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        self.isPresented = false
    }
}

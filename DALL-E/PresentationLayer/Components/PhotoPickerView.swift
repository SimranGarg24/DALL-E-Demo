//
//  PhotoPickerView.swift
//  DALL-E
//
//  Created by Saheem Hussain on 10/10/23.
//

import SwiftUI
import PhotosUI

struct PhotoPickerView<Content: View>: View {
    
    // MARK: Properties
    @StateObject var imagePicker = PhotosPickerViewModel()
    
    @Binding var profilePic: UIImage?
//    @Binding var data: Data
    
    let content: Content
    
    var body: some View {
        
        // MARK: Photo Picker
        PhotosPicker(
            selection: $imagePicker.imageSelection,
            matching: .images
        ) {
            content
        }
        .onChange(of: imagePicker.image, perform: { _ in
            if let image = imagePicker.image {
                profilePic = image
            }
            
//            if let data = imagePicker.data {
//                self.data = data
//            }
        })
    }
}

struct PhotoPicker_Previews: PreviewProvider {
    static var previews: some View {
        PhotoPickerView(profilePic: Binding.constant(UIImage(named: "Image 1")), content: Text("hello"))
    }
}

//
//  PhotoView.swift
//  DALL-E
//
//  Created by Saheem Hussain on 12/10/23.
//

import SwiftUI

struct PhotoView: View {
    
    @Binding var image: UIImage?
    
    @State private var shouldPresentImagePicker = false
    @State private var shouldPresentActionScheet = false
    @State private var shouldPresentCamera = false
    
    var body: some View {
        
        VStack {
            if let image {
                HStack {
                    
                    ZStack(alignment: .topTrailing) {
                        Image(uiImage: image)
                            .resizable()
                            .frame(width: 60, height: 60)
                            .cornerRadius(12)
                        
                        Button {
                            self.image = nil
                        } label: {
                            Image(systemName: "multiply")
                                .font(.subheadline)
                                .foregroundColor(.white)
                        }
                        .padding(4)
                        .background(Color.purple)
                        .clipShape(Circle())
                        .offset(CGSize(width: 6, height: -6))
                        
                    }
                    
                    Spacer()
                    
                    //                PhotoPickerView(profilePic: $image, content: editView)
                    editView
                        .onTapGesture { self.shouldPresentActionScheet = true }
                }
                .padding()
                .background {
                    RoundedRectangle(cornerRadius: 12)
                        .fill(Color.gray.opacity(0.2))
                }
            } else {
                //            PhotoPickerView(profilePic: $image, content: addview)
                addview
                    .onTapGesture { self.shouldPresentActionScheet = true }
            }
        }
        .sheet(isPresented: $shouldPresentImagePicker) {
            ImagePickerView(sourceType: self.shouldPresentCamera ? .camera : .photoLibrary,
                            image: self.$image, isPresented: self.$shouldPresentImagePicker)
        }
        .actionSheet(isPresented: $shouldPresentActionScheet) { () -> ActionSheet in
            ActionSheet(title: Text("Choose mode"),
                        message: Text("Please choose your preferred mode to set your profile image"),
                        buttons: [ActionSheet.Button.default(Text("Camera"), action: {
                self.shouldPresentImagePicker = true
                self.shouldPresentCamera = true
            }), ActionSheet.Button.default(Text("Photo Library"), action: {
                self.shouldPresentImagePicker = true
                self.shouldPresentCamera = false
            }), ActionSheet.Button.cancel()])
        }
    }
    
    var addview: some View {
        HStack {
            Text("Upload Image")
                .foregroundColor(.gray)
            
            Spacer()
            
            Image(systemName: "plus")
                .foregroundColor(.black)
        }
        .padding()
        .background {
            RoundedRectangle(cornerRadius: 12)
                .fill(Color.gray.opacity(0.2))
        }
    }
    
    var editView: some View {
        HStack(spacing: 10) {
            Text("Change")
                .foregroundColor(.gray)
            Image(systemName: "chevron.right")
                .foregroundColor(.black)
        }
    }
}

struct PhotoView_Previews: PreviewProvider {
    static var previews: some View {
        PhotoView(image: Binding.constant(UIImage(named: "cartoon")))
    }
}

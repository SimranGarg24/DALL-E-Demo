//
//  CreateMaskView.swift
//  DALL-E
//
//  Created by Saheem Hussain on 30/10/23.
//

import SwiftUI

struct CreateMaskView: View {
    
    @Environment (\.dismiss) var dismiss
    
    @ObservedObject var viewModel: EditImageViewModel
    
    @State private var circleRadius: CGFloat = 20
    @State private var drawingAction: DrawingAction = .erase
    
    @State private var paintSelected: Bool = true
    
    var body: some View {
        
        VStack {
            MaskView(
                circleRadius: $circleRadius,
                drawingAction: $drawingAction,
                mask: $viewModel.maskImg,
                image: viewModel.originalImg
            )
            .frame(width: 300, height: 300)
            .onAppear {
                circleRadius = 20
            }
            .background(Color.gray.opacity(0.4))
            
            Spacer()
            
            HStack(spacing: 20) {
                Text("Size")
                    .font(.subheadline)
                    .bold()
                Slider(value: $circleRadius, in: 0...50)
            }
            
            HStack(alignment: .top, spacing: 24) {
                VStack {
                    Image(systemName: "photo.circle")
                        .font(.system(size: 24))
                    
                    Text("Mask")
                        .font(.subheadline)
                }
                
                Button {
                    paintSelected =  true
                    drawingAction = .erase
                } label: {
                    Image(systemName: paintSelected ? "paintbrush.pointed" : "paintbrush.pointed.fill")
                }
                .font(.system(size: 26))
                .foregroundColor(paintSelected ? .white : .black)
                .padding(8)
                .background(paintSelected ? Color.black : .clear)
                .cornerRadius(12)
                
                Button {
                    paintSelected = false
                    drawingAction = .draw
                } label: {
                    Image(systemName: paintSelected ? "eraser.fill" : "eraser")
                }
                .font(.system(size: 26))
                .foregroundColor(paintSelected ? .black : .white)
                .padding(8)
                .background(paintSelected ? Color.clear : .black)
                .cornerRadius(12)
                
            }
            .padding(10)
            .padding(.horizontal)
            .background(Color.gray.opacity(0.2))
            .cornerRadius(12)
            .padding(.top)
        }
        .padding()
        .onAppear {
            viewModel.originalImg = viewModel.originalImg?.compressImage(newHeight: 300)
        }
        .toolbar(.hidden, for: .tabBar)
        .navigationBarBackButtonHidden(true)
        .toolbar {
            
            ToolbarItem(placement: .navigationBarLeading) {
                
                HStack {
                    Button {
                        viewModel.originalImg = nil
                        viewModel.maskImg = nil
                        dismiss()
                    } label: {
                        Image(systemName: "arrow.left")
                    }
                    
                    Text("Create Mask")
                }

            }
            
            ToolbarItem(placement: .navigationBarTrailing) {
                Button("Apply", action: {
                    // Handle save action
                    // Note: Implement your image and mask handling logic here
                    if let mask = viewModel.maskImg {
                        
                        viewModel.maskImg = mask.compressImage(newHeight: 300)
                    }
                    dismiss()
                })
                .disabled(viewModel.maskImg == nil)
            }
        }
    }
}

struct CreateMaskView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            CreateMaskView(viewModel: EditImageViewModel())
        }
    }
}

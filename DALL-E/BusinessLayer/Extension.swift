//
//  ViewExtension.swift
//  DALL-E
//
//  Created by Saheem Hussain on 12/10/23.
//

import SwiftUI

extension View {
    func cornerRadius(_ radius: CGFloat, corners: UIRectCorner) -> some View {
        clipShape( RoundedCorner(radius: radius, corners: corners) )
    }
}

extension UIImage {
    func aspectFittedToHeight(_ newHeight: CGFloat) -> UIImage {
//        let scale = newHeight / self.size.height
//        let newWidth = self.size.width * scale
        let newSize = CGSize(width: newHeight, height: newHeight)
        let renderer = UIGraphicsImageRenderer(size: newSize)

        return renderer.image { _ in
            self.draw(in: CGRect(origin: .zero, size: newSize))
        }
    }
    
    func compressImage(newHeight: CGFloat) -> UIImage {
        let resizedImage = self.aspectFittedToHeight(newHeight)
        resizedImage.jpegData(compressionQuality: 0.2) // Add this line
        return resizedImage
    }
}

struct RoundedCorner: Shape {

    var radius: CGFloat = .infinity
    var corners: UIRectCorner = .allCorners

    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: corners,
                                cornerRadii: CGSize(width: radius, height: radius))
        return Path(path.cgPath)
    }
}

//
//  ResultView.swift
//  DALL-E
//
//  Created by Saheem Hussain on 12/10/23.
//

import SwiftUI

struct ResultView: View {
    
    var imageArray: [UIImage]
    
    var body: some View {
        List {
            ForEach(imageArray, id: \.self) { image in
                
                ZStack(alignment: .topTrailing) {
                    
                    Image(uiImage: image)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .cornerRadius(12)
                    
                    Button {
                        UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil)
                    } label: {
                        Image(systemName: "arrow.down.app.fill")
                            .font(.title)
                            .foregroundColor(.white)
                    }
//                    .background(Color.purple)
//                    .clipShape(Circle())
//                    .offset(CGSize(width: 6, height: -6))
                    
                }
            }
            .listRowSeparator(.hidden)
        }
        .listStyle(.plain)
        .scrollIndicators(.hidden)
    }
}

struct ResultView_Previews: PreviewProvider {
    static var previews: some View {
        ResultView(imageArray: [])
    }
}

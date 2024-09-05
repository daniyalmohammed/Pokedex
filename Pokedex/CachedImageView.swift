//
//  CachedImageView.swift
//  Pokedex
//
//  Created by Daniyal Mohammed on 2024-09-05.
//

import SwiftUI

struct CachedImageView: View {
    let imageUrl: String
    
    @State private var image: UIImage? = nil
    
    var body: some View {
        if let image = image {
            Image(uiImage: image)
                .resizable()
                .scaledToFit()
        } else {
            ProgressView()
                .onAppear {
                    loadImage()
                }
        }
    }
    
    private func loadImage() {
        if let cachedImage = ImageCache.shared.getImage(forKey: imageUrl) {
            image = cachedImage
            return
        }
        
        guard let url = URL(string: imageUrl) else { return }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let data = data, let downloadedImage = UIImage(data: data) {
                DispatchQueue.main.async {
                    ImageCache.shared.saveImage(downloadedImage, forKey: imageUrl)
                    image = downloadedImage
                }
            }
        }.resume()
    }
}

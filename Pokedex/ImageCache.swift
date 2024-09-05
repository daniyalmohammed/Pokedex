//
//  ImageCache.swift
//  Pokedex
//
//  Created by Daniyal Mohammed on 2024-09-05.
//

import UIKit

class ImageCache {
    static let shared = ImageCache()
    
    private let cache = NSCache<NSString, UIImage>()
    private let fileManager = FileManager.default
    private let cacheDirectory: URL
    
    private init() {
        cacheDirectory = fileManager.urls(for: .cachesDirectory, in: .userDomainMask)[0]
    }
    
    func getImage(forKey key: String) -> UIImage? {
        if let image = cache.object(forKey: key as NSString) {
            return image
        }
        
        let fileURL = cacheDirectory.appendingPathComponent(key)
        if let image = UIImage(contentsOfFile: fileURL.path) {
            cache.setObject(image, forKey: key as NSString)
            return image
        }
        
        return nil
    }
    
    func saveImage(_ image: UIImage, forKey key: String) {
        cache.setObject(image, forKey: key as NSString)
        
        let fileURL = cacheDirectory.appendingPathComponent(key)
        if let data = image.pngData() {
            try? data.write(to: fileURL)
        }
    }
}

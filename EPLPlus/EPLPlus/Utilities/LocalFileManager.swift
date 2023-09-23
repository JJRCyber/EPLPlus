//
//  LocalFileManager.swift
//  EPLPlus
//
//  Created by Cooper Jacob on 22/9/2023.
//

import Foundation
import SwiftUI

/*
 Class that handles the saving and retrieving of local files
 Singleton instance prevents multiple instances of the class
 */

final class LocalFileManager {
    
    static let instance = LocalFileManager()
    private init() { }
    
    // Saves an image to specified folder
    // Currently used to cache team crest images to reduce network requests
    func saveImage(image: UIImage, imageName: String, folderName: String) {
        // Creates folder if it does not exist
        createFolderIfNeeded(folderName: folderName)
        // Check to ensure we can get pngData from image and get URL from parameters
        guard
            let data = image.pngData(),
            let url = getImageURL(imageName: imageName, folderName: folderName)
        else { return }
        
        // Try to write image to url
        do {
            try data.write(to: url)
        } catch {
            // User does not need to be alerted to error as does not affect user experience
            print("Error saving image. Image: \(imageName) \(error)")
        }
    }
    
    // Retrieves an image from a specifed folder
    func getImage(imageName: String, folderName: String) -> UIImage? {
        // Returns nil if file does not exist
        guard
            let url = getImageURL(imageName: imageName, folderName: folderName),
            FileManager.default.fileExists(atPath: url.path) else {
            return nil
        }
        // Return image at url
        return UIImage(contentsOfFile: url.path)
    }
    
    // Helper function to create folder if it does not exist
    private func createFolderIfNeeded(folderName: String) {
        // Gets url for passed foldername
        guard let url = getFolderURL(folderName: folderName) else { return }
        // If folder does not exist create it
        if !FileManager.default.fileExists(atPath: url.path) {
            do {
                try FileManager.default.createDirectory(at: url, withIntermediateDirectories: true, attributes: nil)
            } catch let error {
                // User does not need to be alerted to error as does not affect user experience
                print("Error creating directory: \(error)")
            }
        }
    }
    
    // Gets folder url given folder name
    private func getFolderURL(folderName: String) -> URL? {
        // Saving in cache directory as all images can be redownloaded if needed
        guard let url = FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask).first else {
            return nil
        }
        return url.appendingPathComponent(folderName)
    }
    
    // Gets image url given folder name and image name
    private func getImageURL(imageName: String, folderName: String) -> URL? {
        guard let folderUrl = getFolderURL(folderName: folderName) else {
            return nil
        }
        // Append .png as all images are png type
        return folderUrl.appendingPathComponent(imageName + ".png")
    }
}

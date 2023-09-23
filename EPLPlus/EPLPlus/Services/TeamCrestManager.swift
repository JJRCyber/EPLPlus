//
//  TeamCrestManager.swift
//  EPLPlus
//
//  Created by Cooper Jacob on 22/9/2023.
//

import Foundation
import SwiftUI
import Combine

/*
 Class to manage the retrieval, storing and downloading of team crest images
 Download links to team crests are returned by API response
 */

final class TeamCrestManager {
    
    // Published var for the crestImage
    @Published var crestImage: UIImage? = nil
    
    // Allows cancellation of the image download
    var badgeImageSubscription: AnyCancellable?
    
    // Team that is passed to class on init
    private let team: Team
    // Reference to local file manager class
    private let localFileManager = LocalFileManager.instance
    
    // Folder name where crestImages will be saved
    private let crestFolderName = "crestImages"
    // Image name for each crest
    private let imageName: String
    
    // Sets team and image name then getsCrest image
    init(team: Team) {
        self.team = team
        self.imageName = "\(team.id)"
        getCrestImage()
    }
    
    // Gets crestImage
    private func getCrestImage() {
        // If image saved in local storage return that image
        if let savedImage = localFileManager.getImage(imageName: imageName, folderName: crestFolderName) {
            self.crestImage = savedImage
        } else {
            // Otherwise download image
            downloadCrestImage()
        }
    }
    
    // Function to download crest image
    private func downloadCrestImage() {
        if team.crest.hasSuffix(".svg") {
            // Load the image from assets using team.id if image is .svg
            if let assetImage = UIImage(named: imageName) {
                self.crestImage = assetImage
            }
            return
        }
        // Get url from API response
        guard let url = URL(string: team.crest) else { return }
        // Map returned data to UIImage
        badgeImageSubscription = NetworkingManager.download(url: url)
            .tryMap({ (data) -> UIImage? in
                return UIImage(data: data)
            })
        // Use of weak self to to prevent object being kept alive if not needed
            .sink(receiveCompletion: NetworkingManager.handleCompletion, receiveValue: { [weak self] (returnedBageImage) in
                guard let self = self, let downloadedBadgeImage = returnedBageImage else { return }
                // Set crestImage as returned image
                self.crestImage = returnedBageImage
                // Cancel subscription as no more data will be returned
                self.badgeImageSubscription?.cancel()
                // Save image to local storage
                self.localFileManager.saveImage(image: downloadedBadgeImage, imageName: imageName, folderName: crestFolderName)
            })
    }
}

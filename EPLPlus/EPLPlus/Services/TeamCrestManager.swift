//
//  TeamCrestManager.swift
//  EPLPlus
//
//  Created by Cooper Jacob on 22/9/2023.
//

import Foundation
import SwiftUI
import Combine

final class TeamCrestManager {
    
    @Published var crestImage: UIImage? = nil
    
    var badgeImageSubscription: AnyCancellable?
    private let team: Team
    private let localFileManager = LocalFileManager.instance
    private let crestFolderName = "crestImages"
    private let imageName: String
    
    init(team: Team) {
        self.team = team
        self.imageName = "\(team.id)"
        getCrestImage()
    }
    
    private func getCrestImage() {
        if let savedImage = localFileManager.getImage(imageName: imageName, folderName: crestFolderName) {
            self.crestImage = savedImage
        } else {
            downloadCrestImage()
        }
    }
    
    private func downloadCrestImage() {
        if team.crest.hasSuffix(".svg") {
            // Load the image from assets using team.id
            if let assetImage = UIImage(named: imageName) {
                self.crestImage = assetImage
            }
            return
        }
        guard let url = URL(string: team.crest) else { return }
        
        badgeImageSubscription = NetworkingManager.download(url: url)
            .tryMap({ (data) -> UIImage? in
                return UIImage(data: data)
            })
            .sink(receiveCompletion: NetworkingManager.handleCompletion, receiveValue: { [weak self] (returnedBageImage) in
                guard let self = self, let downloadedBadgeImage = returnedBageImage else { return }
                self.crestImage = returnedBageImage
                self.badgeImageSubscription?.cancel()
                self.localFileManager.saveImage(image: downloadedBadgeImage, imageName: imageName, folderName: crestFolderName)
            })
    }
}

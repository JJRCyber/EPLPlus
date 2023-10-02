//
//  FavouriteTeamsManager.swift
//  EPLPlus
//
//  Created by Cooper Jacob on 28/9/2023.
//

import Foundation
import CoreData


final class FavouriteTeamsManager {
    private let container: NSPersistentContainer
    private let favouriteTeamsContainer = "FavouriteTeamsContainer"
    private let favouriteTeamEntity = "TeamDetailEntity"
    
    @Published var favouriteTeams: [TeamDetailEntity] = []
    
    init() {
        container = NSPersistentContainer(name: favouriteTeamsContainer)
        container.loadPersistentStores { _, error in
            if let error = error {
                print("Error loading Core Data \(error)")
            }
        }
        self.getFavouriteTeams()
    }
    
    private func getFavouriteTeams() {
        let request = NSFetchRequest<TeamDetailEntity>(entityName: favouriteTeamEntity)
        do {
            favouriteTeams = try container.viewContext.fetch(request)
        } catch let error {
            print("Error fetching favourite teams. \(error)")
        }
    }
    
    public func addTeamToFavourites(team: TeamDetail) {
        let entity = TeamDetailEntity(context: container.viewContext)
        entity.id = Int32(team.id)
        entity.address = team.address
        entity.clubColours = team.clubColors
        entity.crest = team.crest
        entity.founded = Int32(team.founded ?? 0)
        entity.name = team.name
        entity.shortName = team.name
        entity.tla = team.tla
        entity.venue = team.venue
        entity.website = team.website
        save()
    }
    
    public func removeTeamFromFavourites(team: TeamDetail) {
        if let teamEntity = favouriteTeams.first (where: { $0.id == team.id }) {
            container.viewContext.delete(teamEntity)
            save()
        }
    }
    
    private func save() {
        do {
            try container.viewContext.save()
            getFavouriteTeams()
        } catch let error {
            print("Error saving \(error)")
        }
    }
}

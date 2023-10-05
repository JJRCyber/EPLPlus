//
//  FavouriteTeamsManager.swift
//  EPLPlus
//
//  Created by Cooper Jacob on 28/9/2023.
//

import Foundation
import CoreData

/*
 Class to manage the storing and retrieving of favourite teams within core data
 Core data functionality can be extended further to act as a cache to reduce number of API requests
 */
final class FavouriteTeamsManager {
    
    // Setup container and entity values
    private let container: NSPersistentContainer
    private let favouriteTeamsContainer = "FavouriteTeamsContainer"
    private let favouriteTeamEntity = "TeamDetailEntity"
    
    // Published array of favourite teams
    @Published var favouriteTeams: [TeamDetailEntity] = []
    
    // Init loads persistent container and then calls get favourites
    init() {
        container = NSPersistentContainer(name: favouriteTeamsContainer)
        container.loadPersistentStores { _, error in
            if let error = error {
                // Error printed to console. User does not need to be alerted
                // For debugging only
                print("Error loading Core Data \(error)")
            }
        }
        self.getFavouriteTeams()
    }
    
    // Uses fetch request to retrieve favourite teams
    private func getFavouriteTeams() {
        let request = NSFetchRequest<TeamDetailEntity>(entityName: favouriteTeamEntity)
        do {
            favouriteTeams = try container.viewContext.fetch(request)
        } catch let error {
            // Error printed to console. User does not need to be alerted
            // For debugging only
            print("Error fetching favourite teams. \(error)")
        }
    }
    
    // Function to add a team to CoreData by converting TeamDetail into
    // Required CoreData entity
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
    
    // Removes a team from Favourites CoreData container
    public func removeTeamFromFavourites(team: TeamDetail) {
        if let teamEntity = favouriteTeams.first (where: { $0.id == team.id }) {
            container.viewContext.delete(teamEntity)
            save()
        }
    }
    
    // Saves changes made to container and refreshes the published array
    private func save() {
        do {
            try container.viewContext.save()
            getFavouriteTeams()
        } catch let error {
            // Error printed to console. User does not need to be alerted
            // For debugging only
            print("Error saving \(error)")
        }
    }
}

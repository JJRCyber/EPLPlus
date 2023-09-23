//
//  StandingsRowView.swift
//  EPLPlus
//
//  Created by Cooper Jacob on 22/9/2023.
//

import SwiftUI

// Row view for each league position
struct StandingsRowView: View {
    
    let leaguePosition: LeaguePosition
    
    /* Displays:
     - League Position
     - Team Name
     - Wins
     - Draws
     - Losses
     - Points
     */
    
    var body: some View {
        HStack(spacing: 15) {
            Text("\(leaguePosition.position)")
                .frame(width: 25)
                .font(.headline)
            TeamCrestView(team: leaguePosition.team)
                .frame(width: 23, height: 23)
            Text("\(leaguePosition.team.shortName)")
                .frame(alignment: .leading)
            Spacer()
            Text("\(leaguePosition.won)")
                .foregroundColor(Color.theme.green)
                .frame(width: 15)
            Text("\(leaguePosition.draw)")
                .foregroundColor(Color.theme.secondaryText)
                .frame(width: 15)
            Text("\(leaguePosition.lost)")
                .foregroundColor(Color.theme.red)
                .frame(width: 15)
            Text("\(leaguePosition.points)")
                .frame(width: 20)
                .foregroundColor(Color.theme.accent)
        }
        .font(.subheadline)
    }
}

struct StandingsRowView_Previews: PreviewProvider {
    static var previews: some View {
        StandingsRowView(leaguePosition: dev.leaguePosition)
    }
}

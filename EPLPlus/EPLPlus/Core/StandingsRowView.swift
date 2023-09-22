//
//  StandingsRowView.swift
//  EPLPlus
//
//  Created by Cooper Jacob on 22/9/2023.
//

import SwiftUI

struct StandingsRowView: View {
    
    let leaguePosition: LeaguePosition
    
    var body: some View {
        HStack(spacing: 25) {
            Text("\(leaguePosition.position)")
                .frame(width: 25)
            Circle()
                .frame(width: 20, height: 20)
            Text("\(leaguePosition.team.shortName)")
                .frame(alignment: .leading)
            Spacer()
            Text("\(leaguePosition.points)")
                .frame(width: 20)
        }
        .padding(.horizontal)
    }
}

struct StandingsRowView_Previews: PreviewProvider {
    static var previews: some View {
        StandingsRowView(leaguePosition: dev.leaguePosition)
    }
}

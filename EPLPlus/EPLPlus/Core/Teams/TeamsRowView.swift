//
//  TeamsRowView.swift
//  EPLPlus
//
//  Created by Cooper Jacob on 21/9/2023.
//

import SwiftUI

// Row view for each team
struct TeamsRowView: View {
    
    let teamDetail: TeamDetail
    
    var body: some View {
        HStack {
            TeamCrestView(team: Team(teamDetail: teamDetail))
                .frame(width: 30, height: 30)
            Text(teamDetail.shortName)
                .font(.headline)
                .padding()
            Spacer()
            Text(teamDetail.tla)
                .frame(width: 45, alignment: .leading)
                .font(.headline)
                .foregroundColor(Color.theme.secondaryText)
            Image(systemName: "chevron.right")
                .padding()
        }
        .padding()
    }
}

struct TeamsRowView_Previews: PreviewProvider {
    static var previews: some View {
        TeamsRowView(teamDetail: dev.teamDetail)
    }
}

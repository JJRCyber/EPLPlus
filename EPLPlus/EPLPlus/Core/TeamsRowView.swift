//
//  TeamsRowView.swift
//  EPLPlus
//
//  Created by Cooper Jacob on 21/9/2023.
//

import SwiftUI

struct TeamsRowView: View {
    
    let team: Team
    
    var body: some View {
        HStack {
            Circle()
                .frame(width: 30, height: 30)
            Text(team.shortName)
                .font(.headline)
                .padding()
            Spacer()
            Text(team.tla)
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
        TeamsRowView(team: dev.team)
    }
}

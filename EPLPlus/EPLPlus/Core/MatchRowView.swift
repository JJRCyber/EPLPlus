//
//  MatchRowView.swift
//  EPLPlus
//
//  Created by Cooper Jacob on 20/9/2023.
//

import SwiftUI

struct MatchRowView: View {
    
    let match: Match
    
    var body: some View {
        HStack {
            VStack {
                Circle()
                    .frame(width: 30, height: 30)
                Text(match.homeTeam.shortName)
            }
            
            Spacer()
            VStack {
                Text("V")
                Text("\(match.utcDate.formatted(date: .omitted, time: .shortened))")
            }
            .foregroundColor(Color.theme.secondaryText)
            Spacer()
            VStack {
                Circle()
                    .frame(width: 30, height: 30)
                Text(match.awayTeam.shortName)
            }

        }
        .padding()
    }
}

struct FixtureRowView_Previews: PreviewProvider {
    static var previews: some View {
        MatchRowView(match: dev.match)
    }
}

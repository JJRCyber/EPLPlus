//
//  MatchRowView.swift
//  EPLPlus
//
//  Created by Cooper Jacob on 20/9/2023.
//

import SwiftUI

/* Displays each match row:
 - Home team name + crest
 - Time if incomplete
 - Score if complete
 - Away team name + crest
 */

struct MatchRowView: View {
    
    let match: Match
    
    var body: some View {
        HStack {
            VStack {
                TeamCrestView(team: match.homeTeam)
                    .frame(width: 30, height: 30)
                Text(match.homeTeam.shortName)
            }
            .frame(width: UIScreen.main.bounds.width / 3)
            VStack {
                Text("V")
                Text("\(match.utcDate.formatted(date: .omitted, time: .shortened))")
            }
            .foregroundColor(Color.theme.secondaryText)
            .frame(width: UIScreen.main.bounds.width / 3)
            VStack {
                TeamCrestView(team: match.awayTeam)
                    .frame(width: 30, height: 30)
                Text(match.awayTeam.shortName)
            }
            .frame(width: UIScreen.main.bounds.width / 3)

        }
        .padding()
    }
}

struct FixtureRowView_Previews: PreviewProvider {
    static var previews: some View {
        MatchRowView(match: dev.match)
    }
}

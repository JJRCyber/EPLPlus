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
            Spacer(minLength: 0)
            if match.score.winner != nil {
                Group {
                    Text("\(match.score.fullTime.home ?? 0)")
                    Text(" - ")
                    Text("\(match.score.fullTime.away ?? 0)")
                }
                .foregroundColor(Color.theme.secondaryText)
            } else {
                VStack {
                    Text("V")
                    Text("\(match.utcDate.formatted(date: .omitted, time: .shortened))")
                }
                .foregroundColor(Color.theme.secondaryText)
            }
            Spacer(minLength: 0)
            VStack {
                TeamCrestView(team: match.awayTeam)
                    .frame(width: 30, height: 30)
                Text(match.awayTeam.shortName)
            }
            .frame(width: UIScreen.main.bounds.width / 3)
        }
        .padding(.horizontal, 5)
        .padding(.vertical)
    }
}

struct FixtureRowView_Previews: PreviewProvider {
    static var previews: some View {
        MatchRowView(match: dev.match)
    }
}

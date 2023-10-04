//
//  FormView.swift
//  EPLPlus
//
//  Created by Cooper Jacob on 2/10/2023.
//

import SwiftUI
import Charts

struct FormView: View {
    
    let teamId: Int
    @StateObject var viewModel: FormViewModel
    
    init(teamId: Int) {
        self.teamId = teamId
        _viewModel = StateObject(wrappedValue: FormViewModel(teamId: teamId))
    }
    

    
    var body: some View {
      if let position = viewModel.leaguePosition {
        HStack (alignment: .top){
                VStack(spacing: 5) {
                    VStack {
                        Text("Points")
                            .font(.caption)
                            .foregroundColor(Color.theme.secondaryText)
                        Text("\(position.points)")
                            .font(.headline)
                            .foregroundColor(Color.theme.accent)
                    }
                    VStack {
                        Text("Played")
                            .font(.caption)
                            .foregroundColor(Color.theme.secondaryText)
                        Text("\(position.playedGames)")
                            .font(.headline)
                    }
                    VStack() {
                        Text("Won")
                            .font(.caption)
                            .foregroundColor(Color.theme.secondaryText)
                        Text("\(position.won)")
                            .font(.headline)
                            .foregroundColor(Color.theme.green)
                    }
                    VStack() {
                        Text("Drawn")
                            .font(.caption)
                            .foregroundColor(Color.theme.secondaryText)
                        Text("\(position.draw)")
                            .font(.headline)
                            .foregroundColor(Color.theme.secondaryText)
                    }
                    VStack() {
                        Text("Lost")
                            .font(.caption)
                            .foregroundColor(Color.theme.secondaryText)
                        Text("\(position.lost)")
                            .font(.headline)
                            .foregroundColor(Color.theme.red)
                    }
                }
                .padding(.trailing)
                VStack(alignment: .leading) {
                    Text("Goals")
                        .font(.caption)
                        .foregroundColor(Color.theme.secondaryText)
                    Chart {
                        BarMark(x: .value("Goals", position.goalsFor))
                            .foregroundStyle(Color.theme.green)
                        BarMark(x: .value("Goals", position.goalsAgainst))
                            .foregroundStyle(Color.theme.red)
                    }
                    Text("Games Won / Lost")
                        .font(.caption)
                        .foregroundColor(Color.theme.secondaryText)
                    Chart {
                        BarMark(x: .value("Games", position.won))
                            .foregroundStyle(Color.theme.green)
                        BarMark(x: .value("Goals", position.draw))
                            .foregroundStyle(Color.theme.secondaryText)
                        BarMark(x: .value("Goals", position.lost))
                            .foregroundStyle(Color.theme.red)
                    }
                }
            }
            .frame(height: 200)
            .padding()
        }

    }
}

struct FormView_Previews: PreviewProvider {
    static var previews: some View {
        FormView(teamId: 62)
    }
}

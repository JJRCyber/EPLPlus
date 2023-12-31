//
//  SquadListRowView.swift
//  EPLPlus
//
//  Created by Cooper Jacob on 2/10/2023.
//

import SwiftUI

// Simple listRowView to display player name and position
struct SquadListRowView: View {
    
    let player: Player
    
    var body: some View {
        HStack(spacing: 15) {
            Text(player.name)
            Spacer()
            Text(player.position ?? "NA")
        }
        .padding(.horizontal)
        .padding(.vertical, 3)
        .font(.subheadline)
        .foregroundColor(Color.theme.secondaryText)
    }
}

struct SquadListRowView_Previews: PreviewProvider {
    static var previews: some View {
        SquadListRowView(player: Player.init(id: 7, name: "Lionel Messi", position: "Offence", nationality: "England"))
    }
}

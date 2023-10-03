//
//  LoadingIndicator.swift
//  EPLPlus
//
//  Created by Cooper Jacob on 4/10/2023.
//

import SwiftUI

struct LoadingIndicator: View {
    
    let color: Color
    
    private let timer = Timer.publish(every: 0.3, on: .main, in: .common).autoconnect()
    private let loadingSymbols: [Image] = [
        Image(systemName: "soccerball"),
        Image(systemName: "soccerball"),
        Image(systemName: "soccerball")
    ]
    
    @State private var counter: Int = 0
    @State private var showLoadingIndicator: Bool = false
    
    var body: some View {
        
        ZStack {
            if showLoadingIndicator {
                HStack {
                    ForEach(0..<3) { index in
                        loadingSymbols[index]
                            .font(.headline)
                            .foregroundColor(color)
                            .offset(y: counter == index ? -10 : 0)
                    }
                }
                .transition(AnyTransition.opacity.animation(.easeIn))
                .onReceive(timer) { _ in
                    withAnimation(.spring()) {
                        if counter == 2 {
                            counter = 0
                        } else {
                            counter += 1
                        }
                    }
                }
                
            }
        }
        .onAppear {
            showLoadingIndicator.toggle()
        }
        
    }
}

struct LoadingIndicator_Previews: PreviewProvider {
    static var previews: some View {
        LoadingIndicator(color: Color.theme.accent)
    }
}

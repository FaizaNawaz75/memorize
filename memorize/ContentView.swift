//
//  ContentView.swift
//  memorize
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            HStack {
                CardView()
                CardView(isFaceUp: true)
                CardView()
            }.padding(5)
        }
    }
}

#Preview {
    ContentView()
}

struct CardView: View {
    var isFaceUp: Bool = false
    
    var body: some View {
        ZStack {
            if isFaceUp {
                RoundedRectangle(cornerRadius: 10)
                    .foregroundStyle(.white)
                
                RoundedRectangle(cornerRadius: 10)
                    .strokeBorder(style: .init(lineWidth: 2))
                
                Text("👻")
                    .font(.largeTitle)
            } else {
                RoundedRectangle(cornerRadius: 10)
            }
        }
        .foregroundStyle(.orange)
    }
}

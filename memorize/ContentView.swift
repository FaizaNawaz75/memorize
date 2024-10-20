//
//  ContentView.swift
//  memorize
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        let cardIcons = ["👽", "👻", "🦊", "🦁", "🦁"]

        HStack {
            ForEach(cardIcons.indices, id: \.self) { index in
                CardView(cardIcon: cardIcons[index])
            }
        }.padding()
    }
}

#Preview {
    ContentView()
}

struct CardView: View {
    let cardIcon: String
    @State var isFaceUp: Bool = true
    
    var body: some View {
        ZStack {
            let baseCard = RoundedRectangle(cornerRadius: 10)
            
            if isFaceUp {
                baseCard.fill(.white)
                baseCard.strokeBorder(style: .init(lineWidth: 2))
                Text(cardIcon).font(.largeTitle)
            } else {
                baseCard
            }
        }
        .foregroundStyle(.orange)
        .onTapGesture {
            //            isFaceUp = !isFaceUp
            isFaceUp.toggle()
        }
    }
}

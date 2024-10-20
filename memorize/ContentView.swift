//
//  ContentView.swift
//  memorize
//

import SwiftUI

struct ContentView: View {
    let cardIcons = ["👽", "👻", "🦊", "🦁",
                     "🐮", "🐸", "🐙", "🐥"]
    
    @State var cardCount = 4
    
    var body: some View {
        VStack {
            ScrollView {
                cards
            }
            Spacer()
            cardCountAdjusters
        }
    }
    
    //it's not a view builder but a function. as it has 1 line of code, it has implicit returns. So we don't have to mention return here.
    var cards: some View {
        
        //LazyVGrid uses as less space as it can where as HStack uses as much space as it can. It's the way they are defined...
        LazyVGrid(columns: [GridItem(.adaptive(minimum: 120))]) {
            ForEach(0..<cardCount, id: \.self) { index in
                CardView(cardIcon: cardIcons[index])
                    .aspectRatio(2/3, contentMode: .fit)
            }
        }.padding()
    }
    
    var cardCountAdjusters: some View {
        HStack {
            cardRemover
            cardAdder
        }
        .padding()
    }
    
    var cardRemover: some View {
        cardCountAdjuster(by: -1, title: "Remove Card")
    }
    
    var cardAdder: some View {
        cardCountAdjuster(by: 1, title: "Add Card")
    }
    
    fileprivate func cardCountAdjuster(by offset: Int, title: String) -> some View {
        
        Button(action: {
            cardCount += offset
        }) {
            Text(title)
                .padding()
                .frame(maxWidth: .infinity)
                .background(Color.orange)
                .foregroundColor(.white)
                .cornerRadius(10)
        }
        .disabled(cardCount + offset < 1 ||  cardCount + offset > cardIcons.count)
    }
    
}

struct CardView: View {
    let cardIcon: String
    @State var isFaceUp: Bool = true
    
    var body: some View {
        ZStack {
            let baseCard = RoundedRectangle(cornerRadius: 10)
            
            Group {
                baseCard.fill(.white)
                baseCard.strokeBorder(style: .init(lineWidth: 2))
                Text(cardIcon).font(.largeTitle)
            }.opacity(isFaceUp ? 1 : 0)
            
            baseCard.fill().opacity(isFaceUp ? 0 : 1)
        }
        .foregroundStyle(.orange)
        .onTapGesture {
            isFaceUp.toggle()
        }
    }
}

#Preview {
    ContentView()
}

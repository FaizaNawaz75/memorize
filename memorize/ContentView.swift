//
//  ContentView.swift
//  memorize
//

import SwiftUI

enum Theme {
    case Halloween
    case Animals
    case Weather
}

struct ContentView: View {
    @State var cardIcons = [""]
    
    let animalTheme = ["🐅", "🦓", "🦧", "🐎", "🐈","🐄", "🐅", "🦓", "🦧",
                       "🐎", "🐈", "🐄"]
    
    let weatherTheme = ["☁️", "☀️", "🌤️", "🌥️", "🌨️", "🌈", "☁️", "☀️", "🌤️",
                        "🌥️", "🌨️", "🌈"]
    
    let halloweenTheme = ["👻", "🎃", "💀", "👽"]
    
    var body: some View {
        VStack {
            Text ("Memorize!").font(.largeTitle)
            ScrollView {
                cards
            }
            themeButtons
        }
    }
    
    //it's not a view builder but a function. as it has 1 line of code, it has implicit returns. So we don't have to mention return here.
    var cards: some View {
        
        //LazyVGrid uses as less space as it can where as HStack uses as much space as it can. It's the way they are defined...
        LazyVGrid(columns: [GridItem(.adaptive(minimum: 100))]) {
            ForEach(0..<cardIcons.count, id: \.self) { index in
                CardView(cardIcon: cardIcons[index])
                    .aspectRatio(2/3, contentMode: .fit)
            }
        }.padding()
    }
    
    var themeButtons: some View {
        HStack {
            themeButton(title: "Halloween", theme: .Halloween)
            themeButton(title: "Animals", theme: .Animals)
            themeButton(title: "Weather", theme: .Weather)
        }.padding()
    }
    
    fileprivate func themeButton(title: String, theme: Theme) -> some View {
        Button {
            updateTheme(selectedTheme: theme)
        } label: {
            themeButtonTitle(title: title)
        }
    }
    
    fileprivate func themeButtonTitle(title: String) -> some View {
        
        return Text(title)
            .padding()
            .frame(maxWidth: .infinity)
            .background(Color.orange)
            .foregroundColor(.white)
            .cornerRadius(10)
    }
    
    fileprivate func updateTheme(selectedTheme: Theme) {
        
        cardIcons.removeAll()
        switch selectedTheme {
        case .Halloween:
            cardIcons.append(contentsOf: halloweenTheme)
        case .Animals:
            cardIcons.append(contentsOf: animalTheme)
        case .Weather:
            cardIcons.append(contentsOf: weatherTheme)
        }
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

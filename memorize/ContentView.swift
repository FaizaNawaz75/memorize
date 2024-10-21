//
//  ContentView.swift
//  memorizee
//

import SwiftUI

enum Theme {
    case Halloween
    case Animals
    case Weather
}

struct ContentView: View {
    @State var cardIcons: [String] = []
    
    let animalTheme = ["🐅", "🦓", "🦧", "🐎", "🐈","🐄", "🐅", "🦓", "🦧",
                       "🐎", "🐈", "🐄"]
    
    let weatherTheme = ["☁️", "☀️", "🌤️", "🌥️", "🌨️", "🌈", "☁️", "☀️", "🌤️",
                        "🌥️", "🌨️", "🌈"]
    
    let halloweenTheme = ["👻", "🎃", "💀", "👽", "👻", "🎃", "💀", "👽", "🎁",
                          "🎁", "😱", "😱"]
    
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
            themeButton(theme: .Halloween)
            themeButton(theme: .Animals)
            themeButton(theme: .Weather)
        }
    }
    
    fileprivate func themeButton(theme: Theme) -> some View {
        Button {
            updateTheme(selectedTheme: theme)
        } label: {
            let themeInfo = themeInfo(theme: theme)
            themeButtonTitle(title: themeInfo.title, imageName: themeInfo.image)
        }
    }
    
    fileprivate func themeInfo(theme: Theme) -> (title: String, image: String) {
        
        switch theme {
        case .Halloween:
            return ("Halloween", "leaf.fill")
        case .Animals:
            return ("Animals", "tortoise")
        case .Weather:
            return ("Weather", "sun.max.fill")
        }
    }
    
    fileprivate func themeButtonTitle(title: String, imageName: String) -> some View {
        
        VStack {
            Image(systemName: imageName).padding(.bottom, 2)
            Text(title)
        }.padding()
            .foregroundStyle(.orange)
            .background(
                RoundedRectangle(cornerRadius: 10)
                    .stroke(.orange, lineWidth: 1)
            )
    }
    
    fileprivate func updateTheme(selectedTheme: Theme) {
        
        cardIcons.removeAll()
        switch selectedTheme {
        case .Halloween:
            cardIcons.append(contentsOf: halloweenTheme.shuffled())
        case .Animals:
            cardIcons.append(contentsOf: animalTheme.shuffled())
        case .Weather:
            cardIcons.append(contentsOf: weatherTheme.shuffled())
        }
    }
}

struct CardView: View {
    let cardIcon: String
    @State var isFaceUp: Bool = false
    
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

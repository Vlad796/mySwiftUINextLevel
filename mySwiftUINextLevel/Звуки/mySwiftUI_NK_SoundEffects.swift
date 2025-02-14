//
//  mySwiftUI_NK_SoundEffects.swift
//  mySwiftUINextLevel
//
//  Created by Влад Варламов on 08.02.2025.
//

import SwiftUI
import AVKit

//rawValue - не обработанное значение тут  является строкой

class sound {
    static let soundManager = sound()   // Это Singleton. Это патерн который обеспечивает создание только одного экземпляра класса, на протяжении всего приложения
    
    var playr: AVAudioPlayer?   //Плеер, который можно представить как iTunce. Он воспроизводит звуки. Но для него надо указать что воспроизводить
    
    enum soundOption: String {
        case bruh
        case uwu
    }
    
    func playSound(sound: soundOption) {
        guard let url = Bundle.main.url(forResource: sound.rawValue, withExtension: ".mp3") else { return }
        
        do {
            try playr = AVAudioPlayer(contentsOf: url)
            playr?.play()
        } catch {
            print("Error playing sound: \(error.localizedDescription)")
        }
    }
}

struct mySwiftUI_NK_SoundEffects: View {
    var body: some View {
        VStack(spacing: 20) {
            Button {
                sound.soundManager.playSound(sound: .uwu)
            } label: {
                Text("Play Sound 1")
            }
            
            Button {
                sound.soundManager.playSound(sound: .bruh)
            } label: {
                Text("Play Sound 2")
            }
        }
    }
}

#Preview {
    mySwiftUI_NK_SoundEffects()
}

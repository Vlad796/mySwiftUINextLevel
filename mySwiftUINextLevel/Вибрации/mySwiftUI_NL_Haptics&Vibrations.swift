//
//  mySwiftUI_NL_Haptics&Vibrations.swift
//  mySwiftUINextLevel
//
//  Created by Влад Варламов on 09.02.2025.
//

import SwiftUI

/*
 Для того что бы создать вибрации нам нужно:
 1) Создать класс с приватной переменной, которой будет присвоенн класс
 2) Создать функции, в одной будет прописана функция вибрации
    2.1)
 */

class hapticManager {
    private var haptic = hapticManager()
    
    func typeHaptic(type: UINotificationFeedbackGenerator.FeedbackType) {
        let tpHaptic = UINotificationFeedbackGenerator()
        tpHaptic.notificationOccurred(type)
    }
    
    func styleHaptic(style: UIImpactFeedbackGenerator.FeedbackStyle, view: UIView) {
        let stlHaptic = UIImpactFeedbackGenerator(style: style, view: view)
        stlHaptic.impactOccurred()
    }
}

struct mySwiftUI_NL_Haptics_Vibrations: View {
    var body: some View {
        Button {
            hapticManager().typeHaptic(type: .error)
        } label: {
            Text("error")
        }
        Button {
            hapticManager().typeHaptic(type: .warning)
        } label: {
            Text("warning")
        }
        Button {
            hapticManager().typeHaptic(type: .success)
        } label: {
            Text("success")
        }
        Divider()
        Button {
            hapticManager().styleHaptic(style: .heavy, view: .appearance())
        } label: {
            Text("heavy")
        }
    }
}

struct viewForhaptic: View {
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}


#Preview {
    mySwiftUI_NL_Haptics_Vibrations()
}

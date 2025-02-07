 //
//  mySwiftUIRotationGesture.swift
//  mySwiftUINextLevel
//
//  Created by Влад Варламов on 05.02.2025.
//

import SwiftUI

struct mySwiftUI_NL_RotationGesture: View {
    
    @State var angle: Angle = Angle(degrees: 0)         //Нальное положения равное 0
    
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
            .font(.largeTitle)
            .foregroundStyle(.white)
            .padding()
            .background(.blue)
            .clipShape(RoundedRectangle(cornerRadius: 10))
            .rotationEffect(angle)
            .gesture(
                RotationGesture()
                    .onChanged({ value in
                        angle = value
                    })
                    .onEnded({ value in
                        withAnimation(.spring()) {
                            angle = Angle(degrees: 0)
                        }
                    })
            )
    }
}

#Preview {
    mySwiftUI_NL_RotationGesture()
}

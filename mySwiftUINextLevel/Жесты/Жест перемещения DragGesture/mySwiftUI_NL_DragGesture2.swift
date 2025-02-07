//
//  mySwiftUI_NL_DragGesture2.swift
//  mySwiftUINextLevel
//
//  Created by Влад Варламов on 07.02.2025.
//

import SwiftUI

struct mySwiftUI_NL_DragGesture2: View {
    
    @State var startingOffsetY:CGFloat = UIScreen.main.bounds.height * 0.83     //Начальное положение экрана
    @State var currentOffsetY:CGFloat = 0       //Изменяемое положение элемента
    @State var endingOffsetY:CGFloat = 0    //Конечное поожение
    
    var body: some View {
        ZStack{
            Color.blue.ignoresSafeArea()
            
            myPlayStation()
                .offset(y: startingOffsetY)
                .offset(y: currentOffsetY)
                .offset(y: endingOffsetY)
                .gesture(
                    DragGesture()
                        .onChanged { value in
                            withAnimation(.spring) {
                                currentOffsetY = value.translation.height
                            }
                        }
                        .onEnded { value in
                            withAnimation(.spring) {
                                if currentOffsetY < -100 {
                                    endingOffsetY = -startingOffsetY
                                } else  if currentOffsetY > 170 && endingOffsetY != 0 {
                                     endingOffsetY = 0
                                }
                                currentOffsetY = 0
                            }
                        }
                )
            VStack {
                Text ("\(startingOffsetY)")
                Text ("\(currentOffsetY)")
                Text ("\(endingOffsetY)")
            }
        }
    }
}

#Preview {
    mySwiftUI_NL_DragGesture2()
}

struct myPlayStation: View {
    var body: some View {
        VStack(spacing: 20) {
            Image(systemName: "chevron.up")
                .padding(.top)
            
            Text ("Your info")
                .font(.headline)
            
            Image(systemName: "playstation.logo")
                .resizable()
                .scaledToFit()
                .frame(width: 100, height: 100)
            
            Text("PlayStation")
            
            Spacer()
        }
        .frame(maxWidth: .infinity)
        .background(Color.white)
        .clipShape(RoundedRectangle(cornerRadius: 30))
        .ignoresSafeArea(edges: .bottom)
    }
}

//
//  mySwiftUIMagnificationGesture.swift
//  mySwiftUINextLevel
//
//  Created by Влад Варламов on 05.02.2025.
//

import SwiftUI

/*
 scaleEffect - нужен для того что бы был эфект увеличения
 
 gesture - добавляет жесты
 
 onChanged - нужен для того что бы анимация работала правильно
 
 onEnded - нужен для того что бы задать действие элемента после окончания первого жеста
 */

struct mySwiftUI_NL_MagnificationGesture: View {
    
    @State var currentAmount: CGFloat = 0       //Соответствует начальному размеру элемента
    @State var lustAmount: CGFloat = 0      //Для сохранения уже увеличенного размера
    
    var body: some View {
        VStack(spacing: 10){
            HStack {
                Circle()
                    .frame(width: 40, height: 40)
                Text("Your account")
                Spacer()
                Image(systemName: "ellipsis")
            }
            .padding(.horizontal)
            
            RoundedRectangle(cornerRadius: 10)
                .frame(height: 300)
                .frame(maxWidth: .infinity)
                .scaleEffect(1 + currentAmount)
                .gesture(
                    MagnificationGesture()
                        .onChanged({ value in
                            currentAmount = value - 1
                        })
                        .onEnded({ value in
                            withAnimation(.easeIn) {
                                currentAmount = 0
                            }
                        })
                )
            
            HStack{
                Image(systemName: "heart.fill")
                Image(systemName: "text.bubble.fill")
                Spacer()
            }
            .padding(.horizontal)
            
            Text("This is caption for your photo")
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal)
        }
        
        
        
//        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
//            .foregroundStyle(.white)
//            .padding()
//            .background(.red)
//            .clipShape(RoundedRectangle(cornerRadius: 10))
//            .scaleEffect(1 + currentAmount + lustAmount)     //Нужна для эфекта увеличения
//            .gesture(
//                MagnificationGesture()
//                    .onChanged({ value in
//                        currentAmount = value - 1
//                    })
//                    .onEnded({ value in
//                        lustAmount += currentAmount
//                        currentAmount = 0
//                    })
//            )
    }
}

#Preview {
    mySwiftUI_NL_MagnificationGesture()
}

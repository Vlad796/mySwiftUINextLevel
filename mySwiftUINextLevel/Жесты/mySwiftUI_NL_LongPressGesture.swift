//
//  mySwiftUINL_LongPressGesture.swift
//  mySwiftUINextLevel
//
//  Created by Влад Варламов on 05.02.2025.
//

import SwiftUI

/*
 minimumDuration - это время удержания пальца
 
 maximumDistance - на каком растоянии от объекта можно взаимодействовать с ним
 */

struct mySwiftUI_NL_LongPressGesture: View {
    
    @State var isClicked: Bool = false
    @State var isSuccess: Bool = false
    
    var body: some View {
        
        RoundedRectangle(cornerRadius: 10)
            .fill(isSuccess ? Color.green : Color.red)
            .frame(maxWidth: isClicked ? .infinity : 0)
            .frame( height: 50)
            .frame(maxWidth: .infinity, alignment: .leading)
            .background(Color.gray)
            .clipShape(RoundedRectangle(cornerRadius: 10))
            .padding()
        
        HStack {
            Text("Progres")
                .foregroundStyle(Color.white)
                .padding(9)
                .padding(.horizontal)
                .background(Color.gray)
                .clipShape(RoundedRectangle(cornerRadius: 10))
                .padding()
                .onLongPressGesture(minimumDuration: 1.0, maximumDistance: 30) {
                    withAnimation {
                        isSuccess = true
                    }
                } onPressingChanged: { isPresent in
                    if isPresent {
                        withAnimation(.easeInOut(duration: 1.0)) {
                            isClicked = true
                        }
                    } else {
                        DispatchQueue(label: "com.example.mySwiftUINL").asyncAfter(deadline: .now() + 0.1) {
                            if !isSuccess {
                                withAnimation {
                                    isClicked = false
                                }
                            }
                        }
                    }
                }


            
            Text("Reset")
                .foregroundStyle(Color.white)
                .padding(9)
                .padding(.horizontal)
                .background(Color.gray)
                .clipShape(RoundedRectangle(cornerRadius: 10))
                .padding()
                .onTapGesture {
                    isClicked = false
                    isSuccess = false
                }
        }
            
        
//        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
//            .padding()
//            .padding(.horizontal)
//            .background(isClicked ? Color.green : Color.gray)
//            .clipShape(RoundedRectangle(cornerRadius: 10))
////            .onTapGesture {
////                isClicked.toggle()
////            }
//            .onLongPressGesture(minimumDuration: 3.0, maximumDistance: 100) {
//                isClicked.toggle()
//            }
    }
}

#Preview {
    mySwiftUI_NL_LongPressGesture()
}

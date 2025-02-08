//
//  mySwiftUI_NL_GeometryReader.swift
//  mySwiftUINextLevel
//
//  Created by Влад Варламов on 07.02.2025.
//

import SwiftUI

/*
 GeometryReader - Вид контейнера, который определяет своё содержимое в зависимости от собственного размера и пространства координат.
 
 Он очень ресурсо-ёмкий и поэтому его лучше использовать только при реальной необходимости
 */

struct mySwiftUI_NL_GeometryReader: View {
    
    var body: some View {
        
        ScrollView(.horizontal) {
            HStack{
                ForEach(0..<20) { value in
                    GeometryReader { geometry in
                        RoundedRectangle(cornerRadius: 20)
                            .rotation3DEffect(Angle(degrees: getGeometry(geo: geometry) * 30), axis: (x: 0.0, y: 1.0, z: 0.0))
                    }
                    .frame(width: 300, height: 200)
                    .padding()
                }
            }
        }
//        GeometryReader { geometry in
//            HStack(spacing: 0) {
//                Rectangle()
//                    .fill(Color.red)
//                    .frame(width: geometry.size.width * 0.666)  //А уже с GeometryReader красный цвет будет занимать именно ту область экрана, что нyжно, при повороте экрана
//                
//    //                .frame(width: UIScreen.main.bounds.width * 0.666)   //Это не помежет при занять красному цвету нужную область при повороте экрана
//                Rectangle()
//                    .fill(Color.blue)
//            }
//            .ignoresSafeArea()
//        }
    }
    func getGeometry(geo: GeometryProxy) -> Double {
        let maxDistance = UIScreen.main.bounds.width / 2
        let currentX = geo.frame(in: .global).midX
        return Double(1 - (currentX / maxDistance))
    }
}

#Preview {
    mySwiftUI_NL_GeometryReader()
}

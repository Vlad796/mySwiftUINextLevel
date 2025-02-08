//
//  mySwiftUI_NL_Mask.swift
//  mySwiftUINextLevel
//
//  Created by Влад Варламов on 08.02.2025.
//

import SwiftUI

/*
 Для работы этой фичи был взят прямоугольник и к нему была применена маска для наложения на звузды
 */

struct mySwiftUI_NL_Mask: View {
    
    @State var reting: Int = 0
    
    var body: some View {
        ZStack{
            star
                .overlay(starFill.mask(star))       //Задаем маску для наложения элементов друг на друга
        }
    }
    private var star: some View {
        HStack{
            ForEach(1..<6) { index in
                Image(systemName: "star.fill")
                    .font(.largeTitle)
                    .foregroundStyle(.gray)
                    .onTapGesture {
                        withAnimation(.easeInOut) {
                            reting = index       //Присваиваем рейтингу значени индекса
                        }
                    }
            }
        }
    }
    
    private var starFill: some View {
        GeometryReader { geometri in
            ZStack{
                Rectangle()
                    .foregroundStyle(.yellow)
                    .frame(width: CGFloat(reting) / 5 * geometri.size.width)
            }
        }
        .allowsHitTesting(false)    //Модификатор который не разрешает нажисать на слой которому он присвоен
    }
}

#Preview {
    mySwiftUI_NL_Mask()
}

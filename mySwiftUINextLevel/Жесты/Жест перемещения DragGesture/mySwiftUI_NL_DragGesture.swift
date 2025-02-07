//
//  mySwiftUI_NL_DragGesture.swift
//  mySwiftUINextLevel
//
//  Created by Влад Варламов on 07.02.2025.
//

import SwiftUI

/*
 let max = UIScreen.main.bounds.width / 2    //Это максимальное расстояние, на которое элемент можно перетаскивать по горизонтали. Вы увеличиваете его до половины ширины экрана (Screen.main.bounds.width / 2), поэтому прямоугольник сможет перемещаться на половину ширины экрана от своего первоначального положения.
 let currentAmount = abs(moving.width)       //Это абсолютное расстояние по горизонтали, на которое был перетащен прямоугольник, т.е. ширина перемещения. Поскольку перетаскивание может осуществляться как влево, так и вправо, мы используем as(moving.width), чтобы убедиться, что мы имеем дело с положительным значением, игнорируя направление (влево или вправо).
 let procent = currentAmount / max       //При этом вычисляется, насколько сильно элемент был помечен, в процентах от максимально допустимого перетаскивания. Результатом является значение от 0 до 1. Например, если прямоугольник переместить до максимально допустимого значения горизонтального перетаскивания (max), то значение currentAmount будет равно max, а процент будет равен 1,0. Если прямоугольник вообще не перемещается, значение currentAmount будет равно 0, а процент - 0.0.
 */

struct mySwiftUI_NL_DragGesture: View {
    
    @State var moving: CGSize = .zero
    
    
    var body: some View {
        RoundedRectangle(cornerRadius: 15)
            .frame(width: 350, height: 600)
            .offset(moving)
            .scaleEffect(getScaleAmount())
            .rotationEffect(Angle(degrees: getRotationAmount()))
            .gesture(
                DragGesture()
                    .onChanged { value in
                        withAnimation(.spring) {
                            moving = value.translation
                        }
                    }
                    .onEnded({ value in
                        withAnimation(.bouncy) {
//                            moving = value.translation        //Оставляет элемент на том месте, куда он был перемещен
                            moving = .zero      //Возвращает элемента на то место где он и находился
                        }
                    })
            )
    }
    
    func getScaleAmount() -> CGFloat {
        let max = UIScreen.main.bounds.width / 2
        let currentAmount = abs(moving.width)
        let procent = currentAmount / max
        return 1.0 - min(procent, 0.4) * 0.5
    }
    
    func getRotationAmount() -> Double {
        let max = UIScreen.main.bounds.width / 2
        let currentAmount = moving.width
        let procent = currentAmount / max
        let procentRotation = Double(procent)   //константе procentRotation присвавается значения переведенного procent в тип Double
        let maxAngle: Double = 10   //Задаётся максимальный угол в 10
        return procentRotation * maxAngle   //Возвращается соотношения процента поворота и максимального угла при повороте
    }
}

#Preview {
    mySwiftUI_NL_DragGesture()
}

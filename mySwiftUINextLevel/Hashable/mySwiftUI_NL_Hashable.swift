 //
//  mySwiftUI_NL_Hashable.swift
//  mySwiftUINextLevel
//
//  Created by Влад Варламов on 15.02.2025.
//

import SwiftUI

/*
 Протокол Hashable используется как протокол Identifiable - это еще один способ присвоения уникального идентификатора объекту.
 На самом деле, хеширование намного сложнее, но это все, что вам действительно нужно понять для наших целей.
 Когда мы используем хэш-значения в приложениях SwiftUI, это обычно делается для того, чтобы система могла определить, какой объект является каким.
 
 Типы данных которые относятся к Hashable:
    - Базовые типы. К ним относятся String, Int, Bool, числа с плавающей точкой.
    - Перечисления без связанных значений.
    - Массивы и необязательные типы, чьи аргументы соответствуют Hashable.
 
 Если будет создаваться тип данных с двумя значениями:
 struct myCustomData: Hashable {
     let titel: String
     let subTitel: String
     
     func hash(into hasher: inout Hasher) {      //тут мы создаем уникальное значение
         hasher.combine(titel + subTitel)   // тут будет создан уни кальный hash-идентификатор, на основе titel и subTitel
     }
 }
 */


struct myCustomData: Hashable {
    let titel: String
    
    func hash(into hasher: inout Hasher) {      //тут мы создаем уникальное значение
        hasher.combine(titel)   // тут создается уникальный hash-идентификатор, на основе titel
    }
}

struct mySwiftUI_NL_Hashable: View {
    
    let data: [myCustomData] = [
        myCustomData(titel: "one"),
        myCustomData(titel: "two"),
        myCustomData(titel: "three"),
        myCustomData(titel: "fore"),
        myCustomData(titel: "five"),
    ]
    
    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                ForEach(data, id: \.self) { item in
                    Text(item.hashValue.description)
                }
            }
        }
    }
}

#Preview {
    mySwiftUI_NL_Hashable()
}

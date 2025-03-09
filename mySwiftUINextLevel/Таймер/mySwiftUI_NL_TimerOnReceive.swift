//
//  mySwiftUI_NL_TimerOnReceive.swift
//  mySwiftUINextLevel
//
//  Created by Влад Варламов on 08.03.2025.
//

import SwiftUI

/*
 Реализовать таймер в пользовательском интерфейсе Swift так же просто, как одну строку кода!
 Мы будем использовать функцию .onReceive для прослушивания таймера (также известную как "подписка").
 */

struct mySwiftUI_NL_TimerOnReceive: View {
    
    let timer = Timer.publish(every: 3.0, on: .main, in: .common).autoconnect()
    
    //Форматирование дат
    /*
         @State var currentDate = Date()
         var farmatedDate: DateFormatter {
            let formater = DateFormatter()
            formater.dateStyle = .medium
            return formater
         }
         var formatedTime: DateFormatter {
            let formater = DateFormatter()
            formater.timeStyle = .short
            return formater
         }
     */
    
    //Обратный осчёт
    /*
    @State var defoultCount = 10
    @State var finishedText: String? = nil
    */
    
    //Обратный отсчет ограниченного времени
    /*
    @State var timeRemaining = ""
    let futureDate = Calendar.current.date(byAdding: .day, value: 1, to: Date()) ?? Date()
    
    func updadeDate() {
        let remeining = Calendar.current.dateComponents([.hour, .minute, .second], from: Date(), to: futureDate)
        let hour = remeining.hour ?? 0
        let min = remeining.minute ?? 0
        let sec = remeining.second ?? 0
        timeRemaining = "\(hour):\(min):\(sec)"
    }
    */
    
    //Анимации
    @State var anim = 0
    
    var body: some View {
        ZStack {
            RadialGradient(gradient: Gradient(colors: [Color.blue, Color.white]), center: .center, startRadius: 5, endRadius: 500)
                .ignoresSafeArea()
            VStack {
                //Форматирование дат
                /*
                Text(farmatedDate.string(from: currentDate))
                    .font(.system(size: 100, weight: .bold, design: .rounded))
                    .foregroundStyle(Color(#colorLiteral(red: 0.004859850742, green: 0.09608627111, blue: 0.5749928951, alpha: 1)))
                    .lineLimit(1)
                    .minimumScaleFactor(0.1)
                 */
                
                //Обратный осчёт
                /*
                Text(finishedText ?? "\(defoultCount)")
                    .font(.system(size: 70, weight: .bold, design: .rounded))
                    .foregroundStyle(Color(#colorLiteral(red: 0.004859850742, green: 0.09608627111, blue: 0.5749928951, alpha: 1)))
                    .lineLimit(1)
                    .minimumScaleFactor(0.1)
                 */
                
                //Обратный отсчет ограниченного времени
                /*
                Text(timeRemaining)
                    .font(.system(size: 70, weight: .bold, design: .rounded))
                    .foregroundStyle(Color(#colorLiteral(red: 0.004859850742, green: 0.09608627111, blue: 0.5749928951, alpha: 1)))
                    .lineLimit(1)
                    .minimumScaleFactor(0.1)
                 */
                
                //Анимации
//                HStack (spacing: 7){
//                    Circle()
//                        .foregroundStyle(.white)
//                        .offset(y: anim == 1 ? -10 : 0)
//                    Circle()
//                        .foregroundStyle(.white)
//                        .offset(y: anim == 2 ? -10 : 0)
//                    Circle()
//                        .foregroundStyle(.white)
//                        .offset(y: anim == 3 ? -10 : 0)
//                }
//                .frame(width: 100, height: 100)
//                .padding()
                TabView(selection: $anim, content: {
                    RoundedRectangle(cornerRadius: 10)
                        .foregroundStyle(.green)
                        .tag(1)
                    RoundedRectangle(cornerRadius: 10)
                        .foregroundStyle(.blue)
                        .tag(2)
                    RoundedRectangle(cornerRadius: 10)
                        .foregroundStyle(.red)
                        .tag(3)
                    RoundedRectangle(cornerRadius: 10)
                        .foregroundStyle(.brown)
                        .tag(4)
                    RoundedRectangle(cornerRadius: 10)
                        .foregroundStyle(.orange)
                        .tag(5)
                    RoundedRectangle(cornerRadius: 10)
                        .foregroundStyle(.gray)
                        .tag(6)
                })
                .frame(height: 200)
                .tabViewStyle(.page)
            }
            .padding()
        }
        .onReceive(timer) { value in
            //currentDate = value    //Форматирование дат
            
            //Обратный осчёт
            /*
            if defoultCount <= 1 {
                finishedText = "You done"
            } else {
                defoultCount -= 1
            }
             */
            
            //updadeDate()    //Обратный отсчет ограниченного времени
            
            //Анимации
            withAnimation(.easeInOut) {
                anim = anim == 6 ? 0 : anim + 1
            }
        }
    }
}

#Preview {
    mySwiftUI_NL_TimerOnReceive()
}

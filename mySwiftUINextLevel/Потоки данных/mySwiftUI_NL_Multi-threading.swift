//
//  mySwiftUI_NL_Multi-threading.swift
//  mySwiftUINextLevel
//
//  Created by Влад Варламов on 24.02.2025.
//

import SwiftUI

/*
 По умолчанию весь код, который мы пишем в наших приложениях, выполняется в "главном потоке", однако, если основной поток когда-либо будет перегружен задачами, это может замедлить работу, заморозить или даже привести к сбою нашего приложения. К счастью, Apple предоставляет нам легкий доступ ко многим другим потокам, которые мы можем использовать для разгрузки части работы!
 */

class multiThreadViewModel: ObservableObject {
    @Published var dataArray: [String] = []
    
    func fetchData() {
        DispatchQueue.global().async {  //Загрузка в фоновом потоке
            let newData = self.addingData()
            
            DispatchQueue.main.async {      //Загрузка в основной поток
                self.dataArray = newData
            }
        }
    }
    
    //Цикл из элементов
    private func addingData() -> [String]{
        var сycleЬassive: [String] = []
        for x in 0..<100 {
            сycleЬassive.append(String(x))
        }
        return сycleЬassive
    }
}

struct mySwiftUI_NL_Multi_threading: View {
    
    @StateObject var vm = multiThreadViewModel()
    
    var body: some View {
        ScrollView {
            LazyVStack {
                Text("Multi-threading")
                    .font(.headline)
                    .padding(10)
                    .onTapGesture {
                        vm.fetchData()
                    }
                
                ForEach(vm.dataArray, id: \.self) { data in
                    Text(data)
                }
            }
        }
    }
}

#Preview {
    mySwiftUI_NL_Multi_threading()
}

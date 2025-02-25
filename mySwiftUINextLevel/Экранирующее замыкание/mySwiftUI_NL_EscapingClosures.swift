//
//  mySwiftUI_NL_EscapingClosures.swift
//  mySwiftUINextLevel
//
//  Created by Влад Варламов on 25.02.2025.
//

import SwiftUI

/*
 Мы используем замыкания @escaping, чтобы справиться с возвратом из функций при использовании асинхронного кода.
 Это код, который выполняется не сразу, а в будущем.
 Это становится чрезвычайно важным, когда нам нужно загрузить данные из Интернета!
 */

class escapingViewModel: ObservableObject {
    
    @Published var text: String = "hello"
    
//    func getData() {
//        let newData = downloadData()
//        text = newData
//    }
    
    func getData() {
        downloadData4 { [weak self] returnData in
            self?.text = returnData.data
        }
    }
    
    func downloadData() -> String{
        return "New data"
    }
    
    func downloadData2(complitonHandler: (_ data: String) -> Void) {
        complitonHandler("New data 2")
    }
    
    //Вариант с использованием внешней модели типов. Это может пригодиться если нужно будет возвращать несколько типов
    func downloadData3(complitonHandler: @escaping (downloadResult) -> Void) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            let result = downloadResult(data: "New data 3")
            complitonHandler(result)
        }
    }
    
    func downloadData4(complitonHandler: @escaping fulldownloadResult) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            let result = downloadResult(data: "New data 3")
            complitonHandler(result)
        }
    }
}

struct downloadResult {
    let data: String
}

typealias fulldownloadResult = (downloadResult) -> Void

struct mySwiftUI_NL_EscapingClosures: View {
    
    @StateObject var vm = escapingViewModel()
    
    var body: some View {
        Text(vm.text)
            .font(.title)
            .fontWeight(.bold)
            .foregroundStyle(.blue)
            .onTapGesture {
                vm.getData()
            }
    }
}

#Preview {
    mySwiftUI_NL_EscapingClosures()
}

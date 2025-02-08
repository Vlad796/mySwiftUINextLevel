//
//  mySwiftUI_NL_MultipleSheets_2.swift
//  mySwiftUINextLevel
//
//  Created by Влад Варламов on 08.02.2025.
//

import SwiftUI

struct sheetModel2: Identifiable {
    var id = UUID().uuidString
    let title: String
}

/*
 Еще для работы с несколькими листами подойдет такой вариант. Если нам нужно во второй странице неизменяемые значения переменных, то можно напрямую от кнопи создовать листы и уже там задавать содержимое
 */

struct mySwiftUI_NL_MultipleSheets_2: View {
    
    @State var selectModel: sheetModel2 = sheetModel2(title: "Starting sheet")
    @State var showSheet: Bool = false
    @State var showSheet2: Bool = false
    
    var body: some View {
        VStack(spacing: 20){
            Button {
                showSheet.toggle()
            } label: {
                Text("Sheet 1")
            }
            .sheet(isPresented: $showSheet) {
                secondSheeе2(selectModel2: sheetModel2(title: "Page 1"))
            }
            
            Button {
                showSheet.toggle()
            } label: {
                Text("Sheet 2")
            }
            .sheet(isPresented: $showSheet2) {
                secondSheeе2(selectModel2: sheetModel2(title: "Page 2"))
            }
        }
    }
}

struct secondSheeе2: View {
    
    let selectModel2: sheetModel2
    
    var body: some View {
        Text(selectModel2.title)
    }
}

#Preview {
    mySwiftUI_NL_MultipleSheets_2()
}

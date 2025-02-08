//
//  mySwiftUI_NL_MultipleSheets.swift
//  mySwiftUINextLevel
//
//  Created by Влад Варламов on 08.02.2025.
//

import SwiftUI

struct sheetModel: Identifiable {
    var id = UUID().uuidString
    let title: String
}

struct mySwiftUI_NL_MultipleSheets_1: View {
    
    @State var selectModel: sheetModel = sheetModel(title: "Starting sheet")
    @State var showSheet: Bool = false
    
    var body: some View {
        VStack(spacing: 20){
            Button {
                showSheet.toggle()
                selectModel = sheetModel(title: "Page 1")
            } label: {
                Text("Sheet 1")
            }
            
            Button {
                showSheet.toggle()
                selectModel = sheetModel(title: "Page 2")
            } label: {
                Text("Sheet 2")
            }
        }
        .sheet(isPresented: $showSheet) {
            secondSheet(selectModel: $selectModel)
        }
    }
}

struct secondSheet: View {
    
    @Binding var selectModel: sheetModel
    
    var body: some View {
        Text(selectModel.title)
    }
}

#Preview {
    mySwiftUI_NL_MultipleSheets_1()
}

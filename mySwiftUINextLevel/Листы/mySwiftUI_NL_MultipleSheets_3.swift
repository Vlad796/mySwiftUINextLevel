//
//  mySwiftUI_NL_MultipleSheets_3.swift
//  mySwiftUINextLevel
//
//  Created by Влад Варламов on 08.02.2025.
//

import SwiftUI

struct sheetModel3: Identifiable {
    var id = UUID().uuidString
    let title: String
}

/*
 Хороший вариант цикличного исопльзования листов, для отображения разной инфоормации
 */

struct mySwiftUI_NL_MultipleSheets_3: View {
    
    @State var selectModel: sheetModel3?
    @State var showSheet: Bool = false
    @State var showSheet2: Bool = false
    
    var body: some View {
        ScrollView {
            VStack(spacing: 20){
                ForEach(0..<20) { index in
                    Button {
                        showSheet.toggle()
                        selectModel = sheetModel3(title: "Page \(index)")
                    } label: {
                        Text("Sheet \(index)")
                    }
                }
                
                
    //            Button {
    //                showSheet.toggle()
    //                selectModel = sheetModel3(title: "Page 2")
    //            } label: {
    //                Text("Sheet 2")
    //            }
            }
            .sheet(item: $selectModel) { index in
                secondSheeе3(selectModel3: index)
            }
        }
    }
}

struct secondSheeе3: View {
    
    let selectModel3: sheetModel3
    
    var body: some View {
        Text(selectModel3.title)
    }
}

#Preview {
    mySwiftUI_NL_MultipleSheets_3()
}


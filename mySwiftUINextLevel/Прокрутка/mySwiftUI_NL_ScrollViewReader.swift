//
//  mySwiftUI_NL_ScrollViewReader.swift
//  mySwiftUINextLevel
//
//  Created by Влад Варламов on 07.02.2025.
//

import SwiftUI

struct mySwiftUI_NL_ScrollViewReader: View {
    
    @State var textFildText: String = ""
    @State var scrolToIndex = 0
    
    var body: some View {
        VStack{
            TextField("Search", text: $textFildText)
                .padding(.horizontal)
                .keyboardType(.numberPad)
            
            Button {
                if let index = Int(textFildText) {
                    scrolToIndex = index
                }
            } label: {
                Text("Search")
            }

            
            ScrollView {
                ScrollViewReader { proxy in
                    ForEach(0..<100) { index in
                        Text("It's some kind of element \(index)")
                            .font(.headline)
                            .frame(height: 150)
                            .frame(maxWidth: .infinity)
                            .background(.white)
                            .clipShape(RoundedRectangle(cornerRadius: 15))
                            .shadow(radius: 5)
                            .padding()
                            .id(index)
                    }
                    .onChange(of: scrolToIndex) { oldValue, newValue in
                        withAnimation(.easeInOut) {
                            proxy.scrollTo(newValue, anchor: .center)
                        }
                    }
                }
            }
        }
    }
}

#Preview {
    mySwiftUI_NL_ScrollViewReader()
}

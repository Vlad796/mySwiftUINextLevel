//
//  mySwiftUI_NL_PublishersAndSubscribersInCombine.swift
//  mySwiftUINextLevel
//
//  Created by Влад Варламов on 09.03.2025.
//

import SwiftUI
import Combine

class subscribersViewModel: ObservableObject {
    
    @Published var count = 0
    
    @Published var textFildText = ""
    @Published var isValidTextFild: Bool = false
    
    @Published var showButton = false
    
    var cancellables = Set<AnyCancellable>()
    
    
    init() {
        setUpTimer()
        addTextFildSubscriber()
        addButtonSubscriber()
    }
    
    func addTextFildSubscriber() {
        $textFildText
            .debounce(for: .seconds(0.5), scheduler: DispatchQueue.main)    //Задержка перед вызовом основной функции
            .map { (text) -> Bool in
                if text.count > 4 {
                    return true
                } else {
                    return false
                }
            }
            .sink { [weak self] (isValid) in
                self?.isValidTextFild = isValid
            }
            .store(in: &cancellables)
    }
    
    func setUpTimer() {
       Timer.publish(every: 1, on: .main, in: .common)
            .autoconnect()
            .sink { [weak self] _ in
                guard let self = self else { return }   //Проверка на работоспособность self
                self.count += 1
            }
            .store(in: &cancellables)
    }
    
    func addButtonSubscriber() {
        $isValidTextFild
            .combineLatest($count)  //Синхронизация двух издателей $isValidTextFild и $count
            .sink { [weak self] (isValid, count) in
                guard let self = self else { return }
                if isValid && count >= 10 {
                    self.showButton = true
                } else {
                    self.showButton = false
                }
            }
            .store(in: &cancellables)
    }
}

struct mySwiftUI_NL_PublishersAndSubscribersInCombine: View {
    
    @StateObject var vm = subscribersViewModel()
    
    var body: some View {
        VStack {
            Text("\(vm.count)")
                .font(.largeTitle)
            
            TextField("Your name", text: $vm.textFildText)
                .padding()
                .frame(width: 370, height: 50)
                .background(Color(#colorLiteral(red: 0.921431005, green: 0.9214526415, blue: 0.9214410186, alpha: 1)))
                .clipShape(RoundedRectangle(cornerRadius: 10))
                .overlay(alignment: .trailing) {
                    Image(systemName: "xmark")
                        .padding(.trailing)
                        .font(.title)
                        .foregroundStyle(.red)
                        .opacity(
                            vm.textFildText.count < 1 ? 0.0 :
                                vm.isValidTextFild ? 0.0 : 1.0
                        )
                    Image(systemName: "checkmark")
                        .padding(.trailing)
                        .font(.title)
                        .foregroundStyle(.green)
                        .opacity(
                            vm.isValidTextFild ? 1.0 : 0.0
                        )
                }
                .padding(.horizontal)
            
            Button {
                
            } label: {
                Text("Submit")
                    .frame(width: 370, height: 50)
                    .font(.title)
                    .foregroundStyle(.white)
                    .background(.blue)
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                    .opacity(
                        vm.showButton ? 1.0 : 0.5
                    )
            }
            .disabled(!vm.showButton)

        }
    }
}

#Preview {
    mySwiftUI_NL_PublishersAndSubscribersInCombine()
}

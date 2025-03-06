//
//  mySwiftUI_NL_JSONFromAPICombine.swift
//  mySwiftUINextLevel
//
//  Created by Влад Варламов on 04.03.2025.
//

import SwiftUI
import Combine

/*
 Combine - это новый фреймворк от Apple, созданный специально для обработки асинхронных событий.
 Используя издателей и подписчиков, мы можем постоянно синхронизировать данные в нашем приложении.
 */

struct apiModelCombine: Identifiable, Codable {
    let userId: Int
    let id: Int
    let title: String
    let body: String
}

class downloadWhithEscapingCombine: ObservableObject {
    
    @Published var data: [apiModelCombine] = []
    var cancellable = Set<AnyCancellable>()
    
    init() {
        getPosts()
    }
    
    func getPosts() {
        guard let url = URL(string: "https://jsonplaceholder.typicode.com/posts") else { return }
        
        //Описание создания Combine
        /*
        //1: subscribe - Создание Publisher (Издателя), которая происходит в фоновом потоке. Вообще dataTaskPublisher, и так выполняется в фоновом режиме, но иногда это происходит не явно и приходится переносить все вручную
        //2: receive - Перенос обработки в омсновной поток.
        //3: tryMap - Проверка целостности данных и в случае повреждения, выдавать тот тип ошибки который будет указан
        //4: decode - Декодирование данных в модель данных
        //5: sink - Добавление данных в приложение
        //6: store - Отмена подписки если нужно. Это нужно для отмены получения данных в любой момент
        */
        
        URLSession.shared.dataTaskPublisher(for: url)
            .subscribe(on: DispatchQueue.global(qos: .background))
            .receive(on: DispatchQueue.main)
            .tryMap(tryMapOutPut)
//            .tryMap { (data, response) -> Data in
//                guard
//                    let resp = response as? HTTPURLResponse,
//                    resp.statusCode >= 200 && resp.statusCode < 300 else {
//                    throw URLError(.badServerResponse)
//                }
//                return data
//            }
            .decode(type: [apiModelCombine].self, decoder: JSONDecoder())
        
        //Тут прописывается вариант кода, если мы не хотим проверять ошибку
//            .replaceError(with: []) //Тут происходит определение, что будет возвращяться при ошибке
//            .sink(receiveValue: { [weak self] (returnPosts) in
//                self?.data = returnPosts
//            })
        
            .sink { (complition) in
                print("COMPLITION: \(complition)")
            } receiveValue: { [weak self] (returnPosts) in
                self?.data = returnPosts
            }
            .store(in: &cancellable)
    }
    
    func tryMapOutPut(outPut: URLSession.DataTaskPublisher.Output) throws -> Data {
        guard
            let resp = outPut.response as? HTTPURLResponse,
            resp.statusCode >= 200 && resp.statusCode < 300 else {
            throw URLError(.badServerResponse)
        }
        return outPut.data
    }
    
}

struct mySwiftUI_NL_JSONFromAPICombine: View {
    
    @StateObject var vm = downloadWhithEscapingCombine()
    
    var body: some View {
        List {
            ForEach(vm.data) { post in
                VStack {
                    Text(post.title)
                        .font(.headline)
                    Text(post.body)
                        .foregroundStyle(.secondary)
                }
            }
        }
    }
}

#Preview {
    mySwiftUI_NL_JSONFromAPICombine()
}

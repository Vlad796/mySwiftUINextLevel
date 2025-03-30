//
//  mySwiftUI_NL_JSONFromAPIEscaping.swift
//  mySwiftUINextLevel
//
//  Created by Влад Варламов on 02.03.2025.
//

import SwiftUI

struct apiModel: Identifiable, Codable {
    let userId: Int
    let id: Int
    let title: String
    let body: String
}

class downloadDataWhithEscaping: ObservableObject {
    
    @Published var downloadData: [apiModel] = []
    
    init() {
        getData()
    }
    
    func getData() {
        
        guard let url = URL(string: "https://jsonplaceholder.typicode.com/posts") else { return }
        
        downloadData(fromURL: url) { (returnedData) in
            if let data = returnedData {
                guard let newPosts = try? JSONDecoder().decode([apiModel].self, from: data) else { return }
                DispatchQueue.main.async { [weak self] in
                    self?.downloadData = newPosts
                }
            } else {
                print("No data returned")
            }
        }
    }
    
    func downloadData(fromURL url: URL, complitionHandler: @escaping (_ data: Data?) -> ()) {
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard
                let data = data,
                error == nil,
                let response = response as? HTTPURLResponse,
                response.statusCode >= 200 && response.statusCode < 300
            else {
                print ("No data")
                return
            }
            complitionHandler(data)
        }
        .resume()
    }
    
}

struct mySwiftUI_NL_JSONFromAPIEscaping: View {
    
    @StateObject var vm = downloadDataWhithEscaping()
    
    var body: some View {
        List {
            ForEach(vm.downloadData) { index in
                VStack {
                    Text(index.title)
                        .font(.title)
                    Text(index.body)
                        .foregroundStyle(.secondary)
                }
            }
        }
    }
}

#Preview {
    mySwiftUI_NL_JSONFromAPIEscaping()
}

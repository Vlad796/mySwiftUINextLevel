//
//  mySwiftUI_NL_CodableDecodable.swift
//  mySwiftUINextLevel
//
//  Created by Влад Варламов on 01.03.2025.
//

import SwiftUI

/*
 Codable - один из самых мощных протоколов в Swift! Мы используем его для "декодирования" и "кодирования" данных в нашем приложении.
 Это особенно полезно для загрузки данных из Интернета, потому что при загрузке данных они будут представлены в виде данных другого типа (обычно JSON).
 Затем мы используем Codable для преобразования (или "декодирования") данных JSON в тип данных, который есть в нашем приложении для iOS.
 */

struct customerModel: Identifiable, Codable {
    let id: String
    let nameCustomer: String
    let point: Int
    let isPremiem: Bool
    
//    init(id: String, nameCustomer: String, point: Int, isPremiem: Bool) {
//        self.id = id
//        self.nameCustomer = nameCustomer
//        self.point = point
//        self.isPremiem = isPremiem
//    }
//    
//    enum CodingKeys: String, CodingKey {
//        case id
//        case nameCustomer
//        case point
//        case isPremiem
//    }
//    
//    init(from decoder: any Decoder) throws {
//        let container = try decoder.container(keyedBy: CodingKeys.self)
//        self.id = try container.decode(String.self, forKey: .id)
//        self.nameCustomer = try container.decode(String.self, forKey: .nameCustomer)
//        self.point = try container.decode(Int.self, forKey: .point)
//        self.isPremiem = try container.decode(Bool.self, forKey: .isPremiem)
//    }
//    
//    func encode(to encoder: any Encoder) throws {
//        var container = encoder.container(keyedBy: CodingKeys.self)
//        try container.encode(self.id, forKey: .id)
//        try container.encode(self.nameCustomer, forKey: .nameCustomer)
//        try container.encode(self.point, forKey: .point)
//        try container.encode(self.isPremiem, forKey: .isPremiem)
//    }
}

class CodableDecodableViewModel: ObservableObject {
    
    @Published var customer: customerModel? = nil
    
    init() {
        getData()
    }
    
    func getData() {
        guard let data = imitationJSONDATA() else { return }        //Тут мы получаем данные из БД с интернета (в данном случае., имитации)
        self.customer = try? JSONDecoder().decode(customerModel.self, from: data)

//        do {
//            self.customer = try JSONDecoder().decode(customerModel.self, from: data)
//        } catch {
//            print(error.localizedDescription)
//        }
        
        //Код при самостоятельном декодировании данных
//        if
//            let localData = try? JSONSerialization.jsonObject(with: data, options: []),     //Тут происходит декодирование данных из БД
//            let localDictinary = localData as? [String: Any],       //Тут происходит присвоение декодированных данных
//            let id = localDictinary["id"] as? String,       //Тут происходить проверка наличия данных в БД
//            let nameCustomer = localDictinary["nameCustomer"] as? String,       //Тут происходить проверка наличия данных в БД
//            let point = localDictinary["point"] as? Int,        //Тут происходить проверка наличия данных в БД
//            let isPremiem = localDictinary["isPremiem"] as? Bool        //Тут происходить проверка наличия данных в БД
//        {
//            //Тут происходит присвоение данных полученных из БД
//            let newCustomer = customerModel(id: id, nameCustomer: nameCustomer, point: point, isPremiem: isPremiem)
//            customer = newCustomer
//        }
                
            
    }
   
    //имитация получения данных из интернета в формате JSON
    func imitationJSONDATA() -> Data? {
        
        //Добавление данных в БД
        let addCustomer = customerModel(id: "2", nameCustomer: "Светлана Варламова", point: 400, isPremiem: false)
        let jsonData = try? JSONEncoder().encode(addCustomer)
        
//        //Имитация получения данных с БД из интернета
//        let dictinary: [String: Any] = [
//            "id": "1",
//            "nameCustomer": "Влад Варламов",
//            "point": 1000,
//            "isPremiem": true
//        ]
//        //Имитация того, что данные были получены в формате JSON
//        let jsonData = try? JSONSerialization.data(withJSONObject: dictinary, options: [])
        return jsonData
    }
}


struct mySwiftUI_NL_CodableDecodable: View {
    
    @StateObject var vm = CodableDecodableViewModel()
    
    var body: some View {
        VStack(spacing: 10){
            if let content = vm.customer{
                Text(content.id)
                Text(content.nameCustomer)
                Text("\(content.point)")
                Text("\(content.isPremiem )")
            }
        }
    }
}

#Preview {
    mySwiftUI_NL_CodableDecodable()
}

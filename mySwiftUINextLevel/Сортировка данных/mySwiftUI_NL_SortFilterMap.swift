//
//  mySwiftUI_NL_SortFilterMap.swift
//  mySwiftUINextLevel
//
//  Created by Влад Варламов on 15.02.2025.
//

import SwiftUI

/*
 Перед отображением контента на экране (почти всегда) захочется упорядочить данные таким образом, чтобы они отображали определенные фрагменты контента.
 Для этого нужно использовать 3 суперэффективных модификатора, которые предоставляет Apple:

 1. Сортировать(Sort) - упорядочивать данные по критериям
 2. Фильтровать(Filter) - создавать подмножество ваших данных
 3. Сопоставлять(Map) - преобразовывать данные из одного типа в другой
 
 */

struct userModel: Identifiable {
    let  id = UUID().uuidString
    let name: String?
    let points: Int
    let isActive: Bool
}

class arrayModificationViewModel: ObservableObject {
    @Published var usersArray: [userModel] = []
    @Published var sortedArray: [userModel] = []
    @Published var mapArray: [String] = []
    
    init() {
        getUsers()
        sorted()
    }
    
    
    func sorted() {
        //Sort
        /*
        sortedArray = usersArray.sorted(by: { user1, user2 in
            return user1.points > user2.points
        })
        sortedArray = usersArray.sorted(by: { $0.points > $1.points })  //Выполняет тоже самое что и код выше
        */
        
        //Filter
        /*
        sortedArray = usersArray.filter({ user in
            return user.isActive
        })
        sortedArray = usersArray.filter({ $0.isActive }) //Выполняет тоже самое что и код выше
         */
        
        //Map
        /*
        mapArray = usersArray.compactMap({ user in
            return user.name
        })
        mapArray = usersArray.compactMap({ $0.name }) //Выполняет тоже самое что и код выше
         */
        
        //Большая фильтрация
        mapArray = usersArray
            .sorted(by: { $0.points > $1.points })
            .filter ({ $0.isActive })
            .compactMap ({ $0.name })
    }
    
    func getUsers() {
        let user1 = userModel(name: "Влад", points: 100, isActive: true)
        let user2 = userModel(name: "Ваня", points: 24, isActive: false)
        let user3 = userModel(name: "Маша", points: 120, isActive: true)
        let user4 = userModel(name:  nil, points: 30, isActive: false)
        let user5 = userModel(name: "Дима", points: 25, isActive: false)
        let user6 = userModel(name:  nil, points: 67, isActive: true)
        let user7 = userModel(name: "Паша", points: 89, isActive: false)
        let user8 = userModel(name: "Настя", points: 47, isActive: true)
        self.usersArray.append(contentsOf: [
            user1,
            user2,
            user3,
            user4,
            user5,
            user6,
            user7,
            user8
        ])
    }
}

struct mySwiftUI_NL_SortFilterMap: View {
    
    @StateObject var vm = arrayModificationViewModel()
    
    var body: some View {
        ScrollView {
            VStack (spacing: 1){
                ForEach(vm.mapArray, id: \.self) { userName in
                    Text(userName)
                }
//                ForEach(vm.sortedArray ) { user in
//                    VStack (alignment: .leading){
//                        Text(user.name)
//                            .font(.title2)
//                        
//                        HStack {
//                            Text ("Очки: \(user.points)")
//                            Spacer()
//                            if user.isActive {
//                                Image(systemName: "circle.fill")
//                                    .font(.caption)
//                                    .foregroundStyle(.green)
//                            }
//                        }
//                    }
//                    .foregroundStyle(.white)
//                    .padding(.horizontal)
//                    .padding(.vertical, 5)
//                    .background(Color.blue)
//                    .clipShape(RoundedRectangle(cornerRadius: 15))
//                    .padding(.horizontal)
//                    .padding(.vertical, 5)
//                }
            }
            
        }
    }
}

#Preview {
    mySwiftUI_NL_SortFilterMap()
}

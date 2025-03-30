//
//  mySwiftUI_NL_FileManager.swift
//  mySwiftUINextLevel
//
//  Created by Влад Варламов on 15.03.2025.
//

import SwiftUI

/*
 Это удобный ресурс для любого разработчика iOS, где мы можем сохранять документы (файлы, данные, изображения, видео и т.д.) непосредственно на устройстве пользователя.
 Как разработчик, вы несете ответственность за управление данными, которые вы сохраняете на чьем-либо устройстве, и поэтому нам необходимо знать, как сохранять данные, извлекать их, а также удалять!
 */

//Универсальный класс. Он нужен для того что бы пользователи получали доступ к файловому менеджеру
class localFileManager {
    
    static let instance = localFileManager()
    
    func saveImage(image: UIImage, name: String) {
        
        guard let data = image.jpegData(compressionQuality: 1)//Выбираем image и указываем расширение изображения. В скобках указываем качество сохр изображения
        else {
            print("Image do not save")
            return
        }
        
        //Сохранение данных в каталоге Docements.
        let directory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        //Сохранение данных в каталоге Сaches для быстрого доступа к файлам.
        let directory2 = FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask)
        //Использование каталога tmp, для временного хранения файлов
        let directory3 = FileManager.default.temporaryDirectory
        
        print(directory)
        print(directory2)
        print(directory3)
    }
}

//Класс для загрузки картинок которые идут в комплекте с приложением
class fileManagerViewModel: ObservableObject {
    
    @Published var image: UIImage? = nil
    let imageName = "nismo"
    let saveImage = localFileManager.instance
    
    init() {
        getImageFromAssetsFolder()
    }
    
    func getImageFromAssetsFolder() {
        image = UIImage(named: imageName)
    }
    
    func saveImageToDocumentsFolder() {
        guard let imageTrue = image else { return }
        saveImage.saveImage(image: imageTrue, name: imageName)
    }
}

struct mySwiftUI_NL_FileManager: View {
    
    @StateObject var vm = fileManagerViewModel()
    
    var body: some View {
        NavigationStack {
            VStack {
                if let image = vm.image {
                    Image(uiImage: image)
                        .resizable()
                        .scaledToFit()
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                        .padding()
                }
                
                Button {
                    vm.saveImageToDocumentsFolder()
                } label: {
                    Text("Nismo")
                        .font(.system(size: 30, weight: .bold, design: .rounded))
                        .frame(width: 300, height: 50)
                }
                .buttonStyle(.borderedProminent)
                
                Spacer()
                
            }
        }
    }
}

#Preview {
    mySwiftUI_NL_FileManager()
}

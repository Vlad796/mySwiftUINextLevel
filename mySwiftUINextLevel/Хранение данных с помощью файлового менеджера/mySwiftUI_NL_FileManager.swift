//
//  mySwiftUI_NL_FileManager.swift
//  mySwiftUINextLevel
//
//  Created by Влад Варламов on 15.03.2025.
//

import SwiftUI
import UniformTypeIdentifiers

/*
 Это удобный ресурс для любого разработчика iOS, где мы можем сохранять документы (файлы, данные, изображения, видео и т.д.) непосредственно на устройстве пользователя.
 Как разработчик, вы несете ответственность за управление данными, которые вы сохраняете на чьем-либо устройстве, и поэтому нам необходимо знать, как сохранять данные, извлекать их, а также удалять!
 */

//Универсальный класс. Он нужен для того что бы пользователи получали доступ к файловому менеджеру
class localFileManager {
    
    static let instance = localFileManager()
    let folderName: String = "maSwiftUINextLevel"
    
    init() {
        createFolderIfNeeded()
    }
    
    func createFolderIfNeeded() {
        guard
            let path = FileManager
                .default
                .urls(for: .cachesDirectory, in: .userDomainMask)
                .first?
                .appendingPathComponent(folderName)
                .path else
        {
            return
        }
        
        if !FileManager.default.fileExists(atPath: path) {
            do {
                try FileManager.default.createDirectory(atPath: path, withIntermediateDirectories: true)
                print("Success create folder")
            } catch let error {
                print("Error create folder \(error)")
            }
        }
    }
    
    func deleteFolder() {
        guard
            let path = FileManager
                .default
                .urls(for: .cachesDirectory, in: .userDomainMask)
                .first?
                .appendingPathComponent(folderName)
                .path else
        {
            return
        }
        
        do {
            try FileManager.default.removeItem(atPath: path)
            print("Success delete folder")
        } catch let error {
            print("Delet folder error \(error)")
        }
    }
    
    func saveImage(image: UIImage, name: String) -> String {
        
        guard
            let data = image.jpegData(compressionQuality: 1),//Выбираем image и указываем расширение изображения. В скобках указываем качество сохр изображения
            let path = getPathImage(name: "\(name)")//Добавление этой переменной нужно для того что бы взаимодействовать с функцией getPathImage
        else {
            return "Image do not save"
        }
        
        //Более долгоное написание пути сохранения файла и присвоение ему расширения
        /*
            Сохранение данных в каталоге Docements.
            let directory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
            Сохранение данных в каталоге Сaches для быстрого доступа к файлам.
            Использование каталога tmp, для временного хранения файлов
            let directory3 = FileManager.default.temporaryDirectory
            let directory2 = FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask).first
            let path = directory2?.appendingPathComponent("\(name)", conformingTo: .jpeg)//Добавление расширения к объекту
            print(directory)
            print(directory2)
            print(path)
            print(directory3)
        */
         
        //Но есть вариант как записать добавление файла в Сaches более быстро( хранится в getPathImage)
        
        //Запись данных в файловом менеджере устройства
        do {
            try data.write(to: path)
            print(path)
            return "Success loading Image"
        } catch let error {
            return "Error saving file: \(error)"
        }
    }
    
    func getImage(name: String) -> UIImage?{
        
        guard let path = getPathImage(name: name)?.path(),
              //Проверка на наличие изображения по данному пути
                FileManager.default.fileExists(atPath: path) else {
            print("Error geting Image!")
            return nil
        }
        
        return UIImage(contentsOfFile: path)//Получение изображения из файлового менеджера
        
    }
    
    func deleteImage(name: String) -> String{
        guard let path = getPathImage(name: name)?.path,
              //Проверка на наличие изображения по данному пути
              FileManager.default.fileExists(atPath: path) else {
            return "No image was found on this path!"
        }
        
        do {
            try FileManager.default.removeItem(atPath: path)
            return "Successfully deleted file"
        } catch let error {
            return "Error deleting image: \(error)"
        }
    }
    
    func getPathImage(name: String) -> URL? {
        guard let path = FileManager
            .default
            .urls(for: .cachesDirectory, in: .userDomainMask)
            .first?
            .appendingPathComponent(folderName)
            .appendingPathComponent("\(name)", conformingTo: .jpeg)
        else{
            print("Error geting Path!")
            return nil
        }
        
        return path
    }
    
}

//Класс для загрузки картинок которые идут в комплекте с приложением
class fileManagerViewModel: ObservableObject {
    
    @Published var image: UIImage? = nil
    let imageName = "nismo"
    let saveImage = localFileManager.instance
    @Published var infoMessege = "Abc"
    
    init() {
        getImageFromAssetsFolder()//При запуске и нажатии кнопки Save NISMO, изображение сохранится на самом утройстве. И если заменить эту функцию на getImageFromFileManager(), то изображение будет загружаться из файлового менеджера устройства
        //getImageFromFileManager()
    }
    
    func getImageFromAssetsFolder() {
        image = UIImage(named: imageName)
    }
    
    func getImageFromFileManager() {
        image = saveImage.getImage(name: imageName)
    }
    
    func saveImageToDocumentsFolder() {
        guard let imageTrue = image else { return }
        infoMessege = saveImage.saveImage(image: imageTrue, name: imageName)
    }
    
    func deleteImageToDocumentsFolder() {
        infoMessege = saveImage.deleteImage(name: imageName)
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
                VStack {
                    Button {
                        vm.saveImageToDocumentsFolder()
                    } label: {
                        Text("Save NISMO")
                            .font(.system(size: 30, weight: .bold, design: .rounded))
                            .frame(width: 300, height: 50)
                    }
                    .buttonStyle(.borderedProminent)
                    
                    Button {
                        vm.deleteImageToDocumentsFolder()
                    } label: {
                        Text("delete  NISMO")
                            .foregroundStyle(.white)
                            .font(.system(size: 30, weight: .bold, design: .rounded))
                            .frame(width: 325, height: 60)
                            .background(.red)
                            .clipShape(RoundedRectangle(cornerRadius: 10))

                    }
                    
//                    Text("Get NISMO")
//                        .font(.system(size: 20, weight: .bold, design: .rounded))
//                        .foregroundStyle(.gray)
//                        .onTapGesture {
//                            vm.getImageFromFileManager()
//                        }
                }
                Text(vm.infoMessege)
                    .font(.headline)
                    .foregroundStyle(Color(#colorLiteral(red: 0.7540688515, green: 0.7540867925, blue: 0.7540771365, alpha: 1)))
                    .padding(.top)
                
                Spacer()
                
            }
        }
    }
}

#Preview {
    mySwiftUI_NL_FileManager()
}

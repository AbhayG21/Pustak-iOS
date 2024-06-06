//
//  AddBookView.swift
//  pustak
//
//  Created by Abhay(IOS) on 02/06/24.
//

import SwiftUI
import PhotosUI

struct AddBookView: View {
    @State private var title: String = ""
    @State private var ISBN: String = ""
//    @State private var yearPublished:String
    @State private var author: String = ""
    @State private var publisher:String = ""
    @State private var genre:Genre = .comedy
    @State private var nosPages:String = ""
    @State private var qty:String = ""
    @State private var aisle: String = "Select Aisle"
    @State private var bookDescription: String = ""
    @State private var showImagePicker = false
    @State private var selectedImage: UIImage?
    
    let genres = Genre.allCases.map{$0.rawValue}
    let aisles = ["A1", "A2", "B1", "B2", "C1", "C2"]
    
//    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        NavigationView {
            List {
                Section {
                    TextField("Book Name", text: $title)
                    TextField("Author Name", text: $author)
                    TextField("Publisher Name", text:$publisher)
                }
                Section {
                    Picker("Genres", selection: $genre) {
                        ForEach(genres, id: \.self) { genre in
                            Text(genre)
                        }
                    }
                    .pickerStyle(MenuPickerStyle())
                    
                    TextField("ISBN", text: $ISBN)
                    TextField("Quantity",text: $qty)
                }
                Section("Book Description") {
                    TextEditor(text: $bookDescription)
                        .frame(height: 150)
                }
                
            }
            .navigationBarTitle("New Book", displayMode: .inline)
            .navigationBarItems(leading: Button("Cancel", action: {
                // Handle cancel action
//                presentationMode.wrappedValue.dismiss()
            }), trailing: Button("Add", action: {
                // Handle add action
//                presentationMode.wrappedValue.dismiss()
            }))
        }
    }
}

struct ImagePicker: UIViewControllerRepresentable {
    @Binding var selectedImage: UIImage?
    
    func makeCoordinator() -> Coordinator {
        return Coordinator(self)
    }
    
    func makeUIViewController(context: Context) -> PHPickerViewController {
        var config = PHPickerConfiguration()
        config.filter = .images
        let picker = PHPickerViewController(configuration: config)
        picker.delegate = context.coordinator
        return picker
    }
    
    func updateUIViewController(_ uiViewController: PHPickerViewController, context: Context) {}
    
    class Coordinator: NSObject, PHPickerViewControllerDelegate {
        let parent: ImagePicker
        
        init(_ parent: ImagePicker) {
            self.parent = parent
        }
        
        func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
            picker.dismiss(animated: true)
            
            if let provider = results.first?.itemProvider, provider.canLoadObject(ofClass: UIImage.self) {
                provider.loadObject(ofClass: UIImage.self) { (image, error) in
                    DispatchQueue.main.async {
                        if let image = image as? UIImage {
                            self.parent.selectedImage = image
                        }
                    }
                }
            }
        }
    }
}

#Preview{
    AddBookView()
}

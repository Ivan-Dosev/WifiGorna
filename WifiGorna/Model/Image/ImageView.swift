//
//  ImageView.swift
//  ProbaImage
//
//  Created by Ivan Dimitrov on 17.01.21.
//

import SwiftUI
import UIKit

struct ImageView_Previews: PreviewProvider {
    static var previews: some View {
//        ImageView()
        Text("")
    }
}

struct ImagePicker: UIViewControllerRepresentable {

    
    
    class Coordinator: NSObject, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
        
           let parent : ImagePicker
        init(_ parent : ImagePicker) {
          self.parent = parent
          }
        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            if let uiImage = info[.originalImage] as? UIImage {
                    parent.image = uiImage
             
            }
            parent.pMode.wrappedValue.dismiss()
        }
    }
  
    @Environment(\.presentationMode) var pMode
    @Binding var image : UIImage?
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
        
    }
    
    func makeUIViewController(context: UIViewControllerRepresentableContext<ImagePicker>) -> some UIImagePickerController {
           let picker = UIImagePickerController()
               picker.delegate = context.coordinator
        return picker
    }
    func updateUIViewController(_ uiViewController: UIViewControllerType, context: UIViewControllerRepresentableContext<ImagePicker>) {}
}


class ImagePhoto : ObservableObject {
    
    @Published var imagePhoto : Image
    init(imagePhoto : Image = Image("fierstLogo")){
        self.imagePhoto = imagePhoto
    }
}

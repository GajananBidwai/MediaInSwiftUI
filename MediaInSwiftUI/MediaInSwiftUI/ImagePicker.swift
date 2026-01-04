//
//  ImagePicker.swift
//  MediaInSwiftUI
//
//  Created by Neosoft on 02/01/26.
//

import Foundation
import SwiftUI

struct ImagePicker: UIViewControllerRepresentable {
    @Binding var path: NavigationPath
    @Binding var picture: UIImage?
    
    func makeUIViewController(context: Context) -> some UIViewController {
        let mediaPicker = UIImagePickerController()
        mediaPicker.delegate = context.coordinator
        
        if UIImagePickerController.isSourceTypeAvailable(.camera){
            mediaPicker.sourceType = .camera
            mediaPicker.mediaTypes = ["public.image"]
            mediaPicker.allowsEditing = false
            mediaPicker.cameraCaptureMode = .photo
        } else {
            print("The Media is not avaible")
        }
        
        return mediaPicker
    }
    func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
        
    }
    func makeCoordinator() -> ImagePickerCoordinator {
        ImagePickerCoordinator(path: $path, picture: $picture)
    }
    
}

class ImagePickerCoordinator: NSObject, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    @Binding var path: NavigationPath
    @Binding var picture: UIImage?
    
    init(path: Binding<NavigationPath>, picture: Binding<UIImage?>) {
        _path = path
        _picture = picture
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let newPicture = info[.originalImage] as? UIImage {
            picture = newPicture
        }
        path = NavigationPath()
    }
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        path = NavigationPath()
    }
}

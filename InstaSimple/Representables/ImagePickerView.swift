//
//  ImagePickerView.swift
//  InstaSimple
//
//  Created by Gaurav Shah on 1/1/21.
//

import Foundation
import SwiftUI

struct ImagePickerView: UIViewControllerRepresentable {
   @Binding var isShown: Bool
   @Binding var image: Image?
   func makeCoordinator() -> ImagePickerCoordinator {
    return ImagePickerCoordinator(isShown: $isShown, image: $image)
   }
   
   func makeUIViewController(context: Context) -> UIImagePickerController {
    let picker = UIImagePickerController()
    picker.delegate = context.coordinator
    return picker
   }
   
   func updateUIViewController(_ uiViewController: UIImagePickerController, context: Context) {
   }
   
}

class ImagePickerCoordinator: NSObject, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
   @Binding var isShown: Bool
   @Binding var image: Image?
   init(isShown: Binding<Bool>, image: Binding<Image?>) {
    _isShown = isShown
    _image = image
   }
   
   func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
    let uiImage = info[UIImagePickerController.InfoKey.originalImage] as! UIImage
    image = Image(uiImage: uiImage)
    isShown = false
   }
   
   func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
    isShown = false
   }
}

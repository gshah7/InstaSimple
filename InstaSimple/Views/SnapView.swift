//
//  SnapView.swift
//  InstaSimple
//
//  Created by Gaurav Shah on 1/1/21.
//

import SwiftUI
import UIKit


struct SnapView: View {
    @ObservedObject var feed: FeedData
    @State private var showImagePicker: Bool = false
    @State private var image: Image? = nil
    @State private var postImage: Int? = 0 // 1 to segue to PostView
       
    var body: some View{
        NavigationView{
            VStack{
                if image != nil {
                   Spacer()
                   image?.resizable().scaledToFit()
                   Spacer()
                }
            
            NavigationLink(destination: PostView(data: feed, selectedImage: $image), tag: 1, selection: $postImage) { EmptyView() }
            
            HStack{
                Button(action: {self.showImagePicker = true}) {
                   HStack {
                      Text("Pick Photo")
                      Image(systemName: "camera.fill")
                   }
                   .frame(width: 140)
                   .padding()
                   .background(Color.ylw)
                   .foregroundColor(Color.white)
                   .cornerRadius(15)
                }
                
                
                Button(action: {self.postImage = 1}) {
                   HStack{
                      Text("Post Photo")
                      Image(systemName: "paperplane.fill")
                   }
                   .frame(width: 140)
                   .padding()
                   .background(image == nil ? Color.gray : Color.grn)
                   .foregroundColor(Color.white)
                   .cornerRadius(15)
                   
                }.disabled(image == nil)
            }.padding(.bottom)
         }.sheet(isPresented: $showImagePicker) {
            ImagePickerView(isShown: $showImagePicker, image: $image)
         }
      }.navigationBarHidden(true)
   }
}


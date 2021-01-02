//
//  PostView.swift
//  InstaSimple
//
//  Created by Gaurav Shah on 1/1/21.
//

import SwiftUI

struct PostView: View{
   
    @ObservedObject var data: FeedData
    @State var location: String = ""
    @State var caption: String = ""
    @Binding var selectedImage: Image?
    @State var selection: Bool? = false
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
      
    func dismissPost(){
      self.selectedImage = nil
      data.objectWillChange.send()
      self.presentationMode.wrappedValue.dismiss()
   }

    var body: some View{
        NavigationView{
            VStack(spacing: 15){
                HStack{
                    if selectedImage != nil {
                        selectedImage?.resizable().scaledToFill()
                    }
                }.frame(minWidth: 150, idealWidth: 200, maxWidth: 250,
                        minHeight: 100, idealHeight: 100, maxHeight: 100)
          
                Spacer()
                TabView {
                    gramview(data: data, image: $selectedImage, selection: $selection)
                    snapview(data: data, selection: $selection, image: $selectedImage)
                }.frame(width: UIScreen.main.bounds.width,
                        height: UIScreen.main.bounds.height/2.2).tabViewStyle(PageTabViewStyle())
                 
            }
            NavigationLink(destination: ContentView().onAppear(perform: dismissPost), tag: true, selection: $selection) { EmptyView() }
        }.navigationBarTitleDisplayMode(.inline)
    }
}


struct gramview: View {
    
    @ObservedObject var data: FeedData
    @EnvironmentObject var session: SessionStore
    var width: CGFloat = UIScreen.main.bounds.width * 0.85
    var height: CGFloat = UIScreen.main.bounds.height * 0.05
    @Binding var image: Image?
    @Binding var selection: Bool?
    @State var showfeed: Bool = false

    var body: some View{
        ZStack {
            
            Color.grn
            VStack(spacing: 7){
                Rectangle()
                    .frame(width: width, height: 1)
                    .foregroundColor(Color.grn)
                    .padding(.top)

                Text("to story:")
                    .foregroundColor(.white)
                    .font(.title).bold()
                    .frame(width: width, alignment: .leading)
                
                Rectangle()
                    .frame(width: width, height: 1)
                    .foregroundColor(Color.grn)
                    .padding(.top)
                
                ScrollView{
                    
                    Button(action: {
                        self.showfeed = true
                    }, label: {
                        Text("+ new story")
                            .font(.title)
                            .foregroundColor(.grn)
                            .bold()
                    })
                    .frame(width: width/1.4, height: height * 1.2)
                    .background(Color.white)
                    .foregroundColor(Color.grn)
                    .cornerRadius(35)
                    
                    ForEach(data.threads, id: \.id) { thread in
                        HStack{
                            Spacer()
                            
                            Button(action: {
                                let threntry = ThreadEntry(username:data.username, image: image!)
                                thread.addEntry(threadEntry: threntry)
                                selection = true
                            }, label: {
                                Text(thread.name)
                                        .font(.title)
                                        .foregroundColor(.white)
                                    + Text(" ")
                                        .font(.title)
                                        .foregroundColor(.white)
                                    + Text(thread.emoji)
                                        .font(.title)
                                        .foregroundColor(.white)
                            })
                            .frame(width: width/1.4, height: height * 1.2)
                            .overlay(RoundedRectangle(cornerRadius: 35)
                            .stroke(Color.white, lineWidth: 4))
                            
                            Spacer()
                            
                        }.padding(.top)
                }
                
                Rectangle()
                    .frame(width: width, height: 1)
                    .foregroundColor(Color.grn)
                    .padding(.top)
                    
            }.frame(maxWidth: .infinity)
                
            Rectangle()
                .frame(width: width, height: height)
                .foregroundColor(Color.grn)
                .padding(.top)

            Spacer()
                
        }.clipShape(RoundedRectangle(cornerRadius: 0, style: .continuous))
            
        }.sheet(isPresented: $showfeed) {
            FeedView(isShown: $showfeed, data: data)
        }
    }
}

    
struct snapview: View {
    
    @ObservedObject var data: FeedData
    var width: CGFloat = UIScreen.main.bounds.width * 0.85
    var height: CGFloat = UIScreen.main.bounds.height * 0.05
    @EnvironmentObject var session: SessionStore
    @State var location: String = ""
    @State var caption: String = ""
    @Binding var selection: Bool?
    @Binding var image: Image?
    
    var body: some View {
        ZStack{
            
            Color.ylw
            VStack(spacing: 7){
                Group{
                    
                    Rectangle()
                        .frame(width: width, height: 1)
                        .foregroundColor(Color.ylw)
                        .padding(.top)
                    Text("to feed:")
                        .foregroundColor(.white)
                        .font(.title)
                        .bold()
                        .frame(width: width, alignment: .leading)
                    Rectangle()
                        .frame(width: width, height: 1)
                        .foregroundColor(Color.ylw)
                        .padding(.top)
                    TextField("caption", text: $caption)
                        .frame(width: width, height: 1.0)
                        .font(.title3)
                        .padding(.bottom, 7)
                    Rectangle()
                        .frame(width: width, height: 2.0)
                        .foregroundColor(Color.white)
                        .padding(.bottom)
                    
                    Spacer()
                    
                    TextField("location", text: $location)
                        .frame(width: width, height: 1.0)
                        .font(.title3)
                        .padding(.bottom, 7)
                    Rectangle()
                        .frame(width: width, height: 2.0)
                        .foregroundColor(Color.white)
                        .padding(.bottom)
                    
                    Spacer()
                }
                
                Group{
                    
                    Button(action: {
                        let pstentry = Post(location: location, image: image!, user: data.username, caption: caption, date: Date())
                        data.addPost(post: pstentry)
                        session.session?.addpost()
                        selection = true
                    }, label: {
                        Text("post photo")
                            .font(.title)
                            .foregroundColor(.ylw)
                            .bold()
                    })
                    .frame(width: width/1.4, height: height * 1.2)
                    .background(Color.white)
                    .foregroundColor(Color.ylw)
                    .cornerRadius(35)
                    
                    Rectangle()
                        .frame(width: width, height: height)
                        .foregroundColor(Color.ylw)
                        .padding(.top)
                    }
        }.clipShape(RoundedRectangle(cornerRadius: 0, style: .continuous))
        }
    }
}


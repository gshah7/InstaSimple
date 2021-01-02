//
//  ThreadView.swift
//  InstaSimple
//
//  Created by Gaurav Shah on 1/1/21.
//

import SwiftUI

struct ThreadView: View {
   @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
   var thread: Thread
   @ObservedObject var data: FeedData
   @State var currentEntry: ThreadEntry? = nil

    var body: some View{
        VStack{
             if currentEntry != nil {
                Group{
                   Text("\(currentEntry!.username)")
                      .header(fontStyle: .caption)
                      .foregroundColor(.white)
                      .padding(.top, 50)
                   Spacer()
                   currentEntry?.image
                      .resizable()
                      .scaledToFit()
                   Spacer()
                }.onTapGesture{
                   currentEntry = thread.removeFirstEntry() ?? nil
                }
             }
             else{
                VStack{
                   Text("End of Story")
                      .foregroundColor(.white).bold()
                      .frame(maxWidth: .infinity, maxHeight: .infinity)
                      .background(Color.black)
                }
                .onTapGesture{
                   data.objectWillChange.send()
                   self.presentationMode.wrappedValue.dismiss()
                }
             }
          }
          .onAppear {
             currentEntry = thread.removeFirstEntry()
          }
      .navigationBarHidden(true)
      .edgesIgnoringSafeArea(.all)
      .background(Color.black)
    }
}

struct JustifyLeft: ViewModifier {
   var withPadding: Bool
   func body(content: Content) -> some View {
      HStack {
         content
         Spacer()
      }
      .padding(.horizontal)
      .padding(.top)
   }
}

extension Text {
   func header(fontStyle: Font) -> some View {
      self.font(fontStyle).bold().modifier(JustifyLeft(withPadding: true))
    }
}

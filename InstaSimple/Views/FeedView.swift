//
//  FeedView.swift
//  InstaSimple
//
//  Created by Gaurav Shah on 1/1/21.
//

import Foundation
import SwiftUI

struct FeedView: View {
    
    @State var fname: String = ""
    @State var femoji: String = ""
    var width: CGFloat = UIScreen.main.bounds.width * 0.75
    var height: CGFloat = UIScreen.main.bounds.height * 0.05
    @Binding var isShown: Bool
    @ObservedObject var data: FeedData

    var body: some View{
        VStack(spacing: 20){
            Text("new story")
                .fontWeight(.semibold)
                .font(.title)
                .foregroundColor(Color.ylw)
                .padding(.bottom, 100)
            TextField("story name", text: $fname)
                .frame(width: width, height: 1.0)
                .font(.title)
            Rectangle()
                .frame(width: width, height: 4.0)
                .foregroundColor(Color.ylw)
                .padding(.bottom)
            TextField("emoji", text: $femoji)
                .frame(width: width, height: 1.0)
                .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                .padding(.top)
            Rectangle()
                .frame(width: width, height: 4.0)
                .foregroundColor(Color.ylw)
                .padding(.bottom)
            Button(action: {
                data.addThread(thread: Thread(name: fname, emoji: femoji))
                self.isShown = false
            }, label: {
                Text("create story")
                    .fontWeight(.semibold)
                    .font(.title)
                    .foregroundColor(Color.white)
                    .padding()
            })
            .frame(width: width/1.1)
            .background(Color.ylw)
            .cornerRadius(20)
            .padding(.top)
        }
    }
}

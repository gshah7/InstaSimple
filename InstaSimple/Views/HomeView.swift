//
//  HomeView.swift
//  InstaSimple
//
//  Created by Gaurav Shah on 1/1/21.
//

import SwiftUI

struct HomeView: View {
   
   @ObservedObject var data: FeedData
    var width: CGFloat = UIScreen.main.bounds.width * 0.9

    var body: some View {
        NavigationView{
            VStack{
                HStack{
                    Image(systemName: "arrow.right")
                        .font(.title)
                    Text("stories:")
                        .font(.title)
                        .fontWeight(.semibold)
                    
                }.frame(width: width, alignment: .leading)
                
                ScrollView(.horizontal, showsIndicators: false){
                    LazyHStack{
                        ForEach(data.threads.sorted(by: {$0.entries.count > $1.entries.count}), id: \.id) { thread in
                            ThreadCell(thread: thread, data: data)
                        }
                    }
                }.frame(height: 120, alignment: .top)
                
                HStack{
                    Image(systemName: "arrow.down")
                        .font(.title)
                    Text("feed:")
                        .font(.title)
                        .fontWeight(.semibold)
                    
                }.frame(width: width, alignment: .leading)
                
                ScrollView(.vertical, showsIndicators: false){
                    LazyVStack{
                        ForEach(data.posts.sorted(by: {$0.date > $1.date}), id: \.id) { post in
                            FeedCell(post: post)
                        }
                    }
                }.padding(.bottom)
            }.navigationBarTitle("")
            .navigationBarHidden(true)
        }.frame(width: width)
    }
}


struct FeedCell: View {
   
    var post: Post
    var width: CGFloat = UIScreen.main.bounds.width * 0.9
   
    static let postDateFormat: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .long
        return formatter
    }()
   
    var body: some View {
        ZStack{
            Color.lte
            VStack{
                HStack{
                    Text(post.location).fontWeight(.semibold)
                    Spacer()
                    Text(FeedCell.postDateFormat.string(from: post.date)).fontWeight(.thin)
                }
                
                post.image
                    .resizable()
                    .scaledToFit()
                Text("@" + post.user)
                    .fontWeight(.bold)
                    .frame(width: width * 0.9, alignment: .leading)
                    .padding(.bottom, 5)
                Text(post.caption)
                    .fontWeight(.light)
                    .frame(width: width * 0.9, alignment: .leading)
                
            }.padding()
        }
        .frame(width: width)
        .clipShape(RoundedRectangle(cornerRadius: 5, style: .circular))
    }
}


struct ThreadCell: View {

    var thread: Thread
    var data: FeedData
    @State var tview: Int? = 0
    private let badgeHW: CGFloat = 30
    private let threadIconSize: CGFloat = UIScreen.main.bounds.width * 0.2
    var useUnreadBadge: Bool = true
    @State var unreadCount = 0

    var body: some View {

        VStack {
            ZStack {
                NavigationLink(destination: ThreadView(thread: thread, data: data), tag: 1, selection: $tview) { EmptyView() }
                
                Circle().foregroundColor(unreadCount > 0 ? .grn : .ylw)
                Circle().frame(width: threadIconSize * 0.9).foregroundColor(.white)
                
                Button(action: {
                    self.tview = 1
                }, label: {
                    Text(thread.emoji).font(.title)
                })
                
                if unreadCount > 0 && useUnreadBadge {
                   Text("\(unreadCount)")
                      .foregroundColor(.white)
                      .frame(width: badgeHW, height: badgeHW)
                      .background(Color.grn)
                      .clipShape(Circle())
                      .offset(x: UIScreen.main.bounds.width*0.07, y: -UIScreen.main.bounds.width*0.07)
                }
             }.frame(width: threadIconSize, height: threadIconSize + 5)
            Text("\(thread.name)").font(.body).fontWeight(.medium)
          }
          .frame(width: threadIconSize * 1.2, height: UIScreen.main.bounds.width*0.35)
          .onAppear {unreadCount = thread.unreadCount()}
   }
}


extension Text {
   func frame(numLines: CGFloat, fontSize: CGFloat) -> some View {
      let height = UIFont.systemFont(ofSize: fontSize).lineHeight * numLines
      return self.frame(height: height)
   }
}


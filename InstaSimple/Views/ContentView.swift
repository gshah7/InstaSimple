//
//  ContentView.swift
//  InstaSimple
//
//  Created by Gaurav Shah on 1/1/21.
//

import SwiftUI
import Firebase

struct ContentView: View {
    
    // Keep track of which tab is currently selected
    @State var selectedTab = 1
    
    // Keep track of the user's authentication status
    @EnvironmentObject var session: SessionStore
    
    // FeedData objects
    @ObservedObject var data: FeedData = FeedData()
      
    func getUserAuth() {
        session.configureUserAuth()
    }
   
    var body: some View {
        Group {
            if (session.session != nil) {
                TabView(selection:$selectedTab){
                    SnapView(feed: data)
                        .tabItem {
                            Image(systemName: "camera.on.rectangle.fill")
                            Text("Post")
                        }.tag(0)
                    
                    HomeView(data: data)
                        .tabItem {
                            Image(systemName: "photo.fill.on.rectangle.fill")
                            Text("Feed")
                        }.tag(1)
                    
                    ProfileView(data: data)
                        .tabItem{
                            Image(systemName: "person.crop.circle.fill")
                            Text("Profile")
                        }.tag(2)
                    
                }
            } else {
                LoginView()
            }
        }.onAppear(perform: getUserAuth)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environmentObject(SessionStore())
    }
}

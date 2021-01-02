//
//  ProfileView.swift
//  InstaSimple
//
//  Created by Gaurav Shah on 1/1/21.
//

import SwiftUI

struct ProfileView: View{
    @EnvironmentObject var session: SessionStore
    @ObservedObject var data: FeedData

    var body: some View {
        VStack{
            Text("@" + data.username).font(.title).fontWeight(.semibold)
            //Text("Number of Posts: \(session.session!.postnum)").font(.title).fontWeight(.semibold)
            
            Button(action: {
                session.signOut()
            }, label: {Text("Log Out")})
        }
   }
}


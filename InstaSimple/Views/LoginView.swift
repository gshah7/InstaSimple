//
//  LoginView.swift
//  InstaSimple
//
//  Created by Gaurav Shah on 1/1/21.
//

import SwiftUI

struct LoginView: View {
    
    @State private var selection: String? = nil
    @EnvironmentObject var session: SessionStore

    var body: some View {
        NavigationView{
            VStack{
                Image("logo").resizable()
                    .scaledToFit()
                    .frame(width: 150,height:150)
            
                Text("InstaSimple").font(.system(size: 60)).foregroundColor(.ylw)
                Spacer()
                
                HStack{
                    NavigationLink(destination: logView(), tag: "log", selection: $selection) { EmptyView() }
                    NavigationLink(destination: signupView(), tag: "sign", selection: $selection) { EmptyView() }
                }
                
                Button(
                    action: {self.selection = "sign"},
                    label: {
                    Text("sign up")
                        .fontWeight(.semibold)
                        .font(.system(size: 45))
                        .foregroundColor(Color.white)
                })
                    .frame(maxWidth: .infinity)
                    .frame( height: 100)
                    .background(Color.ylw)
                
                Button(
                    action: {self.selection = "log"},
                    label: {
                    Text("login")
                        .fontWeight(.semibold)
                        .font(.system(size: 45))
                        .foregroundColor(Color.white)
                })
                    .frame(maxWidth: .infinity)
                    .frame( height: 100)
                    .background(Color.grn)
            }
        }
    }
}


struct logView: View {
    
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var loggedIn: Bool = false
    @EnvironmentObject var session: SessionStore
    
    private var width: CGFloat = UIScreen.main.bounds.width * 0.75
    private var height: CGFloat = UIScreen.main.bounds.height * 0.05
    
    var body: some View {
        VStack(spacing: 20) {
            
            TextField("email", text: $email)
                .frame(width: width, height: 1.0)
                .font(.title)
            
            Rectangle()
                .frame(width: width, height: 4.0)
                .foregroundColor(Color.grn)
                .padding(.bottom)
            
            SecureField("password", text: $password)
                .frame(width: width, height: 1.0)
                .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                .padding(.top)
            
            Rectangle()
                .frame(width: width, height: 4.0)
                .foregroundColor(Color.grn)
                .padding(.bottom)
            
            Button(action: {logIn()}, label: {
                Text("login")
                    .fontWeight(.semibold)
                    .font(.title)
                    .foregroundColor(Color.white)
                    .padding()
            })
            .frame(width: width/2)
            .background(Color.grn)
            .cornerRadius(20)
            .padding(.top)
        }
    }
    func logIn() {
        if validEntries() {
            session.signIn(email: email, password: password) { (result, error) in
                if let e = error {
                    print(e.localizedDescription)
                } else {
                    loggedIn = true
                    NavigationLink(destination: ContentView()) {}
                    print("session.session != nil: \(session.session != nil)")
                }
            }
        }
    }
    func validEntries() -> Bool {
        if (email != "" && password != "") { return true }
        return false
    }
}


struct signupView: View {
    
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var loggedIn: Bool = false
    @EnvironmentObject var session: SessionStore
    
    private var width: CGFloat = UIScreen.main.bounds.width * 0.75
    private var height: CGFloat = UIScreen.main.bounds.height * 0.05
    
    var body: some View {
        VStack(spacing: 20) {
            
            TextField("email", text: $email)
                .frame(width: width, height: 1.0)
                .font(.title)
            
            Rectangle()
                .frame(width: width, height: 4.0)
                .foregroundColor(Color.ylw)
                .padding(.bottom)
            
            SecureField("password", text: $password)
                .frame(width: width, height: 1.0)
                .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                .padding(.top)
            
            Rectangle()
                .frame(width: width, height: 4.0)
                .foregroundColor(Color.ylw)
                .padding(.bottom)
            
            Button(action: {signUp()}, label: {
                Text("sign up")
                    .fontWeight(.semibold)
                    .font(.title)
                    .foregroundColor(Color.white)
                    .padding()
            })
            .frame(width: width/2)
            .background(Color.ylw)
            .cornerRadius(20)
            .padding(.top)
        }
    }
    
    func signUp() {
        if validEntries() {
            session.signUp(email: email, password: password) { (result, error) in
                if let e = error {
                    print(e.localizedDescription)
                } else {
                    NavigationLink(destination: ContentView()) {}
                }
            }
        }
    }
    
    func validEntries() -> Bool {
        if (email != "" && password != "") { return true }
        return false
    }
}



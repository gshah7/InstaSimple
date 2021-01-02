//
//  FeedData.swift
//  InstaSimple
//
//  Created by Gaurav Shah on 1/1/21.
//

import Foundation
import UIKit
import SwiftUI

class Thread: Identifiable {
    var id = UUID()
    var name: String
    var emoji: String
    var entries: [ThreadEntry]
    
    init(name: String, emoji: String) {
        self.name = name
        self.emoji = emoji
        self.entries = []
    }
    
    init(name: String, emoji: String, entries: [ThreadEntry]) {
        self.name = name
        self.emoji = emoji
        self.entries = entries
    }
    
    func addEntry(threadEntry: ThreadEntry) {
        entries.append(threadEntry)
    }
    
    func removeFirstEntry() -> ThreadEntry? {
        if entries.count > 0 {
            return entries.removeFirst()
        }
        return nil
    }
    
    func unreadCount() -> Int {
        return entries.count
    }
}

struct ThreadEntry {
    var username: String
    var image: Image
}

struct Post: Identifiable {
    var id = UUID()
    var location: String
    var image: Image
    var user: String
    var caption: String
    var date: Date
}

class FeedData: ObservableObject {

    @Published var username: String = "gauravshah"
        
    @Published var threads: [Thread] = [
        Thread(name: "memes", emoji: "😂"),
        Thread(name: "dogs", emoji: "🐶"),
        Thread(name: "tech", emoji: "💻"),
        Thread(name: "eats", emoji: "🍱"),
    ]

    @Published var posts: [Post] = [
        /*
        Post(location: "New York City", image: Image("skyline"), user: "nyerasi", caption: "Concrete jungle, wet dreams tomato 🍅 —Alicia Keys", date: Date()),
        Post(location: "Memorial Stadium", image: Image("garbers"), user: "rjpimentel", caption: "Last Cal Football game of senior year!", date: Date()),
        Post(location: "Soda Hall", image: Image("soda"), user: "chromadrive", caption: "Find your happy place 💻", date: Date())
         */
    ]
    
    func addPost(post: Post) {
        posts.append(post)
    }
    
    func addThread(thread: Thread) {
        threads.insert(thread, at: 0)
    }
}

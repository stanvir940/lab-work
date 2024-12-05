//
//  login_pageApp.swift
//  login_page
//
//  Created by Gaming Lab on 14/11/24.
//

import SwiftUI
import Firebase



@main
struct login_pageApp: App {
    
    init(){
        FirebaseApp.configure()
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}

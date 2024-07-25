//
//  HomeScreen.swift
//  IllumiNote
//
//  Created by Jessie Huang on 2024-07-23.
//
//
//import SwiftUI
//
//struct HomeScreen: View {
//    @State private var searchText: String = ""
//    @State private var songs: [String] = Array(repeating: "Song Title", count: 20) // Sample data
//    @State private var filteredSongs: [String] = []
//    
//    
//
//    var body: some View {
//        VStack {
////            Spacer().frame(height: 0)
//            HStack {
//                Spacer()
//                
//
//                Text("IllumiNote        ")
//                    .font(.custom("Bradley Hand Bold", size: 40))
//                    .foregroundColor(.lilac)
//                    .shadow(color: .ivory, radius: 15, x: 0, y: 7)
//                    .padding()
//                Spacer()
//                
////                Button(action: {
////                    // Continue last session
////                }) {
////                    Image(systemName: "line.horizontal.3")
////                        .foregroundColor(.lilac)
////                }
//                NavigationLink(destination: SettingsScreen()) {
//                    Image(systemName: "line.horizontal.3")
//                        .foregroundColor(.lilac)
//                }
//                .padding(.horizontal)
//                Spacer()
//
//
//            }
//            Spacer().frame(height: 1)
//            ScrollView(.vertical){
//                Text("Welcome Back!                         ")
//                    .font(.title)
//                    .foregroundColor(.ivory)
//                    .padding()
//                Button(action: {
//                    // Continue last session
//                }) {
//                    Text("   Continue from last session            ")
//                        .foregroundColor(.darkColor)
//                        .padding()
//                        .background(Color.lilac)
//                        .cornerRadius(10)
//                }
//                .padding().frame(height: 50)
//                Text("New Songs                                ")
//                    .font(.title)
//                    .foregroundColor(.ivory)
//                    .frame(height: 50)
//                // Search Bar
//                HStack {
//                    Spacer()
//                    Spacer()
//                    TextField("     Search", text: $searchText)
//                        .padding()
//                        .background(Color.ivory)
//                        .cornerRadius(10)
//                        .overlay(
//                            HStack {
//                                Image(systemName: "magnifyingglass")
//                                    .foregroundColor(.gray)
//                                    .padding(.leading, 10)
//                                Spacer()
//                            }
//                        )
//                        .onChange(of: searchText) {
//                            filterSongs(query: searchText)
//                        }
////                    .padding()
//
//                    Button(action: {
//                        // Trigger search
//                        filterSongs(query: searchText)
//                    }) {
//                        Image(systemName: "magnifyingglass")
//                            .foregroundColor(.lilac)
//                    }
//                    .padding()
//                }
////                .padding()
//                Spacer()
//                Spacer()
//
//                Text("Easy                                                              ")
//                    .font(.title3)
//                    .foregroundColor(.ivory)
//                    .frame(height:0)
//                ScrollView(.horizontal) {
//                    HStack {
//                        
//                        ForEach(0..<5) { _ in
//                            Button(action: {
//                            }){
//                                NavigationLink(destination: SongDetailView(songName: "Marry Had a Little Lamb", composer: "Sarah Josepha Hale", duration: "3:45", difficulty: "easy")){
//                                    RoundedRectangle(cornerRadius: 10)
//                                        .fill(Color.mistyBlue)
//                                        .frame(width: 150, height: 150)
//                                }
//                            }
//                        }
//                    }
//                    .padding()
//                }
//                Text("Medium                                                         ")
//                    .font(.title3)
//                    .foregroundColor(.ivory)
//                    .frame(height:0)
//                ScrollView(.horizontal) {
//                    HStack {
//                        
//                        ForEach(0..<5) { _ in
//                            Button(action: {
//                            }){
//                                RoundedRectangle(cornerRadius: 10)
//                                    .fill(Color.mistyBlue)
//                                    .frame(width: 150, height: 150)
//                            }
//                        }
//                    }
//                    .padding()
//                }
//                Text("Hard                                                               ")
//                    .font(.title3)
//                    .foregroundColor(.ivory)
//                    .frame(height:0)
//                ScrollView(.horizontal) {
//                    HStack {
//                        
//                        ForEach(0..<5) { _ in
//                            Button(action: {
//                            }){
//                                RoundedRectangle(cornerRadius: 10)
//                                    .fill(Color.mistyBlue)
//                                    .frame(width: 150, height: 150)
//                            }
//                        }
//                    }
//                    .padding()
//                }
//            }
//            Spacer()
//            Text("Bluetooth Connected")
//                .foregroundColor(.lilac)
//                .padding()
//            Spacer()
//            HStack {
//                Spacer()
//
//                NavigationLink(destination: SongScreen()) {
//                    Image(systemName: "music.note")
//                        .foregroundColor(.mistyBlue)
//                }
//                Spacer()
//                NavigationLink(destination: HomeScreen()) {
//                    Image(systemName: "house.fill")
//                        .foregroundColor(.darkColor)
//                }
//                Spacer()
//                NavigationLink(destination: HIstoryScreen()) {
//                    Image(systemName: "clock")
//                        .foregroundColor(.mistyBlue)
//                }
//                Spacer()
//
//            }
//            .padding()
//            .background(Color.ivory)
//        }
//        .background(Color.darkColor)
////        .edgesIgnoringSafeArea(.all)
//    }
//    private func filterSongs(query: String) {
//        if query.isEmpty {
//            filteredSongs = songs
//        } else {
//            filteredSongs = songs.filter { $0.lowercased().contains(query.lowercased()) }
//        }
//    }
//}
//
//struct HomeScreen_Previews: PreviewProvider {
//    static var previews: some View {
//        HomeScreen()
//    }
//}


import SwiftUI

struct HomeScreen: View {
    @State private var searchText: String = ""
    @State private var songs: [String] = Array(repeating: "Song Title", count: 20) // Sample data
    @State private var filteredSongs: [String] = []

    var body: some View {
        VStack {
            HStack {
                Spacer()
                Text("IllumiNote        ")
                    .font(.custom("Bradley Hand Bold", size: 40))
                    .foregroundColor(.lilac)
                    .shadow(color: .ivory, radius: 15, x: 0, y: 7)
                    .padding()
                Spacer()
                NavigationLink(destination: SettingsScreen()) {
                    Image(systemName: "line.horizontal.3")
                        .foregroundColor(.lilac)
                }
                .padding(.horizontal)
                Spacer()
            }
            Spacer().frame(height: 1)
            ScrollView(.vertical) {
                Text("Welcome Back!                         ")
                    .font(.title)
                    .foregroundColor(.ivory)
                    .padding()
                Button(action: {
                    // Continue last session
                }) {
                    Text("   Continue from last session            ")
                        .foregroundColor(.darkColor)
                        .padding()
                        .background(Color.lilac)
                        .cornerRadius(10)
                }
                .padding().frame(height: 50)
                Text("New Songs                                ")
                    .font(.title)
                    .foregroundColor(.ivory)
                    .frame(height: 50)
                // Search Bar
                HStack {
                    Spacer()
                    Spacer()
                    TextField("     Search", text: $searchText)
                        .padding()
                        .background(Color.ivory)
                        .cornerRadius(10)
                        .overlay(
                            HStack {
                                Image(systemName: "magnifyingglass")
                                    .foregroundColor(.gray)
                                    .padding(.leading, 10)
                                Spacer()
                            }
                        )
                        .onChange(of: searchText) {
                            filterSongs(query: searchText)
                        }
                    Button(action: {
                        // Trigger search
                        filterSongs(query: searchText)
                    }) {
                        Image(systemName: "magnifyingglass")
                            .foregroundColor(.lilac)
                    }
                    .padding()
                }
                Spacer()
                Spacer()

                Text("Easy                                                              ")
                    .font(.title3)
                    .foregroundColor(.ivory)
                    .frame(height:0)
                ScrollView(.horizontal) {
                    HStack {
                        ForEach(0..<5) { index in
                            NavigationLink(destination: SongDetailView(
                                songName: index == 0 ? "Mary Had a Little Lamb" : "Song \(index + 1)",
                                composer: index == 0 ? "Sarah Josepha Hale" : "Composer \(index + 1)",
                                duration: "3:45",
                                difficulty: "easy"
                            )) {
                                ZStack {
                                    RoundedRectangle(cornerRadius: 10)
                                        .fill(Color.mistyBlue)
                                        .frame(width: 150, height: 150)
                                    Image(index == 0 ? "marylamb" : "twinklestar")
                                        .resizable()
                                        .aspectRatio(contentMode: .fill)
                                        .frame(width: 150, height: 150)
                                        .clipShape(RoundedRectangle(cornerRadius: 10))
                                }
                            }
                        }
                    }
                    .padding()
                }
                Text("Medium                                                         ")
                    .font(.title3)
                    .foregroundColor(.ivory)
                    .frame(height:0)
                ScrollView(.horizontal) {
                    HStack {
                        ForEach(0..<5) { index in
                            NavigationLink(destination: SongDetailView(
                                songName: "Song \(index + 6)",
                                composer: "Composer \(index + 6)",
                                duration: "3:45",
                                difficulty: "medium"
                            )) {
                                ZStack {
                                    RoundedRectangle(cornerRadius: 10)
                                        .fill(Color.mistyBlue)
                                        .frame(width: 150, height: 150)
                                    Image("song\(index + 6)")
                                        .resizable()
                                        .aspectRatio(contentMode: .fill)
                                        .frame(width: 150, height: 150)
                                        .clipShape(RoundedRectangle(cornerRadius: 10))
                                }
                            }
                        }
                    }
                    .padding()
                }
                Text("Hard                                                               ")
                    .font(.title3)
                    .foregroundColor(.ivory)
                    .frame(height:0)
                ScrollView(.horizontal) {
                    HStack {
                        ForEach(0..<5) { index in
                            NavigationLink(destination: SongDetailView(
                                songName: "Song \(index + 11)",
                                composer: "Composer \(index + 11)",
                                duration: "3:45",
                                difficulty: "hard"
                            )) {
                                ZStack {
                                    RoundedRectangle(cornerRadius: 10)
                                        .fill(Color.mistyBlue)
                                        .frame(width: 150, height: 150)
                                    Image("song\(index + 11)")
                                        .resizable()
                                        .aspectRatio(contentMode: .fill)
                                        .frame(width: 150, height: 150)
                                        .clipShape(RoundedRectangle(cornerRadius: 10))
                                }
                            }
                        }
                    }
                    .padding()
                }
            }
            Spacer()
            Text("Bluetooth Connected")
                .foregroundColor(.lilac)
                .padding()
            Spacer()
            HStack {
                Spacer()
                NavigationLink(destination: SongScreen()) {
                    Image(systemName: "music.note")
                        .foregroundColor(.mistyBlue)
                }
                Spacer()
                NavigationLink(destination: HomeScreen()) {
                    Image(systemName: "house.fill")
                        .foregroundColor(.darkColor)
                }
                Spacer()
                NavigationLink(destination: HIstoryScreen()) {
                    Image(systemName: "clock")
                        .foregroundColor(.mistyBlue)
                }
                Spacer()
            }
            .padding()
            .background(Color.ivory)
        }
        .background(Color.darkColor)
    }
    
    private func filterSongs(query: String) {
        if query.isEmpty {
            filteredSongs = songs
        } else {
            filteredSongs = songs.filter { $0.lowercased().contains(query.lowercased()) }
        }
    }
}

struct HomeScreen_Previews: PreviewProvider {
    static var previews: some View {
        HomeScreen()
    }
}

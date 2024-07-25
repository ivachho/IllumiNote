//
//  HomeScreen.swift
//  IllumiNote
//
//  Created by Jessie Huang on 2024-07-23.
//

import SwiftUI

struct HomeScreen: View {
    @State private var searchText: String = ""
    @State private var filteredSongs: [Song] = songs
    
    var body: some View {
        VStack {
            HStack {
                Spacer()
                Text("IllumiNote        ")
                    .font(.custom("Bradley Hand Bold", size: 40))
                    .foregroundColor(.ivory)
                    .shadow(color: .darkColor, radius: 15, x: 0, y: 7)
                    .padding()
                Spacer()
                NavigationLink(destination: SettingsScreen()) {
                    Image(systemName: "line.horizontal.3")
                        .foregroundColor(.mistyBlue)
                }
                .padding(.horizontal)
                Spacer()
            }
            Spacer().frame(height: 1)
            ScrollView(.vertical){
                Text("Welcome Back!                         ")
                    .font(.title)
                    .foregroundColor(.darkColor)
                    .padding()
//                Button(action: {
//                    // Continue last session
//                }) {
//                    Text("   Continue from last session            ")
//                        .foregroundColor(.ivory)
//                        .padding()
//                        .background(Color.mistyBlue)
//                        .cornerRadius(10)
//                }
                NavigationLink(destination: SongDetailView(song: mostRecentSong())) {
                    Text("   Continue from last session            ")
                        .foregroundColor(.ivory)
                        .padding()
                        .background(Color.mistyBlue)
                        .cornerRadius(10)
                }
            
                .padding().frame(height: 50)
                Text("New Songs                                ")
                    .font(.title)
                    .foregroundColor(.darkColor)
                    .frame(height: 50)
                Spacer()
                Spacer()
                Text("Easy                                                              ")
                    .font(.title3)
                    .foregroundColor(.darkColor)
                    .frame(height:0)
                ScrollView(.horizontal) {
                    HStack {
                        ForEach(filteredSongs.filter { $0.difficulty == 1 }) { song in
                            NavigationLink(destination: SongDetailView(song: song)) {
                                Image(song.imageName)
                                    .resizable()
                                    .aspectRatio(contentMode: .fill)
                                    .frame(width: 150, height: 150)
                                    .clipShape(RoundedRectangle(cornerRadius: 20))
                            }
                        }
                    }
                    .padding()
                }
                Text("Medium                                                         ")
                    .font(.title3)
                    .foregroundColor(.darkColor)
                    .frame(height:0)
                ScrollView(.horizontal) {
                    HStack {
                        ForEach(filteredSongs.filter { $0.difficulty == 2 }) { song in
                            NavigationLink(destination: SongDetailView(song: song)) {
                                Image(song.imageName)
                                    .resizable()
                                    .aspectRatio(contentMode: .fill)
                                    .frame(width: 150, height: 150)
                                    .clipShape(RoundedRectangle(cornerRadius: 20))
                            }
                        }
                    }
                    .padding()
                }
                Text("Hard                                                               ")
                    .font(.title3)
                    .foregroundColor(.darkColor)
                    .frame(height:0)
                ScrollView(.horizontal) {
                    HStack {
                        ForEach(filteredSongs.filter { $0.difficulty == 3 }) { song in
                            NavigationLink(destination: SongDetailView(song: song)) {
                                Image(song.imageName)
                                    .resizable()
                                    .aspectRatio(contentMode: .fill)
                                    .frame(width: 150, height: 150)
                                    .clipShape(RoundedRectangle(cornerRadius: 20))
                            }
                        }
                    }
                    .padding()
                }
            }
            Spacer()
            Text("Bluetooth Connected")
                .foregroundColor(.darkColor)
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
//            .background(Color.ivory)
            .background(Color.back)
        }
//        .background(Color.darkColor)
        .background(Color.back)

    }
    
    private func filterSongs(query: String) {
        if query.isEmpty {
            filteredSongs = songs
        } else {
            filteredSongs = songs.filter { $0.title.lowercased().contains(query.lowercased()) }
        }
    }
    
    
    private func findSong(byTitle title: String) -> Song? {
        return songs.first { $0.title == title }
    }

    private func mostRecentSong() -> Song {
        guard let recentPlayedSong = playedSongs.first else {
            // Handle the case where there are no played songs, maybe return a default song
            return songs.first!
        }
        return findSong(byTitle: recentPlayedSong.title) ?? songs.first!
    }

}

struct HomeScreen_Previews: PreviewProvider {
    static var previews: some View {
        HomeScreen()
    }
}

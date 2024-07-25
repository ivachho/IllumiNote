//
//  SongScreen.swift
//  IllumiNote
//
//  Created by Jessie Huang on 2024-07-23.
//
import SwiftUI

struct Song: Identifiable, Hashable {
    let id = UUID()
    let title: String
    let difficulty: Int
    let image: String // Add image name or URL
}

struct SongScreen: View {
    @State private var searchText: String = ""
    @State private var songs: [Song] = [
        Song(title: "Song Title 1", difficulty: 1, image: "music.note"),
        Song(title: "Song Title 2", difficulty: 1, image: "music.note"),
        Song(title: "Song Title 3", difficulty: 2, image: "music.note"),
        Song(title: "Song Title 1", difficulty: 2, image: "music.note"),
        Song(title: "Song Title 2", difficulty: 2, image: "music.note"),
        Song(title: "Song Title 3", difficulty: 3, image: "music.note")
    ] // Sample data
    @State private var filteredSongs: [Song] = []
    @State private var likedSongs: Set<Song> = []
    @State private var isFilterPresented = false
    @State private var selectedDifficulty: String? = nil
    @State private var selectedTempo: String? = nil

    var body: some View {
        VStack {
//            Spacer().frame(height: 50)
//            Text("Songs                                         ")
//                .font(.title)
//                .foregroundColor(.ivory)
//                .padding()
            HStack {
                Spacer()
                Text("Songs                         ")
                    .font(.title)
                    .foregroundColor(.ivory)
                    .padding()
                Spacer()
                NavigationLink(destination: LikedSongsScreen(likedSongs: $likedSongs)) {
                    Image(systemName: "heart")
                        .foregroundColor(.lilac)
                }
                Spacer()
                Button(action: {
                    isFilterPresented.toggle()
                }) {
                    Image(systemName: "line.horizontal.3")
                        .foregroundColor(.lilac)
                }
                .sheet(isPresented: $isFilterPresented) {
                    FilterView(isPresented: $isFilterPresented, selectedDifficulty: $selectedDifficulty, selectedTempo: $selectedTempo)
                }
                Spacer()
            }
//            Spacer().frame(height: 0)
            // Search Bar
            HStack {
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
                    .onChange(of: searchText) { newValue in
                        filterSongs(query: newValue)
                    }
                    .padding()

                Button(action: {
                    // Trigger search
                    filterSongs(query: searchText)
                }) {
                    Image(systemName: "magnifyingglass")
                        .foregroundColor(.lilac)
                }
            }
            .padding()

            Spacer().frame(height: 1)
        
            ScrollView(.vertical) {
                VStack {
                    ForEach(filteredSongs) { song in
                        HStack {
                            Image(systemName: song.image) // Use the image name
                                .resizable()
                                .frame(width: 40, height: 40)
                                .cornerRadius(10)
                            Spacer().frame(width: 10)
                            Button(action: {
                                if likedSongs.contains(song) {
                                    likedSongs.remove(song)
                                } else {
                                    likedSongs.insert(song)
                                }
                            }) {
                                Image(systemName: likedSongs.contains(song) ? "heart.fill" : "heart")
                                    .foregroundColor(likedSongs.contains(song) ? .red : .lilac)
                            }
                            Spacer().frame(width: 10)
                            Text(song.title)
                                .foregroundColor(.ivory)
                            Spacer()
                            HStack {
                                ForEach(0..<3) { index in
                                    Image(systemName: index < song.difficulty ? "star.fill" : "star")
                                        .foregroundColor(index < song.difficulty ? .yellow : .gray)
                                }
                            }
                        }
                        .padding()
                        .background(RoundedRectangle(cornerRadius: 10).fill(Color.mistyBlue))
                        .padding(.bottom, 5)
                    }
                }
                .padding()
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
                        .foregroundColor(.darkColor)
                }
                Spacer()
                NavigationLink(destination: HomeScreen()) {
                    Image(systemName: "house.fill")
                        .foregroundColor(.mistyBlue)
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
//        .edgesIgnoringSafeArea(.all)
        .onAppear {
            filteredSongs = songs
        }
    }

    private func filterSongs(query: String) {
        var result = songs
        
        if let difficulty = selectedDifficulty {
            result = result.filter { song in
                switch difficulty {
                case "Easy":
                    return song.difficulty == 1
                case "Medium":
                    return song.difficulty == 2
                case "Hard":
                    return song.difficulty == 3
                default:
                    return true
                }
            }
        }

        if !query.isEmpty {
            result = result.filter { $0.title.lowercased().contains(query.lowercased()) }
        }
        
        filteredSongs = result
    }
}

struct LikedSongsScreen: View {
    @Binding var likedSongs: Set<Song>
    
    var body: some View {
        VStack {
            Spacer().frame(height: 50)
            Text("My Favourites")
                .font(.title)
                .foregroundColor(.ivory)
                .padding()
            ScrollView(.vertical){
                VStack {
                    ForEach(Array(likedSongs)) { song in
                        HStack {
                            Image(systemName: song.image) // Use the image name
                                .resizable()
                                .frame(width: 40, height: 40)
                                .cornerRadius(10)
                            Spacer().frame(width: 10)
                            Button(action: {
                                likedSongs.remove(song)
                            }) {
                                Image(systemName: "heart.fill")
                                    .foregroundColor(.red)
                            }
                            Spacer().frame(width: 10)
                            Text(song.title)
                                .foregroundColor(.ivory)
                            Spacer()
                            HStack {
                                ForEach(0..<3) { index in
                                    Image(systemName: index < song.difficulty ? "star.fill" : "star")
                                        .foregroundColor(index < song.difficulty ? .yellow : .gray)
                                }
                            }
                        }
                        .padding()
                        .background(RoundedRectangle(cornerRadius: 10).fill(Color.mistyBlue))
                        .padding(.bottom, 5)
                    }
                }
                .padding()
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
                        .foregroundColor(.mistyBlue)
                }
                Spacer()
                NavigationLink(destination: HIstoryScreen()) {
                    Image(systemName: "clock")
                        .foregroundColor(.darkColor)
                }
                Spacer()

            }
            .padding()
            .background(Color.ivory)
        }
        .background(Color.darkColor)
        .edgesIgnoringSafeArea(.all)
    }
    
}

struct SongScreen_Previews: PreviewProvider {
    static var previews: some View {
        SongScreen()
    }
}

struct LikedSongsScreen_Previews: PreviewProvider {
    static var previews: some View {
        LikedSongsScreen(likedSongs: .constant([
            Song(title: "Song Title 1", difficulty: 1, image: "music.note"),
            Song(title: "Song Title 2", difficulty: 2, image: "music.note"),
            Song(title: "Song Title 3", difficulty: 3, image: "music.note")
        ]))
    }
}

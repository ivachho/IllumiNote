//
//  SongScreen.swift
//  IllumiNote
//
//  Created by Jessie Huang on 2024-07-24.
//

import SwiftUI

struct SongScreen: View {
    @State private var searchText: String = ""
    @State private var filteredSongs: [Song] = songs
    @State private var likedSongs: Set<Song> = []
    @State private var isFilterPresented = false
    @State private var selectedDifficulty: String? = nil
    @State private var selectedTempo: String? = nil

    var body: some View {
        VStack {
            HStack {
                Spacer()
                Text("Songs                     ")
                    .font(.title)
                    .foregroundColor(.darkColor)
                    .padding()
                Spacer()
                NavigationLink(destination: LikedSongsScreen(likedSongs: $likedSongs)) {
                    Image(systemName: "heart")
                        .foregroundColor(.mistyBlue)
                }
                Spacer()
                Button(action: {
                    isFilterPresented.toggle()
                }) {
                    Image(systemName: "line.horizontal.3")
                        .foregroundColor(.mistyBlue)
                }
                .sheet(isPresented: $isFilterPresented) {
                    FilterView(isPresented: $isFilterPresented, selectedDifficulty: $selectedDifficulty, selectedTempo: $selectedTempo, onApply: applyFilters)
                }
                Spacer()
            }
            
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
                    filterSongs(query: searchText)
                }) {
                    Image(systemName: "magnifyingglass")
                        .foregroundColor(.darkColor)
                }
                Spacer()
            }
            .padding()

            ScrollView(.vertical) {
                VStack {
                    ForEach(filteredSongs) { song in
                        HStack {
                            NavigationLink(destination: SongDetailView(song: song)) {
                                Image(song.imageName)
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 40, height: 40)
                                    .cornerRadius(10)
                            }
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
                            NavigationLink(destination: SongDetailView(song: song)) {
                                Text(song.title)
                                    .foregroundColor(.ivory)
                            }
                            
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
            .background(Color.back)

        }
        .background(Color.back)
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
        
        if let tempo = selectedTempo {
            result = result.filter { song in
                switch tempo {
                case "Slow":
                    return song.tempo == "slow"
                case "Medium":
                    return song.tempo == "medium"
                case "Fast":
                    return song.tempo == "fast"
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

    private func applyFilters() {
        filterSongs(query: searchText)
    }
}

struct LikedSongsScreen: View {
    @Binding var likedSongs: Set<Song>
    
    var body: some View {
        VStack {
            Spacer().frame(height: 50)
            Text("My Favourites")
                .font(.title)
                .foregroundColor(.darkColor)
                .padding()
            ScrollView(.vertical){
                VStack {
                    ForEach(Array(likedSongs)) { song in
                        HStack {
                            NavigationLink(destination: SongDetailView(song: song)) {
                                Image(song.imageName)
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 40, height: 40)
                                    .cornerRadius(10)
                            }
                            Spacer().frame(width: 10)
                            Button(action: {
                                likedSongs.remove(song)
                            }) {
                                Image(systemName: "heart.fill")
                                    .foregroundColor(.red)
                            }
                            Spacer().frame(width: 10)
                            NavigationLink(destination: SongDetailView(song: song)) {
                                Text(song.title)
                                    .foregroundColor(.ivory)
                            }
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
            .background(Color.back)
        }
        .background(Color.back)
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
            Song(title: "Mary Had a Little Lamb", difficulty: 1, imageName: "marylamb", composer: "Sarah Josepha Hale", duration: "1:30", bpm: 60, tempo: "slow"),
            Song(title: "River Flows in You", difficulty: 2, imageName: "yiruma", composer: "Yiruma", duration: "3:00", bpm: 85, tempo: "medium"),
            Song(title: "Clocks", difficulty: 3, imageName: "coldplay", composer: "Coldplay", duration: "4:00", bpm: 120, tempo: "fast")
        ]))
    }
}

//
//  SongScreen.swift
//  IllumiNote
//
//  Created by Jessie Huang on 2024-07-23.
//

import SwiftUI

struct SongScreen: View {
    @State private var searchText: String = ""
    @State private var songs: [String] = Array(repeating: "Song Title", count: 20) // Sample data
    @State private var filteredSongs: [String] = []

    var body: some View {
        VStack {
            Spacer().frame(height: 50)
            Text("My Songs                               ")
                .font(.title)
                .foregroundColor(.ivory)
                .padding()
            Spacer().frame(height: 1)
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
                    .onChange(of: searchText) {
                        filterSongs(query: searchText)
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
                    ForEach(filteredSongs, id: \.self) { song in
                        Button(action: {
                            // Action when a song is selected
                        }) {
                            RoundedRectangle(cornerRadius: 10)
                                .fill(Color.mistyBlue)
                                .frame(width: 350, height: 60)
                                .overlay(
                                    Text(song)
                                        .foregroundColor(.ivory)
                                        .padding()
                                )
                        }
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
        .edgesIgnoringSafeArea(.all)
        .onAppear {
                    filteredSongs = songs
                }
    }
    private func filterSongs(query: String) {
        if query.isEmpty {
            filteredSongs = songs
        } else {
            filteredSongs = songs.filter { $0.lowercased().contains(query.lowercased()) }
        }
    }
}

#Preview {
    SongScreen()
}

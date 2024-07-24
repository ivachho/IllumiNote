//
//  HIstoryScreen.swift
//  IllumiNote
//
//  Created by Jessie Huang on 2024-07-23.
//

import SwiftUI

struct HIstoryScreen: View {
    var body: some View {
        VStack {
//            HStack {
//                Spacer()
//
//                Text("IllumiNote")
//                    .font(.custom("Bradley Hand Bold", size: 20))
//                    .foregroundColor(.ivory)
//                    .shadow(color: .lilac, radius: 15, x: 0, y: 3)
//                    .padding()
//                Spacer().frame(height: 50)
//                NavigationLink(destination: SettingsScreen()) {
//                    Image(systemName: "line.horizontal.3")
//                        .foregroundColor(.lilac)
//                }
//                
//                .padding(.horizontal)
//                Spacer()
//                Spacer()
//
//
//            }
            Spacer().frame(height: 50)
            Text("Recently Played                    ")
                .font(.title)
                .foregroundColor(.ivory)
                .padding()
            ScrollView(.vertical){
                VStack {
                    ForEach(0..<20) { _ in
                        Button(action: {
                        }){
                            RoundedRectangle(cornerRadius: 10)
                                .fill(Color.mistyBlue)
                                .frame(width: 350, height: 60)
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

#Preview {
    HIstoryScreen()
}

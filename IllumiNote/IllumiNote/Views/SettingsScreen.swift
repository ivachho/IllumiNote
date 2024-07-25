//
//  SettingsScreen.swift
//  IllumiNote
//
//  Created by Jessie Huang on 2024-07-23.
//

import SwiftUI

struct SettingsScreen: View {
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
            Text("Settings                                     ")
                .font(.title)
                .foregroundColor(.darkColor)
                .padding()
            ScrollView(.vertical){
                VStack {
                    Text("Account                                                ")
                        .font(.title2)
                        .foregroundColor(.darkColor)
                        .padding()
                    Text("Bluetooth                                              ")
                        .font(.title2)
                        .foregroundColor(.darkColor)
                        .padding()
                }
                .padding()
                

            }
            
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
                        .foregroundColor(.mistyBlue)
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

#Preview {
    SettingsScreen()
}

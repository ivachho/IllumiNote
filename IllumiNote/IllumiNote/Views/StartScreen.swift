//
//  StartScreen.swift
//  IllumiNote
//
//  Created by Jessie Huang on 2024-07-23.
//

import SwiftUI

//struct StartScreen: View {
//    var body: some View {
//        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
//    }
//}
//
//#Preview {
//    StartScreen()
//}

struct StartScreen: View {
//    
    var body: some View {
        VStack {
            
            Spacer().frame(height: 350)
            Text("IllumiNote")
                .font(.custom("Bradley Hand Bold", size: 60))
                .foregroundColor(.ivory)
                .shadow(color: .darkColor, radius: 7, x: 0, y: 3)
                .padding()

//            Button(action: {
//            }) {
//                NavigationLink(destination: HomeScreen()) {
//                      Image(systemName: "arrow.right")
//                          .foregroundColor(.white)
//                          .padding()
//                          .background(
//                              RoundedRectangle(cornerRadius: 30)
//                                  .fill(Color.lilac))
//                  }
//            }
            NavigationLink(destination: HomeScreen()) {
//                HStack {
                    Image(systemName: "arrow.right")
                        .foregroundColor(.ivory)
                        .padding()
                        .background(
                            RoundedRectangle(cornerRadius: 30)
                                .fill(Color.lilac)
                        )
//                }
            }
            .padding().frame(height: 0)
            
            Spacer()
            HStack {
                Spacer()

            }
            .padding()
            .background(Color.darkColor)
        }
        .background(Color.darkColor)
        .edgesIgnoringSafeArea(.all)
    }
}

struct StartScreen_Previews: PreviewProvider {
    static var previews: some View {
        StartScreen()
    }
}

//
//  FeedbackView.swift
//  IllumiNote
//
//  Created by Iva Chho on 2/19/25.
//
import SwiftUI
struct FeedbackView: View {
    @EnvironmentObject var viewModel: FeedbackViewService 
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        VStack {
            Spacer().frame(height: 100)
            
            Image("feedback_icon") // Replace with an appropriate asset
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 200, height: 200)
                .clipShape(RoundedRectangle(cornerRadius: 20))
            
            Text("Session Feedback")
                .font(.title)
                .foregroundColor(.darkColor)
            
            Spacer().frame(height: 20)
            
            VStack {
                Text("Key Accuracy: \(String(format: "%.2f", viewModel.keyAccuracy))%")
                    .font(.title2)
                    .foregroundColor(.darkColor)
                
                Text("Timing Accuracy: \(String(format: "%.2f", viewModel.timingAccuracy))%")
                    .font(.title2)
                    .foregroundColor(.darkColor)
                
                Text("Overall Score: \(String(format: "%.2f", viewModel.overallScore))%")
                    .font(.title2)
                    .foregroundColor(.darkColor)
            }
            .padding()
            
            Spacer().frame(height: 30)
            
            Button(action: {
                presentationMode.wrappedValue.dismiss() // Navigate back
            }) {
                Text("Back to Songs")
                    .font(.title)
                    .padding()
                    .background(Color.mistyBlue)
                    .foregroundColor(.darkColor)
                    .cornerRadius(10)
            }
            .padding()
            
            Spacer()
            HStack {
                Spacer()
            }
            .padding()
            .background(Color.back)
        }
        .background(Color.back)
        .edgesIgnoringSafeArea(.all)
    }
}

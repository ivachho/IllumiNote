//
//  FilterView.swift
//  IllumiNote
//
//  Created by Jessie Huang on 2024-07-24.
//

import SwiftUI

struct FilterView: View {
    @Binding var isPresented: Bool
    @Binding var selectedDifficulty: String?
    @Binding var selectedTempo: String?
    
    let difficulties = ["Easy", "Medium", "Hard"]
    let tempos = ["Slow", "Medium", "Fast"]
    
    var onApply: () -> Void // Callback for applying filters

    var body: some View {
        VStack(spacing: 20) {
            Text("Filter")
                .font(.headline)
                .padding(.top)
            
            Text("Difficulty")
                .font(.subheadline)
            Picker("Difficulty", selection: $selectedDifficulty) {
                Text("None").tag(String?.none)
                ForEach(difficulties, id: \.self) { difficulty in
                    Text(difficulty).tag(String?.some(difficulty))
                }
            }
            .pickerStyle(SegmentedPickerStyle())
            
            Text("Tempo")
                .font(.subheadline)
            Picker("Tempo", selection: $selectedTempo) {
                Text("None").tag(String?.none)
                ForEach(tempos, id: \.self) { tempo in
                    Text(tempo).tag(String?.some(tempo))
                }
            }
            .pickerStyle(SegmentedPickerStyle())
            
            Button(action: {
                onApply() // Call the callback
                isPresented = false
            }) {
                Text("Apply")
                    .foregroundColor(.white)
                    .padding()
                    .background(Color.mistyBlue)
                    .cornerRadius(10)
            }
            .padding(.bottom)
            
            Spacer()
        }
        .padding()
        .background(Color.ivory)
        .cornerRadius(20)
        .shadow(radius: 10)
        .padding(.horizontal, 20)
    }
}

struct FilterView_Previews: PreviewProvider {
    @State static var isPresented = true
    @State static var selectedDifficulty: String? = nil
    @State static var selectedTempo: String? = nil

    static var previews: some View {
        FilterView(isPresented: $isPresented, selectedDifficulty: $selectedDifficulty, selectedTempo: $selectedTempo, onApply: {})
    }
}

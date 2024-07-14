//
//  SessionView.swift
//  IllumiNote
//
//  Created by Iva Chho on 7/14/24.
//

import Foundation
import SwiftUI

struct SessionView: View {
    @EnvironmentObject var bluetoothService: BluetoothService
    var body: some View {
        VStack {
            Text("Session in Progress")
                .font(.largeTitle)
                .padding()
            Spacer()
        }
        .navigationTitle("Session")
    }
}

struct SessionView_Previews: PreviewProvider {
    static var previews: some View {
        SessionView()
    }
}

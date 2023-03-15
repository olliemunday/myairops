//
//  SettingsView.swift
//  myairops
//
//  Created by Ollie on 14/03/2023.
//

import SwiftUI

struct SettingsView: View {
    @Binding var tabSelected: Int

    var body: some View {
        NavigationView {
            List {
                Button("Back to flights") {
                    tabSelected = 0
                }

            }
            .navigationBarTitle("Settings")
        }
    }

}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView(tabSelected: .constant(2))
    }
}

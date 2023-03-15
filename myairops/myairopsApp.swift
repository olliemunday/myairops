//
//  myairopsApp.swift
//  myairops
//
//  Created by Ollie on 14/03/2023.
//

import SwiftUI

@main
struct myairopsApp: App {
    @State private var tabSelected = 0

    var body: some Scene {
        WindowGroup {
            TabView(selection: $tabSelected) {
                FlightsView(tabSelected: $tabSelected)
                    .tag(0)
                    .tabItem { TabViewItem(systemName: "airplane", text: "Flights") }

                ContactsView(tabSelected: $tabSelected)
                    .tag(1)
                    .tabItem { TabViewItem(systemName: "phone", text: "Contacts") }

                SettingsView(tabSelected: $tabSelected)
                    .tag(2)
                    .tabItem { TabViewItem(systemName: "gearshape", text: "Settings") }
            }
        }
    }
}


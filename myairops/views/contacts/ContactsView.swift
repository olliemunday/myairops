//
//  ContactsView.swift
//  myairops
//
//  Created by Ollie on 14/03/2023.
//

import SwiftUI

struct ContactsView: View {
    @Binding var tabSelected: Int

    var body: some View {
        NavigationView {
            VStack {
                List {
                    Button {
                        tabSelected = 2
                    } label: {
                        Text("Go to Settings")
                    }
                }
            }
            .navigationBarTitle("Contacts")

        }
    }
}

struct ContactsView_Previews: PreviewProvider {
    static var previews: some View {
        ContactsView(tabSelected: .constant(1))
    }
}

//
//  TabViewItem.swift
//  myairops
//
//  Created by Ollie on 14/03/2023.
//

import SwiftUI

struct TabViewItem: View {
    let systemName: String
    let text: String

    var body: some View {
        Image(systemName: systemName)
        Text(text)
    }
}

struct TabViewItem_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            TabViewItem(systemName: "airplane", text: "Flights")
        }
    }
}

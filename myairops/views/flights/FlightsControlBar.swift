//
//  FlightsControlBar.swift
//  myairops
//
//  Created by Ollie on 15/03/2023.
//

import SwiftUI

struct FlightsControlBar: View {
    @Binding var showFilterMenu: Bool

    var body: some View {
        HStack {
            FlightsControlBarButton(text: "Sort", icon: "arrow.up.arrow.down") {}
            FlightsControlBarButton(text: "Filter", icon: "switch.2") { showFilterMenu.toggle() }
            FlightsControlBarButton(text: "Map", icon: "map") {}
        }
        .frame(height: 30)
    }
}

struct FlightsControlBarButton: View {

    let text: String
    let icon: String
    let onPress: () -> ()

    var body: some View {
        Button {
            onPress()
        } label: {
            HStack {
                Image(systemName: icon)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .foregroundColor(.primary)
                    .frame(height: 20)

                Text(text)
                    .foregroundColor(.primary)
                    .font(.caption)
                    .bold()
                    .dynamicTypeSize(.xLarge ... .xxxLarge)
            }
        }
        .padding()
        .background(
            Rectangle()
                .cornerRadius(12)
                .foregroundColor(.primary)
                .opacity(0.2)
        )
    }

}

struct FlightsControlBar_Previews: PreviewProvider {
    static var previews: some View {
        FlightsControlBar(showFilterMenu: .constant(false))
    }
}

//
//  FlightProgressIndicator.swift
//  myairops
//
//  Created by Ollie on 14/03/2023.
//

import SwiftUI

struct FlightProgressIndicator: View {

    let stages = [
        "Fuel",
        "Passengers",
        "Depart",
        "Arrive",
        "PFSB"
    ]

    var body: some View {
        VStack {
            ZStack {
                HStack { stageTrack }
                HStack { stageIcons }
            }
            HStack { stageCaptions }
        }
    }

    @ViewBuilder
    private var stageIcons: some View {
        ForEach(stages.indices, id: \.self) { index in
            VStack {
                Image(systemName: "\(index+1).circle.fill")
                    .renderingMode(.original)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .padding()
            }

        }
    }

    @ViewBuilder
    private var stageCaptions: some View {
        ForEach(stages, id: \.self) {
            Color.clear
                .overlay(
                    Text($0)
                        .font(.caption)
                        .multilineTextAlignment(.center)
                )
                .frame(height: 5)
        }
    }

    @ViewBuilder
    private var stageTrack: some View {
        Rectangle()
            .frame(height: 5)
            .padding(.horizontal)
    }
}

struct FlightProgressIndicator_Previews: PreviewProvider {
    static var previews: some View {
        FlightProgressIndicator()
    }
}

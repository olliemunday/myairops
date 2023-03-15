//
//  FlightsView.swift
//  myairops
//
//  Created by Ollie on 14/03/2023.
//

import SwiftUI

struct FlightsView: View {

    @StateObject private var airportManager = AirportManager()
    @StateObject private var airlineManager = AirlineManager()
    @StateObject private var flightManager = FlightManager()

    @Binding var tabSelected: Int
    @State private var showFilterMenu: Bool = false

    var body: some View {
        NavigationView {
            ScrollView {
                Color.clear.frame(height: 8)

                FlightsControlBar(showFilterMenu: $showFilterMenu)
                    .padding(.bottom, 10)

                ForEach(flightManager.flights) { flight in
                    FlightView(flight: flight)
                        .transition(.scale.combined(with: .opacity))
                        .onTapGesture { tabSelected = 1 }
                }

                Spacer()
            }
            .animation(.spring(response: 0.8, dampingFraction: 0.6), value: flightManager.flights)
            .environmentObject(airportManager)
            .environmentObject(airlineManager)
            .navigationTitle("Flights")
        }
        .popover(isPresented: $showFilterMenu) {
                FlightsFilterView()
                    .environmentObject(airportManager)
                    .environmentObject(airlineManager)
                    .environmentObject(flightManager)
        }
    }
}

struct FlightsView_Previews: PreviewProvider {
    static var previews: some View {
        FlightsView(tabSelected: .constant(0))
    }
}

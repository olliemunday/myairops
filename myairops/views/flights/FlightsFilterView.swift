//
//  FlightsFilterView.swift
//  myairops
//
//  Created by Ollie on 15/03/2023.
//

import SwiftUI

struct FlightsFilterView: View {

    @Environment(\.dismiss) private var dismiss
    @EnvironmentObject var airportManager: AirportManager
    @EnvironmentObject var airlineManager: AirlineManager
    @EnvironmentObject var flightManager: FlightManager

    private enum Navigation: String, Hashable {
        case airport = "Airport"
        case airline = "Airline"
    }

    @State private var airportIsArrival: Bool = false

    @State private var navigationStack = [Navigation]()
    var body: some View {
        NavigationStack(path: $navigationStack) {
            VStack {
                List {
                    Section("airport") {
                        Picker("", selection: $airportIsArrival) {
                            Text("Departure").tag(false)
                            Text("Arrival").tag(true)
                        }
                        .pickerStyle(.segmented)
                        NavigationLink(value: Navigation.airport, label: { Text(airportManager.airportSelected?.name ?? "Select").padding(1) })

                    }

                    Section("airline") {
                        NavigationLink(value: Navigation.airline, label: { Text(airlineManager.airlineSelected?.name ?? "Select") })
                    }


                }
                .navigationTitle("Filter")
                .navigationBarTitleDisplayMode(.inline)
                .navigationDestination(for: Navigation.self) {
                    switch $0 {
                    case .airport: airportFilter
                    case .airline: airlineFilter
                    }
                }
                .toolbar {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Button {
                            if let airline = airlineManager.airlineSelected,
                               let airport = airportManager.airportSelected,
                               let airport_iata = airport.iata_code
                            {
                                flightManager.getFlights(airline_iata: airline.iata_code,
                                                         airport_iata: airport_iata)
                            }
                            dismiss()
                        } label: {
                            Text("Apply")
                                .bold()
                        }
                    }
                    ToolbarItem(placement: .navigationBarLeading) {
                        Button("Cancel", role: .destructive) {
                            dismiss()
                        }
                    }
                }

            }

        }
    }

    private var airportFilter: some View {
        NavigationView {
            VStack {
                TextField("Search", text: $airportManager.filterString)
                    .padding(.vertical, 5)
                    .padding(.horizontal, 20)
                    .onChange(of: airportManager.filterString) { _ in
                        airportManager.filterAirports()

                    }

                List {
                    ForEach(airportManager.airportsFiltered) { airport in
                        Button(airport.name) {
                            airportManager.airportSelected = airport
                            navigationStack.removeLast()
                        }
                    }
                }
            }
        }
    }

    private var airlineFilter: some View {
        NavigationView {
            VStack {
                TextField("Search", text: $airlineManager.filterString)
                    .padding(.vertical, 5)
                    .padding(.horizontal, 20)
                    .onChange(of: airlineManager.filterString) { _ in
                        airlineManager.filterAirports()
                    }
                List {
                    ForEach(airlineManager.airlinesFiltered) { airline in
                        Button(airline.name) {
                            airlineManager.airlineSelected = airline
                            navigationStack.removeLast()
                        }
                    }
                }
            }
        }
    }


}

struct FlightsFilterView_Previews: PreviewProvider {
    static var previews: some View {
        FlightsFilterView()
    }
}

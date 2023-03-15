//
//  FlightView.swift
//  myairops
//
//  Created by Ollie on 15/03/2023.
//

import SwiftUI

struct FlightView: View {

    @EnvironmentObject var airlineManager: AirlineManager
    @EnvironmentObject var airportManager: AirportManager

    let flight: Flight

    var body: some View {
        Rectangle()
            .cornerRadius(20)
            .frame(height: 135)
            .foregroundColor(.blue)
            .overlay(
                VStack {
                    topBar.padding(10)
                    journeyInfo
                    Spacer()
                }
            )
            .padding(.horizontal, 10)
            .drawingGroup()
            .shadow(radius: 1)

    }

    private var topBar: some View {
        HStack {
            VStack(alignment: .leading) {
                airlineTitle
                flightCode
            }
            Spacer()
        }
    }

    private var journeyInfo: some View {
        HStack {
            departureAirport
                .padding(.horizontal, 20)

            Spacer()

            arrivalAirport
                .padding(.horizontal, 20)
        }
    }

    private var departureAirport: some View {
        VStack {
            Image(systemName: "building.2.fill")
            Text(flight.dep_iata ?? flight.dep_icao ?? "DEP")
//            Text("02:25")
//                .bold()
//                .font(.caption)
        }
    }

    private var arrivalAirport: some View {
        VStack {
            Image(systemName: "building.2.fill")
            Text(flight.arr_iata ?? flight.arr_icao ?? "ARR")
//            Text("04:25")
//                .bold()
//                .font(.caption)
        }
    }

    private var airlineTitle: some View {
        Text(airlineName)
            .font(.title3)
            .bold()
    }

    @ViewBuilder
    private var flightCode: some View {
        if let code = flight.flight_iata {
            Text(code)
                .font(.caption)
                .bold()
        } else if let code = flight.flight_icao {
            Text(code)
                .font(.caption)
                .bold()
        }
    }


    var airlineName: String {
        airlineManager.getAirlineFromCode(iata: flight.airline_iata, icao: flight.airline_icao) ?? "Unknown"
    }
}

struct FlightView_Previews: PreviewProvider {
    static var previews: some View {
        FlightView(flight: Flight(hex: "AAA7338", flight_iata: "TEST"))
    }
}

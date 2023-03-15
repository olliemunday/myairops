//
//  FlightManager.swift
//  myairops
//
//  Created by Ollie on 15/03/2023.
//

import Foundation

class FlightManager: NSObject, ObservableObject {

    /// Array for flights being shown
    @Published var flights: [Flight] = []

    override init() {
        super.init()
    }

    /// Get list of Airlines from API and update to `airlinesList`
    public func getFlights(airline_iata: String, airport_iata: String) {

        let decoder = JSONDecoder()

        let dataUrl = URL(string: "https://airlabs.co/api/v9/flights?api_key=e952db8d-3f65-4901-817e-ecb5abcf6e7c&airline_iata=\(airline_iata)&dep_iata=\(airport_iata)")

        APIHelper.requestAPI(url: dataUrl) { data, err in
            guard let data = data else { return }

            let json = APIHelper.parseJson(data: data)
            guard let dictionary = json as? [String: Any] else { return }
            guard let flights = dictionary["response"] as? [Any] else { return }

            var flightArray: [Flight] = []

            for flight in flights {
                do {
                    guard let jsonData = try? JSONSerialization.data(withJSONObject: flight) else { return }
                    let decoded = try decoder.decode(Flight.self, from: jsonData)

                    flightArray.append(decoded)
                } catch {
                    continue
                }
            }

            DispatchQueue.main.sync {
                self.flights = Array(flightArray.prefix(60))
            }

        }

    }

}

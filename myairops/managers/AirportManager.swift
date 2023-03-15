//
//  AirportManager.swift
//  myairops
//
//  Created by Ollie on 15/03/2023.
//

import Foundation

class AirportManager: NSObject, ObservableObject {

    let dataUrl = URL(string: "https://airlabs.co/api/v9/airports?&api_key=e952db8d-3f65-4901-817e-ecb5abcf6e7c")

    private var airportsList: [Airport] = []

    /// Array for airports being shown
    @Published var airportsFiltered: [Airport] = []

    /// Filter string to be updated
    @Published var filterString: String = ""

    @Published var airportSelected: Airport?

    override init() {
        super.init()
        DispatchQueue.global(qos: .background).async {
            self.getAirports()
        }
    }

    /// Get list of Airports from API and update to `airportsList`
    private func getAirports() {
        let decoder = JSONDecoder()

        APIHelper.requestAPI(url: dataUrl) { data, err in
            guard let data = data else { return }

            let json = APIHelper.parseJson(data: data)
            guard let dictionary = json as? [String: Any] else { return }
            guard let airports = dictionary["response"] as? [Any] else { return }

            for airport in airports {
                do {
                    guard let jsonData = try? JSONSerialization.data(withJSONObject: airport) else { return }
                    let decoded = try decoder.decode(Airport.self, from: jsonData)

                    self.airportsList.append(decoded)
                } catch {
                    continue
                }
            }
        }

    }

    /// Update the filtered list using `filterString`
    public func filterAirports() {
        if filterString.count <= 0 { return }
        let filtered = airportsList.filter { $0.name.contains(filterString) }
        airportsFiltered = Array(filtered.prefix(60))
    }


}

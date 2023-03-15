//
//  AirlinesManager.swift
//  myairops
//
//  Created by Ollie on 15/03/2023.
//

import Foundation

class AirlineManager: NSObject, ObservableObject {

    let dataUrl = URL(string: "https://airlabs.co/api/v9/airlines?api_key=e952db8d-3f65-4901-817e-ecb5abcf6e7c")

    private var airlinesList: [Airline] = []

    /// Array for airlines being shown
    @Published var airlinesFiltered: [Airline] = []

    /// Filter string to be updated
    @Published var filterString: String = ""

    /// Variable for holding selected Airline
    @Published var airlineSelected: Airline?

    override init() {
        super.init()
        DispatchQueue.global(qos: .background).async {
            self.getAirlines()
        }
    }

    /// Get list of Airlines from API and update to `airlinesList`
    private func getAirlines() {
        let decoder = JSONDecoder()

        APIHelper.requestAPI(url: dataUrl) { data, err in
            guard let data = data else { return }

            let json = APIHelper.parseJson(data: data)
            guard let dictionary = json as? [String: Any] else { return }
            guard let airlines = dictionary["response"] as? [Any] else { return }

            for airline in airlines {
                do {
                    guard let jsonData = try? JSONSerialization.data(withJSONObject: airline) else { return }
                    let airlineObject = try decoder.decode(Airline.self, from: jsonData)

                    self.airlinesList.append(airlineObject)
                } catch {
                    continue
                }
            }
        }

    }

    /// Update the filtered list using `filterString`
    public func filterAirports() {
        if filterString.count <= 0 { return }
        let filtered = airlinesList.filter { $0.name.contains(filterString) }
        airlinesFiltered = Array(filtered.prefix(60))
    }

    /// Get the name of Airline from the IATA or ICAO code
    public func getAirlineFromCode( iata: String? = nil, icao: String? = nil ) -> String? {
        if let code = iata,
           let airline = airlinesList.first(where: { $0.iata_code == code }) {
            return airline.name
        }

        if let code = icao,
           let airline = airlinesList.first(where: { $0.icao_code == code }) {
            return airline.name
        }

        return nil
    }

}

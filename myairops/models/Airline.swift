//
//  Airline.swift
//  myairops
//
//  Created by Ollie on 15/03/2023.
//

import Foundation

struct Airline: Identifiable, Equatable, Hashable, Decodable {

    var id: String { self.icao_code }
    let name: String
    let iata_code: String
    let icao_code: String
    let country_code: String?
    let is_international: Int?
}

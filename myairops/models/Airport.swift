//
//  Airport.swift
//  myairops
//
//  Created by Ollie on 15/03/2023.
//

import Foundation

struct Airport: Identifiable, Equatable, Hashable, Decodable {

    var id: Int { name.hashValue }
    let name: String
    let iata_code: String?
    let icao_code: String?
    let lat: Double?
    let lng: Double?
    let city: String?

}

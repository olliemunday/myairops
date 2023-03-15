//
//  Flight.swift
//  myairops
//
//  Created by Ollie on 15/03/2023.
//

import Foundation

struct Flight: Identifiable, Equatable, Hashable, Decodable {

    var id: String { self.hex }
    let hex: String
    var reg_number: String? = nil
    var flag: String? = nil
    var lat: Double? = nil
    var lng: Double? = nil
    var alt: Int? = nil

    var airline_icao: String? = nil
    var airline_iata: String? = nil

    var flight_icao: String? = nil
    var flight_iata: String? = nil

    var dep_icao: String? = nil
    var dep_iata: String? = nil
    var arr_icao: String? = nil
    var arr_iata: String? = nil



    var status: String? = nil

}

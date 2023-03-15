//
//  AirlabsAPI.swift
//  myairops
//
//  Created by Ollie on 15/03/2023.
//

import Foundation

///
/// AirLabs API shared functions
///

class APIHelper {

    /// Asynchronus callback function for calling the API and keeping in line with Swift concurrency.
    static func requestAPI(url: URL?, withCompletion completion: @escaping (Data?, Error?) -> Void) {
        guard let url = url else { return }

        let session = URLSession.shared.dataTask(with: url) { responseData, response, err in
            guard err == nil else { return }
            completion(responseData, nil)
        }

        session.resume()
    }

    /// Parse json.
    static func parseJson(data: Data) -> Any? {
        do {
            let json = try JSONSerialization.jsonObject(with: data)
            return json
        } catch {
            print(error.localizedDescription)
            return nil
        }
    }
}


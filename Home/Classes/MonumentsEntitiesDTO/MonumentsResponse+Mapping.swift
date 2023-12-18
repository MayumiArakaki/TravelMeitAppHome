//
//  MonumentsResponse+Mapping.swift
//  Home
//
//  Created by Enrique Alata Vences on 5/12/23.
//

struct MonumentsResponseDTO: Decodable {
    let pais: String
    let ciudad: String
    let district: String
    let latitude, longitude: Double
    let general, historic, landscape, artist: Int
    let party: Int
    let monument, short, medium, long: String
    let image: String

    private enum CodingKeys: String, CodingKey {
        case pais = "Pais"
        case ciudad = "Ciudad"
        case district = "District"
        case latitude = "Latitude"
        case longitude = "Longitude"
        case general = "General"
        case historic = "Historic"
        case landscape = "Landscape"
        case artist = "Artist"
        case party = "Party"
        case monument = "Monument"
        case short = "Short"
        case medium = "Medium"
        case long = "Long"
        case image = "Image"
    }
}

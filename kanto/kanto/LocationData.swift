//
//  LocationData.swift
//  kanto
//
//  Created by George Tevosov on 15.02.2022.
//

import Foundation
import CoreLocation

let locationData: [Pin] = [
    Pin(
        title: "42 Barcelona",
        locationName: "Spain",
        coordinate: CLLocationCoordinate2D(latitude: 41.43697710898832,longitude: 2.1693693396277403)
    ),
    Pin(
        title: "42 São Paulo",
        locationName: "Brazil",
        coordinate: CLLocationCoordinate2D(latitude:  -23.557322036853513,longitude: -46.68949971924875)
    ),
    Pin(
        title: "42 Ecole",
        locationName: "France",
        coordinate: CLLocationCoordinate2D(latitude: 48.896487225262824,longitude: 2.318628022127916)
    ),
    Pin(
        title: "1337 – Ben Guérir",
        locationName: "Morocco",
        coordinate: CLLocationCoordinate2D(latitude: 32.2200427830021,longitude: -7.939835965248914)
    ),
    Pin(
        title: "42 Kuala Lumpur",
        locationName: "Malaysia",
        coordinate: CLLocationCoordinate2D(latitude: 3.0663995193129256,longitude: 101.6061626528805)
    ),
]

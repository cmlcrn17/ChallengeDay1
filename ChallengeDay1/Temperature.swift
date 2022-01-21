//
//  Temperature.swift
//  ChallengeDay1
//
//  Created by Ceren TAŞSIN on 21.01.2022.
//

import Foundation

struct Temperature: UnitType {
    static var name = "Temperature"
    
    private static let celsius = NamedUnit(name: "Celsius", unit: UnitTemperature.celsius)
    private static let farenheit = NamedUnit(name: "Farenheit", unit: UnitTemperature.fahrenheit)
    private static let kelvin = NamedUnit(name: "Kelvin", unit: UnitTemperature.kelvin)

    static let units = [celsius, farenheit, kelvin]
}

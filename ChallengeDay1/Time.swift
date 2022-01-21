//
//  Time.swift
//  ChallengeDay1
//
//  Created by Ceren TAŞSIN on 21.01.2022.
//

import Foundation

struct Time: UnitType {
    static var name = "Time"

    private static let seconds = NamedUnit(name: "Seconds", unit: UnitDuration.seconds)
    private static let minutes = NamedUnit(name: "Minutes", unit: UnitDuration.minutes)
    private static let hours = NamedUnit(name: "Hours", unit: UnitDuration.hours)

    static let units = [seconds, minutes, hours]
}

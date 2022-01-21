//
//  UnitType.swift
//  ChallengeDay1
//
//  Created by Ceren TAŞSIN on 21.01.2022.
//

import Foundation

protocol UnitType {
    static var name: String { get }
    static var units: [NamedUnit] { get }
}

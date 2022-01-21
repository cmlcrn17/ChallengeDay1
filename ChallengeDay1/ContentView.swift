//
//  ContentView.swift
//  ChallengeDay1
//
//  Created by Ceren TAŞSIN on 21.01.2022.
//

import SwiftUI

struct DismissingKeyboard: ViewModifier {
    func body(content: Content) -> some View {
        content.onTapGesture(count: 2) {
            let keyWindow = UIApplication.shared.connectedScenes
                .filter({$0.activationState == .foregroundActive})
                .map({$0 as? UIWindowScene})
                .compactMap({$0})
                .first?.windows
                .filter({$0.isKeyWindow}).first
            keyWindow?.endEditing(true)
        }
    }
}

struct ContentView: View {
    @State private var unitTypeIndex = 0
    var unitTypes: [UnitType.Type] {
        return UnitTypes.types
    }
    
    @State private var value = "0"
    @State private var sourceNamedUnitIndexes = Array(repeating: 0, count: UnitTypes.types.count)
    var namedUnits: [NamedUnit] {
        return unitTypes[unitTypeIndex].units
    }
    
    var sourceNamedUnit: NamedUnit {
        let selectedSourceIndex = sourceNamedUnitIndexes[unitTypeIndex]
        return namedUnits[selectedSourceIndex]
    }
    
    @State private var destinationNamedUnitIndexes = Array(repeating: 0, count: UnitTypes.types.count)
    var destinationNamedUnit: NamedUnit {
            let selectedDestinationIndex = destinationNamedUnitIndexes[unitTypeIndex]
            return namedUnits[selectedDestinationIndex]
        }
    
    var result: Double {
            let source = Measurement(value: Double(value) ?? 0, unit: sourceNamedUnit.unit)
            return source.converted(to: destinationNamedUnit.unit).value
        }
    
    
    func format(number: Double) -> String {
            // better than %.5f specifier because it removes trailing zeros
            let formatter = NumberFormatter()
            let nsnumber = NSNumber(value: number)
            formatter.minimumFractionDigits = 0
            formatter.maximumFractionDigits = 5
            return String(formatter.string(from: nsnumber) ?? "")
        }
    
    var body: some View {
        NavigationView{
            Form{
                
                Section() {
                    Picker("Unit", selection: $unitTypeIndex) {
                        ForEach(0 ..< unitTypes.count, id: \.self) {
                            Text("\(self.unitTypes[$0].name)")
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())
                }
                
                Section() {
                    
                    HStack {
                        TextField("Value", text: $value)
                            .keyboardType(.decimalPad)
                        Spacer()
                        Text(sourceNamedUnit.name)
                    }
                    
                    Picker("in", selection: $sourceNamedUnitIndexes[unitTypeIndex]) {
                        ForEach(0 ..< namedUnits.count, id: \.self) { i in
                            Text(self.namedUnits[i].unit.symbol)
                        }
                    }
                    .id(unitTypeIndex) // important with variable number of elements in picker
                    .pickerStyle(SegmentedPickerStyle())
                }
                
                Section(header: Text("=")) {
                    
                    HStack {
                        Text(format(number: result))
                        Spacer()
                        Text(destinationNamedUnit.name)
                    }
                    
                    Picker("in", selection: $destinationNamedUnitIndexes[unitTypeIndex]) {
                        ForEach(0 ..< namedUnits.count, id: \.self) { i in
                            Text(self.namedUnits[i].unit.symbol)
                        }
                    }
                    .id(unitTypeIndex)
                    .pickerStyle(SegmentedPickerStyle())
                }
                
            }.navigationBarTitle("Converter")
        }.modifier(DismissingKeyboard())
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

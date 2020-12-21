//
//  FilterFields.swift
//  Flowerdex
//
//  Created by Víctor A. Hernández on 12/1/20.
//

import SwiftUI

struct FilterFields: View {

    @Binding var edible: Bool
    @Binding var vegetable: Bool
    @Binding var petalCount: Int
    @Binding var growthMonths: Int
    @Binding var bloomMonths: Int
    @Binding var scientificName: String
    @Binding var commonName: String
    
    var body: some View {
        VStack {
            MainText()
            EdibleField(edible: $edible)
            VegetableField(vegetable: $vegetable)
            PetalsField(petalCount: $petalCount)
            GrowthMonthsField(growthMonths: $growthMonths)
            BloomMonthsField(bloomMonths: $bloomMonths)
            CommonNameField(commonName: $commonName)
            ScientificNameField(scientificName: $scientificName)
        }
        .padding()
    }
}

struct MainText: View {
    var body: some View {
        Text("Filters")
            .font(.title2)
            .bold()
            .foregroundColor(Color("Rausch"))
    }
}

struct CommonNameField: View {
    @Binding var commonName: String
    @Environment(\.colorScheme) var colorScheme
    var body: some View {
        TextField("Common Name", text: $commonName)
            .disableAutocorrection(true)
            .autocapitalization(.none)
            .padding()
            .background(colorScheme == .dark ? Constants.Colors.darkGrayColor : Constants.Colors.lightGrayColor)
            .cornerRadius(5.0)
            .padding(.bottom, 5)
    }
}

struct ScientificNameField: View {
    @Binding var scientificName: String
    @Environment(\.colorScheme) var colorScheme
    var body: some View {
        TextField("Scienfitic Name", text: $scientificName)
            .disableAutocorrection(true)
            .autocapitalization(.none)
            .padding()
            .background(colorScheme == .dark ? Constants.Colors.darkGrayColor : Constants.Colors.lightGrayColor)
            .cornerRadius(5.0)
            .padding(.bottom, 5)
    }
}

struct EdibleField: View {
    @Binding var edible: Bool
    var body: some View {
        Toggle(isOn: $edible, label: {
            Text("Edible")
        })
    }
}

struct VegetableField: View {
    @Binding var vegetable: Bool
    var body: some View {
        Toggle(isOn: $vegetable, label: {
            Text("Vegetable")
        })
    }
}

struct PetalsField: View {
    @Binding var petalCount: Int
    var body: some View {
        Stepper(onIncrement: {
            if self.petalCount < 10 { // 10 petals is a lot, but oh well
                self.petalCount += 1
            }
        }, onDecrement: {
            if self.petalCount > 0 {
                self.petalCount -= 1
            }
        }, label: {
            Text("Petals (\(self.petalCount))")
        })
    }
}

struct GrowthMonthsField: View {
    @Binding var growthMonths: Int
    var body: some View {
        Stepper(onIncrement: {
            if self.growthMonths < 10 { // 10 petals is a lot, but oh well
                self.growthMonths += 1
            }
        }, onDecrement: {
            if self.growthMonths > 0 {
                self.growthMonths -= 1
            }
        }, label: {
            Text("Growth Months (\(self.growthMonths))")
        })
    }
}

struct BloomMonthsField: View {
    @Binding var bloomMonths: Int
    var body: some View {
        Stepper(onIncrement: {
            if self.bloomMonths < 10 { // 10 petals is a lot, but oh well
                self.bloomMonths += 1
            }
        }, onDecrement: {
            if self.bloomMonths > 0 {
                self.bloomMonths -= 1
            }
        }, label: {
            Text("Bloom Months (\(self.bloomMonths))")
        })
    }
}

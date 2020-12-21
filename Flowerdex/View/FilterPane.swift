//
//  FilterPane.swift
//  Flowerdex
//
//  Created by Víctor A. Hernández on 12/1/20.
//

import SwiftUI

// bloom_months: Int
// common_name: String
// days_to_harvest: Int
// edible: Bool
// duration????????
// flower_color???????
// scientific_name: String
// vegetable: Bool
// growth_months: Int
// leaf_retention???????

//    Slider(value: $progress, in: 1...6, step: 1, minimumValueLabel: Text("Minimum"), maximumValueLabel: Text("Maximum"), label: {
//        Text("Hello")
//    })

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
            CommonNameField(commonName: $commonName)
            EdibleField(edible: $edible)
            VegetableField(vegetable: $vegetable)
            PetalsField(petalCount: $petalCount)
            GrowthMonthsField(growthMonths: $growthMonths)
            BloomMonthsField(bloomMonths: $bloomMonths)
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
    var body: some View {
        TextField("Common Name", text: $commonName)
            .disableAutocorrection(true)
            .autocapitalization(.none)
            .padding()
            .background(Color.black)
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

struct ScientificNameField: View {
    @Binding var scientificName: String
    var body: some View {
        TextField("Scienfitic Name", text: $scientificName)
    }
}

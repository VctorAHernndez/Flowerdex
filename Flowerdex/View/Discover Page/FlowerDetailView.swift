//
//  FlowerDetailView.swift
//  Flowerdex
//
//  Created by Víctor A. Hernández on 10/25/20.
//

import SwiftUI

struct FlowerDetailView: View {
    
    var flower: Flower
    @State var hasBeenFoundLocal: Bool
    @ObservedObject var imageManager = ImageManager()
    @EnvironmentObject var fModel: FlowerService
    var size: CGFloat = 300
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            HStack {
                Text(self.flower.commonName.capitalized)
                    .font(.title)
                    .fontWeight(/*@START_MENU_TOKEN@*/.semibold/*@END_MENU_TOKEN@*/)
                    .foregroundColor(Constants.Colors.blueGray)
                //                .frame(width: .infinity, alignment: .center)
                Spacer()
                Button(action: {
                    
                    // Depending on past value
                    if self.hasBeenFoundLocal {
                        fModel.removeFound(self.flower.id)
                    } else {
                        fModel.putFound(self.flower.id)
                    }
                    
                    // Change value after request
                    self.hasBeenFoundLocal.toggle()
                    
                }) {
                    if self.hasBeenFoundLocal {
                        Image(systemName: "eye")
                            .font(.title)
                            .foregroundColor(Constants.Colors.rausch)
                    } else {
                        Image(systemName: "eye.slash")
                            .font(.title)
                            .foregroundColor(Constants.Colors.blueGray)
                    }
                    
                }
            }
            
            .padding()
            

            
//            URLImage(url: self.flower.imageURL)
//            Image("amapola")
            // TODO: make placeholder and actual image look equally good
            Image(uiImage: self.imageManager.image!)
                .resizable()
                .frame(width: self.size, height: self.size)
            FlowerInformationPane(flower: flower)
            Spacer()
        }
        .onAppear {
            self.imageManager.fetchImage(self.flower.imageURL)
        }
    }
}

// TODO: account for text overflow
struct FlowerInformationPane: View {
    var flower: Flower
    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: nil) {
                Text("Scientific Name:")
                    .bold()
                Text("\(self.flower.scientificName)")
                    .foregroundColor(Constants.Colors.blueGray)
                    .padding(.bottom)
                Text("Year Discovered:")
                    .bold()
                Text("\(self.flower.year ?? -999)")
                    .foregroundColor(Constants.Colors.blueGray)
            }
            .foregroundColor(Constants.Colors.rausch)
            .padding()
            VStack(alignment: .leading, spacing: nil) {
                Text("Bibliography:")
                    .bold()
                Text("\(self.flower.bibliography ?? "n/a")")
                    .foregroundColor(Constants.Colors.blueGray)
                    .padding(.bottom)
                Text("Author:")
                    .bold()
                Text("\(self.flower.author ?? "n/a")")
                    .foregroundColor(Constants.Colors.blueGray)
            }
            .foregroundColor(Constants.Colors.rausch)
            .padding()
        }
        .padding(.vertical)
    }
}

struct FlowerDetailView_Previews: PreviewProvider {
    static var previews: some View {
        FlowerDetailView(flower: dummyFlowers[0], hasBeenFoundLocal: true)
    }
}

//
//  FowerCardView.swift
//  Flowerdex
//
//  Created by Víctor A. Hernández on 10/25/20.
//

import SwiftUI

struct FlowerCard: View {
    
    var flower: FlowerModel
    @ObservedObject var imageManager = ImageManager()
    @State var isFavorite: Bool = true
    var size: CGFloat = 150
    
    var body: some View {
        HStack {
            HStack(alignment: .top, spacing: 0) {
                Image(uiImage: self.imageManager.image!)
                    .resizable()
//                    .scaledToFit()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: self.size, height: self.size)
                    .background(Color.white)
                CardDescription(commonName: self.flower.commonName, genus: self.flower.genus, family: self.flower.family, size: self.size, isFavorite: self.$isFavorite)
            }
            
        }
        .cornerRadius(15)
        .shadow(radius: 5)
        .padding(.horizontal, 20)
        .padding(.vertical, 5)
        .onAppear {
            self.imageManager.fetchImage(self.flower.imageURL)
        }
    }
}

struct CardDescription: View {
    
    var commonName: String
    var genus: String
    var family: String
    var size: CGFloat
    @Binding var isFavorite: Bool
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(self.commonName.capitalized)
                .font(.headline)
            Spacer()
            HStack {
                Text(self.genus + " > " + self.family)
                    .font(.caption)
                Spacer()
                Button(action: {self.isFavorite.toggle()}) {
                    if self.isFavorite {
                        Image(systemName: "star.fill")
                            .foregroundColor(.yellow)
                    } else {
                        Image(systemName: "star")
                            .foregroundColor(.black)
                    }
                    
                }
            }
        }
        .padding(.vertical, 20)
        .padding(.horizontal, 15)
        .frame(maxWidth: .infinity, maxHeight: self.size, alignment: .topLeading)
        .background(Color.white)
    }
}

struct FowerCardView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            FlowerCard(flower: dummyFlowers[0])
            FlowerCard(flower: dummyFlowers[1])
        }
        .previewLayout(.sizeThatFits)
    }
}

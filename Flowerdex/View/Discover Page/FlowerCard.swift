//
//  FowerCard.swift
//  Flowerdex
//
//  Created by Víctor A. Hernández on 10/25/20.
//

import SwiftUI

struct FlowerCard: View {
    
    var flower: Flower
    @ObservedObject var imageManager = ImageManager()
    var size: CGFloat = 150
    @Environment(\.colorScheme) var colorScheme
    
    var body: some View {
        HStack {
            HStack(alignment: .top, spacing: 0) {
                // TODO: make placeholder and actual image look equally good
                Image(uiImage: self.imageManager.image!)
                    .resizable()
//                    .scaledToFit()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: self.size, height: self.size)
                    .background(colorScheme == .dark ? Constants.Colors.darkGrayColor : Color.white)
                CardDescription(flower: flower, size: size, isFavoriteLocal: flower.isFavorite)
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
    
    var flower: Flower
    var size: CGFloat
    @State var isFavoriteLocal: Bool
    @EnvironmentObject var fModel: FlowerService
    @Environment(\.colorScheme) var colorScheme
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(self.flower.commonName.capitalized)
                .font(.headline)
            Spacer()
            HStack {
                Text(self.flower.genus + " > " + self.flower.family)
                    .font(.caption)
                Spacer()
                Button(action: {
                    
                    // Depending on past value
                    if self.isFavoriteLocal {
                        fModel.removeFavorite(self.flower.id)
                    } else {
                        fModel.putFavorite(self.flower.id)
                    }
                    
                    // Change value after request
                    self.isFavoriteLocal.toggle()
                    
                }) {
                    if self.isFavoriteLocal {
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
        .background(colorScheme == .dark ? Constants.Colors.darkGrayColor : Color.white)
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

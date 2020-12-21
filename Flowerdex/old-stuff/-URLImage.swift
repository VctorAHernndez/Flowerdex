//
//  URLImage.swift
//  Flowerdex
//
//  Created by Víctor A. Hernández on 10/26/20.
//

import SwiftUI

struct URLImage: View {
    
    @ObservedObject private var imageLoader = ImageLoader()
//    var image: Image
    private var placeholder: Image
    
    init(url: String) {
//        self.image = self.placeholder
        self.placeholder = Image(systemName: "photo")
//        self.fetchImage(urlString: url)
        self.imageLoader.load(url: url)
    }
    
//    mutating func fetchImage(urlString: String) {
//        if let url = URL(string: urlString) {
//            DispatchQueue.global().async {
//                if let data = try? Data(contentsOf: url) {
//                    guard let img = UIImage(data: data) else {
//                        return
//                    }
//                    DispatchQueue.main.async {
//                        self.image = Image(uiImage: img)
//                    }
//                }
//            }
//        }
//    }
    
    var body: some View {
        if let uiImage = self.imageLoader.downloadedImage {
            return Image(uiImage: uiImage).resizable().aspectRatio(contentMode: .fit)
        } else {
            return self.placeholder.resizable().aspectRatio(contentMode: .fit)
        }
    }
}



struct URLImage_Previews: PreviewProvider {
    static var previews: some View {
        URLImage(url: "https://c.files.bbci.co.uk/12A9B/production/_111434467_gettyimages-1143489763.jpg")
            .frame(width: 400, height: 900)
    }
}

extension UIImageView {
    func load(url: URL) {
        DispatchQueue.global().async { [weak self] in
            if let data = try? Data(contentsOf: url) {
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self?.image = image
                    }
                }
            }
        }
    }
}

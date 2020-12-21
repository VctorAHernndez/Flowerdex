//
//  Constants.swift
//  Flowerdex
//
//  Created by Víctor A. Hernández on 12/20/20.
//

import Foundation
import SwiftUI

struct Constants {
    struct UserDefaults {
        static let currentUser = "currentUser"
        static let isFirstTimeUser = "isFirstTimeUser"
    }
    
    struct Services {
        static let apiScheme = "https"
        static let apiHost = "ada.uprrp.edu"
        static let apiGetFlowersPath = "/~victor.hernandez17/flowerdex/listFlowers.php"
        static let apiLoginPath = "/~victor.hernandez17/flowerdex/login.php"
        static let apiRegistrationPath = "/~victor.hernandez17/flowerdex/signup.php"
        static let apiPutFavoritePath = "/~victor.hernandez17/flowerdex/putFavoriteFlower.php"
        static let apiRemoveFavoritePath = "/~victor.hernandez17/flowerdex/removeFavoriteFlower.php"
        static let apiPutFoundPath = "/~victor.hernandez17/flowerdex/putFoundFlower.php"
        static let apiRemoveFoundPath = "/~victor.hernandez17/flowerdex/removeFoundFlower.php"
    }
    
    struct Colors {
        static let lightGrayColor = Color(red: 239.0/255.0, green: 243.0/255.0, blue: 244.0/255.0, opacity: 1.0)
        static let darkGrayColor = Color(red: 41.0/255.0, green: 42.0/255.0, blue: 47.0/255.0, opacity: 1.0)
        static let blueGray = Color("Blue Gray")
        static let rausch = Color("Rausch")
    }
}

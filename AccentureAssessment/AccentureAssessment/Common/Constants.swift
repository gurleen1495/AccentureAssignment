//
//  Constants.swift
//  AccentureAssessment
//
//  Created by Gurleen kaur on 15/5/25.
//

import Foundation
class Constants: NSObject {
    
    static let shared = Constants()
    
    struct ServiceUrl{
       static let kBaseURL = "https://jsonplaceholder.typicode.com/posts"
    }
    
    struct Strings{
        static let kIsLoggedIn = "isLoggedIn"
        static let kSpaceString = " "
        static let kEmptyString = ""
        static let kEnterEmail = "Please enter your emailID"
        static let kEnterValidEmail = "Please enter a valid emailID"
        static let kEnterPassword = "Please enter Password"
        static let kEnterPasswordNotMoreThan15 = "Password should be of less than 15 characters"
        static let kEnterPasswordNotLessThan8 = "Password should be of at least 8 characters"
        static let kEmailRegX = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        static let kEmailFormat = "SELF MATCHES %@"
    }
    
    struct Storyboard{
        static let kMainStoryboard = "Main"
    }
    
    struct Identifier {
        static let kLoginViewController = "LoginViewController"
        static let kFavouritesCell = "FavouritesCell"
        static let kMainTabBarController = "MainTabBarController"
        static let kPostCell =  "PostsCell"
    }
    
    struct Alerts {
        static let kLogout = "Logout"
        static let kCancel = "Cancel"
        static let kLogoutMessage = "Are you sure you want to logout?"
        static let kAddPostToFavMessage = "This will mark post in favourites"
        static let kAddPostToFavTitle = "Add to favourites"
        static let kOK = "OK"
        
    }
    
    struct Assets {
      static let kExclamationCircle = "exclamationmark.circle.fill"
      static let kStar = "star"
    }
}

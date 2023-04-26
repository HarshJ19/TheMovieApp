//
//  AppManager.swift
//  TheMovieApp
//
//  Created by Harsh on 26/04/23.
//

import UIKit

class AppManager: NSObject {

    static let sharedInstance = AppManager()

    static func showAlert(strMsg : String, viewController : UIViewController) {
        let alert = UIAlertController(title: AppManager.getAppName(), message: strMsg, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in
            switch action.style{
                case .default:
                print("default")
                
                case .cancel:
                print("cancel")
                
                case .destructive:
                print("destructive")
                
            @unknown default:
                print("Default")
            }
        }))
        viewController.present(alert, animated: true, completion: nil)
    }
    
    static func getAppName() -> String{
        return "TheMovieApp"
    }
    
    enum alertMessages: String {
        case NetworkUnreachable = "Your internet connection seems to be down"
        case NoReviews = "No Reviews"
    }
    
}

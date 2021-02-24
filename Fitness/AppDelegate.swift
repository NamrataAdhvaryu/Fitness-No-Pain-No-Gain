//
//  AppDelegate.swift
//  Fitness
//
//  Created by Namrata Akash on 26/08/20.
//  Copyright © 2020 namrata. All rights reserved.
//

import UIKit
import GoogleSignIn

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate,GIDSignInDelegate {



    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        GoogleSignInIntegration()
        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        
    }
    func GoogleSignInIntegration()
    {
        // Initialize sign-in (Google)
        GIDSignIn.sharedInstance().clientID = Constant().GOOGLE_CLIENT_ID;
        GIDSignIn.sharedInstance().delegate = self;
    }
    
    func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any]) -> Bool
    {
      return GIDSignIn.sharedInstance().handle(url)
    }
    
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!,
              withError error: Error!)
    {
        if let error = error
        {
            if (error as NSError).code == GIDSignInErrorCode.hasNoAuthInKeychain.rawValue
            {
                    print("The user has not signed in before or they have since signed out.")
            }
            else
            {
                print("\(error.localizedDescription)")
            }
            return
        }
           
          let userId = user.userID                  // For client-side use only!
          let idToken = user.authentication.idToken // Safe to send to the server
          let fullName = user.profile.name
          let givenName = user.profile.givenName
          let familyName = user.profile.familyName
          let email = user.profile.email
          // ...

        print("userId:\(userId!)");
        print("fullName:\(fullName!)");
        print("givenName:\(givenName!)");
        print("familyName:\(familyName!)");
        print("email:\(email!)");
        print("idToken:\(idToken!)");
    }
    func sign(_ signIn: GIDSignIn!, didDisconnectWith user: GIDGoogleUser!,
              withError error: Error!)
    {
      // Perform any operations when the user disconnects from app here.
      // ...
    }

}


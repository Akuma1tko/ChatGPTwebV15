import UIKit
import SwiftUI

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?

    func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    ) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)

        let sessionCookie = UserDefaults.standard.string(forKey: "sessionCookie")

        if sessionCookie == nil || sessionCookie?.isEmpty == true {
            window?.rootViewController = UIHostingController(rootView: CookieEntryView())
        } else {
            window?.rootViewController = ViewController()
        }

        window?.makeKeyAndVisible()
        return true
    }
}


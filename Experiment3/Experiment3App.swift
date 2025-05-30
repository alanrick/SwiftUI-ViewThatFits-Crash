import SwiftUI
#if TRANSLATION_ENABLED
import TranslationKit // Import the new package

// Custom UIWindow to detect shake gesture - only needed for translation mode
class ShakeDetectingWindow: UIWindow {
    override func motionEnded(_ motion: UIEvent.EventSubtype, with event: UIEvent?) {
        if motion == .motionShake {
            NotificationCenter.default.post(name: UIDevice.deviceDidShakeNotification, object: nil)
        }
        super.motionEnded(motion, with: event)
    }
}
#endif

@main
struct Experiment3App: App {
    #if TRANSLATION_ENABLED
    @StateObject private var translationManager = TranslationManager()
    #endif

    var body: some Scene {
        WindowGroup {
            #if TRANSLATION_ENABLED
            ContentView()
                .environmentObject(translationManager)
            #else
            ContentView() // Standard view without translation environment
            #endif
        }
        // Note: Activating ShakeDetectingWindow via AppDelegate/SceneDelegate would also need
        // to be wrapped in #if TRANSLATION_ENABLED
    }
}

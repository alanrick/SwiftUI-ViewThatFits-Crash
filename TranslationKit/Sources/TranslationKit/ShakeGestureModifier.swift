import SwiftUI

/// A notification name posted when a device shake is detected.
/// Your application (e.g., via a custom `UIWindow` in `AppDelegate` or `SceneDelegate`)
/// should post this notification upon detecting a shake.
public extension UIDevice {
    static let deviceDidShakeNotification = Notification.Name(rawValue: "deviceDidShakeNotification")
}

// Note: The actual shake detection (e.g., by overriding motionEnded in UIWindow)
// needs to be implemented in the main application, as a package cannot reliably
// override the application's window behavior. This part of the package provides
// the reactive components to the shake.

/// A view modifier that listens for `UIDevice.deviceDidShakeNotification` and triggers
/// the `toggleTranslationMode()` method on the `TranslationManager` from the environment.
///
/// Apply this modifier to a root view in your application.
///
/// ```swift
/// // In your ContentView:
/// YourRootView()
///     .onShakeToggleTranslation() // If using the convenience extension
///     .environmentObject(yourTranslationManagerInstance)
/// ```
///
/// Ensure your app posts `UIDevice.deviceDidShakeNotification` for this to work.
public struct DeviceShakeViewModifier: ViewModifier {
    @EnvironmentObject var translationManager: TranslationManager

    public func body(content: Content) -> some View {
        content
            .onReceive(NotificationCenter.default.publisher(for: UIDevice.deviceDidShakeNotification)) { _ in
                translationManager.toggleTranslationMode()
            }
    }
}

public extension View {
    /// Applies the `DeviceShakeViewModifier` to toggle translation mode on shake.
    /// A `TranslationManager` must be in the environment.
    ///
    /// Your app must post `UIDevice.deviceDidShakeNotification` for the shake to be detected.
    func onShakeToggleTranslation() -> some View {
        self.modifier(DeviceShakeViewModifier())
    }
}

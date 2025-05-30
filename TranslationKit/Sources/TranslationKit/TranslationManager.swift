import SwiftUI
import Combine

/// Manages the translation mode and stores translation data for the application.
///
/// Inject an instance of this class into your SwiftUI environment to make it accessible
/// to `TranslatableText` views and your app's shake gesture handling.
///
/// ```swift
/// // In your App struct:
/// @StateObject private var translationManager = TranslationManager()
///
/// var body: some Scene {
///     WindowGroup {
///         ContentView()
///             .environmentObject(translationManager)
///     }
/// }
/// ```
@MainActor
public class TranslationManager: ObservableObject {
    /// Indicates whether the translation mode is currently active.
    /// When `true`, `TranslatableText` views will display `TextFields` for editing.
    @Published public var isTranslationModeActive: Bool = false

    /// Stores the current set of translations. The key is a unique identifier for the text,
    /// and the value is the user-edited or original string.
    @Published public var translations: [String: String] = [:]

    /// Holds the JSON string of the last exported translation data.
    /// This is populated when translation mode is exited and changes have been made.
    /// Your app can observe this property to trigger actions like presenting a share sheet.
    @Published public var lastExportedJSON: String? = nil

    // Stores the original texts provided to TranslatableText views.
    private var originalTexts: [String: String] = [:]

    public init() {}

    /// Registers a text element with the translation system.
    /// Called by `TranslatableText` on appear.
    /// - Parameters:
    ///   - id: A unique identifier for this text element.
    ///   - originalText: The original, untranslated string.
    public func registerText(id: String, originalText: String) {
        if originalTexts[id] == nil {
            originalTexts[id] = originalText
        }
        if translations[id] == nil {
            translations[id] = originalText
        }
    }

    /// Retrieves the current text for a given ID (edited version if available, otherwise original).
    /// - Parameter id: The unique identifier for the text element.
    /// - Returns: The string to be displayed.
    public func getText(id: String) -> String {
        return translations[id] ?? originalTexts[id] ?? ""
    }

    /// Updates the translation for a given ID.
    /// Called by `TranslatableText` when its `TextField` value changes.
    /// - Parameters:
    ///   - id: The unique identifier for the text element.
    ///   - newText: The new, edited string.
    public func updateTranslation(id: String, newText: String) {
        translations[id] = newText
    }

    /// Toggles the translation mode on or off.
    /// When turning off, it also triggers the preparation of export data.
    public func toggleTranslationMode() {
        isTranslationModeActive.toggle()
        if !isTranslationModeActive {
            print("Exiting translation mode. Preparing export...")
            prepareAndStoreExportData()
        }
    }

    /// Prepares the translation data (only changed items) as a JSON string and stores it in `lastExportedJSON`.
    /// This method is typically called automatically when translation mode is exited.
    public func prepareAndStoreExportData() {
        let changedTranslations = translations.filter { (key, value) in
            originalTexts[key] != value && originalTexts[key] != nil
        }

        let exportableItems = changedTranslations.map { (key, newText) in
            return [
                "id": key,
                "original": originalTexts[key] ?? "Original text not found",
                "translated": newText
            ]
        }

        if exportableItems.isEmpty {
            print("No changes to export.")
            self.lastExportedJSON = nil
            return
        }

        do {
            let jsonData = try JSONEncoder().encode(exportableItems)
            if let jsonString = String(data: jsonData, encoding: .utf8) {
                self.lastExportedJSON = jsonString
                print("Export data prepared (JSON): \(jsonString)")
            } else {
                self.lastExportedJSON = nil
                print("Error: Could not convert JSON data to string.")
            }
        } catch {
            self.lastExportedJSON = nil
            print("Error encoding translations to JSON: \(error)")
        }
    }

    /// Manually triggers export preparation and returns the JSON string.
    /// Useful if you want to provide a manual export button in your UI.
    /// - Returns: The JSON string of the exported data, or `nil` if no data or error.
    public func getExportJSON() -> String? {
        prepareAndStoreExportData()
        return lastExportedJSON
    }
}

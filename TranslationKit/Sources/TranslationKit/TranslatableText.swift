import SwiftUI

/// A view that displays text and allows it to be edited when translation mode is active.
///
/// Use this view for any text in your app that you want to make translatable
/// using the shake-to-translate feature.
///
/// It requires a `TranslationManager` instance to be available in the environment.
///
/// ```swift
/// // Example usage:
/// TranslatableText("Hello, World!", id: "greeting_message")
/// ```
public struct TranslatableText: View {
    @EnvironmentObject var translationManager: TranslationManager

    let id: String
    let originalText: String

    @State private var editedText: String = ""

    /// Initializes a new translatable text view.
    /// - Parameters:
    ///   - originalText: The default text to display and the base for translation.
    ///   - id: A unique identifier for this piece of text. This ID is used to store
    ///         and retrieve translations. Choose a consistent and descriptive ID.
    public init(_ originalText: String, id: String) {
        self.originalText = originalText
        self.id = id
    }

    public var body: some View {
        Group {
            if translationManager.isTranslationModeActive {
                TextField(originalText, text: $editedText, axis: .vertical)
                    .onChange(of: editedText) { newValue in
                        translationManager.updateTranslation(id: id, newText: newValue)
                    }
                    .onAppear {
                        // Ensure editedText is initialized with the current value from manager
                        editedText = translationManager.getText(id: id)
                    }
                    .border(Color.red) // Visual cue for translation mode
            } else {
                Text(translationManager.getText(id: id))
            }
        }
        .onAppear {
            // Register text with the manager and initialize local state
            translationManager.registerText(id: id, originalText: originalText)
            // Initialize editedText based on what manager currently holds (could be original or previously edited)
            editedText = translationManager.getText(id: id)
        }
    }
}

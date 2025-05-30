import SwiftUI
#if TRANSLATION_ENABLED
import TranslationKit // Import the new package
#endif

struct ContentView: View {
    @State var resultVM = OutcomeVM()
    #if TRANSLATION_ENABLED
    @EnvironmentObject var translationManager: TranslationManager
    @State private var showShareSheet = false // To trigger the ShareSheet
    @State private var shareableJson: String? = nil // To hold the JSON for the ShareSheet
    #endif

    var body: some View {
        VStack {
            #if TRANSLATION_ENABLED
            TranslatableText("hello world", id: "contentView.greeting")
                .padding()
            #else
            Text("hello world") // Standard text if not in translation mode
                .padding()
            #endif
            
            ResultPointsView()
                .environment(resultVM)
        }
        #if TRANSLATION_ENABLED
        .onShakeToggleTranslation() // Use the new specific modifier name
        // The print statement can be removed if the modifier directly handles logging or if not needed.
        // For now, keeping it separate to show where app-specific reaction could also go,
        // but the primary action is in the modifier itself.
        // If additional actions are needed on shake in ContentView, one could keep the .onReceive here too,
        // or the onShakeToggleTranslation could accept an optional completion handler.
        // For simplicity, the modifier now directly calls the manager.
        .onChange(of: translationManager.lastExportedJSON) { oldJson, newJson in // Corrected to include oldJson for SwiftUI 3+
            // When new JSON is available and we are NOT in translation mode (meaning export just finished)
            if let json = newJson, !translationManager.isTranslationModeActive {
                self.shareableJson = json
                self.showShareSheet = true // Trigger the share sheet
                print("Share sheet will be presented with JSON: \(json)")
            }
        }
        .sheet(isPresented: $showShareSheet) {
            // Ensure shareableJson is not nil, provide a default or handle error if it is.
            ShareSheetView(activityItems: [shareableJson ?? "No translation data to share."])
                .onDisappear {
                    // Clear the exported JSON data after the share sheet is dismissed
                    // to prevent it from showing again automatically on next view update cycle
                    // if no new changes are made.
                    if translationManager.isTranslationModeActive == false { // Ensure we are not in translation mode
                        translationManager.lastExportedJSON = nil
                        shareableJson = nil
                        print("Share sheet dismissed, exported JSON cleared.")
                    }
                }
        }
        #endif
    }
}

#Preview {
    #if TRANSLATION_ENABLED
    ContentView()
        .environmentObject(TranslationManager()) // Add for preview
    #else
    ContentView()
    #endif
}

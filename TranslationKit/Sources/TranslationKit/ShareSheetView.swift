import SwiftUI
import UIKit

/// A SwiftUI view that wraps `UIActivityViewController` to present a system share sheet.
///
/// Use this view to allow users to share content, such as exported translation data.
///
/// ```swift
/// // Example usage within a .sheet modifier:
/// .sheet(isPresented: $isShowingShareSheet) {
///     ShareSheetView(activityItems: ["Here is my data to share."])
/// }
/// ```
public struct ShareSheetView: UIViewControllerRepresentable {
    /// The items to share. These can be strings, URLs, images, etc.
    public var activityItems: [Any]

    /// Custom `UIActivity` instances to include in the share sheet.
    public var applicationActivities: [UIActivity]? = nil

    /// Activity types to exclude from the share sheet.
    /// For example, `[.postToFacebook, .assignToContact]`
    public var excludedActivityTypes: [UIActivity.ActivityType]? = nil

    public func makeUIViewController(context: Context) -> UIActivityViewController {
        let controller = UIActivityViewController(
            activityItems: activityItems,
            applicationActivities: applicationActivities
        )
        controller.excludedActivityTypes = excludedActivityTypes
        return controller
    }

    public func updateUIViewController(_ uiViewController: UIActivityViewController, context: Context) {
        // No specific updates needed here as UIActivityViewController is typically configured on creation.
    }
}

#if DEBUG
struct ShareSheetView_Previews: PreviewProvider {
    static var previews: some View {
        ShareSheetView(activityItems: ["Previewing shareable content."])
    }
}
#endif

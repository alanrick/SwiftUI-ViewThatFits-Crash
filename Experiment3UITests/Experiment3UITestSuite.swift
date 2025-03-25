//
//  Experiment3UITest.swift
//  Experiment3UITests
//
//  Created by AlanRick on 25.03.25.
//


import XCTest

final class Experiment3UITestsSuite: XCTestCase {
    
    var app: XCUIApplication!
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        continueAfterFailure = false
        
        // Initialize the app
        app = XCUIApplication()
        app.launch()
    }
    
    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        app = nil
    }
    
    func testPointSelectionButtons() throws {
        
        // Assuming we have buttons with numbers 1-4
        for pointNumber in 1...4 {
            // Find the button using the label text
            let pointButton = app.buttons["\(pointNumber)"]
            
            // Verify button exists
            XCTAssertTrue(pointButton.exists, "Point button \(pointNumber) should exist")
            
            // Tap the button
            pointButton.tap()
            
            // Allow time for animation to complete
            sleep(1)
            
            // Verify that tapping changes the selection state
            // Note: In a real test we would need to have a way to verify the selection state
            // This could be through accessibility identifiers or other properties
        }
    }
    
    func testPointSelectionPersistence() throws {
        // Select a specific point
        let pointButton = app.buttons["3"]
        XCTAssertTrue(pointButton.exists, "Point button 3 should exist")
        
        // Tap the button to select it
        pointButton.tap()
        
        // We could add additional validation here based on UI changes when selected
        
        // Restart the app to verify persistence if that's a requirement
        app.terminate()
        app.launch()
        
        // Verify the selection is maintained after restart
        // Would need app-specific logic to verify persistence
    }
    
    func testUILayout() throws {
        // Capture a screenshot for visual verification
        let screenshot = app.screenshot()
        
        // Layout tests would depend on specific requirements
        // For example, verify the buttons are arranged horizontally
        
        // Use XCUIElement frame properties to verify layout
        if app.buttons["1"].exists && app.buttons["2"].exists {
            let button1 = app.buttons["1"]
            let button2 = app.buttons["2"]
            
            // Verify horizontal arrangement (button2 should be to the right of button1)
            XCTAssertGreaterThan(button2.frame.minX, button1.frame.maxX,
                                "Button 2 should be to the right of Button 1")
        }
    }
    
    // Additional helper methods can be added here
    
    /// Helper method to simulate rotating the device
    func rotateDevice(to orientation: UIDeviceOrientation) {
        XCUIDevice.shared.orientation = orientation
    }
    
    /// Test how the app handles rotation
    func testDeviceRotation() throws {
        // Capture the initial layout
        let initialFrame = app.buttons["1"].frame
        
        // Rotate to landscape
        rotateDevice(to: .landscapeLeft)
        
        // Allow time for rotation animation
        sleep(1)
        
        // Verify layout has changed appropriately
        let rotatedFrame = app.buttons["1"].frame
        
        // The exact assertions would depend on how your UI should respond to rotation
        XCTAssertNotEqual(initialFrame, rotatedFrame, "UI should adjust after rotation")
        
        // Rotate back to portrait
        rotateDevice(to: .portrait)
    }
}

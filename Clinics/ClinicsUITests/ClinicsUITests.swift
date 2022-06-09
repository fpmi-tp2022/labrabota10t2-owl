//
//  ClinicsUITests.swift
//  ClinicsUITests
//
//  Created by Mac on 6/6/22.
//

import XCTest

class ClinicsUITests: XCTestCase {

    var app:XCUIApplication!
    
    override func setUpWithError() throws {

        try super.setUpWithError()
        continueAfterFailure = false
        app = XCUIApplication()
        app.launch()
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        // UI tests must launch the application that they test.
        let app = XCUIApplication()
        app.launch()

        // Use recording to get started writing UI tests.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    
    func testSegmentedControl() {
        
        let app = XCUIApplication()
        app/*@START_MENU_TOKEN@*/.buttons["Register"]/*[[".segmentedControls.buttons[\"Register\"]",".buttons[\"Register\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        app/*@START_MENU_TOKEN@*/.buttons["Log in"]/*[[".segmentedControls.buttons[\"Log in\"]",".buttons[\"Log in\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        
        XCTAssertTrue(app.buttons["Enter account"].exists)
        
    }
    
    func testRegister() {
        
        let app = XCUIApplication()
        
        app.segmentedControls.buttons["Register"].tap()
        
        let loginTextField = app.textFields["Login"]
        loginTextField.tap()
        loginTextField.typeText("1")
        
        let eMailTextField = app.textFields["E-mail"]
        eMailTextField.tap()
        eMailTextField.typeText("2")
        
        let passwordSecureTextField = app.secureTextFields["Password"]
        passwordSecureTextField.tap()
        passwordSecureTextField.typeText("3")
        
        let repeatPasswordSecureTextField = app.secureTextFields["Repeat password"]
        repeatPasswordSecureTextField.tap()
        repeatPasswordSecureTextField.typeText("3")
        app/*@START_MENU_TOKEN@*/.staticTexts["Register"]/*[[".buttons.matching(identifier: \"Register\").staticTexts[\"Register\"]",".staticTexts[\"Register\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        
        XCTAssertTrue(app.buttons["Save"].exists)
                
    }
    
    func testHospitals() {
        
        let app = XCUIApplication()
        
        app.segmentedControls.buttons["Register"].tap()
        
        let loginTextField = app.textFields["Login"]
        loginTextField.tap()
        loginTextField.typeText("1")
        
        let eMailTextField = app.textFields["E-mail"]
        eMailTextField.tap()
        eMailTextField.typeText("2")
        
        let passwordSecureTextField = app.secureTextFields["Password"]
        passwordSecureTextField.tap()
        passwordSecureTextField.typeText("3")
        
        let repeatPasswordSecureTextField = app.secureTextFields["Repeat password"]
        repeatPasswordSecureTextField.tap()
        repeatPasswordSecureTextField.typeText("3")
        app/*@START_MENU_TOKEN@*/.staticTexts["Register"]/*[[".buttons.matching(identifier: \"Register\").staticTexts[\"Register\"]",".staticTexts[\"Register\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        
        app/*@START_MENU_TOKEN@*/.staticTexts["Save"]/*[[".buttons[\"Save\"].staticTexts[\"Save\"]",".staticTexts[\"Save\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        
        let collectionViewsQuery = app.collectionViews
        collectionViewsQuery/*@START_MENU_TOKEN@*/.staticTexts["Hospitals"]/*[[".cells.staticTexts[\"Hospitals\"]",".staticTexts[\"Hospitals\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        app.tables/*@START_MENU_TOKEN@*/.cells.containing(.staticText, identifier:"1st City Clinical Hospital").element/*[[".cells.containing(.staticText, identifier:\"64 Nezavisimosti Ave., Minsk\").element",".cells.containing(.staticText, identifier:\"1st City Clinical Hospital\").element"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        
        XCTAssertTrue(collectionViewsQuery/*@START_MENU_TOKEN@*/.staticTexts["Department of Osteoporosis"]/*[[".cells.staticTexts[\"Department of Osteoporosis\"]",".staticTexts[\"Department of Osteoporosis\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.exists)
    }
    
    func testOrderingTalon() {
        
        let app = XCUIApplication()
        
        app.segmentedControls.buttons["Register"].tap()
        
        let loginTextField = app.textFields["Login"]
        loginTextField.tap()
        loginTextField.typeText("1")
        
        let eMailTextField = app.textFields["E-mail"]
        eMailTextField.tap()
        eMailTextField.typeText("2")
        
        let passwordSecureTextField = app.secureTextFields["Password"]
        passwordSecureTextField.tap()
        passwordSecureTextField.typeText("3")
        
        let repeatPasswordSecureTextField = app.secureTextFields["Repeat password"]
        repeatPasswordSecureTextField.tap()
        repeatPasswordSecureTextField.typeText("3")
        app/*@START_MENU_TOKEN@*/.staticTexts["Register"]/*[[".buttons.matching(identifier: \"Register\").staticTexts[\"Register\"]",".staticTexts[\"Register\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        
        let chooseStaticText = app.children(matching: .window).element(boundBy: 0).children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .button).matching(identifier: "Choose").element(boundBy: 0).staticTexts["Choose"]
        chooseStaticText.tap()
        
        let tablesQuery = app.popovers.tables
        tablesQuery/*@START_MENU_TOKEN@*/.staticTexts["40th city clinical polyclinic"]/*[[".cells.staticTexts[\"40th city clinical polyclinic\"]",".staticTexts[\"40th city clinical polyclinic\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        app/*@START_MENU_TOKEN@*/.otherElements["PopoverDismissRegion"]/*[[".otherElements[\"dismiss popup\"]",".otherElements[\"PopoverDismissRegion\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        app/*@START_MENU_TOKEN@*/.staticTexts["Save"]/*[[".buttons[\"Save\"].staticTexts[\"Save\"]",".staticTexts[\"Save\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        
        let collectionViewsQuery = app.collectionViews
        collectionViewsQuery/*@START_MENU_TOKEN@*/.staticTexts["My clinic"]/*[[".cells.staticTexts[\"My clinic\"]",".staticTexts[\"My clinic\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        app/*@START_MENU_TOKEN@*/.staticTexts["Order talon"]/*[[".buttons[\"Order talon\"].staticTexts[\"Order talon\"]",".staticTexts[\"Order talon\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        
        let tablesQuery2 = app.tables
        tablesQuery2/*@START_MENU_TOKEN@*/.staticTexts["Therapist"]/*[[".cells.staticTexts[\"Therapist\"]",".staticTexts[\"Therapist\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        tablesQuery2/*@START_MENU_TOKEN@*/.staticTexts["Ivanova Yulia Vladimirovna"]/*[[".cells.staticTexts[\"Ivanova Yulia Vladimirovna\"]",".staticTexts[\"Ivanova Yulia Vladimirovna\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        
        let cellsQuery = tablesQuery2.cells.containing(.staticText, identifier:"08:00 25 June")
        cellsQuery/*@START_MENU_TOKEN@*/.staticTexts["Order"]/*[[".buttons[\"Order\"].staticTexts[\"Order\"]",".staticTexts[\"Order\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        app.navigationBars["Available talons"].buttons["Therapist"].tap()
        app.navigationBars["Therapist"].buttons["Ordering a talon"].tap()
        app.navigationBars["Ordering a talon"].buttons["My clinic"].tap()
        app.navigationBars["My clinic"].buttons["Personal account"].tap()
        collectionViewsQuery/*@START_MENU_TOKEN@*/.staticTexts["My talons"]/*[[".cells.staticTexts[\"My talons\"]",".staticTexts[\"My talons\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        
        XCTAssertTrue(app.tables.cells.containing(.staticText, identifier:"08:00 25 June").staticTexts["Ivanova Yulia Vladimirovna"].exists)
        cellsQuery/*@START_MENU_TOKEN@*/.staticTexts["Delete"]/*[[".buttons[\"Delete\"].staticTexts[\"Delete\"]",".staticTexts[\"Delete\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        
    }
}

/**
 *  LICENSE
 *
 *  This file is part of the GLPI API Client Library for Swift,
 *  a subproject of GLPI. GLPI is a free IT Asset Management.
 *
 *  Glpi is Licensed under the Apache License, Version 2.0 (the "License");
 *  you may not use this file except in compliance with the License.
 *  You may obtain a copy of the License at
 *
 *  http://www.apache.org/licenses/LICENSE-2.0
 *
 *  Unless required by applicable law or agreed to in writing, software
 *  distributed under the License is distributed on an "AS IS" BASIS,
 *  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 *  See the License for the specific language governing permissions and
 *  limitations under the License.
 *  -----------------------------------------------------------------------------------
 *  @author    Hector Rondon - <hrondon@teclib.com>
 *  @copyright Copyright Teclib. All rights reserved.
 *  @license   Apache License, Version 2.0 https://www.apache.org/licenses/LICENSE-2.0
 *  @link      https://github.com/glpi-project/swift-library-glpi
 *  @link      https://glpi-project.github.io/swift-library-glpi/
 *  @link      http://www.glpi-project.org/
 *  -----------------------------------------------------------------------------------
 */

import XCTest
@testable import Glpi

class GlpiTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
        GlpiConfig.URL = NSURL(string: "https://dev.flyve.org/glpi/apirest.php")!
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    /// Test initSession request
    func testInitSession() {

        let expectationResult = expectation(description: "initSession")

        let expectedUserToken = Constants.initSessionTesting["userToken"] ?? ""
        let expectedAppToken = Constants.initSessionTesting["appToken"] ?? ""
        GlpiConfig.APP_TOKEN = expectedAppToken
        
        GlpiRequest.initSessionByUserToken(userToken: expectedUserToken, completion: { _, response, _ in
            
            if let urlResponse: HTTPURLResponse = response {
                XCTAssertEqual(urlResponse.allHeaderFields["Content-Type"] as? String ?? "", "application/json; charset=UTF-8")
                XCTAssertEqual(urlResponse.statusCode, 200)
                expectationResult.fulfill()
            }
        })
        waitForExpectations(timeout: 10, handler: nil)
    }

    /// Test KillSession request
    func testKillSession() {

        let expectationResult = expectation(description: "killSession")

        GlpiRequest.killSession { _, response, _ in
            
            if let urlResponse: HTTPURLResponse = response {
                XCTAssertEqual(urlResponse.allHeaderFields["Content-Type"] as? String ?? "", "application/json; charset=UTF-8")
                expectationResult.fulfill()
            }
        }
        waitForExpectations(timeout: 10, handler: nil)
    }
    
    /// Test getMyProfiles request
    func testGetMyProfiles() {
        
        let expectationResult = expectation(description: "getMyProfiles")
        
        GlpiRequest.getMyProfiles { _, response, _ in
            
            if let urlResponse: HTTPURLResponse = response {
                XCTAssertEqual(urlResponse.allHeaderFields["Content-Type"] as? String ?? "", "application/json; charset=UTF-8")
                expectationResult.fulfill()
            }
        }
        waitForExpectations(timeout: 1000, handler: nil)
    }
    
    /// Test getActiveProfile request
    func testGetActiveProfile() {

        let expectationResult = expectation(description: "getActiveProfile")

        GlpiRequest.getActiveProfile { _, response, _ in
            
            if let urlResponse: HTTPURLResponse = response {
                XCTAssertEqual(urlResponse.allHeaderFields["Content-Type"] as? String ?? "", "application/json; charset=UTF-8")
                expectationResult.fulfill()
            }
        }
        waitForExpectations(timeout: 10, handler: nil)
    }

    /// Test changeActiveProfile request
    func testChangeActiveProfile() {

        let expectationResult = expectation(description: "changeActiveProfile")
        
        GlpiRequest.changeActiveProfile(profileID: "4") { _, response, _ in
            
            if let urlResponse: HTTPURLResponse = response {
                XCTAssertEqual(urlResponse.allHeaderFields["Content-Type"] as? String ?? "", "application/json; charset=UTF-8")
                expectationResult.fulfill()
            }
        }
        waitForExpectations(timeout: 10, handler: nil)
    }

    /// Test getMyEntities request
    func testGetMyEntities() {

        let expectationResult = expectation(description: "getMyEntities")
        
        GlpiRequest.getMyEntities { _, response, _ in
            
            if let urlResponse: HTTPURLResponse = response {
                XCTAssertEqual(urlResponse.allHeaderFields["Content-Type"] as? String ?? "", "application/json; charset=UTF-8")
                expectationResult.fulfill()
            }
        }
        waitForExpectations(timeout: 10, handler: nil)
    }

    /// Test getActiveEntities request
    func testGetActiveEntities() {

        let expectationResult = expectation(description: "getActiveEntities")
        
        GlpiRequest.getActiveEntities { _, response, _ in
            
            if let urlResponse: HTTPURLResponse = response {
                XCTAssertEqual(urlResponse.allHeaderFields["Content-Type"] as? String ?? "", "application/json; charset=UTF-8")
                expectationResult.fulfill()
            }
        }
        waitForExpectations(timeout: 10, handler: nil)
    }

    /// Test changeActiveEntities request
    func testChangeActiveEntities() {

        let expectationResult = expectation(description: "changeActiveEntities")
        
        GlpiRequest.changeActiveEntities(entitiesID: "0", isRecursive: false, completion: { _, response, _ in
            
            if let urlResponse: HTTPURLResponse = response {
                XCTAssertEqual(urlResponse.allHeaderFields["Content-Type"] as? String ?? "", "application/json; charset=UTF-8")
                expectationResult.fulfill()
            }
        })
        waitForExpectations(timeout: 10, handler: nil)
    }

    /// Test getFullSession request
    func testGetFullSession() {

        let expectationResult = expectation(description: "getFullSession")
        
        GlpiRequest.getFullSession { _, response, _ in
            
            if let urlResponse: HTTPURLResponse = response {
                XCTAssertEqual(urlResponse.allHeaderFields["Content-Type"] as? String ?? "", "application/json; charset=UTF-8")
                expectationResult.fulfill()
            }
        }
        waitForExpectations(timeout: 10, handler: nil)
    }

    /// Test getAllItems request
    func testGetAllItems() {

        let expectationResult = expectation(description: "getAllItems")
        
        GlpiRequest.getAllItems(itemType: ItemType.Computer, completion: { _, response, _ in
            
            if let urlResponse: HTTPURLResponse = response {
                XCTAssertEqual(urlResponse.allHeaderFields["Content-Type"] as? String ?? "", "application/json; charset=UTF-8")
                expectationResult.fulfill()
            }
        })
        waitForExpectations(timeout: 10, handler: nil)
    }

    /// Test getAnItems request
    func testGetAnItems() {

        let expectationResult = expectation(description: "getAnItems")

        GlpiRequest.getItem(itemType: ItemType.Computer, itemID: 119, completion: { _, response, _ in
            
            if let urlResponse: HTTPURLResponse = response {
                XCTAssertEqual(urlResponse.allHeaderFields["Content-Type"] as? String ?? "", "application/json; charset=UTF-8")
                expectationResult.fulfill()
            }
        })
        waitForExpectations(timeout: 10, handler: nil)
    }

    /// Test getsubItems
    func testGetSubItems() {

        let expectationResult = expectation(description: "getsubItems")
        
        GlpiRequest.getSubItems(itemType: ItemType.User, itemID: 24, subItemType: ItemType.UserEmail, completion: { _, response, _ in
            
            if let urlResponse: HTTPURLResponse = response {
                XCTAssertEqual(urlResponse.allHeaderFields["Content-Type"] as? String ?? "", "application/json; charset=UTF-8")
                expectationResult.fulfill()
            }
        })
        waitForExpectations(timeout: 10, handler: nil)
    }

    /// Test addItems
    func testAddItems() {

        let expectationResult = expectation(description: "addItems")

        var payload = [String: Any]()
        var payloadData = [String: String]()
        payloadData["name"] = "Hector Rondon"
        payload["input"] = payloadData
        
        GlpiRequest.addItems(itemType: ItemType.User, payload: payload, completion: { _, response, _ in
            
            if let urlResponse: HTTPURLResponse = response {
                XCTAssertEqual(urlResponse.allHeaderFields["Content-Type"] as? String ?? "", "application/json; charset=UTF-8")
                expectationResult.fulfill()
            }
        })
        waitForExpectations(timeout: 10, handler: nil)
    }

    /// Test updateItems
    func testUpdateItems() {

        let expectationResult = expectation(description: "updateItems")

        var payload = [String: Any]()
        var payloadData = [String: String]()
        payloadData["name"] = "Hector Rondon Update"
        payload["input"] = payloadData
        
        GlpiRequest.updateItems(itemType: ItemType.User, itemID: 24, payload: payload, completion: { _, response, _ in
            
            if let urlResponse: HTTPURLResponse = response {
                XCTAssertEqual(urlResponse.allHeaderFields["Content-Type"] as? String ?? "", "application/json; charset=UTF-8")
                expectationResult.fulfill()
            }
        })

        waitForExpectations(timeout: 10, handler: nil)
    }

    /// Test deleteItems
    func testDeleteItems() {

        let expectationResult = expectation(description: "deleteItems")

        var payload = [String: Any]()
        var payloadData = [String: Int]()
        payloadData["id"] = 24
        payload["input"] = payloadData
        
        GlpiRequest.deleteItems(itemType: ItemType.User, itemID: 24, payload: payload, completion: { _, response, _ in
            
            if let urlResponse: HTTPURLResponse = response {
                XCTAssertEqual(urlResponse.allHeaderFields["Content-Type"] as? String ?? "", "application/json; charset=UTF-8")
                expectationResult.fulfill()
            }
        })
        waitForExpectations(timeout: 10, handler: nil)
    }

    /// Test lostPassword
    func testLostPassword() {
        let expectationResult = expectation(description: "lostPassword")

        var dictionary = [String: AnyObject]()
        dictionary["email"] = "flyve@hi2.in" as AnyObject
        
        GlpiRequest.recoveryPassword(email: "flyve@hi2.in", completion: { _, response, _ in
            
            if let urlResponse: HTTPURLResponse = response {
                XCTAssertEqual(urlResponse.allHeaderFields["Content-Type"] as? String ?? "", "application/json; charset=UTF-8")
                expectationResult.fulfill()
            }
        })
        waitForExpectations(timeout: 10, handler: nil)
    }

    /// Test resetPassword
    func testResetPassword() {
        let expectationResult = expectation(description: "resetPassword")

        var payload = [String: Any]()
        payload["email"] = "flyve@hi2.in"
        payload["password_forget_token"] = "941891fcf47581084d43d2dec49b1c43a58380f4"
        payload["password"] = "12345678"
        
        GlpiRequest.resetPassword(payload: payload, completion: { _, response, _ in
            
            if let urlResponse: HTTPURLResponse = response {
                XCTAssertEqual(urlResponse.allHeaderFields["Content-Type"] as? String ?? "", "application/json; charset=UTF-8")
                expectationResult.fulfill()
            }
        })
        waitForExpectations(timeout: 10, handler: nil)
    }
    
    /// Test testListSearchOptions request
    func testListSearchOptions() {
        
        let expectationResult = expectation(description: "listSearchOptions")
        
        GlpiRequest.listSearchOptions(itemType: ItemType.Computer, completion: { _, response, _ in
            
            if let urlResponse: HTTPURLResponse = response {
                XCTAssertEqual(urlResponse.allHeaderFields["Content-Type"] as? String ?? "", "application/json; charset=UTF-8")
                expectationResult.fulfill()
            }
        })
        waitForExpectations(timeout: 10, handler: nil)
    }
    
    /// Test search request
    func testSearch() {
        
        let expectationResult = expectation(description: "listSearchOptions")
        
        GlpiRequest.searchItems(itemType: ItemType.Computer, completion: { _, response, _ in
            
            if let urlResponse: HTTPURLResponse = response {
                XCTAssertEqual(urlResponse.allHeaderFields["Content-Type"] as? String ?? "", "application/json; charset=UTF-8")
                expectationResult.fulfill()
            }
        })
        waitForExpectations(timeout: 10, handler: nil)
    }
}

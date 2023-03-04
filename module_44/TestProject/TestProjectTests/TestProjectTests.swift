//
//  TestProjectTests.swift
//  TestProjectTests
//
//  Created by SF on 01.06.2021.
//

import XCTest
@testable import TestProject

class TestProjectTests: XCTestCase {
    
    let mockUser = UserMock(firstName: "Andry", lastName: "Jigo", bio: "I love sf", city: "Moscow", friends: [], isClosed: true)
   
    let mockFriend = UserMock(firstName: "Sam", lastName: "Majow", bio: "I love sf", city: "St.Petersburg", friends: [], isClosed: false)
            
    let mockFirstName = "Alex"
    let mockLastName = "Brown"
    let mockBio = "I learn Swift"
    let mockCity = "Los Angeles"
    let mockFriends: [User] = []
    let mockIsClosed = false
           
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    func testChangeName() throws {
            mockUser.changeName(mockFirstName)
            XCTAssertTrue(mockUser.changeNameCalledCount > 0)
            XCTAssertTrue(mockUser.changeNameCalled)
            XCTAssertTrue(mockUser.firstName == mockFirstName)
        }
    
    func testChangeLastName() throws {
            mockUser.changeLastName(mockLastName)
            XCTAssertTrue(mockUser.changeLastNameCalledCount > 0)
            XCTAssertTrue(mockUser.changeLastNameCalled)
            XCTAssertTrue(mockUser.lastName == mockLastName)
        }
    
    func testChangeBio() throws {
            mockUser.changeBio(mockBio)
            XCTAssertTrue(mockUser.changeBioCalledCount > 0)
            XCTAssertTrue(mockUser.changeBioCalled)
            XCTAssertTrue(mockUser.bio == mockBio)
        }
    
    func testChangeCity() throws {
            mockUser.changeCity(mockCity)
            XCTAssertTrue(mockUser.changeCityCalledCount > 0)
            XCTAssertTrue(mockUser.changeCityCalled)
            XCTAssertTrue(mockUser.city == mockCity)
        }
    
    func testAddFriend() throws {
        mockUser.addFriend(mockFriend)
            XCTAssertTrue(mockUser.addFriendCalledCount > 0)
            XCTAssertTrue(mockUser.addFriendCalled)
        XCTAssertTrue(mockUser.friends.last === mockFriend)
        }
    
    func testChangeClosed() throws {
            mockUser.changeClosed(mockIsClosed)
            XCTAssertTrue(mockUser.changeClosedCalledCount > 0)
            XCTAssertTrue(mockUser.changeClosedCalled)
            XCTAssertTrue(mockUser.isClosed == mockIsClosed)
        }
    
    
    
    
    
    

    


    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
}

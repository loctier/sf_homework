//
//  UserMock.swift
//  TestProject
//
//  Created by SF on 01.06.2021.
//

import Foundation

class UserMock: User {
    
   override init(firstName: String, lastName: String, bio: String, city: String, friends: [User], isClosed: Bool) {
       super.init(firstName: firstName, lastName: lastName, bio: bio, city: city, friends: friends, isClosed: isClosed)
        self.firstName = firstName
        self.lastName = lastName
        self.bio = bio
        self.city = city
        self.friends = friends
        self.isClosed = isClosed
    }
    
    // Сколько раз был вызван тот или иной метод
    var changeCityCalledCount = 0
    var changeClosedCalledCount = 0
    var changeNameCalledCount = 0
    var changeLastNameCalledCount = 0
    var changeBioCalledCount = 0
    var addFriendCalledCount = 0
    
    // Был ли вызван тот или иной метод
    var changeCityCalled = false
    var changeClosedCalled = false
    var changeNameCalled = false
    var changeLastNameCalled = false
    var changeBioCalled = false
    var addFriendCalled = false
    
    override func changeCity(_ city: String) {
        changeCityCalledCount += 1
        changeCityCalled = true
        self.city = city
    }
    
    override func changeClosed(_ isClosed: Bool) {
        changeClosedCalledCount += 1
        changeClosedCalled = true
        self.isClosed = isClosed
    }
    
    override func changeName(_ firstName: String) {
        changeNameCalledCount += 1
        changeNameCalled = true
        self.firstName = firstName
    }
    
    override func changeLastName(_ lastName: String) {
        changeLastNameCalledCount += 1
        changeLastNameCalled = true
        self.lastName = lastName
    }
    
    override func changeBio(_ bio: String) {
        changeBioCalledCount += 1
        changeBioCalled = true
        self.bio = bio
    }
    
    override func addFriend(_ friend: User) {
        addFriendCalledCount += 1
        addFriendCalled = true
        friends.append(friend)
    }
        
}

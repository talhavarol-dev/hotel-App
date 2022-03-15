//
//  Registration.swift
//  HotelApp
//
//  Created by Talha Varol on 14.03.2022.
//

import Foundation

struct Registration{
    var firstName: String
    var lastName: String
    var emailAddress: String
    
    var checkInDate: Date
    var checkOutDate: Date
    
    var numberOfAdults: Int
    var numberOfChildren: Int
    
    var roomType: RoomType
    var wifi: Bool
    
    func fullName() -> String {
        return firstName + " " + lastName
    }
    
}

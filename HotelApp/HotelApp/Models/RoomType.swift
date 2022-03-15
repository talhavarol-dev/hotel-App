//
//  RoomType.swift
//  HotelApp
//
//  Created by Talha Varol on 14.03.2022.
//

import Foundation

struct RoomType: Equatable {
    // MARK: - Properties
    var id: Int
    var name: String
    var shortName: String
    var price: Int
    
    // MARK: - Functions
    static func ==(lhs: RoomType, rsh: RoomType) ->Bool{
        return lhs.id == rsh.id
    }
    static var all:[RoomType]{
        return[
            RoomType(id: 0, name: "Two Queens", shortName: "2Q", price: 179),
            RoomType(id: 1, name: "One King", shortName: "K", price: 209),
            RoomType(id: 2, name: "Suit", shortName: "S", price: 309),
        ]
    }
}


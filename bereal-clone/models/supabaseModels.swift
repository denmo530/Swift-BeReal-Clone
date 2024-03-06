//
//  supabaseModels.swift
//  bereal-clone
//
//  Created by Dennis Moradkhani on 2024-03-04.
//

import Foundation

struct Profile: Decodable {
  let username: String?
  let fullName: String?
  let website: String?

  enum CodingKeys: String, CodingKey {
    case username
    case fullName = "full_name"
    case website
  }
}

struct UpdateProfileParams: Encodable {
  let username: String
  let fullName: String
  let website: String

  enum CodingKeys: String, CodingKey {
    case username
    case fullName = "full_name"
    case website
  }
}

struct FriendRequest: Codable {
    let senderId: String
    let receiverId: String
    let status: RequestStatus

    enum RequestStatus: String, Codable {
        case pending = "pending"
        case accepted = "accepted"
        case declined = "declined"
    }
}

enum RequestStatus: String, CodingKey {
    case pending = "pending"
    case accepted = "accepted"
    case declined = "declined"
}

struct UpdateFriendRequest: Encodable {
    let status: RequestStatus

    enum RequestStatus: String, Encodable {
        case pending = "pending"
        case accepted = "accepted"
        case declined = "declined"
    }
}


//
//  FriendRequestService.swift
//  bereal-clone
//
//  Created by Dennis Moradkhani on 2024-03-05.
//

import Foundation
import Supabase

protocol FriendRequestServiceProtocol {
    func sendFriendRequest(to receiverId: String, completion: @escaping (Result<Void, Error>) -> Void) async
    func fetchFriendRequests(completion: @escaping (Result<(received: [FriendRequest], sent: [FriendRequest]), Error>) -> Void) async
    func acceptFriendRequest(requestId: String, completion: @escaping (Result<Void, Error>) -> Void ) async
    func declineFriendRequest(requestId: String, completion: @escaping (Result<Void, Error>) -> Void) async
}

class FriendRequestService: FriendRequestServiceProtocol {
    private let supabaseClient: SupabaseClient
    
    init(supabaseClient: SupabaseClient) {
        self.supabaseClient = supabaseClient
    }
    
    func sendFriendRequest(to receiverId: String, completion: @escaping (Result<Void, Error>) -> Void) async {
        
        do {
            let senderId = try await supabaseClient.auth.session.user.id
            
            let newFriendReq = FriendRequest(
                      senderId: senderId.uuidString,
                      receiverId: receiverId,
                      status: .pending
                  )
            
            try await supabaseClient.database.from("friend_requests")
                .insert(newFriendReq)
                .execute()
            
            completion(.success(()))
        } catch {
            debugPrint(error)
            completion(.failure(error))
            
        }
    }
    
    func fetchFriendRequests(
        completion: @escaping (Result<(received: [FriendRequest], sent: [FriendRequest]), Error>) -> Void) async {
        do {
            let currentUser = try await supabaseClient.auth.session.user
            
            let receivedFriendRequests: [FriendRequest] = try await supabaseClient.database.from("friend_requests")
                .select("*")
                .eq("receiver_id", value: currentUser.id)
                .execute()
                .value
            
            let sentFriendRequests: [FriendRequest] = try await supabaseClient.database.from("fiend_requests")
                .select("*")
                .eq("sender_id", value: currentUser.id)
                .execute()
                .value
            
            
            completion(.success((received: receivedFriendRequests, sent: sentFriendRequests)))
            
        } catch {
            debugPrint(error)
            completion(.failure(error))
        }
    }
    
    func acceptFriendRequest(requestId: String, completion: @escaping (Result<Void, Error>) -> Void) async {
        do {
            try await supabase.database
                .from("friend_requests")
                .update(UpdateFriendRequest(
                    status: .accepted
                )
                )
                .eq("request_id", value: requestId)
                .execute()
            
            completion(.success(()))
            debugPrint("Successfully accepted friend request")
        } catch {
            debugPrint(error)
            completion(.failure(error))
        }
        
    }
    
    func declineFriendRequest(requestId: String, completion: @escaping (Result<Void, Error>) -> Void) async {
        do {
            try await supabase.database
                .from("friend_requests")
                .update(UpdateFriendRequest(
                    status: .declined
                )
                )
                .eq("request_id", value: requestId)
                .execute()
            
            completion(.success(()))
            debugPrint("Successfully declined friend request")
        } catch {
            debugPrint(error)
            completion(.failure(error))
        }
    }
}

//
//  supabase.swift
//  bereal-clone
//
//  Created by Dennis Moradkhani on 2024-03-04.
//

import Foundation
import Supabase

let supabaseURL = Bundle.main.object(forInfoDictionaryKey: "SupabaseURL") as! String
let supabaseKey = Bundle.main.object(forInfoDictionaryKey: "SupabaseKey") as! String


let supabase = SupabaseClient(supabaseURL: URL(string: supabaseURL)!, supabaseKey: supabaseKey)

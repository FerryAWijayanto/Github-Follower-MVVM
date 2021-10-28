//
//  ErrorMessage.swift
//  Github Follower VIP
//
//  Created by Ferry Adi Wijayanto on 14/10/21.
//

import Foundation

enum GFError: String, Error {
    case invalidUsername        = "This username created is an invalid request. Please try again"
    case unableToComplete       = "Unable to complete your request. Please check your internet connection"
    case invalidResponse        = "Invalid response from the server. Please try again"
    case invalidData            = "The data recieved from the server is invalid. Please try again"
    case unableToFavorites      = "There was an error favoriting the user, please try again."
    case alreadyInFavorite      = "Can't favorite the user, because it's already exist."
}

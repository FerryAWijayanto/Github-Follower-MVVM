//
//  SearchViewModel.swift
//  Github Follower MVVM
//
//  Created by Ferry Adi Wijayanto on 24/10/21.
//

import Foundation

protocol ViewModelType {
    associatedtype Input
    associatedtype Output
    
    func transform(input: Input) -> Output
}

class SearchViewModel: ViewModelType {
    
    let username = Binder<String>("")
    let errorMessage = Binder<String>("")
    
    struct Input {
        var searchUsername: Binder<String>
    }
    
    struct Output {
        var errorMessage: Binder<String>
        var username: Binder<String>
    }
    
    func transform(input: Input) -> Output {
        var username = ""
        var errorMessage = ""
        
        if input.searchUsername.value.isEmpty {
            errorMessage = "Please enter a username. We need to know who to look for"
        } else {
            username = input.searchUsername.value
        }
        
        return Output(errorMessage: Binder<String>(errorMessage), username: Binder<String>(username))
    }
}

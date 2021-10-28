//
//  FollowerListViewModel.swift
//  Github Follower MVVM
//
//  Created by Ferry Adi Wijayanto on 28/10/21.
//

import Foundation

class FollowerListViewModel: ViewModelType {
    
    struct Input {
        let username: Binder<String>
    }
    
    struct Output {
        var followers: Binder<[Follower]>
        var errorResponse: Binder<String>
    }
    
    private var page = 1
    
    let manager: DataFetcher
    
    init(manager: DataFetcher = NetworkDataFetcher(service: NetworkService())) {
        self.manager = manager
    }
    
    func transform(input: Input) -> Output {
        search(username: input.username.value)
        var followerLists: [Follower] = []
        var errorResponse = ""
        manager.getFollower(from: input.username.value, page: page) { results in
            switch results {
            case .success(let followers):
                followerLists = followers
            case .failure(let error):
                errorResponse = error.rawValue
            }
        }
        return Output(followers: Binder<[Follower]>(followerLists), errorResponse: Binder<String>(errorResponse))
    }
    
    private func search(username: String) {
        
        manager.getFollower(from: username, page: page) { results in
            switch results {
            case .success(let followers):
                print(followers)
            case .failure(let error):
                print(error.rawValue)
            }
        }
    }
}

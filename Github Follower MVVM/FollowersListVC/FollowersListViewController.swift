//
//  FollowersListViewController.swift
//  Github Follower VIP
//
//  Created by Ferry Adi Wijayanto on 12/10/21.
//

import UIKit


final class FollowersListViewController: UIViewController {
    
    // MARK: - UI Outlets
    
    @IBOutlet weak var collectionView: UICollectionView!
    //
    
    // MARK: - Public Properties
    var username: String!
    var followerViewModel = FollowerListViewModel()
    var followers: [Follower] = []
    //    var followers = FollowerViewModel(cells: [])
    
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = username
        configure()
        setupCollectionView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden = false
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    // MARK: - Public Methods
    func setupCollectionView() {
        collectionView.register(UINib(nibName: "FollowerCell", bundle: nil), forCellWithReuseIdentifier: FollowerCell.reuseID)
    }
    
    private func configure() {
        let input = FollowerListViewModel.Input(username: Binder<String>(username))
        let output = followerViewModel.transform(input: input)
        
        output.followers.bind { followers in
            self.followers = followers
        }
        
        output.errorResponse.bind { errorMessage in
            print(errorMessage)
        }
    }
}

extension FollowersListViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FollowerCell.reuseID, for: indexPath) as! FollowerCell
        //        let followerViewModel = followers.cells[indexPath.row]
        //        cell.set(follower: followerViewModel)
        return cell
    }
    
}

extension FollowersListViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width                           = view.bounds.width
        let padding: CGFloat                = 12
        let minimumInterimSpacing: CGFloat  = 10
        let availableWidth                  = width - (padding * 2) - (minimumInterimSpacing * 2)
        let itemWidth                       = availableWidth / 3
        
        return CGSize(width: itemWidth, height: itemWidth + 40)
    }
}

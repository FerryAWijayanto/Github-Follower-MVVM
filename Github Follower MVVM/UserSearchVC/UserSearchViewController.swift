//
//  UserSearchViewController.swift
//  Github Follower VIP
//
//  Created by Ferry Adi Wijayanto on 12/10/21.
//

import UIKit

final class UserSearchViewController: UIViewController {

  // MARK: - UI Outlets
    @IBOutlet weak var searchTextField: UITextField!
    private var viewModel: SearchViewModel!
    

  // MARK: - Lifecycle

  override func viewDidLoad() {
    super.viewDidLoad()
    configure()
  }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden = true
    }


  private func configure() {
    viewModel = SearchViewModel()
  }
    
    private func setupViewModel() {
        let input = SearchViewModel.Input(searchUsername: Binder<String>(searchTextField.text ?? ""))

        let output = viewModel.transform(input: input)

        output.errorMessage.bind { message in
            let ac = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "Dismiss", style: .default, handler: nil))
            self.present(ac, animated: true)
        }

        output.username.bind { username in
            print(username)
            let followerListVC: FollowersListViewController = FollowersListViewController.loadFromStoryboard()
            followerListVC.username = username
            self.navigationController?.pushViewController(followerListVC, animated: true)
        }
    }
    
  
  // MARK: - UI Actions
    @IBAction func searchTapped(_ sender: UIButton) {
        setupViewModel()
    }
}


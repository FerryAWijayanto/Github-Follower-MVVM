//
//  Extensions+UIImageView.swift
//  Github Follower VIP
//
//  Created by Ferry Adi Wijayanto on 23/10/21.
//

import UIKit

extension UIImageView {
    
    func set(imageUrl: String) {
        guard let url = URL(string: imageUrl) else { return }
        
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            
            DispatchQueue.main.async {
                if let data = data {
                    self.image = UIImage(data: data)
                }
            }
        }
        task.resume()
    }
}

//
//  ImageCell.swift
//  les6.1
//
//  Created by Павел on 05.12.2020.
//

import UIKit

//protocol ImageCellDelegate {
//    func didButtonPressed()
//}

class ImageCell: UICollectionViewCell {
    
   // var delegate: ImageCellDelegate?

    @IBOutlet private weak var imageView: UIImageView!
    
 
    
    override func prepareForReuse() {
        imageView.image = nil
    }

   /* func setImage(photoModel: Photo, completion: @escaping ((UIImage)?) -> Void) {
        if let image = photoModel.image {
            imageView.image = image
            return
        }
        
        guard let imageURL = URL(string: photoModel.url) else { return }
        
        
        
        
        DispatchQueue.global().async {
            guard let imageData = try? Data(contentsOf: imageURL)  else { return }
            let image = UIImage(data: imageData)
            
           
        DispatchQueue.main.async {
            self.imageView.image = image
            completion(image)
        }
        }
        
    } */
    
    func setImage2(photoModel: Photo, completion: @escaping ((UIImage)?) -> Void) {
    if let image = photoModel.image {
        imageView.image = image
        return
    }
    
    guard let imageURL = URL(string: photoModel.url) else { return }
    
    
    
    
        URLSession.shared.dataTask(with: imageURL) { data, _, _ in
            if
                let data = data, let image = UIImage(data: data) {
                completion(image)
                DispatchQueue.main.async {
                    self.imageView.image = image
                }
            }
            
        }.resume()
        
    
}
    
   
    
    
}

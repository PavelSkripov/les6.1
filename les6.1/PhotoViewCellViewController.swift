//
//  PhotoViewCellViewController.swift
//  les6.1
//
//  Created by Павел on 07.12.2020.
//

import UIKit

class PhotoViewCellViewController: UIViewController {

    @IBOutlet weak var photo: UIImageView!
    
    var photoImage = UIImage()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        photo.image = photoImage
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

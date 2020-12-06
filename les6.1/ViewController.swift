//
//  ViewController.swift
//  les6.1
//
//  Created by Павел on 05.12.2020.
//

import UIKit



class CollectionViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    
    private var photos: [Photo] = []
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
       
        
        collectionView.dataSource = self
        collectionView.delegate = self
        
       collectionView.register(UINib(nibName: "ImageCell", bundle: nil), forCellWithReuseIdentifier: "ImageCell")
        
    //    setupPhotos()
    }
    
    func setupPhotos () {
        //photos = Array(repeating: Photo(url: "https://picsum.photos/100"), count: 9)
        
        guard let imageURL = URL(string: "https://jsonplaceholder.typicode.com/photos") else { return }
        
        let task = URLSession.shared.dataTask(with: imageURL) { data, _, _ in
            guard
                let data = data,
                let photos = try? JSONDecoder().decode([Photo].self, from: data)
            else { return }
                self.photos = photos.prefix(15).map {Photo(url: $0.url)}
                
                DispatchQueue.main.async {
                    self.collectionView.reloadData()
                }
            
        }.resume()
        
        
        
        
        
    }
    
    @IBAction func Load(_ sender: Any) {
        setupPhotos()
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
extension CollectionViewController: UICollectionViewDataSource {
    
    //func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
  //      collectionView.dequeueReusableCell(withReuseIdentifier: "IDCell", for: indexPath)
  //  }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return photos.count
    }
    
 func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ImageCell", for: indexPath) as! ImageCell
    
    //cell.setImage(photoModel: photos[indexPath.item]) {[weak self] image in
    //    self?.photos[indexPath.item].image = image
    //}
    
    cell.setImage2(photoModel: photos[indexPath.item]) {[weak self] (image) in
        self?.photos[indexPath.item].image = image
    }
    
     return cell
    }
}
extension CollectionViewController: UICollectionViewDelegateFlowLayout {
    
    /*func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let viewWidth = view.frame.width - 21
        let width = viewWidth / 3
        return CGSize(width: width, height: width)
}*/
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let size = (collectionView.frame.width - 30) / 3
        
        return .init(width: size, height: size)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        10
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        10
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "PhotoViewCellViewController") as! PhotoViewCellViewController
        vc.photoImage = photos[indexPath.item].image!
        self.present(vc, animated: true, completion: nil)
        
        print(indexPath.item)
    }
    
}

struct Photo: Codable {
    
    let url: String
    var image: UIImage?
    
    init(url: String) {
        self.url = url
    }
    
    private enum CodingKeys: String, CodingKey {
        case url = "url"
    }
}

//extension CollectionViewController: ImageCellDelegate {
//    func didButtonPressed(){
        //let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        //let vc = storyBoard.instantiateViewController(withIdentifier: "ID3")
        //self.present(vc, animated: true, completion: nil)
  //      self.performSegue(withIdentifier: "show", sender: nil)
        
  //  }
//}

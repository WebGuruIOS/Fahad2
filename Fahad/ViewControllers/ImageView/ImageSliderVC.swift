//
//  ImageSliderVC.swift
//  Fahad
//
//  Created by Prince on 07/04/22.
//

import UIKit

class ImageSliderVC: UIViewController{

   
    @IBOutlet weak var imageSlider: UICollectionView!
    
    var imageString = String()
    var imageArr = [String]()
    var uiImage = UIImage()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        imageSlider.delegate = self
        imageSlider.dataSource = self
        imageSlider.register(UINib(nibName: "ImageSlideCustCell", bundle: Bundle.main ), forCellWithReuseIdentifier: "ImageSlideCustCell")
        print("Images:",imageArr)
    }
  
    @IBAction func act_Back(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
}

extension ImageSliderVC: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return imageArr.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = imageSlider.dequeueReusableCell(withReuseIdentifier: "ImageSlideCustCell", for: indexPath) as! ImageSlideCustCell
        let img = imageArr[indexPath.row]
        if let imageUrl:URL = URL(string:"\(img)") {
         cell.imageView.kf.setImage(with: imageUrl)
      }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let img = imageArr[indexPath.row]
        let url = URL(string:img)
            if let data = try? Data(contentsOf: url!)
            {
                uiImage = UIImage(data: data)!
            }
        
        let imageInfo = GSImageInfo(image:uiImage, imageMode: .aspectFit)
        let transitionInfo = GSTransitionInfo(fromView: collectionView)
        let imageViewer = GSImageViewerController(imageInfo: imageInfo, transitionInfo: transitionInfo)
        imageViewer.dismissCompletion = {
        }
        present(imageViewer, animated:true)
    }
    
}



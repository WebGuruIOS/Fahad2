//
//  ProductDetailsViewController.swift
//  Fahad
//
//  Created by Kondalu on 23/08/21.
//

import UIKit
import Cosmos
import Social

var optionId = String()
class ProductDetailsViewController: UIViewController, ProductTableViewCellDelegate {
    func selectedItem(attributeName: String, subAttributeData: ProductOptionValue) {
        if attributeName == "size"{
             size_productOptionValueId = subAttributeData.productOptionValueId ?? ""
            size_optionValueId = subAttributeData.optionValueId ?? ""
        }else if attributeName == "color"{
          color_productOptionValueId = subAttributeData.productOptionValueId ?? ""
          color_optionValueId = subAttributeData.optionValueId ?? ""
        }
    }
    @IBOutlet weak var similarHeightCon: NSLayoutConstraint!
    @IBOutlet weak var sellerView: UIView!
//    {
//        didSet{
//            sellerView.layer.borderColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
//            sellerView.layer.borderWidth = 0.5
//        }
//    }
    @IBOutlet weak var incrementView: UIView!
//    {
//        didSet{
//            incrementView.layer.borderColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
//            incrementView.layer.borderWidth = 0.5
//        }
//    }
    @IBOutlet weak var viewAllView: UIView!
    @IBOutlet weak var viewAllHeightCon: NSLayoutConstraint!
    @IBOutlet weak var mainCartView: UIView!{
        didSet{
            mainCartView.clipsToBounds = true
            mainCartView.layer.cornerRadius = mainCartView.frame.size.width / 2
            }
        }
    
    var imageString = String()
    @IBOutlet weak var sellerHeightCon: NSLayoutConstraint!
    @IBOutlet weak var reviewHeightCon: NSLayoutConstraint!
    @IBOutlet weak var sizeTVHeightCon: NSLayoutConstraint!
    @IBOutlet weak var likeButton: UIButton!
    @IBOutlet weak var shirtNameLabel: UILabel!
    
    @IBOutlet weak var addCartView: UIView!{
        didSet{
            addCartView.clipsToBounds = true
            addCartView.layer.cornerRadius = 40
            addCartView.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
        }
    }
    var counterValue = 1
    
    @IBOutlet weak var btn_AddYourReview: UIButton!
    @IBOutlet weak var whiteButton: UIButton!
    
    @IBOutlet weak var specificatonLabel: UILabel!
   
    @IBOutlet weak var productSizeTV: UITableView!
    @IBOutlet weak var despLabel: UILabel!
    @IBOutlet weak var cartImage: UIImageView!
    @IBOutlet weak var addCartButton: UIButton!
    @IBOutlet weak var productReviewTV: UITableView!
   
    @IBOutlet weak var sellerNameLabel: UILabel!
    @IBOutlet weak var frequentlyCV: UICollectionView!
    @IBOutlet weak var productImgCV: UICollectionView!
    @IBOutlet weak var incrementButton: UIButton!
    @IBOutlet weak var countLabel: UILabel!
    @IBOutlet weak var decrementButton: UIButton!
    @IBOutlet weak var ratingView: CosmosView!
   
    
    @IBOutlet weak var oldPricelabel: UILabel!
    @IBOutlet weak var newPricelabel: UILabel!
    @IBOutlet weak var shareButton: UIButton!
    var productReviewArr = [ProductReviews]()
    var productOptionArr = [ProductOptions]()
    var similarProductArr = [ProductRelated]()
    var scrollingTimer = Timer()
    var counter = 0
    var sellerPhone = String()
    //CommonArrays
    var productScrollImageArr = [ImageGallery]()
    //CommonStrings
    var productId = String()
    var sellerId = String()
    var wishId = String()
    var languageID = UserDefaults.standard.string(forKey: "languageId") ?? "1"
    let customerId = UserDefaults.standard.string(forKey: "UserIdKey") ?? "0"
    var wishID = String()
    var image_Arr = [String]()
    
    var size_productOptionValueId:String = ""
    var size_optionValueId:String = ""
    var color_productOptionValueId:String = ""
    var color_optionValueId:String = ""
    
    
    //isWishlist
    override func viewDidLoad() {
        super.viewDidLoad()
        specificatonLabel.text = "Lorem ipsum dolor sit er elit lamet, consectetaur cillium adipisicing pecu, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor"
        //ScrollImages
        productImgCV.delegate = self
        productImgCV.dataSource = self
        productImgCV.register(UINib(nibName: "ImagesCollectionViewCell", bundle: Bundle.main), forCellWithReuseIdentifier: "ImagesCollectionViewCell")
        //FrequentlyProducts
        frequentlyCV.delegate = self
        frequentlyCV.dataSource = self
        frequentlyCV.register(UINib(nibName: "FrequentlyCollectionViewCell", bundle: Bundle.main), forCellWithReuseIdentifier: "FrequentlyCollectionViewCell")
        
        //reviews
        productReviewTV.delegate = self
        productReviewTV.dataSource = self
        productReviewTV.register(UINib(nibName: "ReviewTableViewCell", bundle: nil), forCellReuseIdentifier: "ReviewTableViewCell")
        //sizeTV
        productSizeTV.delegate = self
        productSizeTV.dataSource = self
        productSizeTV.register(UINib(nibName: "SizeTableViewCell", bundle: nil), forCellReuseIdentifier: "SizeTableViewCell")
        
        // Add review buttom
        btn_AddYourReview.backgroundColor = .clear
        btn_AddYourReview.layer.cornerRadius = 5
        btn_AddYourReview.layer.borderWidth = 1
        btn_AddYourReview.layer.borderColor = UIColor.black.cgColor
        //  startTimer()
         
        self.scrollingTimer = Timer.scheduledTimer(timeInterval: 2.0, target: self, selector: #selector(self.changeImage), userInfo: nil, repeats: true)
        let cartTapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(gotoCartVC))
        cartImage.isUserInteractionEnabled = true
        cartImage.addGestureRecognizer(cartTapGestureRecognizer)
        productDetailsData()
        
        if wishId == "0"{
           
            whiteButton.isHidden = false
            likeButton.isHidden = true
        }else if wishId == "1"{
            
            whiteButton.isHidden = true
            likeButton.isHidden = false
        }
        self.setNeedsStatusBarAppearanceUpdate()
        
        let sortBgTapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(doubleTag))
        productImgCV.isUserInteractionEnabled = true
        sortBgTapGestureRecognizer.numberOfTapsRequired = 1
        productImgCV.addGestureRecognizer(sortBgTapGestureRecognizer)
        productDetailsData()
        
        
    }
    
    @objc func doubleTag(){
        let vc =
        self.storyboard?.instantiateViewController(withIdentifier: "ImageSliderVC") as! ImageSliderVC
        vc.imageArr = image_Arr
        self.navigationController?.pushViewController(vc, animated: true)
        print("ClickedOn Tag")
    }
    
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if UserDefaults.standard.string(forKey: "isStudentLoggdIn") != nil {
            self.btn_AddYourReview.isHidden = false
        }else{
            self.btn_AddYourReview.isHidden = true
        }
        navigationController?.setNavigationBarHidden(true, animated: animated)
        productDetailsData()
     //   productReviewTV.reloadData()
        
    }
    
    
//  @available(iOS 13.0, *)
    @IBAction func act_AddYourReview(_ sender: Any) {
        let ratingVc = self.storyboard?.instantiateViewController(withIdentifier: "RatingViewController") as! RatingViewController
        ratingVc.prodId = productId
        self.navigationController?.pushViewController(ratingVc, animated: true)
    }
    
    @IBAction func sellerShareButtonAction(_ sender: UIButton) {
      openWhatsapp()
    }
    func openWhatsapp(){
        let urlWhats = "whatsapp://send?phone=+91\(sellerPhone)"
        if let urlString = urlWhats.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed){
            if let whatsappURL = URL(string: urlString) {
                if UIApplication.shared.canOpenURL(whatsappURL){
                    if #available(iOS 10.0, *) {
                        UIApplication.shared.open(whatsappURL, options: [:], completionHandler: nil)
                    } else {
                        UIApplication.shared.openURL(whatsappURL)
                    }
                }
                else {
                    ApiService.shared.showAlert(title: "", msg: "Install Whatsapp".localiz() )
                   // print("Install Whatsapp")
                }
            }
        }
    }
    @IBAction func whiteButtonAction(_ sender: UIButton) {
        whiteButton.addTarget(self, action: #selector(bestSellrProductfavButton(sender:)), for: .touchUpInside)
    }
    @objc func bestSellrProductfavButton(sender:UIButton){
        
        let parameters:[String:Any] = ["product_id": "\(productId)","customer_id": "\(customerId)"]
        RemoveAndAddWishListDataResponce.AddUserData(api: "appapi/wishlist/add", parameters: parameters) { (data) in
            if data != nil{
                let status = data?.responseCode
                let text = data?.responseText ?? ""
                print("statuse Is",status ?? 0)
                switch status {
                case 1:
                    if data?.responseStatus == "0"{
                        self.whiteButton.isHidden = false
                        self.likeButton.isHidden = true
                    }else{
                        self.whiteButton.isHidden = true
                        self.likeButton.isHidden = false
                    }
                   ApiService.shared.showAlert(title: "", msg: "\(text)" )
                   
                case 201:
                    ApiService.shared.showAlert(title: "", msg: "something" )
                default:
                    ApiService.shared.showAlert(title: "", msg: "something" )
                }
            }
        }
        
    }
    @objc func gotoCartVC(){
        let updateProfileVC = self.storyboard?.instantiateViewController(withIdentifier: "MyCartViewController") as! MyCartViewController
            updateProfileVC.hidesBottomBarWhenPushed = true
       self.navigationController?.pushViewController(updateProfileVC, animated: true)
   }
    @objc func changeImage(){
        if counter < productScrollImageArr.count {
          let index = IndexPath.init(item: counter, section: 0)
          self.productImgCV.scrollToItem(at: index, at: .centeredHorizontally, animated: true)
          counter += 1
       } else {
          counter = 0
          let index = IndexPath.init(item: counter, section: 0)
          self.productImgCV.scrollToItem(at: index, at: .centeredHorizontally, animated: true)
       }
    }
    func productDetailsData(){
        ACProgressHUD.shared.showHUD()
        let parameters:[String:Any] = ["product_id":"\(productId)","language_id":"\(languageID)","customer_id":"\(customerId)","currency_code":"USD","device_id":"12345","seller_id":"\(sellerId)"]
        ProductDetailsDataResponce.AddUserData(api: "appapi/product/product_details", parameters: parameters) { (data) in
            if data != nil{
                let status = data?.responseCode
               //Banner Slider
                if let data = data?.responseData?.imageGallery{
                    for i in 0..<data.count{
                        DispatchQueue.main.async {
                            self.productScrollImageArr.append(data[i])
                        }
                    }
                 }
                if let data = data?.responseData?.productReviews{
                    self.productReviewArr = []
                    for i in 0..<data.count{
                        self.productReviewArr.append(data[i])
//                        DispatchQueue.main.async {
//                            self.productReviewArr.append(data[i])
//                        }
                    }
                 }
                
                if let data = data?.responseData?.productOptions{
                    self.productOptionArr = []
                    for i in 0..<data.count{
                        self.productOptionArr.append(data[i])
//                        DispatchQueue.main.async {
//                            self.productOptionArr.append(data[i])
//                        }
                    }
                 }
                if let data = data?.responseData?.productRelated{
                    for i in 0..<data.count{
                        DispatchQueue.main.async {
                            self.similarProductArr.append(data[i])
                            print("similarProductArr",self.similarProductArr)
                            
                            print("laksmi",self.similarProductArr.count)
                        }
                    }
                 }
                if let data = data?.responseData?.name{
                    let str = data.stripOutHtml()
                    self.shirtNameLabel.text = str
                }
                if let data = data?.responseData?.price{
                    self.oldPricelabel.text = "$\(data)"
                }
                if let data = data?.responseData?.mainPrice{
                    self.newPricelabel.text = "$\(data)"
                }
//                if let data = data?.responseData?.tax{
//                    self.newPricelabel.text = "$\(data)"
//                }
                if let data = data?.responseData?.rating{
                    
                    self.ratingView.rating = Double(data) ?? 0.0
                }
                if let data = data?.responseData?.description{
                    self.despLabel.text = data
                }
                if let data = data?.responseData?.sellerName{
                    self.sellerNameLabel.text = data
                }
                if let data = data?.responseData?.sellerPhone{
                    self.sellerPhone = data
                }
                if let data = data?.responseData?.isWishlist{
                    if data == "0"{
                        self.whiteButton.isHidden = false
                        self.likeButton.isHidden = true
                    }else{
                        self.whiteButton.isHidden = true
                        self.likeButton.isHidden = false
                    }
                }
            switch status {
                case 1:
//                    print("sucess")
//                    print("ImageArrValue:",self.productScrollImageArr)
                    self.image_Arr.removeAll()
                    
                    if self.productScrollImageArr.count == 0{
                        //similarProductArr[indexPath.row].thumb ?? ""
                        self.image_Arr.append(self.imageString)
                    }else{
                        for items in self.productScrollImageArr {
                            self.image_Arr.append(items.thumb ?? "")
                            print("Items:",self.image_Arr)
                            
                        }
                    }
                    DispatchQueue.main.async {
                        self.productImgCV.reloadData()
                        self.productSizeTV.reloadData()
                        self.frequentlyCV.reloadData()
                        self.productReviewTV.reloadData()
                        ACProgressHUD.shared.hideHUD()
                    }
                case 0:
                    ApiService.shared.showAlert(title: "", msg: "Something Went Wrong " )
                default:
                    ApiService.shared.showAlert(title: "", msg: "Something Went Wrong" )
                }
            }
        }
    }
    func addToCartAction(){
       
        let parameters:[String:Any] = ["product_id":"\(productId)","seller_id":"1","customer_id":"\(customerId)","quantity":"\(countLabel.text ?? "")","size":size_optionValueId,"color":color_optionValueId, "option[237]":size_productOptionValueId,"option[241]":color_productOptionValueId]
        
        print("ParamValue:",parameters)
        VerifyOtpDataResponce.AddUserData(api: "appapi/cart/add_to_cart_new", parameters: parameters) { (data) in
            if data != nil{
                let responseCode = data?.responseCode
                let responseText = data?.responseText ?? ""
                let code = data?.responseData ?? ""
                print("code",code)
                print("statuse Is",responseCode ?? 0)
                switch responseCode {
                case 1:
                    let secVC = self.storyboard?.instantiateViewController(withIdentifier: "MyCartViewController") as! MyCartViewController
                    self.navigationController?.pushViewController(secVC, animated: true)
                  ApiService.shared.showAlert(title: "", msg: "\(responseText)" )
                case 0:
                    ApiService.shared.showAlert(title: "", msg: "\(responseText)" )
                default:
                    ApiService.shared.showAlert(title: "", msg: "Please Enter Valid Email Or Password" )
                }
            }
        }
    }
    
    @IBAction func addToCartButton(_ sender: UIButton) {
        var colorsizeStatus:Bool = true
        if UserDefaults.standard.string(forKey: "isStudentLoggdIn") != nil {
            if size_productOptionValueId == ""{
            colorsizeStatus = false
                ApiService.shared.showAlert(title: "", msg: "Please select product size" )
            }else if color_productOptionValueId == "" {
                ApiService.shared.showAlert(title: "", msg: "Please select product color" )
                colorsizeStatus = false
            }
            if colorsizeStatus{
                addToCartAction()
            }
            
           // addToCartAction()
        }else{
            orderDetails()
        }
    }
    func orderDetails(){
        let alertController = UIAlertController(title: "For use this features you need an account", message: "Do you want Login an account", preferredStyle: .alert)
        let ok = UIAlertAction(title: "Login" , style: .default) { (_ action) in
            let updateProfileVC = self.storyboard?.instantiateViewController(withIdentifier: "LoginViewController") as! LoginViewController
            updateProfileVC.hidesBottomBarWhenPushed = true
            self.navigationController?.pushViewController(updateProfileVC, animated: true)
        }
        let cancel = UIAlertAction(title: "Cancel" , style: .default) { (_ action) in
            self.navigationController?.popViewController(animated: true)
        }
        ok.setValue(UIColor.black, forKey: "titleTextColor")
        cancel.setValue(UIColor.red, forKey: "titleTextColor")
        alertController.addAction(ok)
        alertController.addAction(cancel)
        alertController.view.tintColor = .yellow
        self.present(alertController, animated: true, completion: nil)
    }
   
    override func viewWillDisappear(_ animated: Bool) {
       // self.navigationController?.navigationBar.isHidden = true
    }
    
    @IBAction func backButtonAction(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func incrementButtonAction(_ sender: UIButton) {
        counterValue += 1;
        self.countLabel.text = "\(counterValue)"
    }
    @IBAction func decrementButtonAction(_ sender: UIButton) {
        if(counterValue != 1){
            counterValue -= 1
        }
        if countLabel.text == "1"{
            ApiService.shared.showAlert(title: "", msg: "Order quantity can not be 0" )
        }
        self.countLabel.text = "\(counterValue)"
    }
    @IBAction func likeButtonAction(_ sender: UIButton) {
        likeButton.addTarget(self, action: #selector(bestSellrProductfavButton(sender:)), for: .touchUpInside)
    }
    
    @IBAction func similarProductsViewAllAction(_ sender: UIButton) {
        
    }
    
   
    @IBAction func shareButtonAction(_ sender: UIButton) {
        let someText:String = "Hello want to share text also"
        let objectsToShare:URL = URL(string: "https://www.ozone-ws.com/index.php?route=product/product&product_id=\(productId)")!
          let sharedObjects:[AnyObject] = [objectsToShare as AnyObject,someText as AnyObject]
          let activityViewController = UIActivityViewController(activityItems : sharedObjects, applicationActivities: nil)
          activityViewController.popoverPresentationController?.sourceView = self.view

        activityViewController.excludedActivityTypes = [ UIActivity.ActivityType.airDrop, UIActivity.ActivityType.postToFacebook,UIActivity.ActivityType.postToTwitter,UIActivity.ActivityType.mail,UIActivity.ActivityType.postToWeibo]

          self.present(activityViewController, animated: true, completion: nil)
        
      /*  //Set the default sharing message.
              let message = "Message goes here."
              //Set the link to share.
              if let link = NSURL(string: "http://yoururl.com")
              {
                let objectsToShare = [message,link] as [Any]
                  let activityVC = UIActivityViewController(activityItems: objectsToShare, applicationActivities: nil)
                activityVC.excludedActivityTypes = [UIActivity.ActivityType.airDrop, UIActivity.ActivityType.addToReadingList]
                self.present(activityVC, animated: true, completion: nil)
              }*/
        
    }
    //HomeAppliance products
    @objc func similarProductfavButton(sender:UIButton){
//        let indexPath = IndexPath.init(row: 0, section: 0)
//        let cell = frequentlyCV.cellForItem(at: indexPath) as? FrequentlyCollectionViewCell
//
//        let parameters:[String:Any] = ["product_id": "\(similarProductArr[sender.tag].productId ?? "")","customer_id": "\(customerId)"]
//        RemoveAndAddWishListDataResponce.AddUserData(api: "appapi/wishlist/add", parameters: parameters) { (data) in
//            if data != nil{
//                let status = data?.responseCode
//                let text = data?.responseText ?? ""
//                print("statuse Is",status ?? 0)
//                switch status {
//                case 1:
//                    if data?.responseStatus == "0"{
//                        cell?.whiteButton.isHidden = false
//                        cell?.redButton.isHidden = true
//                    }else{
//                        cell?.whiteButton.isHidden = true
//                        cell?.redButton.isHidden = false
//                    }
//                   ApiService.shared.showAlert(title: "", msg: "\(text)" )
//                    DispatchQueue.main.async {
//                    //    self.similarProductArr.removeAll()
//                       // self.productDetailsData()
//                        self.frequentlyCV.reloadData()
//                    }
//                case 201:
//                    ApiService.shared.showAlert(title: "", msg: "something" )
//                default:
//                    ApiService.shared.showAlert(title: "", msg: "something" )
//                }
//            }
    //    }
        
    }
}
extension ProductDetailsViewController : UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == productSizeTV{
            return productOptionArr.count
        }else if tableView == productReviewTV{
            return productReviewArr.count
        }else{
            return productReviewArr.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if tableView == productSizeTV{
            let cell = productSizeTV.dequeueReusableCell(withIdentifier: "SizeTableViewCell", for: indexPath) as! SizeTableViewCell
            cell.selectionStyle = .none
            cell.delegate = self
            cell.productNameLabel.text = productOptionArr[indexPath.row].name
            cell.objectArr = productOptionArr[indexPath.row].productOptionValue ?? []
            cell.productValueCV.reloadData()
           // self.productReviewTV.reloadData()
           // self.productSizeTV.reloadData()
            print("obejectArr",cell.objectArr)
            print("productOptionArr123",productOptionArr)
            if productOptionArr.isEmpty == false{
                sizeTVHeightCon.constant = (50 * CGFloat(productOptionArr.count))
               
                print("Kondallu")
            }else{
                sizeTVHeightCon.constant = 0
                print("vedavathi")
            }
           return cell
        }else if tableView == productReviewTV{
        let cell = productReviewTV.dequeueReusableCell(withIdentifier: "ReviewTableViewCell", for: indexPath) as! ReviewTableViewCell
        cell.homeSetUP(productReviewArr[indexPath.row])
       reviewHeightCon.constant = (100 * CGFloat(productReviewArr.count))
        cell.selectionStyle = .none
        return cell
    }
        return UITableViewCell()
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if tableView == productSizeTV{
            return 50
        }else if tableView == productReviewTV{
           return 100
        }else{
            return 100
        }
    }
}
extension ProductDetailsViewController : UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == productImgCV{
            if productScrollImageArr.count == 0{
                return 1
            }else{
                return productScrollImageArr.count
            }
            
        }else if collectionView == frequentlyCV{
            if similarProductArr.count == 0{
                print("kondalu123",similarProductArr.count)
                viewAllHeightCon.constant = 0
                similarHeightCon.constant = 0
            }else{
                viewAllHeightCon.constant = 40
                similarHeightCon.constant = 275
            }
          return similarProductArr.count
        }
        else{
            return similarProductArr.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == productImgCV {
            let cell = productImgCV.dequeueReusableCell(withReuseIdentifier: "ImagesCollectionViewCell", for: indexPath) as! ImagesCollectionViewCell
            if productScrollImageArr.count == 0{
                if let imageUrl:URL = URL(string:"\(imageString)") {
                    cell.imgView.kf.setImage(with: imageUrl)
                }
            }else{
            let data = productScrollImageArr[indexPath.row].thumb ?? ""
            if let imageUrl:URL = URL(string:"\(data)") {
                cell.imgView.kf.setImage(with: imageUrl)
            }
            }
           return cell
        }else if collectionView == frequentlyCV{
            let cell = frequentlyCV.dequeueReusableCell(withReuseIdentifier: "FrequentlyCollectionViewCell", for: indexPath) as! FrequentlyCollectionViewCell
//            if similarProductArr.count == 0{
//                print("kondalu123",similarProductArr.count)
//                viewAllHeightCon.constant = 0
//            }
            cell.homeSetUP(similarProductArr[indexPath.row])
            
            cell.redButton.tag = indexPath.row
            cell.whiteButton.tag = indexPath.row
            wishId = "\(similarProductArr[indexPath.row].isWishlist ?? "")"
            cell.redButton.addTarget(self, action: #selector(similarProductfavButton(sender:)), for: .touchUpInside)
            cell.whiteButton.addTarget(self, action: #selector(similarProductfavButton(sender:)), for: .touchUpInside)
            cell.redButton.addTarget(self, action: #selector(similarProductfavButton(sender:)), for: .touchUpInside)
             print("wishId",wishId)
            if wishId == "0"{
                cell.whiteButton.addTarget(self, action: #selector(similarProductfavButton(sender:)), for: .touchUpInside)
                cell.whiteButton.isHidden = false
                cell.redButton.isHidden = true
            }else if wishId == "1"{
                cell.redButton.addTarget(self, action: #selector(similarProductfavButton(sender:)), for: .touchUpInside)
                cell.whiteButton.isHidden = true
                cell.redButton.isHidden = false
            }
           return cell
        }
        return UICollectionViewCell()
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == frequentlyCV{
            let secVC = self.storyboard?.instantiateViewController(withIdentifier: "ProductDetailsViewController") as! ProductDetailsViewController
                secVC.productId = similarProductArr[indexPath.row].productId ?? ""
            secVC.imageString = similarProductArr[indexPath.row].thumb ?? ""
                secVC.sellerId = "1"
            secVC.hidesBottomBarWhenPushed = true
            self.navigationController?.pushViewController(secVC, animated: true)
        }
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == productImgCV{
            let size = CGSize(width: collectionView.bounds.width, height: collectionView.bounds.height)
            return size
        }else{
            let size = CGSize(width: 175, height: 240)
            return size
        }
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        if collectionView == frequentlyCV{
            return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 5)
            
        }
        else{
            return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        }
        
    }
}

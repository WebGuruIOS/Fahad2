//
//  HomeViewController.swift
//  Fahad
//
//  Created by Kondalu on 13/08/21.
//

import UIKit
import LanguageManager_iOS

class HomeViewController: UIViewController,UITabBarControllerDelegate {
    
    
    @IBOutlet weak var pageView: UIPageControl!
    @IBOutlet weak var cartMainView: UIView!{
        didSet{
            cartMainView.clipsToBounds = true
            cartMainView.layer.cornerRadius = cartMainView.frame.size.width / 2
            }
        }
    
    @IBOutlet weak var img5: UIImageView!{
        didSet{
            img5.layer.cornerRadius = 7
            img5.layer.masksToBounds = true
        }
    }
    @IBOutlet weak var img4: UIImageView!{
        didSet{
            img4.layer.cornerRadius = 7
            img4.layer.masksToBounds = true
        }
    }
    @IBOutlet weak var img2: UIImageView!{
        didSet{
            img2.layer.cornerRadius = 7
            img2.layer.masksToBounds = true
        }
    }
    @IBOutlet weak var img3: UIImageView!{
        didSet{
            img3.layer.cornerRadius = 7
            img3.layer.masksToBounds = true
        }
    }
    @IBOutlet weak var img1: UIImageView!{
        didSet{
            img1.layer.cornerRadius = 7
            img1.layer.masksToBounds = true
        }
    }
    
    @IBOutlet weak var cartImage: UIImageView!
    @IBOutlet weak var homeApplianceCV: UICollectionView!
    @IBOutlet weak var bestSellersCV: UICollectionView!
    @IBOutlet weak var trendingTV: UITableView!
    @IBOutlet weak var newProducts: UICollectionView!
    @IBOutlet weak var featuredProductCV: UICollectionView!
    @IBOutlet weak var shopByCateCV: UICollectionView!
    @IBOutlet weak var FeaturedSellersCV: UICollectionView!
    @IBOutlet weak var scrollCV: UICollectionView!
   
    @IBOutlet weak var homeApplianceView: UIView!{
        didSet{
            homeApplianceView.layer.cornerRadius = 5
            homeApplianceView.layer.masksToBounds = true
        }
    }
    @IBOutlet weak var bestSellerView: UIView!{
        didSet{
            bestSellerView.layer.cornerRadius = 5
            bestSellerView.layer.masksToBounds = true
        }
    }
    
    @IBOutlet weak var trendingProductView: UIView!{
        didSet{
            trendingProductView.layer.cornerRadius = 5
            trendingProductView.layer.masksToBounds = true
        }
    }
    @IBOutlet weak var newProductView: UIView!{
        didSet{
            newProductView.layer.cornerRadius = 5
            newProductView.layer.masksToBounds = true
        }
    }
    @IBOutlet weak var featuredProductView: UIView!{
        didSet{
            featuredProductView.layer.cornerRadius = 5
            featuredProductView.layer.masksToBounds = true
        }
    }
    @IBOutlet weak var featuredSellerView: UIView!{
        didSet{
            featuredSellerView.layer.cornerRadius = 5
            featuredSellerView.layer.masksToBounds = true
        }
    }
    @IBOutlet weak var searchButton: UIButton!{
        didSet{
            searchButton.layer.cornerRadius = 5
            searchButton.layer.masksToBounds = true
        }
    }
    
    @IBOutlet weak var vw_FeaturedSellerBgView: UIView!
    @IBOutlet weak var vw_posterFeaturedSeller: UIView!
    @IBOutlet weak var vw_FeaturedProductView: UIView!
    @IBOutlet weak var shopByCategoryBgView: UIView!
    @IBOutlet weak var banner_featureProduct: UIView!
    @IBOutlet weak var vw_ShopByCateViewAll: UIView!
    @IBOutlet weak var vw_NewProductBgView: UIView!
    @IBOutlet weak var bannert_NewProduct: UIView!
    @IBOutlet weak var vw_TrendingNowProdBg: UIView!
    @IBOutlet weak var banner_TrendingNow: UIView!
    @IBOutlet weak var vw_BestSellerBgView: UIView!
    @IBOutlet weak var vw_BestSellerBannerBg: UIView!
    @IBOutlet weak var vw_homeApplianceBg: UIView!
    
    @IBOutlet weak var bannerBestSellerHeight: NSLayoutConstraint!
    @IBOutlet weak var vw_tendingNowHeight: NSLayoutConstraint! // img4
    @IBOutlet weak var bannerBgView: NSLayoutConstraint!
    @IBOutlet weak var constantShopByCategioryHeight: NSLayoutConstraint!
    @IBOutlet weak var constantFeaturedsellerHeight: NSLayoutConstraint! // Featured SellerConstant
    @IBOutlet weak var poster1Height: NSLayoutConstraint!
    @IBOutlet weak var featuredProductViewAllBgHeight: NSLayoutConstraint!
    @IBOutlet weak var featuredProductConstantHeight: NSLayoutConstraint! // Featured Product
    @IBOutlet weak var bannerFeateredHeight: NSLayoutConstraint!
    @IBOutlet weak var newProductViewAllHeight: NSLayoutConstraint!
    @IBOutlet weak var constantNewProductHeight: NSLayoutConstraint!
    @IBOutlet weak var bannerNewProductHeight: NSLayoutConstraint!
    @IBOutlet weak var trendingNowVioewAllHeight: NSLayoutConstraint!
    @IBOutlet weak var collVw_HomeApplianceConstantHeight: NSLayoutConstraint!
    @IBOutlet weak var Constant_bestSellerHeight: NSLayoutConstraint!
    
    @IBOutlet weak var bestSellerViewAllHeight: NSLayoutConstraint!
    
    @IBOutlet weak var shopByCateViewAllHeight: NSLayoutConstraint!
    
    @IBOutlet weak var homeApplianceViewAllHeight: NSLayoutConstraint!
    // @IBOutlet weak var vw_featureProductBgViewConsHeight: NSLayoutConstraint!
    
    var isCheck = Bool()
    var nameArr = ["vjhghj","vbjhk","bvfjbvfjkbvkjf","bdvbhnbv","vbmvbmn"," mnbmb","bvmhbhb"]
    var carousalTimer: Timer?
    var newOffsetX: CGFloat = 0.0
   
    var homeScrollImageArr = [BannerSlider]()
    var elcctronicArr = [ElectronicBanner]()
    var fashionBannerArr = [FashionBanner]()
    var videoBannerArr = [VideoBanner]()
    var homeShopByCateArr = [Categories]()
    var homeFeaturedSellerArr = [Featured_seller]()
    var homeFeaturedProductArr = [Featured_product]()
    var homeNewProductArr = [New_product]()
    var homemobilesArr = [New_product]()
    var homeApplianceArr = [Home_appliances]()
    var homeBestSellerArr = [Best_seller]()
    var homeTrendingArr = [Trending_product]()
    var languageID = UserDefaults.standard.string(forKey: "languageId") ?? "1"
    let customerId = UserDefaults.standard.string(forKey: "UserIdKey") ?? "0"
    var fcmTocken = UserDefaults.standard.string(forKey: "fcmToken")
    var wishId = String()
    var timer = Timer()
    var counter = 0
  //  var prod_Id = String()
   // var productId = UserDefaults.standard.string(forKey: "productId")
   // var prodId = String()
    override func viewDidLoad() {
        super.viewDidLoad()
        print(fcmTocken ?? "")
        searchButton?.contentHorizontalAlignment = UIControl.ContentHorizontalAlignment.left
       //let signUp = NSLocalizedString("SiGN-UP", comment: "this is sign Up Button")
        //button.setTitle(signUp,for: .normal)
       // title = "SHOP BY CATEGIORY".localiz()
      //  self.scrollCV.scrollToItem(at:IndexPath(item: 0, section: 0), at: .right, animated: false)
        
        //Best Seller
        let layout1 = UICollectionViewFlowLayout()
        layout1.scrollDirection = .vertical //.horizontal
        layout1.minimumLineSpacing = 5.0
        layout1.minimumInteritemSpacing = 5.0
        bestSellersCV.collectionViewLayout = layout1
        
        //New Products
        let layout2 = UICollectionViewFlowLayout()
        layout2.scrollDirection = .vertical //.horizontal
        layout2.minimumLineSpacing = 5.0
        layout2.minimumInteritemSpacing = 5.0
        newProducts.collectionViewLayout = layout2
        
        //Home Appliance
        let layout3 = UICollectionViewFlowLayout()
        layout3.scrollDirection = .vertical //.horizontal
        layout3.minimumLineSpacing = 5.0
        layout3.minimumInteritemSpacing = 5.0
        homeApplianceCV.collectionViewLayout = layout3
        
        //Featured Products
        let layout4 = UICollectionViewFlowLayout()
        layout4.scrollDirection = .vertical //.horizontal
        layout4.minimumLineSpacing = 5.0
        layout4.minimumInteritemSpacing = 5.0
        featuredProductCV.collectionViewLayout = layout4
        
        //ScrollImages
        scrollCV.delegate = self
        scrollCV.dataSource = self
        scrollCV.register(UINib(nibName: "ScrollImageCollectionViewCell", bundle: Bundle.main), forCellWithReuseIdentifier: "ScrollImageCollectionViewCell")
        //ShopByCate
        shopByCateCV.delegate = self
        shopByCateCV.dataSource = self
        shopByCateCV.register(UINib(nibName: "ShopByCateCollectionViewCell", bundle: Bundle.main), forCellWithReuseIdentifier: "ShopByCateCollectionViewCell")
        //FeaturedSellers
        FeaturedSellersCV.delegate = self
        FeaturedSellersCV.dataSource = self
        FeaturedSellersCV.register(UINib(nibName: "FeaturedSellersCollectionViewCell", bundle: Bundle.main), forCellWithReuseIdentifier: "FeaturedSellersCollectionViewCell")
        //FeaturedProducts
        featuredProductCV.delegate = self
        featuredProductCV.dataSource = self
        featuredProductCV.register(UINib(nibName: "FeaturedProductCollectionViewCell", bundle: Bundle.main), forCellWithReuseIdentifier: "FeaturedProductCollectionViewCell")
        //NewProducts
        newProducts.delegate = self
        newProducts.dataSource = self
        newProducts.register(UINib(nibName: "NewProductsCollectionViewCell", bundle: Bundle.main), forCellWithReuseIdentifier: "NewProductsCollectionViewCell")
       
        //Best Sellers
        bestSellersCV.delegate = self
        bestSellersCV.dataSource = self
        bestSellersCV.register(UINib(nibName: "BestSellerCollectionViewCell", bundle: Bundle.main), forCellWithReuseIdentifier: "BestSellerCollectionViewCell")
       
        //Home Appliance
        homeApplianceCV.delegate = self
        homeApplianceCV.dataSource = self
        homeApplianceCV.register(UINib(nibName: "HomeApplianceCollectionViewCell", bundle: Bundle.main), forCellWithReuseIdentifier: "HomeApplianceCollectionViewCell")
        //Trending Now
        trendingTV.delegate = self
        trendingTV.dataSource = self
        trendingTV.register(UINib(nibName: "TrendingTableViewCell", bundle: nil), forCellReuseIdentifier: "TrendingTableViewCell")
        //  self.trendingTV.addObserver(self, forKeyPath: "contentSize", options: [], context: nil)
        
        let cartTapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(gotoCartVC))
        cartImage.isUserInteractionEnabled = true
        cartImage.addGestureRecognizer(cartTapGestureRecognizer)
      //  startTimer()
        homeData()
        homeData2()
        pageView.numberOfPages = homeScrollImageArr.count
        pageView.currentPage = 0
        DispatchQueue.main.async {
            self.timer = Timer.scheduledTimer(timeInterval: 2.0, target: self, selector: #selector(self.changeImage), userInfo: nil, repeats: true)
        }
        self.banner_TrendingNow.isHidden = true
        self.vw_BestSellerBannerBg.isHidden = true
        self.vw_posterFeaturedSeller.isHidden = true
        self.bannert_NewProduct.isHidden = true
        self.banner_featureProduct.isHidden = true
        self.setNeedsStatusBarAppearanceUpdate()
        //Home Products
        homeBestSellerArr.removeAll()
        homeTrendingArr.removeAll()
        homeShopByCateArr.removeAll()
        homeFeaturedSellerArr.removeAll()
        homeFeaturedProductArr.removeAll()
        homeNewProductArr.removeAll()
        homemobilesArr.removeAll()
        homeApplianceArr.removeAll()
        homeData()
}
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .default    //lightContent
    }
    
    @objc func gotoCartVC(){
        if UserDefaults.standard.string(forKey: "isStudentLoggdIn") != nil {
        let updateProfileVC = self.storyboard?.instantiateViewController(withIdentifier: "MyCartViewController") as! MyCartViewController
            updateProfileVC.hidesBottomBarWhenPushed = true
            self.navigationController?.pushViewController(updateProfileVC, animated: true)
           
        }else{
            orderDetails()
        }
      }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
            setNeedsStatusBarAppearanceUpdate()
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
       // self.navigationController?.navigationBar.isHidden = false
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    @objc func changeImage() {
     
        if homeScrollImageArr.count != 0{
            if counter < homeScrollImageArr.count {
                let index = IndexPath.init(item: counter, section: 0)
                self.scrollCV.scrollToItem(at: index, at: .centeredHorizontally, animated: true)
                pageView.currentPage = counter
                counter += 1
            } else {
                counter = 0
                let index = IndexPath.init(item: counter, section: 0)
                self.scrollCV.scrollToItem(at: index, at: .centeredHorizontally, animated: false)
                pageView.currentPage = counter
                counter = 1
            }
        }
     
  }
    
//            @objc func didTap() {
//                let fullScreenController = homeScrollImageArr.presentFullScreenController(from: self)
//                // set the activity indicator for full screen controller (skipping the line will show no activity indicator)
//                fullScreenController.slideshow.activityIndicator = DefaultActivityIndicator(style: .white, color: nil)
//            }
    
    func orderDetails(){
        let alertController = UIAlertController(title: "For use this features you need an account", message: "Do you want Login an account", preferredStyle: .alert)
        let ok = UIAlertAction(title: "Login" , style: .default) { (_ action) in
            let updateProfileVC = self.storyboard?.instantiateViewController(withIdentifier: "LoginViewController") as! LoginViewController
            updateProfileVC.hidesBottomBarWhenPushed = true
            print("KK123456")
            self.navigationController?.pushViewController(updateProfileVC, animated: true)
           // self.present(updateProfileVC, animated: false, completion: nil)
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
//        override func viewWillLayoutSubviews() {
//            super.updateViewConstraints()
//            self.trendingHeightCon?.constant = self.trendingTV.contentSize.height
//        }
//        func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
//            self.viewWillLayoutSubviews()
//        }
    
    @IBAction func shopByCateViewmoreAction(_ sender: UIButton) {
        let secVC = self.storyboard?.instantiateViewController(withIdentifier: "CategoriesViewController") as! CategoriesViewController
        secVC.backId = "1"
            secVC.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(secVC, animated: true)
    }
    
    @IBAction func homeApplianceViewMoreAction(_ sender: UIButton) {
        let secVC = self.storyboard?.instantiateViewController(withIdentifier: "SortAndFilterViewController") as! SortAndFilterViewController
        secVC.extraParam = "appapi/product/view_all_home_appliances_products"
        secVC.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(secVC, animated: true)
    }
   
    @IBAction func bestSellerViewMoreAction(_ sender: UIButton) {
        let secVC = self.storyboard?.instantiateViewController(withIdentifier: "SortAndFilterViewController") as! SortAndFilterViewController
        secVC.extraParam = "appapi/product/view_all_best_seller_products"
        secVC.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(secVC, animated: true)
    }
    @IBAction func trendingNowViewMoreAction(_ sender: UIButton) {
        let secVC = self.storyboard?.instantiateViewController(withIdentifier: "SortAndFilterViewController") as! SortAndFilterViewController
        secVC.extraParam = "appapi/product/view_all_trending_products"
        secVC.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(secVC, animated: true)
    }
   
    @IBAction func newProductViewMoreAction(_ sender: UIButton) {
        let secVC = self.storyboard?.instantiateViewController(withIdentifier: "SortAndFilterViewController") as! SortAndFilterViewController
        secVC.extraParam = "appapi/product/view_all_new_products"
        secVC.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(secVC, animated: true)
    }
    @IBAction func fearturedProductViewmoreAction(_ sender: UIButton) {
        let secVC = self.storyboard?.instantiateViewController(withIdentifier: "SortAndFilterViewController") as! SortAndFilterViewController
        secVC.extraParam = "appapi/product/view_all_featured_products"
        //appapi/product/view_all_featured_products
        //"appapi/product/view_all_featured_products"
        //product/view_all_featured_products
        secVC.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(secVC, animated: true)
    }
    @IBAction func searchButtonAction(_ sender: UIButton) {
        let secVC = self.storyboard?.instantiateViewController(withIdentifier: "ProductSearchViewController") as! ProductSearchViewController
        secVC.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(secVC, animated: true)
    }
    //        override func viewDidLayoutSubviews(){
//             trendingTV.frame = CGRect(x: trendingTV.frame.origin.x, y: trendingTV.frame.origin.y, width: trendingTV.frame.size.width, height: trendingTV.contentSize.height)
//             trendingTV.reloadData()
//        }
    func homeData2(){
        let parameters:[String:Any] = ["currency_code":"USD","customer_id":"\(customerId)","device_id":"12345ABD","language_id":"\(languageID)","device_token":fcmTocken ?? "","device_type":"A"]
        HomeDataResponce.AddUserData(api: "appapi/product/homepage", parameters: parameters) { (data) in
            if data != nil{
                let status = data?.responseCode
                if let data = data?.responseData?.bannerSlider{
                    for i in 0..<data.count{
                        DispatchQueue.main.async {
                            self.homeScrollImageArr.append(data[i])
                    }
                }
            }
                switch status {
                    case 1:
                        print("sucess")
                        DispatchQueue.main.async {
                            self.scrollCV.reloadData()
                    }
                    case 201:
                        ApiService.shared.showAlert(title: "", msg: "Something Went Wrong".localiz() )
                    default:
                        ApiService.shared.showAlert(title: "", msg: "Something Went Wrong".localiz() )
                }
            }
        }
    }
    
    func homeData(){
        let parameters:[String:Any] = ["currency_code":"USD","customer_id":"\(customerId)","device_id":"12345ABD","language_id":"\(languageID)","device_token":fcmTocken ?? "","device_type":"I"]
        HomeDataResponce.AddUserData(api: "appapi/product/homepage", parameters: parameters) { (data) in
            if data != nil{
                let status = data?.responseCode
               //Banner Slider
                if let data = data?.responseData?.bannerSlider{
                    for i in 0..<data.count{
                        DispatchQueue.main.async {
                         //   self.homeScrollImageArr.append(data[i])
                    }
                  }
                }
                    if let data = data?.responseData?.fashionBanner{
                        for i in 0..<data.count{
                            DispatchQueue.main.async {
                                self.fashionBannerArr.append(data[i])
                                if self.fashionBannerArr.count != 0 {
                                    let data1 = self.fashionBannerArr[0].image ?? ""
                                    DispatchQueue.main.async {
                                        if let imageUrl:URL = URL(string:"\(data1)") {
                                            self.img2.kf.setImage(with: imageUrl)
                                            self.banner_featureProduct.isHidden = false
                        }
                    }
                                }else{
                                    self.banner_featureProduct.isHidden = true
                                }
               
            }
        }
      }
   
                    if let data = data?.responseData?.electronicBanner{
                        for i in 0..<data.count{
                            DispatchQueue.main.async {
                                self.elcctronicArr.append(data[i])
                                if self.elcctronicArr.count != 0 {
                                    let data1 = self.elcctronicArr[0].image ?? ""
                                    DispatchQueue.main.async {
                                         if let imageUrl:URL = URL(string:"\(data1)") {
                                            self.img1.kf.setImage(with: imageUrl)
                                            self.vw_posterFeaturedSeller.isHidden = false
                                           // self.img5.kf.setImage(with: imageUrl)
                                           // self.img3.kf.setImage(with: imageUrl)
                                          // self.img4.kf.setImage(with: imageUrl)
                                          
                                    }
                               }
                                }else{
                                    self.vw_posterFeaturedSeller.isHidden = true
                                }
                                
                       }
                    }
                }
                    if let data = data?.responseData?.videoBanner{
                        for i in 0..<data.count{
                            DispatchQueue.main.async {
                                self.videoBannerArr.append(data[i])
                                if self.videoBannerArr.count != 0 {
                                    let data1 = self.videoBannerArr[0].image ?? ""
                                    DispatchQueue.main.async {
                                         if let imageUrl:URL = URL(string:"\(data1)") {
                                            //self.bannert_NewProduct.isHidden = false
                                             //self.img3.kf.setImage(with: imageUrl)
                                            //self.img2.kf.setImage(with: imageUrl)
                                    }
                                }
                                }else{
                                    self.bannert_NewProduct.isHidden = true
                          }
                       }
                    }
                }
                
                
                //ShopByCate
                if let data = data?.responseData?.shop_by_category{
                    let cate = data.categories
                    for i in 0..<cate!.count{
                        DispatchQueue.main.async {
                            self.homeShopByCateArr.append(cate![i])
                        }
                   }
                }
                //Featured Seller
                if let data = data?.responseData?.featured_seller{
                    for i in 0..<data.count{
                        DispatchQueue.main.async {
                            self.homeFeaturedSellerArr.append(data[i])
                        }
                   }
                }
                //Featured Product
                if let data = data?.responseData?.featured_product{
                    for i in 0..<data.count{
                        DispatchQueue.main.async {
                            self.homeFeaturedProductArr.append(data[i])
                        }
                   }
                }
                //New Product
                if let data = data?.responseData?.new_product{
                    for i in 0..<data.count{
                        DispatchQueue.main.async {
                            self.homeNewProductArr.append(data[i])
                        }
                   }
                }
                //HomeAppliance
                if let data = data?.responseData?.home_appliances{
                    for i in 0..<data.count{
                        DispatchQueue.main.async {
                            self.homeApplianceArr.append(data[i])
                        }
                   }
                }
                //BestSeeler
                if let data = data?.responseData?.best_seller{
                    for i in 0..<data.count{
                        DispatchQueue.main.async {
                            self.homeBestSellerArr.append(data[i])
                        }
                   }
                }
                //TrendingProducts
                if let data = data?.responseData?.trending_product{
                    for i in 0..<data.count{
                        DispatchQueue.main.async {
                            self.homeTrendingArr.append(data[i])
                        }
                   }
                }
            switch status {
                case 1:
                    print("sucess")
                    DispatchQueue.main.async {
                        
                        //self.scrollCV.reloadData()
                        // self.homeShopByCateArr.removeAll()
                        
                        // SHOP BY CATEGORY
                        self.shopByCateCV.reloadData()
                        //homeShopByCateArr constantShopByCategioryHeight
                        if self.homeShopByCateArr.count != 0 {
                            self.vw_ShopByCateViewAll.isHidden = false
                        }else{
                            self.constantShopByCategioryHeight.constant = 0
                            self.shopByCateViewAllHeight.constant = 0
                            self.vw_ShopByCateViewAll.isHidden = true
                        }
                        
                     // FEATURED SELLER
                        
                       // self.FeaturedSellersCV.removeAll()
                        self.FeaturedSellersCV.reloadData()
                        if self.homeFeaturedSellerArr.count != 0 {
                            // homeFeaturedSellerArr, constantFeaturedsellerHeight
                            self.featuredSellerView.isHidden = false
                            self.vw_FeaturedSellerBgView.isHidden = false
                        }else{
                            self.constantFeaturedsellerHeight.constant = 0
                            self.vw_FeaturedSellerBgView.isHidden = true
                            self.featuredSellerView.isHidden = true
                        }
                        
                        // FEATURED PRODUCTS
                        self.featuredProductCV.reloadData()
                      //homeFeaturedProductArr featuredProductConstantHeight
                        if self.homeFeaturedProductArr.count != 0{
                            self.featuredProductView.isHidden = false
                            self.featuredProductConstantHeight.constant = CGFloat(((self.homeFeaturedProductArr.count / 2) * 125))
                        }else{
                            self.featuredProductConstantHeight.constant = 0
                            self.featuredProductView.isHidden = true
                        }
                        // HOME NEW PRODUCT
                       // self.homeNewProductArr.removeAll()
                        self.newProducts.reloadData()
                        //homeNewProductArr newProductViewAllHeight // constantNewProductHeight
                        if self.homeNewProductArr.count != 0 {
                            self.newProductView.isHidden = false
                            self.constantNewProductHeight.constant = CGFloat(((self.homeNewProductArr.count / 2) * 125))
                        }else{
                            self.constantNewProductHeight.constant = 0
                            self.newProductView.isHidden = true
                        }
                        
// FeatSeller = 108, ShopByCate = 170, FeatProduct = 250, New Product = 250, TreandingProd = 150,BestSeller = 270,HomeAppliance = 262
                        
                        // HOME APPLIANCE
                        self.homeApplianceCV.reloadData()
                        //homeApplianceArr , collVw_HomeApplianceConstantHeight
                        if self.homeApplianceArr.count != 0{
                            self.homeApplianceView.isHidden = false
                            self.collVw_HomeApplianceConstantHeight.constant = CGFloat(((self.homeApplianceArr.count / 2) * 131))
                        }else{
                            self.collVw_HomeApplianceConstantHeight.constant = 0
                            self.homeApplianceView.isHidden = true
                        }
                        
                        // BEST SELLER
                       // self.homeBestSellerArr.removeAll()
                        self.bestSellersCV.reloadData()
                        //homeBestSellerArr Constant_bestSellerHeight
                        if self.homeBestSellerArr.count != 0 {
                            self.bestSellerView.isHidden = false
                            self.Constant_bestSellerHeight.constant = CGFloat(((self.homeBestSellerArr.count / 2 ) * 135))
                        }else{
                            self.Constant_bestSellerHeight.constant = 0
                            self.bestSellerView.isHidden = true
                        }
                        
                        // TRENDING NOW PRODUCTS
                        self.trendingTV.reloadData()
                        //homeTrendingArr vw_tendingNowHeight, trendingNowVioewAllHeight
                        if self.homeTrendingArr.count != 0 {
                            self.trendingProductView.isHidden = false
                            self.vw_TrendingNowProdBg.isHidden = false
                            self.vw_tendingNowHeight.constant = CGFloat(((self.homeNewProductArr.count / 1) * 150))
                        }else{
                           // self.vw_tendingNowHeight.constant = 0
                            self.vw_TrendingNowProdBg.isHidden = true
                            self.trendingProductView.isHidden = true
                        }
                    }
                case 201:
                    ApiService.shared.showAlert(title: "", msg: "Something Went Wrong".localiz() )
                default:
                    ApiService.shared.showAlert(title: "", msg: "Something Went Wrong".localiz() )
                }
            }
        }
    }
    
}
extension HomeViewController : UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == scrollCV{
            return homeScrollImageArr.count
        }else if collectionView == shopByCateCV{
            return homeShopByCateArr.count
        }else if collectionView == FeaturedSellersCV{
            return homeFeaturedSellerArr.count
        }else if collectionView == featuredProductCV{
            return homeFeaturedProductArr.count
        }else if collectionView == newProducts{
            return homeNewProductArr.count
        }else if collectionView == bestSellersCV{
            return homeBestSellerArr.count
        }else if collectionView == homeApplianceCV{
            return homeApplianceArr.count
        }
        else{
            return 5
        }
    }
    @objc func cartButton(sender:UIButton){
        let secVC = self.storyboard?.instantiateViewController(withIdentifier: "ProductDetailsViewController") as! ProductDetailsViewController
       
        secVC.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(secVC, animated: true)
        
    }
    
    //featuredProducts
    @objc func featuredProductfavButton(sender:UIButton){
        let indexPath = IndexPath.init(row: 0, section: 0)
        let cell = featuredProductCV.cellForItem(at: indexPath) as? FeaturedProductCollectionViewCell
        let parameters:[String:Any] = ["product_id": "\(homeFeaturedProductArr[sender.tag].productId ?? "")","customer_id": "\(customerId)"]
        RemoveAndAddWishListDataResponce.AddUserData(api: "appapi/wishlist/add", parameters: parameters) { (data) in
            if data != nil{
                let status = data?.responseCode
                let text = data?.responseText ?? ""
                print("statuse Is",status ?? 0)
                switch status {
                case 1:
                    if data?.responseStatus == "0"{
                        cell?.whiteFavButton.isHidden = false
                        cell?.redFavButton.isHidden = true
                    }else{
                        cell?.whiteFavButton.isHidden = true
                        cell?.redFavButton.isHidden = false
                    }
                   ApiService.shared.showAlert(title: "", msg: "\(text)".localiz() )
                    DispatchQueue.main.async {
                        self.homeFeaturedProductArr.removeAll()
                        self.homeData()
                    }
                case 201:
                    ApiService.shared.showAlert(title: "", msg: "something" )
                default:
                    ApiService.shared.showAlert(title: "", msg: "something" )
                }
            }
        }
        
    }
    func addToCartAction(product_Id:String){
       
        let parameters:[String:Any] = ["productId":product_Id, "seller_id":"1"]
        
//        ["productId":"\(product_Id)","seller_id":"1","customer_id":"\(customerId)","quantity":"1")","option[227]":"25","option[228]":"19"]
        
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
                  ApiService.shared.showAlert(title: "", msg: "\(responseText)".localiz() )
                case 0:
                    ApiService.shared.showAlert(title: "", msg: "\(responseText)".localiz() )
                default:
                    ApiService.shared.showAlert(title: "", msg: "Please Enter Valid Email Or Password" )
                }
            }
        }
    }
    
    //new products
    @objc func newProductfavButton(sender:UIButton){
        let indexPath = IndexPath.init(row: 0, section: 0)
        let cell = newProducts.cellForItem(at: indexPath) as? NewProductsCollectionViewCell
        let parameters:[String:Any] = ["product_id": "\(homeNewProductArr[sender.tag].productId ?? "")","customer_id": "\(customerId)"]
        RemoveAndAddWishListDataResponce.AddUserData(api: "appapi/wishlist/add", parameters: parameters) { (data) in
            if data != nil{
                let status = data?.responseCode
                let text = data?.responseText ?? ""
                print("statuse Is",status ?? 0)
                switch status {
                case 1:
                    if data?.responseStatus == "0"{
                        cell?.whiteButton.isHidden = false
                        cell?.favButton.isHidden = true
                    }else{
                        cell?.whiteButton.isHidden = true
                        cell?.favButton.isHidden = false
                    }
                   ApiService.shared.showAlert(title: "", msg: "\(text)".localiz() )
                    DispatchQueue.main.async {
                        self.homeNewProductArr.removeAll()
                        self.homeData()
                    }
                case 201:
                    ApiService.shared.showAlert(title: "", msg: "something" )
                default:
                    ApiService.shared.showAlert(title: "", msg: "something" )
                }
            }
        }
        
    }
    //bestSeeler products
    @objc func bestSellrProductfavButton(sender:UIButton){
        let indexPath = IndexPath.init(row: 0, section: 0)
        let cell = bestSellersCV.cellForItem(at: indexPath) as? BestSellerCollectionViewCell
        let parameters:[String:Any] = ["product_id": "\(homeBestSellerArr[sender.tag].productId ?? "")","customer_id": "\(customerId)"]
        RemoveAndAddWishListDataResponce.AddUserData(api: "appapi/wishlist/add", parameters: parameters) { (data) in
            if data != nil{
                let status = data?.responseCode
                let text = data?.responseText ?? ""
                print("statuse Is",status ?? 0)
                switch status {
                case 1:
                    if data?.responseStatus == "0"{
                        cell?.whiteButton.isHidden = false
                        cell?.favButton.isHidden = true
                    }else{
                        cell?.whiteButton.isHidden = true
                        cell?.favButton.isHidden = false
                    }
                   ApiService.shared.showAlert(title: "", msg: "\(text)".localiz() )
                    DispatchQueue.main.async {
                        self.homeBestSellerArr.removeAll()
                        self.homeData()
                    }
                case 201:
                    ApiService.shared.showAlert(title: "", msg: "something" )
                default:
                    ApiService.shared.showAlert(title: "", msg: "something" )
                }
            }
        }
        
    }
    //Trending products
    @objc func trendingProductfavButton(sender:UIButton){
        let indexPath = IndexPath.init(row: 0, section: 0)
        //let cell = newProducts.cellForItem(at: indexPath) as? HomeTrendingAllCell
        let cell = trendingTV.cellForRow(at: indexPath) as? HomeTrendingAllCell
        let parameters:[String:Any] = ["product_id": "\(homeTrendingArr[sender.tag].productId ?? "")","customer_id": "\(customerId)"]
        RemoveAndAddWishListDataResponce.AddUserData(api: "appapi/wishlist/add", parameters: parameters) { (data) in
            if data != nil{
                let status = data?.responseCode
                let text = data?.responseText ?? ""
                print("statuse Is",status ?? 0)
                switch status {
                case 1:
                    if data?.responseStatus == "0"{
                        cell?.whiteButton.isHidden = false
                        cell?.redButton.isHidden = true
                    }else{
                        cell?.whiteButton.isHidden = true
                        cell?.redButton.isHidden = false
                    }
                   ApiService.shared.showAlert(title: "", msg: "\(text)".localiz() )
                    DispatchQueue.main.async {
                        self.homeTrendingArr.removeAll()
                        self.homeData()
                    }
                case 201:
                    ApiService.shared.showAlert(title: "", msg: "something" )
                default:
                    ApiService.shared.showAlert(title: "", msg: "something" )
                }
            }
        }
        
    }
    //HomeAppliance products
    @objc func homeApplianceProductfavButton(sender:UIButton){
        let indexPath = IndexPath.init(row: 0, section: 0)
        let cell = homeApplianceCV.cellForItem(at: indexPath) as? HomeApplianceCollectionViewCell
        
        let parameters:[String:Any] = ["product_id": "\(homeApplianceArr[sender.tag].productId ?? "")","customer_id": "\(customerId)"]
        RemoveAndAddWishListDataResponce.AddUserData(api: "appapi/wishlist/add", parameters: parameters) { (data) in
            if data != nil{
                let status = data?.responseCode
                let text = data?.responseText ?? ""
                print("statuse Is",status ?? 0)
                switch status {
                case 1:
                    if data?.responseStatus == "0"{
                        cell?.whiteButton.isHidden = false
                        cell?.favButton.isHidden = true
                    }else{
                        cell?.whiteButton.isHidden = true
                        cell?.favButton.isHidden = false
                    }
                   ApiService.shared.showAlert(title: "", msg: "\(text)".localiz() )
                    DispatchQueue.main.async {
                        self.homeApplianceArr.removeAll()
                        self.homeData()
                    }
                case 201:
                    ApiService.shared.showAlert(title: "", msg: "something" )
                default:
                    ApiService.shared.showAlert(title: "", msg: "something" )
                }
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
       
        if collectionView == scrollCV {
            let cell = scrollCV.dequeueReusableCell(withReuseIdentifier: "ScrollImageCollectionViewCell", for: indexPath) as! ScrollImageCollectionViewCell
            pageView.numberOfPages = homeScrollImageArr.count
            cell.homeSetUP(homeScrollImageArr[indexPath.row])
           return cell
        }else if collectionView == shopByCateCV{
            let cell = shopByCateCV.dequeueReusableCell(withReuseIdentifier: "ShopByCateCollectionViewCell", for: indexPath) as! ShopByCateCollectionViewCell
            cell.homeSetUP(homeShopByCateArr[indexPath.row])
            
            return cell
            
        }else if collectionView == FeaturedSellersCV{
            let cell = FeaturedSellersCV.dequeueReusableCell(withReuseIdentifier: "FeaturedSellersCollectionViewCell", for: indexPath) as! FeaturedSellersCollectionViewCell
            cell.homeSetUP(homeFeaturedSellerArr[indexPath.row])
            return cell
        }else if collectionView == featuredProductCV{
            let cell = featuredProductCV.dequeueReusableCell(withReuseIdentifier: "FeaturedProductCollectionViewCell", for: indexPath) as! FeaturedProductCollectionViewCell
            cell.bucketButton.addTarget(self, action: #selector(cartButton(sender:)), for: .touchUpInside)
            cell.homeSetUP(homeFeaturedProductArr[indexPath.row])
            
            cell.redFavButton.tag = indexPath.row
            cell.whiteFavButton.tag = indexPath.row
            wishId = "\(homeFeaturedProductArr[indexPath.row].isWishlist ?? "")"
            cell.redFavButton.addTarget(self, action: #selector(featuredProductfavButton(sender:)), for: .touchUpInside)
            cell.whiteFavButton.addTarget(self, action: #selector(featuredProductfavButton(sender:)), for: .touchUpInside)
             print("wishId",wishId)
            if wishId == "0"{
                cell.whiteFavButton.addTarget(self, action: #selector(featuredProductfavButton(sender:)), for: .touchUpInside)
                cell.whiteFavButton.isHidden = false
                cell.redFavButton.isHidden = true
            }else if wishId == "1"{
                cell.redFavButton.addTarget(self, action: #selector(featuredProductfavButton(sender:)), for: .touchUpInside)
                cell.whiteFavButton.isHidden = true
                cell.redFavButton.isHidden = false
            }
            return cell
        }else if collectionView == newProducts{
            let cell = newProducts.dequeueReusableCell(withReuseIdentifier: "NewProductsCollectionViewCell", for: indexPath) as! NewProductsCollectionViewCell
            
             cell.homeSetUP(homeNewProductArr[indexPath.row])
            
            cell.favButton.tag = indexPath.row
            cell.whiteButton.tag = indexPath.row
            wishId = "\(homeNewProductArr[indexPath.row].isWishlist ?? "")"
            cell.favButton.addTarget(self, action: #selector(newProductfavButton(sender:)), for: .touchUpInside)
            cell.whiteButton.addTarget(self, action: #selector(newProductfavButton(sender:)), for: .touchUpInside)
             print("wishId",wishId)
            if wishId == "0"{
                cell.whiteButton.addTarget(self, action: #selector(newProductfavButton(sender:)), for: .touchUpInside)
                cell.whiteButton.isHidden = false
                cell.favButton.isHidden = true
            }else if wishId == "1"{
                cell.favButton.addTarget(self, action: #selector(newProductfavButton(sender:)), for: .touchUpInside)
                cell.whiteButton.isHidden = true
                cell.favButton.isHidden = false
            }
            return cell
        }else if collectionView == bestSellersCV{
            let cell = bestSellersCV.dequeueReusableCell(withReuseIdentifier: "BestSellerCollectionViewCell", for: indexPath) as! BestSellerCollectionViewCell
            cell.homeSetUP(homeBestSellerArr[indexPath.row])
            cell.cartButton.addTarget(self, action: #selector(cartButton(sender:)), for: .touchUpInside)
            
            cell.favButton.tag = indexPath.row
            cell.whiteButton.tag = indexPath.row
            wishId = "\(homeBestSellerArr[indexPath.row].isWishlist ?? "")"
            cell.favButton.addTarget(self, action: #selector(bestSellrProductfavButton(sender:)), for: .touchUpInside)
            cell.whiteButton.addTarget(self, action: #selector(bestSellrProductfavButton(sender:)), for: .touchUpInside)
             print("wishId",wishId)
            if wishId == "0"{
                cell.whiteButton.addTarget(self, action: #selector(bestSellrProductfavButton(sender:)), for: .touchUpInside)
                cell.whiteButton.isHidden = false
                cell.favButton.isHidden = true
            }else if wishId == "1"{
                cell.favButton.addTarget(self, action: #selector(bestSellrProductfavButton(sender:)), for: .touchUpInside)
                cell.whiteButton.isHidden = true
                cell.favButton.isHidden = false
            }
            return cell
        }else{
            let cell = homeApplianceCV.dequeueReusableCell(withReuseIdentifier: "HomeApplianceCollectionViewCell", for: indexPath) as! HomeApplianceCollectionViewCell
            cell.cartButton.addTarget(self, action: #selector(cartButton(sender:)), for: .touchUpInside)
            cell.homeSetUP(homeApplianceArr[indexPath.row])
            
            cell.favButton.tag = indexPath.row
            cell.whiteButton.tag = indexPath.row
            wishId = "\(homeApplianceArr[indexPath.row].isWishlist ?? "")"
            cell.favButton.addTarget(self, action: #selector(homeApplianceProductfavButton(sender:)), for: .touchUpInside)
            cell.whiteButton.addTarget(self, action: #selector(homeApplianceProductfavButton(sender:)), for: .touchUpInside)
             print("wishId",wishId)
            if wishId == "0"{
                cell.whiteButton.addTarget(self, action: #selector(homeApplianceProductfavButton(sender:)), for: .touchUpInside)
                cell.whiteButton.isHidden = false
                cell.favButton.isHidden = true
            }else if wishId == "1"{
                cell.favButton.addTarget(self, action: #selector(homeApplianceProductfavButton(sender:)), for: .touchUpInside)
                cell.whiteButton.isHidden = true
                cell.favButton.isHidden = false
            }
            return cell
        }
        
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == featuredProductCV{
        let secVC = self.storyboard?.instantiateViewController(withIdentifier: "ProductDetailsViewController") as! ProductDetailsViewController
            secVC.productId = homeFeaturedProductArr[indexPath.row].productId ?? ""
            secVC.sellerId = homeFeaturedProductArr[indexPath.row].seller_id ?? ""
            secVC.imageString = homeFeaturedProductArr[indexPath.row].thumb ?? ""
        secVC.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(secVC, animated: true)
        }else if collectionView == newProducts{
            let secVC = self.storyboard?.instantiateViewController(withIdentifier: "ProductDetailsViewController") as! ProductDetailsViewController
                secVC.productId = homeNewProductArr[indexPath.row].productId ?? ""
                secVC.sellerId = "1"
            secVC.imageString = homeNewProductArr[indexPath.row].thumb ?? ""
            secVC.hidesBottomBarWhenPushed = true
            self.navigationController?.pushViewController(secVC, animated: true)
        }else if collectionView == bestSellersCV{
            let secVC = self.storyboard?.instantiateViewController(withIdentifier: "ProductDetailsViewController") as! ProductDetailsViewController
                secVC.productId = homeBestSellerArr[indexPath.row].productId ?? ""
                secVC.sellerId = "1"
            secVC.imageString = homeBestSellerArr[indexPath.row].thumb ?? ""
            secVC.hidesBottomBarWhenPushed = true
            self.navigationController?.pushViewController(secVC, animated: true)
        }else if collectionView == homeApplianceCV{
            let secVC = self.storyboard?.instantiateViewController(withIdentifier: "ProductDetailsViewController") as! ProductDetailsViewController
                secVC.productId = homeApplianceArr[indexPath.row].productId ?? ""
                secVC.sellerId = "1"
            secVC.imageString = homeApplianceArr[indexPath.row].thumb ?? ""
            secVC.hidesBottomBarWhenPushed = true
            self.navigationController?.pushViewController(secVC, animated: true)
        }else if collectionView == shopByCateCV{
            let secVC = self.storyboard?.instantiateViewController(withIdentifier: "SortAndFilterViewController") as! SortAndFilterViewController
                secVC.cateId = homeShopByCateArr[indexPath.row].categoryId ?? ""
            secVC.extraParam = "appapi/product/category_wise_product"
            secVC.hidesBottomBarWhenPushed = true
            self.navigationController?.pushViewController(secVC, animated: true)
        }
    }
    
    // MARK: - UICollectionViewDelegateFlowLayout
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//       var width = CGFloat()
//       var height = CGFloat()
        
       
        
        if collectionView == scrollCV{
            let size = CGSize(width: collectionView.bounds.width, height: collectionView.bounds.height)
            return size
        }else if collectionView == FeaturedSellersCV{
            let size = CGSize(width: 90, height: 45)
            return size
        }else if collectionView == featuredProductCV{
//            let size = (collectionView.frame.size.width - 10) / 2
//            return CGSize(width: size, height: size)
//            let noOfColumn = 2
//            let collectionviewWidth = collectionView.frame.width
//            let bothEdge =  CGFloat(5 + 5) // left + right
//            let excludingEdge = collectionviewWidth - bothEdge
//            let cellWidthExcludingSpaces = excludingEdge - (CGFloat((noOfColumn - 1)) * 2.0)
//            let finalCellWidth = CGFloat(cellWidthExcludingSpaces / CGFloat(noOfColumn))
//            let heighthyy = finalCellWidth
//
//            width = finalCellWidth
//            height = finalCellWidth * 50
            let size = CGSize(width: 175, height: 240)
            return size

        }else if collectionView == newProducts{
//            let size = (collectionView.frame.size.width - 10) / 2
//            return CGSize(width: size, height: size)
            let size = CGSize(width: 175, height: 240)
            return size
        }else if collectionView == bestSellersCV{
//            let size = (collectionView.frame.size.width - 10) / 2
//            return CGSize(width: size, height: size)
            let size = CGSize(width: 175, height: 260)
            return size
        }else if collectionView == homeApplianceCV{
//            let size = (collectionView.frame.size.width - 10) / 2
//            return CGSize(width: size, height: size)
            let size = CGSize(width: 175, height: 240)
            return size
        }
        else{
            let size = CGSize(width: 135, height: 170)
            return size
        }
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        if collectionView == FeaturedSellersCV{
            return UIEdgeInsets(top: 5, left: 0, bottom: 5, right: 5)
            
        }
        else{
            return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        }
        
    }
    
}
extension HomeViewController : UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return homeTrendingArr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = trendingTV.dequeueReusableCell(withIdentifier: "HomeTrendingAllCell", for: indexPath) as! HomeTrendingAllCell
        cell.homeSetUP(homeTrendingArr[indexPath.row])
        cell.selectionStyle = .none
        
        cell.redButton.tag = indexPath.row
        cell.whiteButton.tag = indexPath.row
        
        wishId = "\(homeTrendingArr[indexPath.row].isWishlist ?? "")"
        cell.redButton.addTarget(self, action: #selector(trendingProductfavButton(sender:)), for: .touchUpInside)
        
        cell.whiteButton.addTarget(self, action: #selector(trendingProductfavButton(sender:)), for: .touchUpInside)
        
         print("wishId",wishId)
        if wishId == "0"{
            cell.whiteButton.addTarget(self, action: #selector(trendingProductfavButton(sender:)), for: .touchUpInside)
            cell.whiteButton.isHidden = false
            cell.redButton.isHidden = true
        }else if wishId == "1"{
            cell.redButton.addTarget(self, action: #selector(trendingProductfavButton(sender:)), for: .touchUpInside)
            cell.whiteButton.isHidden = true
            cell.redButton.isHidden = false
        }
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let secVC = self.storyboard?.instantiateViewController(withIdentifier: "ProductDetailsViewController") as! ProductDetailsViewController
            secVC.productId = homeTrendingArr[indexPath.row].productId ?? ""
            secVC.sellerId = "1"
        secVC.imageString = homeTrendingArr[indexPath.row].thumb ?? ""
        secVC.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(secVC, animated: true)
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
    
    
}
class HomeTrendingAllCell: UITableViewCell {
    
    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var lineLabel: UILabel!
    @IBOutlet weak var redButton: UIButton!
    @IBOutlet weak var whiteButton: UIButton!
    @IBOutlet weak var oldPriceLabel: UILabel!
    @IBOutlet weak var newPriceLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var trendingView: UIView!
    override func awakeFromNib() {
        super.awakeFromNib()
        mainView.layer.cornerRadius = 10
        mainView.layer.masksToBounds = false
    }
    func homeSetUP(_ cateDetails: Trending_product){
        
        let name = cateDetails.name ?? ""
        let str = name.stripOutHtml()
        nameLabel.text = str
        let tax = cateDetails.tax ?? ""
        let price = cateDetails.price ?? ""
        let dd = "USD"
        let rr = tax + " \(dd)"
        let newString = price.replacingOccurrences(of: "USD", with: "")
        if price == rr{
            oldPriceLabel.text = ""
            lineLabel.isHidden = true
           
        }else{
            oldPriceLabel.text = newString
            lineLabel.isHidden = false
        }
        newPriceLabel.text = cateDetails.tax ?? ""
        let data = cateDetails.thumb ?? ""
       DispatchQueue.main.async {
            if let imageUrl:URL = URL(string:"\(data)") {
                self.imgView.kf.setImage(with: imageUrl)
            
       }
        }
    }
}
//extension UIImage {
//    func imageWithColor(color1: UIColor) -> UIImage {
//        UIGraphicsBeginImageContextWithOptions(self.size, false, self.scale)
//        color1.setFill()
//
//        let context = UIGraphicsGetCurrentContext()
//        context?.translateBy(x: 0, y: self.size.height)
//        context?.scaleBy(x: 1.0, y: -1.0)
//        context?.setBlendMode(CGBlendMode.normal)
//
//        let rect = CGRect(origin: .zero, size: CGSize(width: self.size.width, height: self.size.height))
//        context?.clip(to: rect, mask: self.cgImage!)
//        context?.fill(rect)
//
//        let newImage = UIGraphicsGetImageFromCurrentImageContext()
//        UIGraphicsEndImageContext()
//
//        return newImage!
//    }
//}

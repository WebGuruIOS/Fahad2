//
//  AboutUsViewController.swift
//  Fahad
//
//  Created by Kondalu on 30/08/21.
//

import UIKit
import WebKit

class AboutUsViewController: UIViewController, WKUIDelegate{

  
    @IBOutlet weak var webView: WKWebView!
   
    @IBOutlet weak var pageNameLabel: UILabel!
    var str_PageHeader = String()
    
    var pageId = String()
    override func viewDidLoad() {
        super.viewDidLoad()
         pageDespData()
        self.setNeedsStatusBarAppearanceUpdate()
        self.pageNameLabel.text = str_PageHeader
       // self.webView.uiDelegate = self
      
    }
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
   
    
    func pageDespData(){
     
        let parameters:[String:Any] = ["page_id":"\(pageId)"]
        ViewMoreDataResponce.AddUserData(api: "appapi/home/page_description", parameters: parameters) { (data) in
            if data != nil{
                let responseCode = data?.responseCode
                let responseText = data?.responseText ?? ""
                let code = data?.responseData
                var page_URL = code?.page_url
               // self.pageDespTV.text = code?.page_title ?? ""
               // let gg = code?.page_description ?? "No data Found"
               // let str = gg.stripOutHtml()
                
               // self.pageDespTV.text = str
                print("statuse Is",responseCode ?? 0)
                switch responseCode {
                case 1:
                 print("sucess")
                    DispatchQueue.main.async {
                    let urlWeb = URL(string:page_URL ?? "")
                    let request = URLRequest(url: urlWeb!)
                    print("URL:",request)
                    self.webView.load(NSURLRequest(url: NSURL(string:page_URL ?? "" )! as URL) as URLRequest)
                    }
                   // UIWebView.load(request)
                
                case 0:
                    ApiService.shared.showAlert(title: "", msg: "\(responseText)" )
                default:
                    ApiService.shared.showAlert(title: "", msg: "Please Enter Valid Email Or Password" )
                }
            }
        }
    }
    @IBAction func backButtonAction(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
}
extension String {

    func stripOutHtml() -> String? {
        do {
            guard let data = self.data(using: .unicode) else {
                return nil
            }
            let attributed = try NSAttributedString(data: data, options: [.documentType: NSAttributedString.DocumentType.html, .characterEncoding: String.Encoding.utf8.rawValue], documentAttributes: nil)
            return attributed.string
        } catch {
            return nil
        }
    }
}
extension AboutUsViewController: WKNavigationDelegate{
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        ACProgressHUD.shared.showHUD()
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        ACProgressHUD.shared.hideHUD()
    }
    
    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
        ACProgressHUD.shared.hideHUD()
    }
}

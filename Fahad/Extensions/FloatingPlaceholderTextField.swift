//
//  FloatingPlaceholderTextField.swift
//  Fahad
//
//  Created by Kondalu on 19/08/21.
//

//import Foundation
//
//
//@IBDesignable
//class FloatingPlaceholderTextField: UIView{
//    
//    private var textInput: MDCTextField!
//    private var controller: MDCTextInputControllerOutlined!
//    private let textColor = UIColor(named: "textColor") // Dynamic dark & light color created in the assets folder
//    private var placeHolderText = ""
//    private var radius = ""
//    private var text = ""
//    @IBInspectable var setPlaceholder: String{
//        get{
//            return placeHolderText
//        }
//        set(str){
//            placeHolderText = str
//        }
//    }
//    @IBInspectable var text1: String{
//        get{
//            return text
//        }
//        set(str){
//            text = str
//        }
//    }
//    override func layoutSubviews() {
//       
//        setupInputView()
//        setupContoller()
//           
//    }
//    
//    private func setupInputView(){
//        //MARK: Text Input Setup
//        
//        if let _ = self.viewWithTag(1){return}
//        
//        textInput = MDCTextField()
//      //  textInput.roundCorners(corners: .allCorners, radius: 20)
//        textInput.tag = 1
//        
//        textInput.translatesAutoresizingMaskIntoConstraints = false
//               
//        self.addSubview(textInput)
//        
//        textInput.placeholder = placeHolderText
//        
//        textInput.delegate = self
//        
//        textInput.textColor = textColor
//        
//        NSLayoutConstraint.activate([
//            (textInput.topAnchor.constraint(equalTo: self.topAnchor)),
//            (textInput.bottomAnchor.constraint(equalTo: self.bottomAnchor)),
//            (textInput.leadingAnchor.constraint(equalTo: self.leadingAnchor)),
//            (textInput.trailingAnchor.constraint(equalTo: self.trailingAnchor))
//        ])
//    }
//    
//    private func setupContoller(){
//        // MARK: Text Input Controller Setup
//        
//        controller = MDCTextInputControllerOutlined(textInput: textInput)
//        
//        controller.activeColor = textColor
//        controller.normalColor = textColor
//        controller.textInput?.textColor = textColor
//        controller.inlinePlaceholderColor = textColor
//        controller.floatingPlaceholderActiveColor = textColor
//        controller.floatingPlaceholderNormalColor = textColor
//        
//    }
//    
//    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
//        textField.resignFirstResponder()
//    }
//    
//}
//
//extension FloatingPlaceholderTextField: UITextFieldDelegate {
//    
//}

//
//  MainMenuPopUp.swift
//  GameTry
//
//  Created by Samuel Hong on 5/19/22.
//

import Foundation
import UIKit

class MainMenuPopUp : UIView{
    
    let popupView = UIView(frame: CGRect.zero)
    let popupTitle = UILabel(frame: CGRect.zero)
    let popupText = UILabel(frame: CGRect.zero)
    let popupButton = UIButton(frame: CGRect.zero)
        
    let BorderWidth: CGFloat = 2.0
    
    init(){
        super.init(frame:CGRect.zero)
    }
    required init?(coder aDecoder: NSCoder){
        fatalError("init(coder:) has not been implemented")
    }
    
}

//
//  LoginViewModel.swift
//  AccentureAssessment
//
//  Created by Gurleen kaur on 14/5/25.
//

import Foundation
import UIKit

class LoginViewModel {

    func validateEmailField(_ txtField: UITextField)-> (Bool, String) {
       if txtField.text!.isEmpty {
           return (false, Constants.Strings.kEnterEmail)
       }
       if (txtField.text!.trimmingCharacters(in: CharacterSet.whitespaces)).count == 0 {
           txtField.text = Constants.Strings.kEmptyString
           return (false, Constants.Strings.kEnterEmail)
       }
       
        let emailTest = NSPredicate(format: Constants.Strings.kEmailFormat, Constants.Strings.kEmailRegX)
       
       let result = emailTest.evaluate(with: txtField.text)
       
       if result {
           return(true, Constants.Strings.kEmptyString)
       } else {
           return(false, Constants.Strings.kEnterValidEmail)
       }
   }
   
    func validatePasswordTextField(_ txtField: UITextField)-> (Bool, String) {
       var (Success,Message) = (true,Constants.Strings.kEmptyString)
       
       if txtField.text!.isEmpty {
           (Success,Message) = (false, Constants.Strings.kEnterPassword)
           return (Success,Message)
       }
       
       if (txtField.text!.trimmingCharacters(in: CharacterSet.whitespaces)).count == 0 {
           txtField.text = Constants.Strings.kEmptyString
           (Success,Message) = (false, Constants.Strings.kEnterPassword)
           return (Success,Message)
       }
       
       if txtField.text?.count ?? 0 > 15 {
           (Success,Message) = (false, Constants.Strings.kEnterPasswordNotMoreThan15)
           return (Success,Message)
       }
       
       if txtField.text?.count ?? 0 < 8 {
           (Success,Message) = (false, Constants.Strings.kEnterPasswordNotLessThan8)
           return (Success,Message)
       }
       return (Success,Message)
   }
}

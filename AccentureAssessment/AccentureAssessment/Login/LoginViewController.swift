//
//  LoginViewController.swift
//  AccentureAssessment
//
//  Created by Gurleen kaur on 12/5/25.
//

import UIKit

class LoginViewController: UIViewController {
    
    //MARK: Variables
    private let viewModel = LoginViewModel()
    
    //MARK: Outlets
    @IBOutlet weak var txtFieldEmail: UITextField!
    @IBOutlet weak var txtFieldPassword: UITextField!
    @IBOutlet weak var btnLogin: UIButton!
    @IBOutlet weak var lblErrorEmail: UILabel!
    @IBOutlet weak var lblErrorPassword: UILabel!
    
    //MARK: View Functions
    override func viewDidLoad() {
        super.viewDidLoad()
        btnLogin.isEnabled = false
        btnLogin.alpha = 0.5
        txtFieldEmail.addTarget(self, action: #selector(textFieldsChanged), for: .editingChanged)
        txtFieldPassword.addTarget(self, action: #selector(textFieldsChanged), for: .editingChanged)
    }
    
    //MARK: Functions
    @objc func textFieldsChanged() {
        let (isEmailValid, emailErrorMsg) = viewModel.validateEmailField(txtFieldEmail)
        let (isPasswordValid, passwordErrorMsg) = viewModel.validatePasswordTextField(txtFieldPassword)
        let attributedSuccess = NSAttributedString(string: Constants.Strings.kEmptyString)
        lblErrorEmail.attributedText = isEmailValid ? attributedSuccess : errorMessage(warningText: emailErrorMsg)
        lblErrorPassword.attributedText = isPasswordValid ? attributedSuccess : errorMessage(warningText: passwordErrorMsg)
        btnLogin.isEnabled = isEmailValid && isPasswordValid
        btnLogin.alpha = btnLogin.isEnabled ? 1.0 : 0.5
    }
    
    func navigateToMainScreen() {
        if let tabBarVC = storyboard?.instantiateViewController(withIdentifier: Constants.Identifier.kMainTabBarController) as? UITabBarController {
            tabBarVC.modalPresentationStyle = .fullScreen
            present(tabBarVC, animated: true, completion: nil)
        }
    }
    
    func errorMessage(warningText: String) -> NSMutableAttributedString {
        let attachment = NSTextAttachment()
        attachment.image = UIImage(systemName: Constants.Assets.kExclamationCircle)?.withTintColor(.systemRed, renderingMode: .automatic)
        let fullString = NSMutableAttributedString(attachment: attachment)
        fullString.append(NSAttributedString(string: Constants.Strings.kSpaceString))
        fullString.append(NSAttributedString(string: warningText))
        return fullString
    }
    
    //MARK: Actions
    @IBAction func loginAction(_ sender: Any) {
        UserDefaults.standard.set(true, forKey: Constants.Strings.kIsLoggedIn)
        navigateToMainScreen()
    }
    
}

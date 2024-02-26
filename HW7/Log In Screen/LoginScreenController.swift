//
//  LoginScreenController.swift
//  HW7
//
//  Created by Jefferson Cuartas on 11/1/23.
//

import UIKit
import Alamofire

class LoginScreenController: UIViewController {
    
    let loginScreen = LoginScreenView()
    
    let defaults = UserDefaults.standard
        
    override func loadView() {
            view = loginScreen
        }

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Log In"
        
        // check is user is authenticated, if so proceed to redirect the user to home screen
        isUserAuthenticated()

        // Do any additional setup after loading the view.
        loginScreen.buttonLogin.addTarget(self, action: #selector(onButtonLoginTapped), for: .touchUpInside)
        
        // Do any additional setup after loading the view.
        loginScreen.buttonSignup.addTarget(self, action: #selector(onButtonSignupTapped), for: .touchUpInside)
        
    }
    
    func setAuthToken(authToken: String){
        self.defaults.set(authToken, forKey: "authToken")
    }
    
    func isUserAuthenticated(){
        let autTokenSaved = defaults.object(forKey: "authToken") as! String?
    
        if let token = autTokenSaved {
            print("Authenticated! Redirecting to home screen..")
            let homeScreenController = ViewController()
            homeScreenController.authToken = token
            homeScreenController.delegate = self
            self.navigationController?.pushViewController(homeScreenController, animated: true)
            
        } else {
            print("No auth token...must login in")
        }
    }
    
    func displayErrorAlert(message: String){
        let alert = UIAlertController(
            title: "Error!",
            message: message,
            preferredStyle: .alert
        )
        
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        self.present(alert, animated: true)
    }
    
    @objc func onButtonSignupTapped(){
        let signupScreenController = SignupScreenController()
        navigationController?.pushViewController(signupScreenController, animated: true)
    }
    
    @objc func onButtonLoginTapped(){
        if let email = loginScreen.textFieldEmail.text, let password = loginScreen.textFieldPassword.text {
            
            if !email.isEmpty && !password.isEmpty {
                
                if Utilities.isValidEmail(email) != true {
                    let msg = "Please enter a valid email"
                    displayErrorAlert(message: msg)
                    return
                }
                
                let user = User(email: email, password: password, name: "")
                logIn(user: user)
                
            } else {
                let msg = "All fields are required"
                displayErrorAlert(message: msg)
            }
        }
    }
    
    func logIn(user: User){
        if let url = URL(string: APIConfigs.authURL+"login"){
            
            AF.request(url, method:.post, parameters:
                        [
                            //MARK: we can unwrap them here since we made sure they are not null above...
                            "email": user.email,
                            "password": user.password,
                        ])
                .responseData(completionHandler: { response in
                    //MARK: retrieving the status code...
                    let status = response.response?.statusCode
                    
                    switch response.result{
                    case .success(let data):
                        //MARK: there was no network error...
                        
                        //MARK: status code is Optional, so unwrapping it...
                        if let uwStatusCode = status{
                            switch uwStatusCode{
                                //MARK: the request was valid 200-level...
                                case 200...299:
                                //decoder
                                let decoder = JSONDecoder()
                                do{
                                    let receivedData = try decoder
                                        .decode(Token.self, from: data)
                                    print("Login successful")
                                    //Save token in user defaults
                                    let tokenSaved = receivedData.token
                                    self.defaults.set(tokenSaved, forKey: "authToken")
                                    
                                    //instantiate home controller
                                    let homeScreenController = ViewController()
                                    homeScreenController.authToken = tokenSaved
                                    homeScreenController.delegate = self
                                    self.navigationController?.pushViewController(homeScreenController, animated: true)
                                }catch{

                                }
                                    break
                        
                                case 400...499:
                                //MARK: the request was not valid 400-level...
                                    print(data)
                                    let errorMsg = "Sorry your email or password is incorrect. Please try again."
                                    self.displayErrorAlert(message: errorMsg)
                                    break
                        
                                default:
                                //MARK: probably a 500-level error...
                                    print(data)
                                    break
                        
                            }
                        }
                        break
                        
                    case .failure(let error):
                        //MARK: there was a network error...
                        print(error)
                        break
                    }
                })
        }else{
        }
    }
}

//
//  SignupScreenController.swift
//  HW7
//
//  Created by Jefferson Cuartas on 11/1/23.
//

import UIKit
import Alamofire

class SignupScreenController: UIViewController {
    
    let signupScreen = SignupScreenView()
        
    override func loadView() {
            view = signupScreen
        }

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Sign Up"

        // Do any additional setup after loading the view.
        signupScreen.buttonSignup.addTarget(self, action: #selector(onButtonSignupTapped), for: .touchUpInside)
    }
    
    @objc func onButtonSignupTapped(){
        
        if let email = signupScreen.textFieldEmail.text, let password = signupScreen.textFieldPassword.text, let name = signupScreen.textFieldName.text{
            
            if !email.isEmpty && !password.isEmpty && !name.isEmpty {
                
                if Utilities.isValidEmail(email) != true {
                    let msg = "invalid email"
                    displayErrorAlert(message: msg)
                    return
                }
                
                let user = User(email: email, password: password, name: name)
                print(user)
                signUp(user: user)
                
            } else {
                let msg = "All fields are required"
                displayErrorAlert(message: msg)
            }
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
        
    func signUp(user: User){
        print("Sign up was called")
        if let url = URL(string: APIConfigs.authURL+"register"){
            
            AF.request(url, method:.post, parameters:
                        [
                            //MARK: we can unwrap them here since we made sure they are not null above...
                            "name": user.name,
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
                                case 200...299:
                                //MARK: the request was valid 200-level...
                                    //prompt the user sign up was successful
                                    //set auth token to data token response value
                                    //pop controller
                                    //redirect to view controller (home screen)
                                    let decoder = JSONDecoder()
                                    do{
                                        let receivedData = try decoder
                                            .decode(Token.self, from: data)
                                        print(receivedData.token)
                                        //prompt the user login was successful
                                        print("Registration successful")
                                        //Save token in user defaults
                                        let tokenSaved = receivedData.token
                                        //instantiate login controller
                                        let loginScreenController = LoginScreenController()
                                        //set authToken
                                        loginScreenController.setAuthToken(authToken: tokenSaved)
    
                                        //home controller
                                        let homeScreenController = ViewController()
                                        homeScreenController.authToken = tokenSaved
                                        homeScreenController.delegate = loginScreenController
                                        
                                        //redirect
                                        self.navigationController?.pushViewController(homeScreenController, animated: true)
                                        
                                    }catch{

                                    }
                                
                                    break
                        
                                case 400...499:
                                //MARK: the request was not valid 400-level...
                                print(data)
                                    break
                        
                                default:
                                //MARK: probably a 500-level error...
                                    let errorMsg = "The user already exists"
                                    self.displayErrorAlert(message: errorMsg)
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

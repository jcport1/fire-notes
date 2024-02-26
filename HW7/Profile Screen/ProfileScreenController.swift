//
//  ProfileScreenController.swift
//  HW7
//
//  Created by Jefferson Cuartas on 11/5/23.
//

import UIKit
import Alamofire

class ProfileScreenController: UIViewController {
    
    let profileScreen = ProfileScreenView()
    
    var authToken: String!
    
    override func loadView() {
            view = profileScreen
        }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Profile"
        
        getProfileDetails()
        
    }
    
    func setProfileDetails(registeredUser: RegisteredUser){
        profileScreen.textLabelName.text = "Name: \(registeredUser.name)"
        profileScreen.textLabelEmail.text = "Email: \(registeredUser.email)"
        
    }
    
    func getProfileDetails(){
        if let url = URL(string: APIConfigs.authURL + "me"){
            AF.request(url, method: .get,
                headers: [
                    "x-access-token": authToken
                ]).responseDecodable(of: RegisteredUser.self){ response in
                //MARK: retrieving the status code...
                let status = response.response?.statusCode
                
                switch response.result{
                case .success(let data):
                    //MARK: there was no network error...
                    
                    //status code is Optional, so unwrapping it...
                    if let uwStatusCode = status{
                        switch uwStatusCode{
                            case 200...299:
                            //MARK: the request was valid 200-level...
                            print(data)
                            self.setProfileDetails(registeredUser: data)
                                break
                    
                            case 400...499:
                            //MARK: the request was not valid 400-level...
                            print(data)
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
            }
        }
    }

}

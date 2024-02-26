//
//  NotesAPICalls.swift
//  HW7
//  Resources:
//  - Swipe Delete in UIKit: https://www.hackingwithswift.com/example-code/uikit/how-to-swipe-to-delete-uitableviewcells
//  Created by Jefferson Cuartas on 11/1/23.
//

import Foundation
import UIKit
import Alamofire

extension ViewController:NotesProtocol{
    //MARK: get all notes...
    func getAllNotes(){
        if let url = URL(string: APIConfigs.baseURL + "getall"){
            AF.request(url, method: .get,
                headers: [
                    "x-access-token": authToken
                ]).responseDecodable(of: NoteIfo.self){ response in
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
                                self.userNotes = data.notes
                                print(self.userNotes)
                                self.mainScreen.tableViewNotes.reloadData()
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
    
    //MARK: add a new contact call: add endpoint...
    func addANewNote(note: String){
        if let url = URL(string: APIConfigs.baseURL+"post"){
            
            AF.request(url, method:.post, parameters:
                        [
                            //MARK: we can unwrap them here since we made sure they are not null above...
                            "text": note
                        ], headers: [
                            "x-access-token": authToken
                        ])
                .responseString(completionHandler: { response in
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
                                self.getAllNotes()
                                self.clearAddViewFields()
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
                })
        }else{
            //alert that the URL is invalid...
        }
    }
    
    func deleteNote(id: String){
        if let url = URL(string: APIConfigs.baseURL+"delete"){
            
            AF.request(url, method:.post, parameters:
                        [
                            //MARK: we can unwrap them here since we made sure they are not null above...
                            "id": id
                        ], headers: [
                            "x-access-token": authToken
                        ])
                .responseString(completionHandler: { response in
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
                                    self.getAllNotes()
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
                })
        }else{
            //alert that the URL is invalid...
        }
        
        
    }
}

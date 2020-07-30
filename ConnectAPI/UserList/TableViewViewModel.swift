//
//  TableViewViewModel.swift
//  ConnectAPI
//
//  Created by gibntn on 26/7/2563 BE.
//  Copyright © 2563 nattanat. All rights reserved.
//

import UIKit
import Alamofire

struct User: Codable {
    let userId: Int
    let id: Int
    let title: String
    let body: String
}

//Step 1: Make a delegate protocol
protocol TableViewViewModelDelegate: class {
    func userDataDidDownloadData(sender: TableViewViewModel)
}

class TableViewViewModel {
    //Step 2: Make a public delegate property
    weak var delegate: TableViewViewModelDelegate?
    private let apiURL = "https://jsonplaceholder.typicode.com/posts"
    var allUsers: [User] = .init()
    var uId = [Int]() // [1,2,3,4,5,6,7,8,9,10]
    var userGroup = [[User]]() // [[{User1},{User2},...,{User10}],[{User11},...,{User20}],...,[{User91},...,{User100}]]

    func getDataFromAPI() {

        guard let url = URL(string: apiURL) else {
            print("URL is false")
            return
        }
        
        Alamofire.request(url).response(completionHandler: completionHandler)
    }
    
    func completionHandler(response: DefaultDataResponse) {
        DispatchQueue.main.async {
            if let unwrappedError = response.error {
                // ทำอะไรกับ error ซักอย่าง
                print(unwrappedError.localizedDescription)
            }
            if let unwrappedData = response.data,
                let user = try? JSONDecoder().decode([User].self, from: unwrappedData) {
                self.didDownload(users: user)
            }
        }
    }
    
    private func didDownload(users: [User]) {
        allUsers = users
        
        (allUsers).forEach({ (user) in
            if uId.contains(user.userId) == false {
                uId.append(user.userId)
                userGroup.append([User]())
            }
            userGroup[user.userId-1].append(user)
        })
        
        //Step 5: Update the delegate so that object listening to you can get the data
        delegate?.userDataDidDownloadData(sender: self)
    }
}

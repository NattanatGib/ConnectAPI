//
//  TableViewViewModel.swift
//  ConnectAPI
//
//  Created by gibntn on 26/7/2563 BE.
//  Copyright © 2563 nattanat. All rights reserved.
//

import UIKit
import Alamofire

//Step 1: Make a delegate protocol
protocol TableViewViewModelDelegate: class {
    func userDataDidDownloadData(sender: TableViewViewModel)
    func userDataDidnotDownloadData(error: Error)
}

class TableViewViewModel {
    func receivedUserData(sender: UserDataUseCase) {
//        ส่ง data ไปให้ View Controller
    }
    
    let useCase = UserDataUseCase()
    //Step 2: Make a public delegate property
    weak var delegate: TableViewViewModelDelegate?
    
    var allUsers: [User] = .init()
    var uId = [Int]() // [1,2,3,4,5,6,7,8,9,10]
    var userGroup = [[User]]() // [[{User1},{User2},...,{User10}],[{User11},...,{User20}],...,[{User91},...,{User100}]]

    func getUserData() {
//        useCase.getUserData(onManageDataSuccess: { [weak self] user in
//            self?.didDownload(users: user)
//        })
        useCase.getUserData(onManageDataSuccess: didDownload(users:), onManageDataFailed: cannotDownload(error:))
        
    }
    
    private func didDownload(users: [User]) -> Void {
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
    
    private func cannotDownload(error: Error) -> Void {
        delegate?.userDataDidnotDownloadData(error: error)
    }
    
}

//
//  TableViewUsecase.swift
//  ConnectAPI
//
//  Created by gibntn on 29/7/2563 BE.
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
class UserDataUseCase: TableViewNetworkDelegate {
    
    typealias callBackFunction = ([User]) -> Void
    
    var network: TableViewNetwork = .init()
    
    var onManageDataSuccess: callBackFunction?
    var onManageDataFailed: ((Error) -> Void)?
    
    func getUserData(onManageDataSuccess: @escaping callBackFunction, onManageDataFailed: @escaping ((Error) -> Void)) {
        self.onManageDataSuccess = onManageDataSuccess
        self.onManageDataFailed = onManageDataFailed
        network.delegate = self
        network.getUserData()
    }
    
    func completionHandler(response: DefaultDataResponse) {
        DispatchQueue.main.async {
            if let unwrappedData = response.data,
                let user = try? JSONDecoder().decode([User].self, from: unwrappedData) {
//                self.didDownload(users: user)
                self.onManageDataSuccess?(user)
            } else if let unwrappedError = response.error {
                print(unwrappedError.localizedDescription)
                self.onManageDataFailed?(unwrappedError)
            }
        }
    }
}

//
//  TableViewNetwork.swift
//  ConnectAPI
//
//  Created by gibntn on 30/7/2563 BE.
//  Copyright © 2563 nattanat. All rights reserved.
//

import Foundation
import Alamofire

protocol TableViewNetworkDelegate: class {
    func completionHandler(response: DefaultDataResponse)
}

class TableViewNetwork {
    enum Services: String {
        case userData = "https://jsonplaceholder.typicode.com/p"
    }
    
    weak var delegate: TableViewNetworkDelegate?
    
    func getUserData() {
        guard let url = URL(string: Services.userData.rawValue) else {
            print("URL is false")
            return
        }
        Alamofire.request(url).response { [weak self] data in
            self?.delegate?.completionHandler(response: data)
        }
    }
}

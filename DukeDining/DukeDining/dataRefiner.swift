//
//  dataRefiner.swift
//  DukeDining
//
//  Created by Oliver Adolfo Rodas on 11/2/19.
//  Copyright © 2019 Duke University. All rights reserved.
//

import Foundation

class dataRefiner {
    
    func getDict () -> [String:[String:[[String:Any]]]]? {
        guard let url = Bundle.main.url(forResource: "final", withExtension: "json") else{return [:]}
            do {
                let data = try Data(contentsOf: url)
                
                let jsonResponse = try JSONSerialization.jsonObject(with: data, options: .mutableContainers)
                guard let json = jsonResponse as? [String:[String:[[String:Any]]]] else{
                    print("rip")
                    return [:]
                }
                //print(json)
                
                //let user = User(index: 0, jsonInit: json)
                //print(user.title)
                
                
//                guard let dayDict = json["November"]!["2"] else{
//                    print("bad")
//                    return [:]
//                }
//                for dict in dayDict{
//                    print(dict["Location"]!)
//                }
                //print(json["October"]!["2"])
                return json
            } catch {
                print("error:\(error)")
            }
        return [:]
    }
}

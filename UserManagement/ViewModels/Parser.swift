//
//  Parser.swift
//  UserManagement
//
//  Created by Karen Madoyan on 2021/3/21.
//

import Foundation

    struct Parser {
        func parse(pageSize: Int, page: Int, completion: @escaping ([User]) -> ()) {
            let endpoint = "\(Bundle.InfoPlistKeys.BaseURLs.Development.value)/api?seed=renderforest&results=\(pageSize)&page=\(page)"
            guard let api = URL(string: endpoint) else { return }
            
            URLSession.shared.dataTask(with: api) { data, response, error in
                guard error == nil else { print(error!.localizedDescription); return }
                
                guard
                    let response = response as? HTTPURLResponse,
                    (200...299).contains(response.statusCode) else { print("Server error!"); return }
                
                guard let data = data else { return }
                
                do {
                    let result = try JSONDecoder().decode(RequestResponse.self, from: data)
                    completion(result.users)
                }  catch {
                    print("JSON error: \(error.localizedDescription)")
                }
            }.resume()
        }
    }

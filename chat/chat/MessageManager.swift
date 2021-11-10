//
//  MessageManager.swift
//  chat
//
//  Created by Gonzalo Romero on 07/11/2021.
//

import Foundation

enum APIError: Error{
    case problem
}

class MessageManager{
    
    func retrieve(onCompletition: @escaping (Result<[Message],APIError>) -> Void){
        let url = Bundle.main.url(forResource: "messages", withExtension: "json")
        guard let myurl = url,
              let myData = try? Data(contentsOf: myurl),
              let messages = try? JSONDecoder().decode([Message].self, from: myData) else{
            onCompletition(.failure(.problem))
            return
        }
        onCompletition(.success(messages))
    }
}


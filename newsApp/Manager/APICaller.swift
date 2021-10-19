//
//  APICaller.swift
//  newsApp
//
//  Created by Thaddeus Lorenz on 10/11/21.
//

import Foundation
import Coinpaprika

final class APICaller
{
    
    static let shared = APICaller()
    
// define url used for API call
    struct Constants
    {
        static let topHeadlinesURL = URL(string: "https://newsapi.org/v2/everything?q=Cryptocurrency&from=2021-10-11&sortBy=popularity&apiKey=e7c26303e78d4d0abb663d1a0e9b8e50")
        
    }
    private init()
    {
        // to-do
    }

// Call GET request for specified URL

    public func getTopStories(completion: @escaping (Result<[Article], Error>) -> Void)
    {
        
        guard let url = Constants.topHeadlinesURL else
        {
            return
        }
        let task = URLSession.shared.dataTask(with: url) { data, _, error in
            if let error = error
            {
                completion(.failure(error))
            }
            else if let data = data
            {
                do
                {
                    let result = try JSONDecoder().decode(APIResponse.self, from: data)
                    completion(.success(result.articles))
                }
                catch
                {
                    completion(.failure(error))
                }
            }
            
        }
        task.resume()
    }
    
}

// Models... included in same file as API Caller because it was less messy... for an app
// this simple I did not create multiple structs/classes


struct APIResponse: Codable
{
    let articles: [Article]
}

struct Article: Codable
{
    
    let source: Source
    let title: String
    let url: String?
    let urlToImage: String?
    let publishedAt: String
    
}

struct Source: Codable
{
    let name: String
}




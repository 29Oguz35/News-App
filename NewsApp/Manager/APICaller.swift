//
//  APICaller.swift
//  NewsApp
//
//  Created by naruto kurama on 28.04.2022.
//

import Foundation

class APICaller {
    static let shared = APICaller()
    
    struct Constants {
        static let topHeadlinesURL = URL(string: "https://newsapi.org/v2/top-headlines?country=us&apiKey=ef5ad57f9b4240129a949dab81830e8c")
    }
    private init() { }
    
    public func getTopStories(completion : @escaping (Result<[Article] ,Error>) -> Void) {
        guard let url = Constants.topHeadlinesURL else { return }
        
        URLSession.shared.dataTask(with: url) { data, _, error in
            if let error = error {
                completion(.failure(error))
            }
            else if let data = data {
                do {
                    let result = try JSONDecoder().decode(APIResponse.self, from: data)
                    
                    print("Articles : \(result.articles.count)")
                    completion(.success(result.articles))
                } catch {
                    completion(.failure(error))
                }
            }
        }.resume()
        
    }
}

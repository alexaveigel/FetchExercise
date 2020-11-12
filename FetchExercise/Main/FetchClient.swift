//
//  FetchClient.swift
//  FetchExercise
//
//  Created by Admin on 11/12/20.
//

import Foundation

struct FetchRequest {
    let url: URL
    
    init() {
        let apiString = "https://fetch-hiring.s3.amazonaws.com/hiring.json"
        guard let url = URL(string: apiString) else { fatalError() }
        self.url = url
    }
    
    func fetchData(completion: @escaping(Result<[FetchItem], Error>) -> Void) {
        let request = FetchRequest()
        
        let dataTask = URLSession.shared.dataTask(with: request.url){
            data, URLResponse, error in
            guard let jsonData = data else {
                completion(.failure(error!))
                return
            }
            do {
                let decoder = JSONDecoder()
                let fetchResponse = try decoder.decode(Array<FetchItem>.self, from: jsonData)
                let fetchData = fetchResponse
                completion(.success(fetchData))
            } catch {
                completion(.failure(error))
            }
        }
        dataTask.resume()
    }
}

struct FetchItem: Decodable {
    let id: Int?
    let listId: Int
    let name: String?
}


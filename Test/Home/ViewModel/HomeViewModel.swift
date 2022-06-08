//
//  HomeViewModel.swift
//  Test
//
//  Created by Akshay on 07/06/22.
//

import Foundation
import GiphyUISDK

class HomeViewModel {
    func getTrendingImages(completionHandler:@escaping (Model?) -> Void) {
        GPHCache.shared.downloadAssetData("https://api.giphy.com/v1/gifs/trending?api_key=0BsHlTzVk1KRDIoPOJOFjnA2OrMk4AqJ&limit=25&rating=g") { jsonData, error in
     
            if let data = jsonData {
                do {
                    let decoder = JSONDecoder()
                    let model = try decoder.decode(Model.self, from:data)
                    completionHandler(model)
                } catch {
                    print("Something went wrong")
                    completionHandler(nil)

                }
            }
        }
    }
}

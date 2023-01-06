//
//  News.swift
//  module_37
//
//  Created by Denis Loctier on 05/01/2023.
//




// News model
import Foundation
import Alamofire
import ObjectMapper


final class NewsAPI {
    
    static let shared = NewsAPI()
    
//    func getUserMapple(completionHandler: @escaping (_ dotaData: [DotaModelMapable]) -> ()) {
//
//        guard let urlString = URL(string: dotaUrl) else { return }
//
//        AF.request(urlString).responseJSON { response in
//
//            switch response.result {
//            case .success(let value):
//                guard let dotaData = Mapper<DotaModelMapable>().mapArray(JSONObject: value) else { return }
//                completionHandler(dotaData)
//            case .failure(let error):
//                print(error.localizedDescription)
//            }
//        }
//  }
    
    
    
    func fetchNews(onCompletion: @escaping ([Article]) -> () ) {
        let newsUrl = "https://newsapi.org/v2/everything?q=euronews&from=2023-01-01&sortBy=publishedAt&apiKey=eb948f8c1b924ee4a183a90eb175889f"
        guard let urlString = URL(string: newsUrl) else {return}
        
        AF.request(urlString).validate().responseString { response in
            
            switch response.result {
                        case .success(let value):
                guard let news = News(JSONString: value) else { return }
                onCompletion (news.articles)
            case .failure(let error):
                            print(error.localizedDescription)
                        }
            
        }
        
        
        
//        AF.request(urlString).responseJSON { response in
//            print(response)
//
//            switch response.result {
//                       case .success(let value):
//                           guard let news = Mapper<News>().mapArray(JSONObject: value) else { return }
//                onCompletion (news.articles)
//                       case .failure(let error):
//                           print(error.localizedDescription)
//                       }
            
                
            
//            guard let news = try? JSONDecoder().decode(News.self, from: response) else {
//                print("Не удалось декодировать JSON")
//
//                return
//            }
//
            
            
            
        }
        
//        let task = URLSession.shared.dataTask(with: url) {(data, response, error) in
//            guard let data = data else {
//                print("Data пришла пустой")
//                return
//            }
//
//            guard let news = try? JSONDecoder().decode(News.self, from: data) else {
//                print("Не удалось декодировать JSON")
//
//                return
//            }
//
//            onCompletion (news.articles)
//
//        }
//
//        task.resume()
        
    }
    

struct News: Mappable {
    init?(map: ObjectMapper.Map) {
    }
    mutating func mapping(map: ObjectMapper.Map) {
        articles <- map["articles"]
    }
    var articles: [Article] = []
}

struct Article: Mappable {
    init?(map: ObjectMapper.Map) {
    }
    
    mutating func mapping(map: ObjectMapper.Map) {
        source <- map["source"]
        title <- map["title"]
        urlToImage <- map["urlToImage"]
    }
    var source: Source?
    var title: String = ""
    var urlToImage: String = ""
}

struct Source: Mappable {
    init?(map: ObjectMapper.Map) {
    }
    
    mutating func mapping(map: ObjectMapper.Map) {
        name <- map["name"]
    }
    
    var name: String = ""
}



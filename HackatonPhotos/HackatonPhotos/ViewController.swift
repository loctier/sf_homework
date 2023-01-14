//
//  ViewController.swift
//  HackatonPhotos
//
//  Created by Denis Loctier on 11/01/2023.
//
/// Всё сделано программно, без использования Storyboard.
/// По некоторым пунктам:
// Вы добавили собственную фичу в приложение -—10 баллов;
/// Собственная фича: загруженную фотографию можно сохранить или использовать как-то иначе при помощи кнопки "Share"
// Вы работали с другим API, выстраивая методы под него — 7 баллов;
/// Да, с API Unsplash вместо Flicker
// Вы сделали комбинированное решение библиотеки + чистая реализация — 10 баллов;
/// В основном чистая реализация, но в imageViewCollectionViewCell.swift используется библиотека Kingfisher


import UIKit

struct APIResponse: Codable {
    let total: Int
    let total_pages: Int
    let results: [Result]
}

struct Result: Codable {
    let id: String
    let urls: URLS
}

struct URLS: Codable {
    let regular: String
    let thumb: String
}


class ViewController: UIViewController {
    
    private var collectionView: UICollectionView?
    
    var results: [Result] = []
    
    let searchBar = UISearchBar()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        self.title = "Unsplash"
        
        searchBar.delegate = self
        searchBar.showsCancelButton = true
        searchBar.placeholder = "Введите запрос"
        view.addSubview(searchBar)
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        layout.itemSize = CGSize(width: view.frame.size.width/2, height: view.frame.size.width/2)
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(ImageCollectionViewCell.self, forCellWithReuseIdentifier: ImageCollectionViewCell.identifier)
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.backgroundColor = .systemBackground
        view.addSubview(collectionView)
        self.collectionView = collectionView
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        searchBar.frame = CGRect(x: 10, y: view.safeAreaInsets.top, width: view.frame.size.width-20, height: 50)
        collectionView?.frame = CGRect(x: 0, y: view.safeAreaInsets.top+55, width: view.frame.size.width, height: view.frame.size.height-55)
    }
    
    
    func fetchPhotos(query: String) {
        
        let urlString = "https://api.unsplash.com/search/photos?client_id=MHRuANj3tbkbZlApqunB1FnwP15gyJtwRFds7dkOBrY&per_page=30&query=\(query)"
        
        guard let url = URL(string: urlString) else { return }
        let task = URLSession.shared.dataTask(with: url) { [weak self] data, _, error in
            guard let data = data, error == nil else { return }
            
            do {
                let jsonResult = try JSONDecoder().decode(APIResponse.self, from: data)
                // print(jsonResult.results[0].urls.thumb)
                print(jsonResult.results.count)
                DispatchQueue.main.async {
                    self?.results = jsonResult.results
                    self?.collectionView?.reloadData()
                }
                
            } catch {
                print(error)
            }
            
            
        }
        task.resume()
    }
    
}

extension ViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return results.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let thumbURL = results[indexPath.item].urls.thumb
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ImageCollectionViewCell.identifier, for: indexPath) as? ImageCollectionViewCell else { return UICollectionViewCell() }
        cell.configure(with: thumbURL)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let imageURL = results[indexPath.item].urls.regular
        let id = results[indexPath.item].id
        
        let rootVC = FullImageViewController()
        
        rootVC.configure(with: imageURL, id: id)
        
        
        navigationController?.pushViewController(rootVC, animated: true)
        
    }
    
    
}



extension ViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        if let searchQuery = searchBar.text {
            results = []
            collectionView?.reloadData()
            fetchPhotos(query: searchQuery)
        }
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        results = []
        collectionView?.reloadData()
    }
    
    
}

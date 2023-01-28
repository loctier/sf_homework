//
//  VideoTableViewController.swift
//  module_41
//
//  Created by Denis Loctier on 28/01/2023.
//

import UIKit
import AVKit

class VideoTableViewController: UITableViewController {
    
    var videos: [Video] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        
        navigationItem.title = "Videos"
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.largeTitleDisplayMode = .always
        
        
        
        
        videos.append(Video(title: "Big Buck Bunny", thumbnail: nil, url: URL(string: "https://archive.org/download/BigBuckBunny_124/Content/big_buck_bunny_720p_surround.mp4")!))
        videos.append(Video(title: "Scooby Doo Mystery Incorporated", thumbnail: nil, url: URL(string: "https://archive.org/download/scooby-doo-mystery-incorporated-season-1-2/Scooby-Doo.Mystery.Incorporated.S01E01.Beware.The.Beast.From.Below.1080p.AMZN.WEB-DL.DD.2.0.x264-CtrlHD.mp4")!))
        videos.append(Video(title: "My Little Pony: Friendship is Magic", thumbnail: nil, url: URL(string: "https://archive.org/download/MyLittlePonyFull/Season%201/My%20Little%20Pony%20Friendship%20is%20Magic%20-%20Season%201%20Episode%2001%20-%20Friendship%20Is%20Magic%2C%20Part%2001.mp4")!))
        videos.append(Video(title: "The Simpsons", thumbnail: nil, url: URL(string: "https://archive.org/download/thesimpletons/S27%20Season%2027/The.Simpsons.S27E01.Every.Man%27s.Dream.1080p.WEB-DL.x265.10bit.AAC.5.1-ImE%5BUTR%5D.mp4")!))

        
//        videos.append(Video(title: "Big Buck Bunny", thumbnail: nil, url: URL(string: "http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4")!))
//        videos.append(Video(title: "Elephant Dream", thumbnail: nil, url: URL(string: "http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ElephantsDream.mp4")!))
//        videos.append(Video(title: "For Bigger Blazes", thumbnail: nil, url: URL(string: "http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ForBiggerBlazes.mp4")!))
//        videos.append(Video(title: "For Bigger Escape", thumbnail: nil, url: URL(string: "http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ForBiggerEscapes.mp4")!))
//        videos.append(Video(title: "For Bigger Fun", thumbnail: nil, url: URL(string: "http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ForBiggerFun.mp4")!))
        
        
        for (index, video) in videos.enumerated() {
            getThumbnailFromUrl(url: video.url) { (thumbnail) in
                
                self.videos[index].thumbnail = thumbnail
                self.tableView.reloadData()
            }
        }
        
    }
    
    func getThumbnailFromUrl(url: URL, completion: @escaping ((_ image: UIImage)->Void)) {
        
        DispatchQueue.global().async {
            let asset = AVAsset(url: url)
            let generator = AVAssetImageGenerator(asset: asset)
            generator.appliesPreferredTrackTransform = true
            let time = CMTime(seconds: 20, preferredTimescale: 1)
            do {
                let imageRef = try generator.copyCGImage(at: time, actualTime: nil)
                let thumbnail = UIImage(cgImage: imageRef)
                DispatchQueue.main.async {
                    completion (thumbnail)
                }
            } catch {
                print (error.localizedDescription)
            }

        }
        
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
            return videos.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "VideoCell", for: indexPath) as! VideoTableViewCell
        cell.titleLabel.text = videos[indexPath.row].title
        
        guard let thumbnail = videos[indexPath.row].thumbnail else { return cell }
        
        cell.thumbnailImageView.image = thumbnail
        cell.activityIndicator.stopAnimating()
        
        return cell
    }
    

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let video = videos[indexPath.row]
        let player = AVPlayer(url: video.url)
        let playerViewController = AVPlayerViewController()
        playerViewController.player = player
        present(playerViewController, animated: true) {
            player.play()
        }
    }
    
    
}

//
//  FullImageController.swift
//  HackatonPhotos
//
//  Created by Denis Loctier on 14/01/2023.
//

import UIKit

class FullImageViewController: UIViewController {

    private var fileID: String = ""
    
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
            
    override func viewWillLayoutSubviews() {
        imageView.frame = view.bounds
        view.addSubview(imageView)
    }
    
    override func viewDidLoad() {
        // navigationController?.navigationBar.prefersLargeTitles = false
        view.backgroundColor = .systemBackground
        configureItems()
    }
    
    func configure(with urlString: String, id: String) {
        guard let url = URL(string: urlString) else {
            return
        }
        URLSession.shared.dataTask(with: url) { [weak self] data, _, error in
            guard let data = data, error == nil else { return }
            DispatchQueue.main.async {
                let image = UIImage(data: data)
                self?.imageView.image = image
            }
        }.resume()
        self.fileID = id
    }
        
    private func configureItems() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "square.and.arrow.up"), style: .plain, target: self, action: #selector(shareImage))
    }
    
    
// MARK: Ниже — реализация функционала Share для загруженного изображения ("вы добавили собственную фичу в приложение -— 10 баллов")
    
    @objc func shareImage() {
        
        guard let image = imageView.image else { return }
        
        // Convert the image into jpeg image data. compressionQuality is the quality-compression ratio in % (from 0.0 (0%) to 1.0 (100%)); 1 is the best quality but have bigger filesize
        let jpgImageData = image.jpegData(compressionQuality: 1.0)

        // Write the jpg image into a filepath and return the filepath in NSURL
        let jpgImageURL = jpgImageData?.dataToFile(fileName: "\(fileID).jpg")

        // Create the Array which includes the files you want to share
        var filesToShare = [Any]()

        // Add the path of jpg image to the Array
        filesToShare.append(jpgImageURL!)

        // Make the activityViewContoller which shows the share-view
        let activityViewController = UIActivityViewController(activityItems: filesToShare, applicationActivities: nil)

        // Show the share-view
        self.present(activityViewController, animated: true, completion: nil)
    }

}

/// Get the current directory
///
/// - Returns: the Current directory in NSURL
func getDocumentsDirectory() -> NSString {
    let paths = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)
    let documentsDirectory = paths[0]
    return documentsDirectory as NSString
}

extension Data {

    /// Data into file
    ///
    /// - Parameters:
    ///   - fileName: the Name of the file you want to write
    /// - Returns: Returns the URL where the new file is located in NSURL
    func dataToFile(fileName: String) -> NSURL? {

        // Make a constant from the data
        let data = self

        // Make the file path (with the filename) where the file will be loacated after it is created
        let filePath = getDocumentsDirectory().appendingPathComponent(fileName)

        do {
            // Write the file from data into the filepath (if there will be an error, the code jumps to the catch block below)
            try data.write(to: URL(fileURLWithPath: filePath))

            // Returns the URL where the new file is located in NSURL
            return NSURL(fileURLWithPath: filePath)

        } catch {
            // Prints the localized description of the error from the do block
            print("Error writing the file: \(error.localizedDescription)")
        }

        // Returns nil if there was an error in the do-catch -block
        return nil

    }

}

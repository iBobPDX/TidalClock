//
//  ViewController.swift
//  TidalClock
//
//  Created by Robert Corlett on 12/1/18.
//  Copyright © 2018 Robert Corlett. All rights reserved.
//

import UIKit

class TideCollectionViewController: UICollectionViewController {

    private var tapGestureRecognizer: UITapGestureRecognizer!
    let pixels = Pixels()
    
    let session = URLSession(configuration: .default)
    var dataTask: URLSessionDataTask?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        collectionView.alwaysBounceVertical = false
        collectionView.register(PixelCollectionViewCell.self, forCellWithReuseIdentifier: PixelCollectionViewCell.reuseIdentifier)
        tapGestureRecognizer = UITapGestureRecognizer.init(target: self, action: #selector(handleTap(_:)))
        collectionView.addGestureRecognizer(tapGestureRecognizer)
        
        
    }
    
    func fetchWaterLevel() {
        dataTask?.cancel()
        
        if var urlComponents = URLComponents(string: "https://tidesandcurrents.noaa.gov/api/datagetter") {
            urlComponents.query = "date=latest&station=8452660&product=water_level&datum=MLLW&units=english&time_zone=gmt&application=tidal_clock&format=json"
            
            guard let url = urlComponents.url else { return }
            
            dataTask = session.dataTask(with: url) { [weak self] data, response, error in
                defer { self?.dataTask = nil }
                
                if let error = error {
                    print(error.localizedDescription)
                } else if let data = data,
                    let response = response as? HTTPURLResponse,
                    response.statusCode == 200 {
                    let tideLevel = TideLevel(data)
                    
                    self?.pixels.setWaterLevel(tideLevel) { [weak self] in
                        DispatchQueue.main.async {
                            self?.collectionView.reloadData()
                        }
                    }
                }
            }

            dataTask?.resume()
        }
    }
    
    @objc func handleTap(_ gesture: UITapGestureRecognizer) {
        fetchWaterLevel()

//        pixels.flashLight { [weak self] in
//            print("flash")
//            self?.collectionView.reloadData()
//        }
    }
}

// MARK - UICollectionViewDataSource
extension TideCollectionViewController {
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return pixels.pixelArray.count
    }
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return pixels.pixelArray[section].count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PixelCollectionViewCell.reuseIdentifier, for: indexPath)
        cell.backgroundColor = pixels.pixelArray[indexPath.section][indexPath.row]
        return cell
    }
}

// MARK - UICollectionViewFlowLayoutDelegate
extension TideCollectionViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let screenSize = self.view.bounds.inset(by: self.view.safeAreaInsets)
        
        let size = CGSize.init(width: screenSize.width / CGFloat(pixels.pixelArray[indexPath.section].count), height: screenSize.height / CGFloat(pixels.pixelArray.count))
        return size
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        pixels.setColor(.white, forItemAt: indexPath)
        collectionView.reloadItems(at: [indexPath])
    }
}

// Mark - Rotation
extension TideCollectionViewController {
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        self.collectionViewLayout.invalidateLayout()
    }
}


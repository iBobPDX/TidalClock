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
    var pixels: Pixels = Pixels()
    
    var dataTask: URLSessionDataTask?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        collectionView.alwaysBounceVertical = false
        collectionView.register(PixelCollectionViewCell.self, forCellWithReuseIdentifier: PixelCollectionViewCell.reuseIdentifier)
        tapGestureRecognizer = UITapGestureRecognizer.init(target: self, action: #selector(handleTap(_:)))
        collectionView.addGestureRecognizer(tapGestureRecognizer)
        
        pixels.delegate = self
    }
    
    func fetchWaterLevel() {
        dataTask?.cancel()
        dataTask = TideService().loadTideData(completion: { [weak self] (tide, error) in
            if let error = error {
                print(error.localizedDescription)
                self?.pixels.errorLamp()
            } else if let tide = tide {
                self?.pixels.setWaterLevel(tide)
            }
        })
        
        dataTask?.resume()
    }
    
    @objc func handleTap(_ gesture: UITapGestureRecognizer) {
        fetchWaterLevel()
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
        let size = CGSize.init(width: screenSize.width / CGFloat(pixels.pixelArray[indexPath.section].count) - 1, height: screenSize.height / CGFloat(pixels.pixelArray.count) - 1)
        return size
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 0, bottom: 1, right: 1)
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

extension TideCollectionViewController: DisplayDelegate {
    func didUpdatePixels() {
        DispatchQueue.main.async {
            self.collectionView.reloadData()
        }
    }
}

//
//  ViewController.swift
//  PhotoFrames
//
//  Created by Djuro Alfirevic on 4/8/17.
//  Copyright © 2017 Djuro Alfirevic. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    // MARK: - Properties
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var frameImageView: UIImageView!
    @IBOutlet weak var userImageView: UIImageView!
    var frames = [
        #imageLiteral(resourceName: "bronze"),
        #imageLiteral(resourceName: "love"),
        #imageLiteral(resourceName: "metal"),
        #imageLiteral(resourceName: "wedding"),
        #imageLiteral(resourceName: "wood")
    ]
    lazy var imagePicker: UIImagePickerController = {
        let picker = UIImagePickerController()
        picker.allowsEditing = false
        picker.delegate = self

        return picker
    }()

    // MARK: - Actions
    @IBAction func choosePhotoButtonTapped() {
        present(imagePicker, animated: true)
    }

    @IBAction func imageOptionSegmentedControl(_ sender: UISegmentedControl) {
        if sender.selectedSegmentIndex == 0 { // Frame
            view.sendSubview(toBack: frameImageView)
        } else { // Photo
            view.sendSubview(toBack: userImageView)
        }
    }

}

extension ViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {

    // MARK: - UICollectionViewDataSource
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return frames.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! PhotoFrameCollectionViewCell

        cell.image = frames[indexPath.row]

        return cell
    }

    // MARK: - UICollectionViewDelegate
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {

        frameImageView.image = frames[indexPath.row]
    }

    // MARK: - UICollectionViewDelegateFlowLayout
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.size.width/4, height: collectionView.frame.size.height-10)
    }

}

extension ViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    // MARK: - UIImagePickerControllerDelegate
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true)
    }

    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let image = info[UIImagePickerControllerOriginalImage] as? UIImage {
            userImageView.image = image
        }

        picker.dismiss(animated: true)
    }

}

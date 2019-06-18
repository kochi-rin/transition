//
//  DetailViewController.swift
//  transition
//
//  Created by kouchi.rin on 2019/06/18.
//  Copyright © 2019 kouchi.rin. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    var image: UIImage?

    @IBOutlet weak var imageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.

        navigationController?.setNavigationBarHidden(true, animated: false)

        imageView.image = image
        imageView.addMask(rect: CGRect(origin: CGPoint(x: 100, y: 200), size: CGSize(width: 300, height: 300)))
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

    @IBAction func tappedClose(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
}

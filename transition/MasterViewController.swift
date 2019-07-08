//
//  MasterViewController.swift
//  transition
//
//  Created by kouchi.rin on 2019/06/18.
//  Copyright © 2019 kouchi.rin. All rights reserved.
//

import UIKit

class MasterViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var scrollView: UIScrollView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.

        navigationController?.setNavigationBarHidden(true, animated: false)
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

    @IBAction func tappedSearch(_ sender: Any) {
        let vc = UIStoryboard(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "DetailViewController") as! DetailViewController
        vc.image = imageView.image
        navigationController?.pushViewController(vc, animated: true)
    }
}

extension MasterViewController: CoverVerticalWithFadeByPushAnimatorProtocol {
    var originViewPosition: CGPoint? {
        // TODO: get the origin of self.view
        return imageView.convert(imageView.frame, to: view).origin
    }
}

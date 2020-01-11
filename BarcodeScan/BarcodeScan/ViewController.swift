//
//  ViewController.swift
//  BarcodeScan
//
//  Created by 曲波 on 2019/12/21.
//  Copyright © 2019 曲波. All rights reserved.
//

import UIKit

protocol ReloadViewControllerDelegate {
    func reloadTableView()
}

class ViewController: UIViewController {
    
    
    static var data:[String] = [] {
        didSet {
//            guard let v = data else { return }
            print(data)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func alert(title:String, message:String) {
        var alertController: UIAlertController!
        alertController = UIAlertController(title: title,
                                            message: message,
                                            preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "OK",
                                                style: .default,
                                                handler: nil))
        present(alertController, animated: true)
    }
    
    func confirm() {

        let str = ViewController.data[ViewController.data.count - 1]
        let alert = UIAlertController(title: "提示", message: str, preferredStyle: .alert)
        let btnOK = UIAlertAction(title: "確定", style: .default) { (UIAlertAction) -> Void in
            print("確定操作")
        }
        let btnCancel = UIAlertAction(title: "取消", style: .cancel) { (UIAlertAction) in
            print("取消操作")
        }
        alert.addAction(btnOK)
        alert.addAction(btnCancel)
        //self.presentedViewController?.showDetailViewController(alert, sender: nil)
        present(alert, animated: true)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    @objc private func cameraClick() {
        self.performSegue(withIdentifier: "toCameraPage", sender: nil)
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let page = segue.destination as! CameraViewController
        page.data1 = "123"
        page.reloadTableViewDelegate = self
        super.prepare(for: segue, sender: sender)
    }
}

extension ViewController: UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 2 + ViewController.data.count
        default:
            return 100
        }
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: "cameraCell") as! CameraCell
            cell.button.setBackgroundImage(#imageLiteral(resourceName: "sliderThumb"), for: .normal)
            cell.button.setTitle(nil, for: .normal)
            cell.button.addTarget(self, action: #selector(cameraClick), for: .touchUpInside)
            return cell
        default:
            let cell = tableView.dequeueReusableCell(withIdentifier: "scanedCell") as! ScanedCell
            if ViewController.data.count >= indexPath.section {
                cell.label.text = ViewController.data[indexPath.section] as String
            } else {
                cell.label.text = "没有更多了！"
            }
            return cell
        }
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.row {
        case 0:
            return 240.0
        default:
            return 40.0
        }
    }
    // MARK: - Header
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 30
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        switch section {
//        case 0:
//            return nil
        default:
            let view = UIView()
            view.backgroundColor = UIColor(red:0.94, green:0.94, blue:0.94, alpha:1.0)
            let viewLabel = UILabel(frame: CGRect(x: 10, y: 0, width: UIScreen.main.bounds.size.width, height: 30))
            viewLabel.text = "スキャン"
            viewLabel.textColor = UIColor(red:0.31, green:0.31, blue:0.31, alpha:1.0)
            view.addSubview(viewLabel)
            tableView.addSubview(view)
            return view
        }
    }
}

extension ViewController: ReloadViewControllerDelegate {
    func reloadTableView() {
        print("callback reloadTableView()")
        confirm()
        //alert(title: "123", message: "str")
//        self.viewDidLoad()//.tableview.reloadData()
//        self.view.reloadInputViews()
//        print(ViewController.data)
//        let keywindow = (UIApplication.shared.delegate as! AppDelegate).window?.rootViewController
    }
}

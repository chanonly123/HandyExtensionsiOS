//
//  TableViewController.swift
//  HandyExtensionsiOS
//
//  Created by Chandan on 16/09/18.
//  Copyright © 2018 Chandan. All rights reserved.
//

import UIKit

class TableViewController: UITableViewController {
    enum Rows: String {
        case gradientLoading = "Gradient loading animation",
            stackViewHiding = "Stack View Hiding",
        extendedScrolling = "Extended scrolling"
    }

    var array: [Rows] = [.gradientLoading, .stackViewHiding, .extendedScrolling]

    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.rowHeight = UITableView.automaticDimension
        self.clearsSelectionOnViewWillAppear = true
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return array.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(type: MainCell.self)
        cell.lbl.text = array[indexPath.row].rawValue
        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        var viewc: UIViewController?
        switch self.array[indexPath.row] {
        case .gradientLoading:
            viewc = storyboard?.instantiateViewController(type: GradientLoadingVC.self)
        case .stackViewHiding:
            viewc = storyboard?.instantiateViewController(type: StackViewHidingVC.self)
        case .extendedScrolling:
            viewc = storyboard?.instantiateViewController(type: ExtendedScrollingVC.self)
        }
        if viewc != nil {
            self.show(viewc!, sender: self)
        }
    }
}

class MainCell: UITableViewCell {
    @IBOutlet weak var lbl: UILabel!
}

extension UITableView {
    func dequeueReusableCell<T: UITableViewCell>(type: T.Type) -> T {
        let identifier = String(describing: type)
        if let reusableCell = self.dequeueReusableCell(withIdentifier: identifier) {
            if let cell = reusableCell as? T {
                return cell
            } else {
                print("tableview cell cannot be casted: \(identifier)")
            }
        } else {
            print("tableview cell not found: \(identifier)")
        }
        guard let tableViewCell = UITableViewCell() as? T else {
            fatalError("tableviewcell not found")
        }
        return tableViewCell
    }
}

extension UIStoryboard {
    func instantiateViewController<T>(type: T.Type) -> T {
        let id = String(describing: type)
        guard let viewController = instantiateViewController(withIdentifier: id) as? T else {
            fatalError("ViewController not found: \(id)")
        }
        return viewController
    }
}

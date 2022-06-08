//
//  ViewController.swift
//  Test
//
//  Created by Akshay on 06/06/22.
//

import UIKit
import GiphyUISDK

class ViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView! {
        didSet {
            tableView.delegate = self
            tableView.dataSource = self
        }
    }
    @IBOutlet weak var searchBar: UISearchBar! {
        didSet {
            searchBar.delegate = self
        }
    }
    
    lazy var viewModel: HomeViewModel = HomeViewModel()
    var model: Model?
    static let cellReuseIdentifier: String = "Cell"
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.getTrendingImages { model in
            self.model = model
            DispatchQueue.main.async {
                let appDelegate = UIApplication.shared.delegate as! AppDelegate
                appDelegate.favModel = self.model
                self.tableView.reloadData()
            }
        }
    }
}
extension ViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.model?.data?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ViewController.cellReuseIdentifier, for: indexPath) as! HomeViewCell
        if let data = self.model?.data?[indexPath.row] {
            cell.setContent(url: data.user?.avatarURL ?? "", isFav: data.isFav)
        }
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 300
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if var data = self.model?.data?[indexPath.row] {
            data.isFav = !data.isFav
            self.model?.data?[indexPath.row] = data
        }
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        appDelegate.favModel = self.model
        self.tableView.reloadRows(at: [indexPath], with: .none)
   }
    
    
}
extension ViewController: UISearchBarDelegate {

// This method updates filteredData based on the text in the Search Box
func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    var filteredData: [Datum]?
    if let data: [Datum] = appDelegate.favModel?.data {
        filteredData = searchText.isEmpty ? data : data.filter({ dataObj in
            // If dataItem matches the searchText, return true to include it
            return dataObj.user?.avatarURL?.range(of: searchText, options: .caseInsensitive) != nil
        })

    }
    self.model?.data = filteredData
    tableView.reloadData()
}

}

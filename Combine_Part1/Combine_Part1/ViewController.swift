//
//  ViewController.swift
//  Combine_Part1
//
//  Created by Monica Deshwal on 04/01/23.
//

import UIKit
import Combine

class ViewController: UIViewController {
    
    private var webService = WebService()
    private var cancellable: AnyCancellable?

    private var posts = [Post]() {
        didSet {
            self.tableView.reloadData()
        }
    }
    let cellIdentifier = "PostTableViewCell"
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellIdentifier)
        tableView.dataSource = self
        
        self.cancellable = self.webService.getPosts()
            .catch { _ in Just(self.posts)}
            .assign(to: \.posts, on: self)
    }
}

extension ViewController : UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.posts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier)
        let post = self.posts[indexPath.row]
        cell?.textLabel?.text = post.title
        return cell ?? UITableViewCell()
    }
}

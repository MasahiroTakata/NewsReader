//
//  ListViewController.swift
//  NewsReader
//
//  Created by 高田将弘 on 2020/09/07.
//  Copyright © 2020 高田将弘. All rights reserved.
//

import UIKit

class ListViewController: UITableViewController {
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        return 3
    } // 表示するセルの数を３にする
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        
        cell.textLabel!.text = "記事タイトル"
        tableView.deleteRows(at: [indexPath], with: .automatic) // 記事を削除する
        
        return cell
    } // 表示するセルを作成する
}

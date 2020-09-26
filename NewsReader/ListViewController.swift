//
//  ListViewController.swift
//  NewsReader
//
//  Created by 高田将弘 on 2020/09/07.
//  Copyright © 2020 高田将弘. All rights reserved.
//

import UIKit

class ListViewController: UITableViewController, XMLParserDelegate{
    var parser:XMLParser!
    var items = [Item]()
    var item:Item?
    var currentString = ""
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{ // セルの数を設定する
        return items.count // アプリに表示させるセル数
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{ // セルの内容を設定する
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) // 画面範囲から消えたセルを再利用するメソッド この時、どのセルを再利用するのかを指定する
        cell.textLabel?.text = items[indexPath.row].title
        
        return cell // 表示するセルを作成する
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        startDownload()
    }
    
    func startDownload() {
        self.items = []
        
        if let url = URL(string: "https://wired.jp/rssfeeder/"){ // オプショナルバインディング、iPhoneアプリ開発では頻繁に使う
            if let parser = XMLParser(contentsOf: url){ // これもオプショナルバインディング nilの場合は式の結果はfalseになり、if文の中身は実行されない
                self.parser = parser // parserメソッド呼び出し
                self.parser.delegate = self
                self.parser.parse() // データを解析するメソッド
            }
        }
    }
    
    // 必要なデータのみを取り出すメソッド（要素名の開始タグが見つかる毎に呼び出される）
    func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String: String]) {
        self.currentString = ""
        
        if elementName == "item" { // 変数elementNameにはダウンロードしたRSSのデータの要素名が入っている
            self.item = Item() // タグ要素が「item」の時、ニュース記事を入れる箱を用意する
        }
    }
    
    func parser(_ parser: XMLParser, foundCharacters string: String){
        self.currentString += string // 見つかった記事の内容を格納する
    }
    
    func parser(_ parser: XMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?){
        switch elementName { // 要素名をチェックそして、要素ごとに処理を分ける
            case "title": self.item?.title = currentString
            case "link": self.item?.link = currentString
            case "item": self.items.append(self.item!)
            default: break
        }
    }
    
    func parserDidEndDocument(_ parser: XMLParser) {
        self.tableView.reloadData() // テーブルビューの内容を更新して、取得したニュースの記事を画面に表示する
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?){
        if let indexPath = self.tableView.indexPathForSelectedRow {
            let item = items[indexPath.row] // ユーザーがタップしたセルのindexPathを取得、items配列から該当する記事を取得
            let controller = segue.destination as! DetailViewController // 遷移先のビューコントローラーを格納
            controller.title = item.title // 遷移先のtitleプロパティに記事のタイトルを格納
            controller.link = item.link // 記事のURLを格納
        }
    }
}

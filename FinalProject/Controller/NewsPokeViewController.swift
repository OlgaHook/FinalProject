//
//  ViewController.swift
//  FinalProject
//
//  Created by olga.krjuckova on 20/08/2021.
//

import UIKit
import Gloss
import WebKit

class NewsPokeViewController: UIViewController {
    
    //pokeItem Model Class
    var pokeItems: [PokeItem] = []
    
    @IBOutlet weak var pokeNewsTableView: UITableView!
    @IBOutlet weak var pokeNewsActivityIndicatorView: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //set title
        self.title = "Pokemon related World News"
        pokeNewsActivityIndicatorView.isHidden = true
        //to avoid news request pressing any time -> addes hangleGetData()
        handleGetData()
        
    }
    
    
    //logic of activity indicator
    func activityIndicator(animated: Bool){
        DispatchQueue.main.async {
            if animated{
                self.pokeNewsActivityIndicatorView.isHidden = false
                self.pokeNewsActivityIndicatorView.startAnimating()
            }else{
                self.pokeNewsActivityIndicatorView.isHidden = true
                self.pokeNewsActivityIndicatorView.stopAnimating()
            }
        }
        
    }
    //Simple alert Item Bar Button
    @IBAction func infoBarItem(_ sender: Any) {
        //put here created alert extension
        
        basicAlert(title: "Pokemon News Info", message: "Press (>) to get Pokemon latest News")
    }
    
    
    @IBAction func getDataTapped(_ sender: Any) {
        
        self.activityIndicator(animated: true)
        handleGetData()
        
    }
    
    func handleGetData(){
        let jsonUrl = "https://newsapi.org/v2/everything?apiKey=8b14d98abae14dd9ac3e37adbd3d60f5&q=pokemon&from=2021-07-30&sortBy=publishedAt"
        //check if url is valid, if not -> just return
        guard let url = URL(string: jsonUrl) else {return}
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "GET"
        urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let sessionUrl = URLSession(configuration: .default)
        let task = sessionUrl.dataTask(with: urlRequest) { data, response, err in
            //first response from url
            print("response:", response as Any)
            
            if let err = err {
                self.basicAlert(title: "Error!", message: "\(err.localizedDescription)")
            }
            //data from sessionUrl.dataTask
            guard let data = data else {
                
                self.basicAlert(title: "Error!", message: "Something went wrong, no data")
                
                return
            }
            
            do{
                if let dictionaryData = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]{
                    print("dictionaryData: ", dictionaryData)
                    //passing DictionaryData to the func populateData
                    self.populateData(dictionaryData)
                    
                }
            }catch{
                
            }
        }
        //to call the session
        task.resume()
        
    }
    //request for all info ,that is inside "articles"
    func populateData(_ dictionary: [String: Any]){
        guard  let responseDict = dictionary["articles"] as? [Gloss.JSON] else {
            return
        }
        //Automatically,update pokeItem,or return empty one if something is gonna go bad -> []
        pokeItems = [PokeItem].from(jsonArray: responseDict) ?? []
        //to present on a TableV we are running in a new thread
        DispatchQueue.main.async {
            self.pokeNewsTableView.reloadData()
            self.activityIndicator(animated: false)
            
        }
    }
}

//extension to present the data and pass it by clicking to another VC

extension NewsPokeViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //var pokeItems assigned above, automatically presenting .count, when reloading data
        return pokeItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "pokeNews", for: indexPath) as? PokeNewsTableViewCell else {
            return UITableViewCell()
        }
        let pokeItem = pokeItems[indexPath.row]
        cell.pokeNewsLabel.text = pokeItem.pokeTitle
        cell.pokeNewsLabel.numberOfLines = 0
        
        //to have image
        if let pokeImage = pokeItem.pokeImage{
            cell.pokeNewsImage.image = pokeImage
            
            
        }
        
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    //func when click on Cell-> tells the delegate a row is selected.Specific indexPaths on the specific Cell
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //create a Storyboard connection, accesing name, without using seg.
        //Class name "DetailPokeViewController" -_ set as Storuboard ID
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        guard let vc = storyboard.instantiateViewController(identifier: "DetailPokeViewController")as?
                DetailPokeViewController else {return}
        
        
        let pokeItem = pokeItems[indexPath.row]
        vc.contentPokeString = pokeItem.pokeDescription
        vc.titlePokeString = pokeItem.pokeTitle
        vc.weburlPokeString = pokeItem.pokeUrl
        vc.newsPokeImage = pokeItem.pokeImage
        
        navigationController?.pushViewController(vc, animated: true)
        
    }
    
    
    
}

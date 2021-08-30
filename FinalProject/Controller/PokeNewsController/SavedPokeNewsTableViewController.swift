//
//  SavedPokeNewsTableViewController.swift
//  FinalProject
//
//  Created by olga.krjuckova on 23/08/2021.
//

import UIKit
import CoreData


class SavedPokeNewsTableViewController: UITableViewController {
    
    //same as in DetailPokeVC
    var savedPokeItems = [PokeItems]()
    var context: NSManagedObjectContext?
    
    //var weburlPokeStringForSource = Int()
    
    @IBOutlet weak var editButtonTitle: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.reloadData()
        
        
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        context = appDelegate.persistentContainer.viewContext
        loadData()
    }
        
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        loadData()
        counItems()
    }
    
    //copied func
        func saveData(){
            do{
                try context?.save()
                basicAlert(title: "OK", message: "Poke News was Deleted")
            }catch{
                print(error.localizedDescription)
            }
            loadData()
        }
    
    //how many items saved
    func counItems(){
        let itemsInTable = String(self.tableView.numberOfRows(inSection: 0))
        self.title = "Saved Pokemon News(\(itemsInTable))"
    }
    @IBAction func saveEditButtonTapped(_ sender: Any) {
        
        tableView.isEditing = !tableView.isEditing
        if tableView.isEditing{
            editButtonTitle.title = "Save"
        }else{
            editButtonTitle.title = "Edit"
        }
    }
    
    
    @IBAction func savedInfoButtonTapped(_ sender: Any) {
        basicAlert(title: "Info", message: "Here You can Find Saved Pokemon News")
    }
    
    func loadData(){
        let request:NSFetchRequest<PokeItems> = PokeItems.fetchRequest()
        do{
            savedPokeItems = try (context?.fetch(request))!
            tableView.reloadData()
        }catch{
            fatalError("Error in loading Poke Items")
        }
    }
    
    
    // MARK: - Table view data source
    
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return savedPokeItems.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "savedPokeData", for: indexPath) as? PokeNewsTableViewCell else{
            return UITableViewCell()
            
        }
        
        let pokeItem = savedPokeItems[indexPath.row]
        cell.pokeNewsLabel.text = pokeItem.newsTitle
        cell.pokeNewsLabel.numberOfLines = 0
        
        //to have image
        if let pokeImage = UIImage(data: pokeItem.pokeImage!){
            cell.pokeNewsImage.image = pokeImage
            
            
        }
        

        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
   
    
    //ddidSelectRow means, when I gonna tap on specific indexPath row then Ill go to mentioned View or another controller
    //and Im gonna pass value vc
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //see in storyboardId
        //need to pass item.url
        //The WebViewController StoryBoard ID must be set
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        guard let vc = storyboard.instantiateViewController(identifier: "WebPokeViewController") as? WebPokeViewController else {
            return
        }
        self.title = "Saved"
        vc.urlPokeString = self.savedPokeItems[indexPath.row].pokeUrl ??
           "https://newsapi.org/v2/everything?apiKey=8b14d98abae14dd9ac3e37adbd3d60f5&q=pokemon&from=2021-08-20&sortBy=publishedAt"
        navigationController?.pushViewController(vc, animated: true)
        
        
    }
    
    
    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        // Delete the row from the data source
        if editingStyle == .delete {
            let alert = UIAlertController(title: "Delete", message: "Do you want to delete?", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
            alert.addAction(UIAlertAction(title: "Delete", style: .destructive, handler: {_ in
                let item = self.savedPokeItems[indexPath.row]
                self.context?.delete(item)
                self.saveData()
                
            }))
            self.present(alert, animated: true)
            //need AllertController with closure
            //safeData and load Data
        }
    }

    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
        let row = savedPokeItems.remove(at: fromIndexPath.row)
        savedPokeItems.insert(row, at: to.row)
    }
   
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    
}

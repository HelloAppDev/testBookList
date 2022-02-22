import UIKit

class BookListTableViewController: UITableViewController {
    
    var booksCell: [BookModel] {
        get {
            if let data = defaults.value(forKey: "booksCell") as? Data {
                return try! PropertyListDecoder().decode([BookModel].self, from: data)
            } else {
                return [BookModel]()
            }
        }
        set {
            if let data = try? PropertyListEncoder().encode(newValue) {
                defaults.setValue(data, forKey: "booksCell")
            }
        }
    }
    let label = UILabel(frame: CGRect(x: 0, y: 0, width: 200, height: 35))
    var bookStore = BookModel(booksTitle: "", date: "")
    let defaults = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.setHidesBackButton(true, animated: false)
        showHiddenEmptyLabel()
    }
    func saveBookData (booksTitle: String, date: String?) {
        let book = BookModel(booksTitle: booksTitle, date: date!)
        booksCell.insert(book, at: 0)
    }
    
    func showHiddenEmptyLabel() {
        label.center = CGPoint(x: 200, y: 295)
        label.textAlignment = NSTextAlignment.center
        label.text = "Empty list"
        label.textColor = .darkGray
        label.font = UIFont.preferredFont(forTextStyle: .largeTitle)
        self.view.addSubview(label)
        label.isHidden = true
    }
    
    @IBAction func unwindSegue (_ segue: UIStoryboardSegue) {
        guard segue.identifier == "addNewBookSegue",
              let sourceVC = segue.source as? AddBook else { return }
        let newBook = sourceVC.addingNewBook
        if let selectedIndexPath = tableView.indexPathForSelectedRow {
            booksCell[selectedIndexPath.row] = newBook
            tableView.reloadRows(at: [selectedIndexPath], with: .fade)
        } else {
            let newIndexPath = IndexPath(row: booksCell.count, section: 0)
            booksCell.append(newBook)
            tableView.insertRows(at: [newIndexPath], with: .fade)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        guard segue.identifier == "editBookSegue",
              let indexPath = tableView.indexPathForSelectedRow else { return }
        let bookEdit = booksCell[indexPath.row]
        let editBookVC = segue.destination as? EditBook
        editBookVC?.editingBook = bookEdit
    }
    
    @IBAction func unwindEditingSegue (_ segue: UIStoryboardSegue) {
        guard segue.identifier == "editBookSegue",
              let sourceVC = segue.source as? EditBook else { return }
        let editBook = sourceVC.editingBook
        if let selectedIndexPath = tableView.indexPathForSelectedRow {
            booksCell[selectedIndexPath.row] = editBook
            tableView.reloadRows(at: [selectedIndexPath], with: .fade)
        } else {
            let indexPath = tableView.indexPathForSelectedRow!
            let bookEdit = booksCell[indexPath.row]
            let editBookVC = segue.destination as? EditBook
            editBookVC?.editingBook = bookEdit
        }
    }
    
    func sortAlert() {
        let ac = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        let sortName = UIAlertAction(title: "Sort by name", style: .default, handler: { [self] _ in
            booksCell = booksCell.sorted(by: { $0.booksTitle < $1.booksTitle })
            tableView.reloadData()
        })
        let sortDate = UIAlertAction(title: "Sort by date", style: .default, handler: { [self] _ in
            booksCell = booksCell.sorted(by: { $0.date < $1.date
            })
            tableView.reloadData()
        })
        let cancel = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        
        ac.addAction(sortName)
        ac.addAction(sortDate)
        ac.addAction(cancel)
        present(ac, animated: true, completion: nil)
    }
    @IBAction func sortButtonPressed(_ sender: UIBarButtonItem) {
        sortAlert()
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        if booksCell.count == 0 {
            label.isHidden = false
            tableView.separatorStyle = .none
        } else {
            label.isHidden = true
            tableView.separatorStyle = .singleLine
        }
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return booksCell.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! BookTableViewCell
        let index = indexPath.row
        let book = booksCell[index]
        cell.set(book: book)
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    override func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .delete
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            booksCell.remove (at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
}

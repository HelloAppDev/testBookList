import UIKit

class EditBook: UIViewController {
    
    var editingBook = BookModel(booksTitle: "", date: "")
    
    @IBOutlet weak var editBookTF: UITextField!
    @IBOutlet weak var editDate: UIDatePicker!
    @IBOutlet weak var editButton: UIButton!
    @IBOutlet weak var hiddenEditDateLabel: UILabel!
    
    lazy var edit = editBookTF.text
    
    override func viewDidLoad() {
        super.viewDidLoad()
        editName()
    }
    
    @IBAction func changeDate(_ sender: UIDatePicker) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        let dateValue = dateFormatter.string(from: sender.date)
        hiddenEditDateLabel.text = dateValue
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        guard segue.identifier == "editBookSegue" else { return }
        let bookName = editBookTF.text ?? ""
        let dateBook = hiddenEditDateLabel.text ?? ""
        self.editingBook = BookModel(booksTitle: bookName, date: dateBook)
    }
    
    private func editName() {
        editBookTF.text = editingBook.booksTitle
        hiddenEditDateLabel.text = editingBook.date
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
}

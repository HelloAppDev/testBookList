import UIKit

class AddBook: UIViewController {
    
    @IBOutlet weak var bookNameTF: UITextField!
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var addButton: UIButton!
    @IBOutlet weak var hiddenDateLabel: UILabel!
    
    var addingNewBook = BookModel(booksTitle: "", date: "")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupAddTargetIsNotEmptyTextFields()
        updateUI()
    }
    
    func setupAddTargetIsNotEmptyTextFields() {
        addButton.backgroundColor = .gray
        addButton.isUserInteractionEnabled = false
        bookNameTF.addTarget(self, action: #selector(textFieldsIsNotEmpty),
                             for: .editingChanged)
    }
    
    @objc func textFieldsIsNotEmpty(sender: UITextField) {
        sender.text = sender.text?.trimmingCharacters(in: .whitespaces)
        guard
            let title = bookNameTF.text, !title.isEmpty
        else {
            addButton.backgroundColor = .gray
            addButton.isUserInteractionEnabled = false
            return
        }
        addButton.backgroundColor = .systemBlue
        addButton.isUserInteractionEnabled = true
    }
    
    @IBAction func changeDate(_ sender: UIDatePicker) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        let dateValue = dateFormatter.string(from: sender.date)
        hiddenDateLabel.text = dateValue
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        guard segue.identifier == "addNewBookSegue" else { return }
        let bookName = bookNameTF.text ?? ""
        let dateBook = hiddenDateLabel.text ?? ""
        self.addingNewBook = BookModel(booksTitle: bookName, date: dateBook)
    }
    
    private func updateUI() {
        bookNameTF.text = addingNewBook.booksTitle
        hiddenDateLabel.text = addingNewBook.date
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
}

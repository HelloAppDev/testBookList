import UIKit

class BookTableViewCell: UITableViewCell {
    @IBOutlet weak var nameOfBookLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    
    func set(book: BookModel) {
    self.nameOfBookLabel.text = book.booksTitle
    self.dateLabel.text = book.date
  }
}

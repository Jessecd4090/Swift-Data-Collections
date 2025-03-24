//
//  BookTableViewCell.swift
//  FavoriteBooks
//
//  Created by Jestin Dorius on 3/10/25.
//

import UIKit

class BookTableViewCell: UITableViewCell {
    
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var authorLabel: UILabel!
    
    @IBOutlet var genreLabel: UILabel!
    @IBOutlet var lengthLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func update(with Book: Book) {
        guard ((titleLabel.text?.isEmpty) != nil) else { return }
            titleLabel.text? = Book.title
            authorLabel.text? = Book.author
            genreLabel.text? = Book.genre
            lengthLabel.text? = Book.length
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

//TODO: need to acutally create with a COCOTOUCH  class 

//Subclass of UITableViewCell
//chcekc the XIB
//https://www.youtube.com/watch?v=mT3OFcui97k
class StockTableViewCell : UITableView{
    @IBOutlet var stockTitleLabel: UILabel!;



    override func awakeFromNib(){
        super.awakeFromNib()
    }
       override func setSelected(_ selected : Bool,animated : Bool){
        super.setSelected(selected)
    }


    static let identifier = "StockTableViewCell"
    //Nibe is a way to represent a cell in a tableviewCell
    static func nib()-> UINib{
        return UINib(nibName:"Stock
        TableViewCell",
        bundle:nil)
    }
    //used to configure each cell with their result
    func configure(with model: StockProfile){
        self.stockTitleLabel.text = model.title

        //used
    }

}
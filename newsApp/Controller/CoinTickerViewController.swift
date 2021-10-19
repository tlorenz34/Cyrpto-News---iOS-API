//
//  CoinTickerViewController.swift
//  newsApp
//
//  Created by Thaddeus Lorenz on 10/12/21.
//

import UIKit
import Coinpaprika



struct Ticker{
    var name: String
    var value: String
    init(name: String, value: String){
        self.name = name
        self.value = value
    }
}

class CoinTickerViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    

    let numberFormatter = NumberFormatter()


    var tickerArray = [String]()
    
    
    var array = [Ticker]()
    

    @IBOutlet weak var tableView: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        Coinpaprika.API.tickers(quotes: [.usd, .btc]).perform { (response) in
          switch response {


          case .success(let tickers):
            
            
            var arraySlice = tickers[0...20]

            for i in arraySlice{
                self.array.append(Ticker(name: "\(i.name)", value: "\(i.betaValue)"))
                print(self.array)
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            }
            

            case .failure(let error):
                break
            // Failure reason as error
          }
        }

        
        

    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "TickerTableViewCell", for: indexPath) as! TickerTableViewCell
        
        let ticker = array[indexPath.row]

        
        cell.coinNameLabel?.text = ticker.name
        
        cell.coinValueLabel?.text = ticker.value
        
        return cell
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        self.array.count
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
 

}




import UIKit
import Firebase

private struct Feed {
    let id: String
    let title: String
}

class FeedTableViewController: UITableViewController {

    private enum FeedTableViewControllerCellIdentifier: String {
        case Feed = "Feed"
    }
    
    private lazy var feeds = {
        return [Feed(id: "123",
                     title: "Apple"),
                Feed(id: "456",
                     title: "Google"),
                Feed(id: "789",
                     title: "Samsung")]
    }()
        
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return feeds.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: FeedTableViewControllerCellIdentifier.Feed.rawValue,
                                                 for: indexPath)
        cell.textLabel?.text = feeds[indexPath.row].title
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let product: [String : Any] =
            [
                AnalyticsParameterItemID : feeds[indexPath.row].id,
                AnalyticsParameterItemName : feeds[indexPath.row].title,
                AnalyticsParameterItemCategory : "Feeds",
                AnalyticsParameterItemVariant : "Feeds",
                AnalyticsParameterItemBrand : "Feeds",
                AnalyticsParameterPrice : 1.00,
                AnalyticsParameterCurrency : "GBP",
                AnalyticsParameterQuantity : 1
        ]
        
        Analytics.logEvent(AnalyticsEventEcommercePurchase, parameters: [
            AnalyticsParameterTransactionID : "123456",
            AnalyticsParameterValue : 1.0,
            AnalyticsParameterCurrency : "GBP",
            "items" : [product]
            ])
    }
}

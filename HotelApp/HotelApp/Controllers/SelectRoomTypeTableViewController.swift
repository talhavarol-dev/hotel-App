//
//  SelectRoomTypeTableViewController.swift
//  HotelApp
//
//  Created by Talha Varol on 15.03.2022.
//

import UIKit


protocol SelectRoomTypeTableViewControllerDelegate: AnyObject {
    func didSelect(roomType: RoomType)
}
class SelectRoomTypeTableViewController: UITableViewController {

    // MARK: - Properties
    var selectedRoomType: RoomType?
    weak var delegate: SelectRoomTypeTableViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    // MARK: - Functions
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
        
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return RoomType.all.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "RoomTypeCell")!
        let roomType = RoomType.all[indexPath.row]
        
        cell .textLabel?.text = roomType.name
        cell.detailTextLabel?.text = "₺ \(roomType.price)"
        
        if roomType == self.selectedRoomType{
            // o an çizilmekte olan oda türü, önceden seçilen oda türü mü?
            cell.accessoryType = .checkmark
        }else{
            cell.accessoryType = .none
        }
        return cell
        
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        selectedRoomType = RoomType.all[indexPath.row]
        delegate?.didSelect(roomType: selectedRoomType!)
        tableView.reloadData()
    }
 

}

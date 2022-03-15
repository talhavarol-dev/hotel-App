//
//  AddRegistrationTableViewController.swift
//  HotelApp
//
//  Created by Talha Varol on 14.03.2022.
//

import UIKit

class AddRegistrationTableViewController: UITableViewController,SelectRoomTypeTableViewControllerDelegate {
    
    
    // MARK: - UI Elements
    
    @IBOutlet var firstNameTextField: UITextField!
    @IBOutlet var lastNameTextField: UITextField!
    @IBOutlet var emailTextField: UITextField!
    
    @IBOutlet var checkInDateLabel: UILabel!
    @IBOutlet var checkInDatePicker: UIDatePicker!
    @IBOutlet var checkOutDateLabel: UILabel!
    @IBOutlet var checkOutDatePicker: UIDatePicker!
    
    @IBOutlet var numberOfAdultsLabel: UILabel!
    @IBOutlet var numberOfAdultsStepper: UIStepper!
    @IBOutlet var numberOfChildrenLabel: UILabel!
    @IBOutlet var numberOfChildrenStepper: UIStepper!
    @IBOutlet var wifiSwitch: UISwitch!
    
    @IBOutlet var roomTypeLabel: UILabel!
    
    
    // MARK: - Properties
    let checkInDateLabelCellIndexPath = IndexPath(row: 0, section: 1)
    let checkOutDateLabelCellIndexPath = IndexPath(row: 2, section: 1)
    
    let checkInDatePiickerCellIndexPath = IndexPath(row: 1, section: 1)
    let checkOutDatePiickerCellIndexPath = IndexPath(row: 3, section: 1)
    
    var isCheckInDatePickerShown: Bool = false{
        didSet{
            // isHidden: Bir arayüz elemanının gözüküp gözükmemesi.
            checkInDatePicker.isHidden = !isCheckInDatePickerShown
        }
    }
    var isCheckOutDatePickerShown: Bool = false{
        didSet{
            // isHidden: Bir arayüz elemanının gözüküp gözükmemesi.
            checkOutDatePicker.isHidden = !isCheckOutDatePickerShown
        }
    }
    
    var roomType: RoomType?
    
    var registration: Registration?{
        guard let roomType = roomType else {return nil}
        
        let firstName = firstNameTextField.text!
        let lastName = lastNameTextField.text!
        let email = emailTextField.text!
        let checkInDate = checkInDatePicker.date
        let checkOutDate = checkOutDatePicker.date
        let numberOfAdults = Int(numberOfAdultsStepper.value)
        let numberOfChildren = Int(numberOfChildrenStepper.value)
        let hasWifi = wifiSwitch.isOn
        
        return Registration(firstName: firstName, lastName: lastName, emailAddress: email, checkInDate: checkInDate, checkOutDate: checkOutDate, numberOfAdults: numberOfAdults, numberOfChildren: numberOfChildren, roomType: roomType, wifi: hasWifi)
    }
    
    // MARK: Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // datePicker ıos 15 ten sonra sürüklemeli gelmiyor. Bunu eklemen lazım.
        
        checkInDatePicker.preferredDatePickerStyle = .wheels
        checkOutDatePicker.preferredDatePickerStyle = .wheels
        
        //CheckIn tarihini, bugün olarak ayarla
        // Date() ->> o anın tarihi.
        
        let today = Calendar.current.startOfDay(for: Date())
        
        // en küçük tarih ayarlandı. picker'ım saatli formatta olsaydı o da gelecekti.
        
        checkInDatePicker.minimumDate = today
        checkInDatePicker.date = today
        
        updateDateViews()
        
        // StoryBoarddaki geçici değerleri sıfırlar
        updateNumberOfGuests()
        
        updateRoomTyope()
    }
    
    // MARK: - Functions
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "SelectRoomType" {
            let destination = segue.destination as? SelectRoomTypeTableViewController
            destination?.delegate = self
            destination?.selectedRoomType = roomType
        }
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath{
        case checkInDatePiickerCellIndexPath:
            if isCheckInDatePickerShown{
                return 216
            }else{
                return 0
            }
        case checkOutDatePiickerCellIndexPath:
            if isCheckOutDatePickerShown{
                return 216
            }else{
                return 0
            }
        default:
            return 44
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // seçili olan hücrenin seçili olma durumunu kaldırır
        tableView.deselectRow(at: indexPath, animated: true)
        
        switch indexPath {
        case checkInDateLabelCellIndexPath:
            if isCheckInDatePickerShown {
                isCheckInDatePickerShown = false
            }else if isCheckInDatePickerShown{
                isCheckOutDatePickerShown = false
                isCheckInDatePickerShown = true
            }else{
                isCheckInDatePickerShown = true
            }
            
            tableView.beginUpdates()
            tableView.endUpdates()
     
        case checkOutDateLabelCellIndexPath:
            if isCheckOutDatePickerShown {
                isCheckOutDatePickerShown = false
            }else if isCheckInDatePickerShown{
                isCheckOutDatePickerShown = true
                isCheckInDatePickerShown = false
            }else{
                isCheckOutDatePickerShown = true
            }
            tableView.beginUpdates()
            tableView.endUpdates()
        default:
            break
        }
    }
    
    
    func updateDateViews(){
        
        // minimum 1 gün konaklama olmak zorunda.
        let oneDay: Double = 24 * 60 * 60 // 24 saati saniye cinsinden tanımladık.
        checkOutDatePicker.minimumDate = checkInDatePicker.date.addingTimeInterval(oneDay)
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        
        checkInDateLabel.text = dateFormatter.string(from: checkInDatePicker.date)
        checkOutDateLabel.text = dateFormatter.string(from: checkOutDatePicker.date)
        
    }
    
    func updateNumberOfGuests(){
        numberOfAdultsLabel.text = "\(Int(numberOfAdultsStepper.value))"
        numberOfChildrenLabel.text = "\(Int(numberOfChildrenStepper.value))"
    }
    func updateRoomTyope(){
        if let roomType = roomType {
            roomTypeLabel.text = roomType.name
        }else {
            roomTypeLabel.text = "Not Set"
        }
    }
    func didSelect(roomType: RoomType) {
        self.roomType = roomType
        updateRoomTyope()
    }
    
    // MARK: - Actions
    @IBAction func datePickerValueChanged(_ picker: UIDatePicker){
        updateDateViews()
        
    }
    @IBAction func stepperValueChanged(_ stepper: UIStepper)
    {
        updateNumberOfGuests()
    }
    @IBAction func wifiSwitchChanged(_ sender: UISwitch){
        
    }
    @IBAction func cancelBarButtonTapped(_ button: UIButton){
        dismiss(animated: true, completion: nil)
    }
}

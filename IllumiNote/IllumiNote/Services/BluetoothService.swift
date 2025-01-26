import Foundation
import CoreBluetooth

class BluetoothService: NSObject, ObservableObject, CBCentralManagerDelegate, CBPeripheralDelegate {
    var centralManager: CBCentralManager!
    var raspberryPiPeripheral: CBPeripheral?
    var writeCharacteristic: CBCharacteristic?

    @Published var receivedResults: Bool = false
    @Published var isConnected: Bool = false
    var resultsData: Data?

    override init() {
        super.init()
        centralManager = CBCentralManager(delegate: self, queue: nil)
    }

    func peripheral(_ peripheral: CBPeripheral, didUpdateValueFor characteristic: CBCharacteristic, error: Error?) {
        if let error = error {
            print("Error receiving value: \(error.localizedDescription)")
            return
        }

        if let value = characteristic.value {
            resultsData = value
            print("Received data: \(String(data: value, encoding: .utf8) ?? "Invalid data")")
            receivedResults = true // Notify that results are ready
        }
    }

    /// Called whenever the Bluetooth state changes
    func centralManagerDidUpdateState(_ central: CBCentralManager) {
        if central.state == .poweredOn {
            // scan for peripherals with any service UUIDs
            centralManager.scanForPeripherals(withServices: nil, options: nil)
        }
    }

    /// Called when a peripheral is discovered
    /// if peripheral is the raspberry pi, it attempts to connect
    func centralManager(_ central: CBCentralManager, didDiscover peripheral: CBPeripheral, advertisementData: [String : Any], rssi RSSI: NSNumber) {
        if peripheral.name == "raspberrypi" {
            raspberryPiPeripheral = peripheral
            raspberryPiPeripheral?.delegate = self
            centralManager.stopScan()
            centralManager.connect(peripheral, options: nil)
        }
    }

    /// Called when the peripheral is successfully connected
    func centralManager(_ central: CBCentralManager, didConnect peripheral: CBPeripheral) {
        isConnected = true
        peripheral.discoverServices(nil)
    }

    func centralManager(_ central: CBCentralManager, didDisconnectPeripheral peripheral: CBPeripheral, error: Error?) {
        isConnected = false
    }

    func peripheral(_ peripheral: CBPeripheral, didDiscoverServices error: Error?) {
        guard let services = peripheral.services else { return }
        for service in services {
            peripheral.discoverCharacteristics(nil, for: service)
        }
    }

    func peripheral(_ peripheral: CBPeripheral, didDiscoverCharacteristicsFor service: CBService, error: Error?) {
        guard let characteristics = service.characteristics else { return }
        for characteristic in characteristics {
            if characteristic.properties.contains(.write) {
                writeCharacteristic = characteristic
                // Write data here or store the characteristic for later use
                // You can send the JSON data after finding the characteristic
                //sendJSONData(to: peripheral)
            }
        }
    }

    func sendMIDIData(from jsonFileName: String) {
        guard let peripheral = raspberryPiPeripheral, let writeCharacteristic = writeCharacteristic else {
            print("Peripheral or characteristic is not ready.")
            return
        }

        // Load the JSON file
        if let url = Bundle.main.url(forResource: jsonFileName, withExtension: "json") {
            do {
                let jsonData = try Data(contentsOf: url)
                print("Sending JSON data: \(String(data: jsonData, encoding: .utf8) ?? "Invalid JSON")")
                peripheral.writeValue(jsonData, for: writeCharacteristic, type: .withResponse)
            } catch {
                print("Failed to load JSON file: \(error)")
            }
        } else {
            print("JSON file not found.")
        }
    }

    func peripheral(_ peripheral: CBPeripheral, didWriteValueFor characteristic: CBCharacteristic, error: Error?) {
        if let error = error {
            print("Error writing value: \(error.localizedDescription)")
        } else {
            print("Successfully wrote value for characteristic \(characteristic.uuid)")
        }
    }
}

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

    func isBluetoothConnected() -> Bool {
        guard let peripherals = centralManager?.retrieveConnectedPeripherals(withServices: []) else {
            return false
        }
        return !peripherals.isEmpty
    }

    func checkBluetoothDevices() {
        let connectedPeripherals = centralManager.retrieveConnectedPeripherals(withServices: [])
        isConnected = !connectedPeripherals.isEmpty
        print("Connected peripherals count: \(connectedPeripherals.count)")
        connectedPeripherals.forEach { peripheral in
            print("Connected peripheral name: \(peripheral.name ?? "Unknown")")
        }
    }

    func centralManagerDidUpdateState(_ central: CBCentralManager) {
        switch central.state {
        case .poweredOn:
            let connectedDevices = central.retrieveConnectedPeripherals(withServices: [])
            print("Connected devices count: \(connectedDevices.count)")
            connectedDevices.forEach { device in
                print("Connected device name: \(device.name ?? "Unknown")")
            }
            checkBluetoothDevices()
            centralManager.scanForPeripherals(withServices: nil, options: nil)
        case .poweredOff:
            print("Bluetooth is powered off")
            isConnected = false
        default:
            print("Bluetooth state: \(central.state)")
        }
    }
    /// Called when a peripheral is discovered
   /// if peripheral is the raspberry pi, it attempts to connect
//    func centralManager(_ central: CBCentralManager, didDiscover peripheral: CBPeripheral, advertisementData: [String : Any], rssi RSSI: NSNumber) {
//        print("Discovered peripheral: \(peripheral.name ?? "Unknown"), RSSI: \(RSSI)")
//        print("Advertisement data: \(advertisementData)")
//        print("Peripheral UUID: \(peripheral.identifier.uuidString)") // This is the unique identifier for the peripheral.
//        
//        if peripheral.name == "raspberrypi" {
//            raspberryPiPeripheral = peripheral
//            raspberryPiPeripheral?.delegate = self
//            centralManager.stopScan()
//            centralManager.connect(peripheral, options: nil)
//        }
//    }
    
    func centralManager(_ central: CBCentralManager, didDiscover peripheral: CBPeripheral, advertisementData: [String: Any], rssi RSSI: NSNumber) {
        print("Discovered Peripheral: \(peripheral)")
        print("Name: \(peripheral.name ?? "Unknown")")
        print("Advertisement Data: \(advertisementData)")
        print("RSSI: \(RSSI)")

        // Check for a name in the advertisement data
        if peripheral.name == "raspberrypi" {
                   raspberryPiPeripheral = peripheral
                   raspberryPiPeripheral?.delegate = self
                   centralManager.stopScan()
                   centralManager.connect(peripheral, options: nil)
               }

    }



    func centralManager(_ central: CBCentralManager, didConnect peripheral: CBPeripheral) {
        isConnected = true
        print("Connected to peripheral: \(peripheral.name ?? "Unknown")")
        peripheral.discoverServices(nil)
    }

    func centralManager(_ central: CBCentralManager, didDisconnectPeripheral peripheral: CBPeripheral, error: Error?) {
        isConnected = false
        print("Disconnected from peripheral: \(peripheral.name ?? "Unknown")")
    }
    
    func centralManager(_ central: CBCentralManager, didFailToConnect peripheral: CBPeripheral, error: Error?) {
            print("Failed to connect: \(peripheral.name ?? "Unknown")")
        }
    
    
    

    func peripheral(_ peripheral: CBPeripheral, didDiscoverServices error: Error?) {
        guard let services = peripheral.services else { return }
        print("Discovered services")
        for service in services {
            peripheral.discoverCharacteristics(nil, for: service)
        }
    }

//    func peripheral(_ peripheral: CBPeripheral, didDiscoverCharacteristicsFor service: CBService, error: Error?) {
//        guard let characteristics = service.characteristics else { return }
//        for characteristic in characteristics {
//            if characteristic.properties.contains(.write) {
//                writeCharacteristic = characteristic
//            }
//        }
//    }

    func peripheral(_ peripheral: CBPeripheral, didUpdateValueFor characteristic: CBCharacteristic, error: Error?) {
        if let error = error {
            print("Error receiving value: \(error.localizedDescription)")
            return
        }

        if let value = characteristic.value {
            resultsData = value
            print("Received data: \(String(data: value, encoding: .utf8) ?? "Invalid data")")
            receivedResults = true
        }
    }
    
    func peripheral(_ peripheral: CBPeripheral, didDiscoverCharacteristicsFor service: CBService, error: Error?) {
        guard let characteristics = service.characteristics else { return }
        for characteristic in characteristics {
            if characteristic.properties.contains(.write) {
                writeCharacteristic = characteristic
                print("Write characteristic found: \(characteristic.uuid)")
            }
        }
    }


//    func sendMIDIData(from jsonFileName: String) {
//        guard let peripheral = raspberryPiPeripheral, let writeCharacteristic = writeCharacteristic else {
//            print("Peripheral or characteristic is not ready.")
//            return
//        }
//
//        if let url = Bundle.main.url(forResource: jsonFileName, withExtension: "json") {
//            do {
//                let jsonData = try Data(contentsOf: url)
//                print("Sending JSON data: \(String(data: jsonData, encoding: .utf8) ?? "Invalid JSON")")
//                peripheral.writeValue(jsonData, for: writeCharacteristic, type: .withResponse)
//            } catch {
//                print("Failed to load JSON file: \(error)")
//            }
//        } else {
//            print("JSON file not found.")
//        }
//    }


    func sendMIDIData(from jsonFileName: String) {
        guard let peripheral = raspberryPiPeripheral, let writeCharacteristic = writeCharacteristic else {
            print("Peripheral or characteristic is not ready.")
            return
        }

        if isConnected {
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
        } else {
            print("Bluetooth is not connected.")
        }
    }


//    func peripheral(_ peripheral: CBPeripheral, didWriteValueFor characteristic: CBCharacteristic, error: Error?) {
//        if let error = error {
//            print("Error writing value: \(error.localizedDescription)")
//        } else {
//            print("Successfully wrote value for characteristic \(characteristic.uuid)")
//        }
//    }
    
    func peripheral(_ peripheral: CBPeripheral, didWriteValueFor characteristic: CBCharacteristic, error: Error?) {
        if let error = error {
            print("Error writing value: \(error.localizedDescription)")
        } else {
            print("Successfully wrote value for characteristic \(characteristic.uuid)")
        }
    }

}

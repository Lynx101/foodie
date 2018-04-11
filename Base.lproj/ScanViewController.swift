import UIKit
import AVFoundation

var PantryScans:[String] = ["0055577105979"]
var PantryItems:[String:String] = ["0055577105979" : "Syrup"]

var Item = ""

class CameraView: UIView {
    override class var layerClass: AnyClass {
        get {
            return AVCaptureVideoPreviewLayer.self
        }
    }
    
    
    override var layer: AVCaptureVideoPreviewLayer {
        get {
            return super.layer as! AVCaptureVideoPreviewLayer
        }
    }
}
class ScanViewController: UIViewController, AVCaptureMetadataOutputObjectsDelegate {
    
    var cameraView: CameraView!
    
    let session = AVCaptureSession()
    let sessionQueue = DispatchQueue(label: AVCaptureSession.self.description(), attributes: [], target: nil)
    
    override func loadView() {
        cameraView = CameraView()
        
        view = cameraView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let alertController = UIAlertController(title: "Shake To Get Out Of Scan", message: "", preferredStyle: .alert)
        
        alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        
        present(alertController, animated: true, completion: nil)
        
        session.beginConfiguration()
        
        let videoDevice = AVCaptureDevice.default(for: .video)
        
        if (videoDevice != nil) {
            let videoDeviceInput = try? AVCaptureDeviceInput(device: videoDevice!)
            
            if (videoDeviceInput != nil) {
                if (session.canAddInput(videoDeviceInput!)) {
                    session.addInput(videoDeviceInput!)
                }
            }
            
            let metadataOutput = AVCaptureMetadataOutput()
            
            if (session.canAddOutput(metadataOutput)) {
                session.addOutput(metadataOutput)
                
                metadataOutput.metadataObjectTypes = [
                    .ean13,
                    .qr
                ]
                
                metadataOutput.setMetadataObjectsDelegate(self, queue: DispatchQueue.main)
            }
        }
        
        session.commitConfiguration()
        
        cameraView.layer.session = session
        cameraView.layer.videoGravity = .resizeAspectFill
        
        let videoOrientation: AVCaptureVideoOrientation
        switch UIApplication.shared.statusBarOrientation {
        case .portrait:
            videoOrientation = .portrait
            
        case .portraitUpsideDown:
            videoOrientation = .portraitUpsideDown
            
        case .landscapeLeft:
            videoOrientation = .landscapeLeft
            
        case .landscapeRight:
            videoOrientation = .landscapeRight
            
        default:
            videoOrientation = .portrait
        }
        
        cameraView.layer.connection?.videoOrientation = videoOrientation
        
        
        
    }
    
    override func motionEnded(_ motion: UIEventSubtype, with event: UIEvent?)
    {
        if event?.subtype == UIEventSubtype.motionShake
        {
            
            
            performSegue(withIdentifier: "Segue3", sender: nil)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        sessionQueue.async {
            self.session.startRunning()
            
            let alertController = UIAlertController(title: "Shake To Get Out Of Scan", message: "", preferredStyle: .alert)
            
            alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            
            self.present(alertController, animated: true, completion: nil)
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        sessionQueue.async {
            self.session.stopRunning()
        }
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        
        // Update camera orientation
        let videoOrientation: AVCaptureVideoOrientation
        switch UIDevice.current.orientation {
        case .portrait:
            videoOrientation = .portrait
            
        case .portraitUpsideDown:
            videoOrientation = .portraitUpsideDown
            
        case .landscapeLeft:
            videoOrientation = .landscapeRight
            
        case .landscapeRight:
            videoOrientation = .landscapeLeft
            
        default:
            videoOrientation = .portrait
        }
        
        cameraView.layer.connection?.videoOrientation = videoOrientation
    }
    
    func metadataOutput(_ output: AVCaptureMetadataOutput, didOutput metadataObjects: [AVMetadataObject], from connection: AVCaptureConnection) {
        if (metadataObjects.count > 0 && metadataObjects.first is AVMetadataMachineReadableCodeObject)
        {
            let scan = metadataObjects.first as! AVMetadataMachineReadableCodeObject
            
            
            if PantryScans.contains(scan.stringValue!)
            {
                let alertController = UIAlertController(title: String("Already Scanned \(PantryItems[scan.stringValue!] ?? "")"), message: "", preferredStyle: .alert)
                
                alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                
                present(alertController, animated: true, completion: nil)
                
                print(PantryItems)
                
            } else
            {
                let alertController = UIAlertController(title: "Barcode Scanned", message: scan.stringValue, preferredStyle: .alert)
                
                alertController.addAction(UIAlertAction(title: "Discard", style: .default, handler: { (action) in
                    alertController.dismiss(animated: true, completion: nil)
                }))
                
                alertController.addAction(UIAlertAction(title: "Save", style: .default, handler:{ (action) in
                    alertController.dismiss(animated: true, completion: nil)
                    
                    if PantryItems.keys.contains(scan.stringValue!)
                    {
                        
                    } else
                    {
                        
                        //1. Create the alert controller.
                        let alert = UIAlertController(title: "Pantry Item", message: "", preferredStyle: .alert)
                        
                        //2. Add the text field. You can configure it however you need.
                        alert.addTextField { (textField) in
                            textField.placeholder = "Enter Pantry Item Name"
                            
                        }
                        
                        // 3. Grab the value from the text field, and print it when the user clicks OK.
                        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { [weak alert] (_) in
                            let textField = alert?.textFields![0] // Force unwrapping because we know it exists.
                            
                            Item = String("Text field: \(textField?.text ?? "")")
                            
                        }))
                        
                        PantryScans.append(scan.stringValue!)
                        PantryItems[scan.stringValue!] = Item
                        
                        // 4. Present the alert.
                        self.present(alert, animated: true, completion: nil)
                        
                    }
                }))
                
                present(alertController, animated: true, completion: nil)
                
                print(PantryItems)
                
            }
        }
    }
    
}



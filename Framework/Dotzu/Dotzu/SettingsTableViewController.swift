//
//  SettingsTableViewController.swift
//  exampleWindow
//
//  Created by Remi Robert on 18/01/2017.
//  Copyright © 2017 Remi Robert. All rights reserved.
//

import UIKit
import ReplayKit

class SettingsTableViewController: UITableViewController {
    
    @IBOutlet weak var switchResetLogs: UISwitch!
    @IBOutlet weak var switchOverridePrint: UISwitch!
    @IBOutlet weak var switchDisplayInfoFile: UISwitch!
    @IBOutlet weak var switchDisplayDate: UISwitch!
    @IBOutlet weak var switchNetworkEnable: UISwitch!
    @IBOutlet weak var imageViewLogo: UIImageView!
    
    @IBOutlet weak var startButton: UIButton!
    @IBOutlet weak var stopButton: UIButton!
    
    let recorder = RPScreenRecorder.shared()
    
    @IBAction func valueDidChange(_ sender: UISwitch) {
        let tag = sender.tag
        switch tag {
        case 0: LogsSettings.shared.resetLogsStart = sender.isOn
        case 1: LogsSettings.shared.overridePrint = sender.isOn
        case 2:
            LogsSettings.shared.fileInfo = sender.isOn
            LogNotificationApp.settingsChanged.post(Void())
        case 3:
            LogsSettings.shared.date = sender.isOn
            LogNotificationApp.settingsChanged.post(Void())
        case 4:
            LogsSettings.shared.network = sender.isOn
            if LogsSettings.shared.network {
                LoggerNetwork.register()
            } else {
                LoggerNetwork.unregister()
            }
        default: break
        }
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let image = UIImage(named: "logo", in: Bundle(for: LogHeadView.self), compatibleWith: nil)
        imageViewLogo.image = image?.withRenderingMode(.alwaysTemplate)
        imageViewLogo.tintColor = Color.mainGreen
        
        switchDisplayInfoFile.onTintColor = Color.mainGreen
        switchOverridePrint.onTintColor = Color.mainGreen
        switchResetLogs.onTintColor = Color.mainGreen
        switchDisplayDate.onTintColor = Color.mainGreen
        switchNetworkEnable.onTintColor = Color.mainGreen
        
        UIApplication.shared.statusBarStyle = .lightContent
        setNeedsStatusBarAppearanceUpdate()
        
        switchOverridePrint.tag = 1
        switchDisplayInfoFile.tag = 2
        switchDisplayDate.tag = 3
        switchNetworkEnable.tag = 4
        
        switchResetLogs.isOn = LogsSettings.shared.resetLogsStart
        switchOverridePrint.isOn = LogsSettings.shared.overridePrint
        switchDisplayInfoFile.isOn = LogsSettings.shared.fileInfo
        switchDisplayDate.isOn = LogsSettings.shared.date
        switchNetworkEnable.isOn = LogsSettings.shared.network
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        updateStartButtonUI()
    }
    
    @IBAction fileprivate func startRecord(_ sender: UIButton) {
        if recorder.isRecording { return }
        if #available(iOS 10.0, *) {
            recorder.startRecording { (error) in
                self.updateStartButtonUI()
                if let error = error {
                    self.updateStartButtonUI()
                    print(error)
                }
            }
        } else {
            // Fallback on earlier versions
        }
    }
    
    @IBAction fileprivate func stopRecord(_ sender: UIButton) {
        if recorder.isRecording {
            recorder.stopRecording { (previewVC, error) in
                self.updateStartButtonUI()
                if let previewVC = previewVC {
                    previewVC.previewControllerDelegate = self
                    self.present(previewVC, animated: true, completion: nil)
                }
                
                if let error = error {
                    print(error)
                }
            }
        }
    }
    
    fileprivate func updateStartButtonUI() {
        if recorder.isRecording {
            startButton.setTitle("IS RECORDING", for: .normal)
            startButton.setTitleColor(.black, for: .normal)
        } else {
            startButton.setTitle("START", for: .normal)
            startButton.setTitleColor(.white, for: .normal)
        }
    }
}

extension SettingsTableViewController: RPPreviewViewControllerDelegate {
    func previewControllerDidFinish(_ previewController: RPPreviewViewController) {
        dismiss(animated: true, completion: nil)
    }
}

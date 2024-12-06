//
//  StaticDataFile.swift
//

import Foundation


struct StoryBoard {
    static let main = "Main"
}

struct Controller {
    static let homeVC = "HomeViewController"
    static let onboardingVC = "OnboardingViewController"
    static let settingVC = "SettingViewController"
    static let channelDetailsVC = "ChannelDetailViewController"
    static let addChannelVC = "AddChannelViewController"
}

struct Cell {
    static let channelsCell = "ChannelsTableViewCell"
    static let categoriesCell = "CategoriesCollectionViewCell"
    static let onboardingCell = "OnboardingCollectionViewCell"
}

struct AppConfigs
{
    static let appName : String = "The Channels"
    
    static let kBaseURL  = ""
    static let kGetCategoriesURL  = kBaseURL + "getcategories.php"
    static let kGetChannelsURL  = kBaseURL + "getchannels.php"
    static let kChannelActionURL  = kBaseURL + "action.php"
    
    static let kAppStoreAppId = "1473551769"
    static let kAppSharingURL : String = "https://apps.apple.com/app/slideshow-maker-photo-video/id1473551769"
    
    static let kSupportEmail : String = "support@thechannels.com"
    
    static let kAppTermsURL : String = "https://firebase.google.com/terms"
    static let kAppPrivacyPolicyURL : String = "https://support.google.com/admob/answer/6128543?hl=en"
}


func getIntroTitles()->[[String : String]]
{
    var arrIntroSlides = [[String : String]]()
    arrIntroSlides.append(["image":"icintro_0","title":"#1 Channel Listing App\non the AppStore"])
    arrIntroSlides.append(["image":"icintro_1","title":"Join Premium Channels"])
    arrIntroSlides.append(["image":"icintro_2","title":"Support us to grow by\nreview on the App Store"])
    return arrIntroSlides
}


func getMoreApps()->[[String : String]]
{
    var arrApps = [[String : String]]()
    arrApps.append([
        "appimage":"https://is1-ssl.mzstatic.com/image/thumb/Purple116/v4/2c/0b/4a/2c0b4a35-a5a2-2a12-3432-962063fbae31/AppIcon-0-0-1x_U007emarketing-0-7-0-85-220.png/292x0w.webp",
        "apptitle":"Period Tracker - Cycle Tracker",
        "appurl":"https://apps.apple.com/us/app/period-tracker-cycle-tracker/id1472492169"])
    arrApps.append([
        "appimage":"https://is1-ssl.mzstatic.com/image/thumb/Purple211/v4/9e/6e/a2/9e6ea2bb-a7c4-0763-5769-b2731fd85687/AppIcon-0-0-1x_U007emarketing-0-7-0-85-220.png/292x0w.webp",
        "apptitle":"Top Nine",
        "appurl":"https://apps.apple.com/us/app/top-nine/id1493363160"])
    arrApps.append([
        "appimage":"https://is1-ssl.mzstatic.com/image/thumb/Purple116/v4/7c/f6/4d/7cf64d29-4ecc-650e-51bf-13e1dc62ea60/AppIcon-0-0-1x_U007emarketing-0-7-0-0-85-220.png/292x0w.webp",
        "apptitle":"VPN Proxy Master",
        "appurl":"https://apps.apple.com/us/app/vpn-proxy-master/id1465195263"])
    arrApps.append([
        "appimage":"https://is1-ssl.mzstatic.com/image/thumb/Purple211/v4/af/5e/e2/af5ee2e9-1d53-5f44-f506-46a5305ed8e9/AppIconOpt3-0-0-1x_U007emarketing-0-7-0-0-85-220.png/292x0w.webp",
        "apptitle":"Followers+ Track for IG",
        "appurl":"https://apps.apple.com/us/app/followers-track-for-ig/id1463947171"])

    arrApps.append([
        "appimage":"https://is1-ssl.mzstatic.com/image/thumb/Purple116/v4/85/ae/72/85ae7284-5db8-810a-6e58-5c8004d89cbc/AppIcon-1x_U007emarketing-0-7-0-85-220-0.png/292x0w.webp",
        "apptitle":"Slideshow Maker Photo Video",
        "appurl":"https://apps.apple.com/us/app/slideshow-maker-photo-video/id1473551769"])
    arrApps.append([
        "appimage":"https://is1-ssl.mzstatic.com/image/thumb/Purple126/v4/60/39/a5/6039a567-fe49-d394-3712-fbdbaf8ce9d7/AppIcon-0-0-1x_U007emarketing-0-7-0-sRGB-85-220.png/292x0w.webp",
        "apptitle":"Pdf Scan - My Scanner App",
        "appurl":"https://apps.apple.com/us/app/pdf-scan-my-scanner-app/id1467641686"])
    arrApps.append([
        "appimage":"https://is1-ssl.mzstatic.com/image/thumb/Purple221/v4/f8/cd/7f/f8cd7f05-86f8-87b6-f46d-413a28e59bbf/AppIcon-0-0-1x_U007emarketing-0-7-0-85-220.png/292x0w.webp",
        "apptitle":"Hidden Camera Scanner Detector",
        "appurl":"https://apps.apple.com/us/app/hidden-camera-scanner-detector/id1468725639"])
    arrApps.append([
        "appimage":"https://is1-ssl.mzstatic.com/image/thumb/Purple211/v4/eb/57/1f/eb571f85-4617-fe2b-3f6d-f92b149e12c5/AppIcon-0-0-1x_U007epad-0-0-0-0-85-220.png/292x0w.webp",
        "apptitle":"Cleaner: Clean Up Storage",
        "appurl":"https://apps.apple.com/us/app/cleaner-clean-up-storage/id1452301483"])

    return arrApps
}



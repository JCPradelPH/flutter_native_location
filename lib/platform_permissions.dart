




import 'package:flutter_native_location/plugin_methods.dart';

class PlatformPermissions {
  static final String accessCheckinProperties = "android.permission.ACCESS_CHECKIN_PROPERTIES";
  static final String accessCoarseLocation = "android.permission.ACCESS_COARSE_LOCATION";
  static final String accessFineLocation = "android.permission.ACCESS_FINE_LOCATION";
  static final String accessLocationExtraCommands = "android.permission.ACCESS_LOCATION_EXTRA_COMMANDS";
  static final String accessNetworkState = "android.permission.ACCESS_NETWORK_STATE";
  static final String accessNotificationPolicy = "android.permission.ACCESS_NOTIFICATION_POLICY";
  static final String accessWifiState = "android.permission.ACCESS_WIFI_STATE";
  static final String accountManager = "android.permission.ACCOUNT_MANAGER";
  static final String addVoicemail = "com.android.voicemail.permission.ADD_VOICEMAIL";
  static final String answerPhoneCalls = "android.permission.ANSWER_PHONE_CALLS";
  static final String batteryStats = "android.permission.BATTERY_STATS";
  static final String bindAccessibilityService = "android.permission.BIND_ACCESSIBILITY_SERVICE";
  static final String bindAppwidget = "android.permission.BIND_APPWIDGET";
  static final String bindAutofillService = "android.permission.BIND_AUTOFILL_SERVICE";
  // deprecated
  static final String bindCarrierMessagingService = "android.permission.BIND_CARRIER_MESSAGING_SERVICE";
  static final String bindCarrierServices = "android.permission.BIND_CARRIER_SERVICES";
  static final String bindChooserTargetService = "android.permission.BIND_CHOOSER_TARGET_SERVICE";
  static final String bindConditionProviderService = "android.permission.BIND_CONDITION_PROVIDER_SERVICE";
  static final String bindDeviceAdmin = "android.permission.BIND_DEVICE_ADMIN";
  static final String bindDreamService = "android.permission.BIND_DREAM_SERVICE";
  static final String bindIncallService = "android.permission.BIND_INCALL_SERVICE";
  static final String bindInputMethod = "android.permission.BIND_INPUT_METHOD";
  static final String bindMidiDeviceService = "android.permission.BIND_MIDI_DEVICE_SERVICE";
  static final String bindNfcService = "android.permission.BIND_NFC_SERVICE";
  static final String bindNotificationListenerService = "android.permission.BIND_NOTIFICATION_LISTENER_SERVICE";
  static final String bindPrintService = "android.permission.BIND_PRINT_SERVICE";
  static final String bindQuickSettingsTile = "android.permission.BIND_QUICK_SETTINGS_TILE";
  static final String bindRemoteviews = "android.permission.BIND_REMOTEVIEWS";
  static final String bindScreeningService = "android.permission.BIND_SCREENING_SERVICE";
  static final String bindTelecomConnectionService = "android.permission.BIND_TELECOM_CONNECTION_SERVICE";
  static final String bindTextService = "android.permission.BIND_TEXT_SERVICE";
  static final String bindTvInput = "android.permission.BIND_TV_INPUT";
  static final String bindVisualVoicemailService = "android.permission.BIND_VISUAL_VOICEMAIL_SERVICE";
  static final String bindVoiceInteraction = "android.permission.BIND_VOICE_INTERACTION";
  static final String bindVpnService = "android.permission.BIND_VPN_SERVICE";
  static final String bindVrListenerService = "android.permission.BIND_VR_LISTENER_SERVICE";
  static final String bindWallpaper = "android.permission.BIND_WALLPAPER";
  static final String bluetooth = "android.permission.BLUETOOTH";
  static final String bluetoothAdmin = "android.permission.BLUETOOTH_ADMIN";
  static final String bluetoothPrivileged = "android.permission.BLUETOOTH_PRIVILEGED";
  static final String bodySensors = "android.permission.BODY_SENSORS";
  static final String broadcastPackageRemoved = "android.permission.BROADCAST_PACKAGE_REMOVED";
  static final String broadcastSms = "android.permission.BROADCAST_SMS";
  static final String broadcastSticky = "android.permission.BROADCAST_STICKY";
  static final String broadcastWapPush = "android.permission.BROADCAST_WAP_PUSH";
  static final String callPhone = "android.permission.CALL_PHONE";
  static final String callPrivileged = "android.permission.CALL_PRIVILEGED";
  static final String camera = "android.permission.CAMERA";
  static final String captureAudioOutput = "android.permission.CAPTURE_AUDIO_OUTPUT";
  static final String captureSecureVideoOutput = "android.permission.CAPTURE_SECURE_VIDEO_OUTPUT";
  static final String captureVideoOutput = "android.permission.CAPTURE_VIDEO_OUTPUT";
  static final String changeComponentEnabledState = "android.permission.CHANGE_COMPONENT_ENABLED_STATE";
  static final String changeConfiguration = "android.permission.CHANGE_CONFIGURATION";
  static final String changeNetworkState = "android.permission.CHANGE_NETWORK_STATE";
  static final String changeWifiMulticastState = "android.permission.CHANGE_WIFI_MULTICAST_STATE";
  static final String changeWifiState = "android.permission.CHANGE_WIFI_STATE";
  static final String clearAppCache = "android.permission.CLEAR_APP_CACHE";
  static final String controlLocationUpdates = "android.permission.CONTROL_LOCATION_UPDATES";
  static final String deleteCacheFiles = "android.permission.DELETE_CACHE_FILES";
  static final String deletePackages = "android.permission.DELETE_PACKAGES";
  static final String diagnostic = "android.permission.DIAGNOSTIC";
  static final String disableKeyguard = "android.permission.DISABLE_KEYGUARD";
  static final String dump = "android.permission.DUMP";
  static final String expandStatusBar = "android.permission.EXPAND_STATUS_BAR";
  static final String factoryTest = "android.permission.FACTORY_TEST";
  static final String getAccounts = "android.permission.GET_ACCOUNTS";
  static final String getAccountsPrivileged = "android.permission.GET_ACCOUNTS_PRIVILEGED";
  static final String getPackageSize = "android.permission.GET_PACKAGE_SIZE";
  // deprecated
  static final String getTasks = "android.permission.GET_TASKS";
  static final String globalSearch = "android.permission.GLOBAL_SEARCH";
  static final String installLocationProvider = "android.permission.INSTALL_LOCATION_PROVIDER";
  static final String installPackages = "android.permission.INSTALL_PACKAGES";
  static final String installShortcut = "com.android.launcher.permission.INSTALL_SHORTCUT";
  static final String instantAppForegroundService = "android.permission.INSTANT_APP_FOREGROUND_SERVICE";
  static final String internet = "android.permission.INTERNET";
  static final String killBackgroundProcesses = "android.permission.KILL_BACKGROUND_PROCESSES";
  static final String locationHardware = "android.permission.LOCATION_HARDWARE";
  static final String manageDocuments = "android.permission.MANAGE_DOCUMENTS";
  static final String manageOwnCalls = "android.permission.MANAGE_OWN_CALLS";
  static final String masterClear = "android.permission.MASTER_CLEAR";
  static final String mediaContentControl = "android.permission.MEDIA_CONTENT_CONTROL";
  static final String modifyAudioSettings = "android.permission.MODIFY_AUDIO_SETTINGS";
  static final String modifyPhoneState = "android.permission.MODIFY_PHONE_STATE";
  static final String mountFormatFilesystems = "android.permission.MOUNT_FORMAT_FILESYSTEMS";
  static final String mountUnmountFilesystems = "android.permission.MOUNT_UNMOUNT_FILESYSTEMS";
  static final String nfc = "android.permission.NFC";
  static final String packageUsageStats = "android.permission.PACKAGE_USAGE_STATS";
  // deprecated
  static final String persistentActivity = "android.permission.PERSISTENT_ACTIVITY";
  static final String processOutgoingCalls = "android.permission.PROCESS_OUTGOING_CALLS";
  static final String readCalendar = "android.permission.READ_CALENDAR";
  static final String readCallLog = "android.permission.READ_CALL_LOG";
  static final String readContacts = "android.permission.READ_CONTACTS";
  static final String readExternalStorage = "android.permission.READ_EXTERNAL_STORAGE";
  static final String readFrameBuffer = "android.permission.READ_FRAME_BUFFER";
  // deprecated
  static final String readInputState = "android.permission.READ_INPUT_STATE";
  static final String readLogs = "android.permission.READ_LOGS";
  static final String readPhoneNumbers = "android.permission.READ_PHONE_NUMBERS";
  static final String readPhoneState = "android.permission.READ_PHONE_STATE";
  static final String readSms = "android.permission.READ_SMS";
  static final String readSyncSettings = "android.permission.READ_SYNC_SETTINGS";
  static final String readSyncStats = "android.permission.READ_SYNC_STATS";
  static final String readVoicemail = "com.android.voicemail.permission.READ_VOICEMAIL";
  static final String reboot = "android.permission.REBOOT";
  static final String receiveBootCompleted = "android.permission.RECEIVE_BOOT_COMPLETED";
  static final String receiveMms = "android.permission.RECEIVE_MMS";
  static final String receiveSms = "android.permission.RECEIVE_SMS";
  static final String receiveWapPush = "android.permission.RECEIVE_WAP_PUSH";
  static final String recordAudio = "android.permission.RECORD_AUDIO";
  static final String reorderTasks = "android.permission.REORDER_TASKS";
  static final String requestCompanionRunInBackground = "android.permission.REQUEST_COMPANION_RUN_IN_BACKGROUND";
  static final String requestCompanionUseDataInBackground = "android.permission.REQUEST_COMPANION_USE_DATA_IN_BACKGROUND";
  static final String requestDeletePackages = "android.permission.REQUEST_DELETE_PACKAGES";
  static final String requestIgnoreBatteryOptimizations = "android.permission.REQUEST_IGNORE_BATTERY_OPTIMIZATIONS";
  static final String requestInstallPackages = "android.permission.REQUEST_INSTALL_PACKAGES";
  // deprecated
  static final String restartPackages = "android.permission.RESTART_PACKAGES";
  static final String sendRespondViaMessage = "android.permission.SEND_RESPOND_VIA_MESSAGE";
  static final String sendSms = "android.permission.SEND_SMS";
  static final String setAlarm = "com.android.alarm.permission.SET_ALARM";
  static final String setAlwaysFinish = "android.permission.SET_ALWAYS_FINISH";
  static final String setAnimationScale = "android.permission.SET_ANIMATION_SCALE";
  static final String setDebugApp = "android.permission.SET_DEBUG_APP";
  // deprecated
  static final String setPreferredApplications = "android.permission.SET_PREFERRED_APPLICATIONS";
  static final String setProcessLimit = "android.permission.SET_PROCESS_LIMIT";
  static final String setTime = "android.permission.SET_TIME";
  static final String setTimeZone = "android.permission.SET_TIME_ZONE";
  static final String setWallpaper = "android.permission.SET_WALLPAPER";
  static final String setWallpaperHints = "android.permission.SET_WALLPAPER_HINTS";
  static final String signalPersistentProcesses = "android.permission.SIGNAL_PERSISTENT_PROCESSES";
  static final String statusBar = "android.permission.STATUS_BAR";
  static final String systemAlertWindow = "android.permission.SYSTEM_ALERT_WINDOW";
  static final String transmitIr = "android.permission.TRANSMIT_IR";
  static final String uninstallShortcut = "com.android.launcher.permission.UNINSTALL_SHORTCUT";
  static final String updateDeviceStats = "android.permission.UPDATE_DEVICE_STATS";
  static final String useFingerprint = "android.permission.USE_FINGERPRINT";
  static final String useSip = "android.permission.USE_SIP";
  static final String vibrate = "android.permission.VIBRATE";
  static final String wakeLock = "android.permission.WAKE_LOCK";
  static final String writeApnSettings = "android.permission.WRITE_APN_SETTINGS";
  static final String writeCalendar = "android.permission.WRITE_CALENDAR";
  static final String writeCallLog = "android.permission.WRITE_CALL_LOG";
  static final String writeContacts = "android.permission.WRITE_CONTACTS";
  static final String writeExternalStorage = "android.permission.WRITE_EXTERNAL_STORAGE";
  static final String writeGservices = "android.permission.WRITE_GSERVICES";
  static final String writeSecureSettings = "android.permission.WRITE_SECURE_SETTINGS";
  static final String writeSettings = "android.permission.WRITE_SETTINGS";
  static final String writeSyncSettings = "android.permission.WRITE_SYNC_SETTINGS";
  static final String writeVoicemail = "com.android.voicemail.permission.WRITE_VOICEMAIL";

  static final List<String> androidPermissions = <String>[
    writeExternalStorage,
    camera,
  ];

  static final List<String> iosPermissions = <String>[
    PluginMethods.hasIosStoragePerm,
    PluginMethods.hasIosCameraPerm,
  ];
}
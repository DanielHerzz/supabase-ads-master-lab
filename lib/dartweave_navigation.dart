import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/gestures.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:io';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:flutter/foundation.dart';
import 'dart:async';

class NavigationArgsScope extends InheritedWidget {
  final String pageId;
  final Map<String, dynamic> args;
  const NavigationArgsScope({super.key, required this.pageId, required this.args, required super.child});
  static NavigationArgsScope? maybeOf(BuildContext context) =>
      context.dependOnInheritedWidgetOfExactType<NavigationArgsScope>();
  @override
  bool updateShouldNotify(NavigationArgsScope oldWidget) =>
      pageId != oldWidget.pageId || args != oldWidget.args;
}

class NavigationService {
  static Widget page(String pageId, {Map<String, dynamic> args = const {}}) {
    switch (pageId) {
      case "Ads": return NavigationArgsScope(pageId: "Ads", args: args, child: const AdsPage());
case "Database": return NavigationArgsScope(pageId: "Database", args: args, child: const DatabasePage());
case "Auth": return NavigationArgsScope(pageId: "Auth", args: args, child: const AuthPage());
case "Storage": return NavigationArgsScope(pageId: "Storage", args: args, child: const StoragePage());
      default: throw StateError('Unknown page ID: $pageId');
    }
  }

  static Future<dynamic> open(BuildContext context, String pageId,
      {Map<String, dynamic> args = const {}}) async {
    final target = page(pageId, args: Map<String, dynamic>.of(args));
    return await Navigator.of(context).push(MaterialPageRoute<dynamic>(
      settings: RouteSettings(name: pageId, arguments: args),
      builder: (_) => target,
    ));
  }

  static Future<dynamic> replace(BuildContext context, String pageId,
      {Map<String, dynamic> args = const {}}) async {
    final target = page(pageId, args: Map<String, dynamic>.of(args));
    return await Navigator.of(context).pushReplacement(MaterialPageRoute<dynamic>(
      settings: RouteSettings(name: pageId, arguments: args),
      builder: (_) => target,
    ));
  }

  static void back(BuildContext context, [dynamic result]) {
    if (Navigator.canPop(context)) Navigator.of(context).pop(result);
  }

  static Future<void> openAsRoot(BuildContext context, String pageId,
      {Map<String, dynamic> args = const {}}) async {
    final target = page(pageId, args: Map<String, dynamic>.of(args));
    await Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute<void>(
        settings: RouteSettings(name: pageId, arguments: args),
        builder: (_) => target,
      ),
      (_) => false,
    );
  }
}
class AdsPage extends StatefulWidget {
  const AdsPage();
  @override State<AdsPage> createState() => _AdsPageState();
}
class _AdsPageState extends State<AdsPage> {
    late final DwAdMobComponent _dwAdMob_admob = DwAdMobComponent(
    componentName: 'admob',
    testMode: DwAdMobService.testMode,
    isMounted: () => mounted,
    onInitialized: (status) async {
      if (!mounted) return;
      if (!context.mounted) return; if (mounted) { setState(() { _dwView_txtAdsStatus_text = ("Status: AdMob SDK Initialized").toString(); }); }
      if (!context.mounted) return; if (mounted) { setState(() { _dwView_txtAdsOutput_text = (status).toString(); }); }
    },
    onConsentUpdated: (consentStatus, canRequestAds) async {
      if (!mounted) return;
      if (!context.mounted) return; if (mounted) { setState(() { _dwView_txtAdsStatus_text = ("Status: Consent status updated").toString(); }); }
      if (!context.mounted) return; if (mounted) { setState(() { _dwView_txtAdsOutput_text = (consentStatus).toString(); }); }
    },
    onInterstitialLoaded: (adUnitId) async {
      if (!mounted) return;
      if (!context.mounted) return; if (mounted) { setState(() { _dwView_txtAdsStatus_text = ("Status: Interstitial loaded & ready").toString(); }); }
      if (!context.mounted) return; if (mounted) { setState(() { _dwView_txtAdsOutput_text = (adUnitId).toString(); }); }
    },
    onInterstitialFailedToLoad: (errorCode, errorMessage) async {
      if (!mounted) return;
      if (!context.mounted) return; if (mounted) { setState(() { _dwView_txtAdsStatus_text = ("Status: Interstitial failed to load").toString(); }); }
      if (!context.mounted) return; if (mounted) { setState(() { _dwView_txtAdsOutput_text = (errorMessage).toString(); }); }
    },
    onInterstitialDismissed: () async {
      if (!mounted) return;
    },
    onRewardedLoaded: (adUnitId) async {
      if (!mounted) return;
      if (!context.mounted) return; if (mounted) { setState(() { _dwView_txtAdsStatus_text = ("Status: Rewarded ad loaded & ready").toString(); }); }
      if (!context.mounted) return; if (mounted) { setState(() { _dwView_txtAdsOutput_text = (adUnitId).toString(); }); }
    },
    onRewardedFailedToLoad: (errorCode, errorMessage) async {
      if (!mounted) return;
    },
    onUserEarnedReward: (rewardAmount, rewardType) async {
      if (!mounted) return;
      if (!context.mounted) return; if (mounted) { setState(() { _dwView_txtAdsStatus_text = ("🎉 Success: User earned reward!").toString(); }); }
      if (!context.mounted) return; if (mounted) { setState(() { _dwView_txtAdsOutput_text = (rewardType).toString(); }); }
    },
    onRewardedDismissed: () async {
      if (!mounted) return;
    },
    onAppOpenAdLoaded: (adUnitId) async {
      if (!mounted) return;
      if (!context.mounted) return; if (mounted) { setState(() { _dwView_txtAdsStatus_text = ("Status: App Open ad ready").toString(); }); }
      if (!context.mounted) return; if (mounted) { setState(() { _dwView_txtAdsOutput_text = (adUnitId).toString(); }); }
    },
    onAppOpenAdFailedToLoad: (errorCode, errorMessage) async {
      if (!mounted) return;
    },
    onAppOpenAdDismissed: () async {
      if (!mounted) return;
    },
    onAppOpenAdFailedToShow: (errorCode, errorMessage) async {
      if (!mounted) return;
    },
    onRewardedInterstitialLoaded: (adUnitId) async {
      if (!mounted) return;
    },
    onRewardedInterstitialFailedToLoad: (errorCode, errorMessage) async {
      if (!mounted) return;
    },
    onRewardedInterstitialEarnedReward: (rewardAmount, rewardType) async {
      if (!mounted) return;
    },
    onRewardedInterstitialDismissed: () async {
      if (!mounted) return;
    },
  );
late String _dwView_txtAdsStatus_text = "Status: Ready to test Google AdMob ads";
late String _dwView_txtAdsOutput_text = "Waiting for action...";
  
  
  @override void dispose() { _dwAdMob_admob.dispose(); super.dispose(); }
  @override Widget build(BuildContext context) => DwStatusBarManager(hasStatusBar: true, isDarkIcons: false, statusBarColor: Colors.transparent, child: Scaffold(
  backgroundColor: const Color(0xFF0F172A),
  appBar: null,
  body: SafeArea(
    top: true,
    bottom: true,
    child: LayoutBuilder(
      builder: (context, layoutConstraints) => Container(
        width: (layoutConstraints.hasBoundedWidth
            ? layoutConstraints.maxWidth
            : null),
        height: (layoutConstraints.hasBoundedHeight
            ? layoutConstraints.maxHeight
            : null),
        constraints: BoxConstraints(
          minWidth: 32.0,
          maxWidth: double.infinity,
          minHeight: 60.0,
          maxHeight: double.infinity,
        ),
        clipBehavior: Clip.none,
        child: LayoutBuilder(
          builder: (context, parentConstraints) => Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize:
                ((((MediaQuery.sizeOf(context).width < 600
                        ? true
                        : MediaQuery.sizeOf(context).width < 1024
                        ? true
                        : true) &&
                    true &&
                    (true == true) &&
                    (true == true)))
                ? (parentConstraints.hasBoundedHeight
                      ? MainAxisSize.max
                      : MainAxisSize.min)
                : (parentConstraints.hasBoundedHeight
                      ? MainAxisSize.max
                      : MainAxisSize.min)),
            children: [
              (parentConstraints.hasBoundedHeight
                  ? Expanded(
                      flex: 1,
                      child: LayoutBuilder(
                        builder: (context, layoutConstraints) => Container(
                          width: (layoutConstraints.hasBoundedWidth
                              ? layoutConstraints.maxWidth
                              : null),
                          height: (layoutConstraints.hasBoundedHeight
                              ? layoutConstraints.maxHeight
                              : null),
                          constraints: BoxConstraints(
                            minWidth: 32.0,
                            maxWidth: double.infinity,
                            minHeight: 60.0,
                            maxHeight: double.infinity,
                          ),
                          clipBehavior: Clip.none,
                          child: Padding(
                            padding: EdgeInsets.fromLTRB(
                              16.0,
                              16.0,
                              16.0,
                              16.0,
                            ),
                            child: const SizedBox(),
                          ),
                        ),
                      ),
                    )
                  : LayoutBuilder(
                      builder: (context, layoutConstraints) => Container(
                        width: (layoutConstraints.hasBoundedWidth
                            ? layoutConstraints.maxWidth
                            : null),
                        height: (layoutConstraints.hasBoundedHeight
                            ? layoutConstraints.maxHeight
                            : null),
                        constraints: BoxConstraints(
                          minWidth: 32.0,
                          maxWidth: double.infinity,
                          minHeight: 60.0,
                          maxHeight: double.infinity,
                        ),
                        clipBehavior: Clip.none,
                        child: Padding(
                          padding: EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 16.0),
                          child: const SizedBox(),
                        ),
                      ),
                    )),
            ],
          ),
        ),
      ),
    ),
  ),
));
}

class DatabasePage extends StatefulWidget {
  const DatabasePage();
  @override State<DatabasePage> createState() => _DatabasePageState();
}
class _DatabasePageState extends State<DatabasePage> {
    late final DwSupabaseDb _dwSupabaseDb_supaDb = DwSupabaseDb(
    projectUrl: 'https://pvyblfezvganlttlybky.supabase.co',
    anonKey: 'sb_publishable_Th-TPbQZmeZ_-hXDCpvNng_SLsjF-di',
    defaultTable: 'notes',
    isMounted: () => mounted,
    onDataLoaded: (table, rows, json, rowCount) async {
      if (!mounted) return;
      if (!context.mounted) return; if (mounted) { setState(() { _dwView_txtDbStatus_text = ("Status: Data loaded successfully").toString(); }); }
      if (!context.mounted) return; if (mounted) { setState(() { _dwView_txtDbOutput_text = (json).toString(); }); }
    },
    onWriteCompleted: (operation, table, rows, json, success) async {
      if (!mounted) return;
      if (!context.mounted) return; if (mounted) { setState(() { _dwView_txtDbStatus_text = ("Status: Write completed").toString(); }); }
      if (!context.mounted) return; if (mounted) { setState(() { _dwView_txtDbOutput_text = (operation).toString(); }); }
    },
    onRealtimeEvent: (table, eventType, record, json) async {
      if (!mounted) return;
      if (!context.mounted) return; if (mounted) { setState(() { _dwView_txtDbStatus_text = ("Status: Realtime event triggered").toString(); }); }
      if (!context.mounted) return; if (mounted) { setState(() { _dwView_txtDbOutput_text = (json).toString(); }); }
    },
    onFailure: (operation, errorCode, errorMessage) async {
      if (!mounted) return;
    },
    onCountSuccess: (count) async {
      if (!mounted) return;
    },
    onRpcSuccess: (json) async {
      if (!mounted) return;
    },
    onError: (message) async {
      if (!mounted) return;
      if (!context.mounted) return; if (mounted) { setState(() { _dwView_txtDbStatus_text = ("Status: DB error").toString(); }); }
      if (!context.mounted) return; if (mounted) { setState(() { _dwView_txtDbOutput_text = (message).toString(); }); }
    },
  );
late String _dwView_txtDbStatus_text = "Status: Ready to query database";
late String _dwView_txtDbOutput_text = "Waiting for action...";
late final TextEditingController _dwCtrl_edtDbTable = TextEditingController(text: "notes");
String get _dwView_edtDbTable_text => _dwCtrl_edtDbTable.text;
set _dwView_edtDbTable_text(String v) => _dwCtrl_edtDbTable.text = v;
late final TextEditingController _dwCtrl_edtDbColumn = TextEditingController(text: "title");
String get _dwView_edtDbColumn_text => _dwCtrl_edtDbColumn.text;
set _dwView_edtDbColumn_text(String v) => _dwCtrl_edtDbColumn.text = v;
late final TextEditingController _dwCtrl_edtDbValue = TextEditingController(text: "Hello Supabase");
String get _dwView_edtDbValue_text => _dwCtrl_edtDbValue.text;
set _dwView_edtDbValue_text(String v) => _dwCtrl_edtDbValue.text = v;
  
  
  @override void dispose() { _dwSupabaseDb_supaDb.dispose(); _dwCtrl_edtDbTable.dispose(); _dwCtrl_edtDbColumn.dispose(); _dwCtrl_edtDbValue.dispose(); super.dispose(); }
  @override Widget build(BuildContext context) => DwStatusBarManager(hasStatusBar: true, isDarkIcons: false, statusBarColor: Colors.transparent, child: Scaffold(
  backgroundColor: const Color(0xFF0F172A),
  appBar: null,
  body: SafeArea(
    top: true,
    bottom: true,
    child: LayoutBuilder(
      builder: (context, layoutConstraints) => Container(
        width: (layoutConstraints.hasBoundedWidth
            ? layoutConstraints.maxWidth
            : null),
        height: (layoutConstraints.hasBoundedHeight
            ? layoutConstraints.maxHeight
            : null),
        constraints: BoxConstraints(
          minWidth: 32.0,
          maxWidth: double.infinity,
          minHeight: 60.0,
          maxHeight: double.infinity,
        ),
        clipBehavior: Clip.none,
        child: LayoutBuilder(
          builder: (context, parentConstraints) => Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize:
                ((((MediaQuery.sizeOf(context).width < 600
                        ? true
                        : MediaQuery.sizeOf(context).width < 1024
                        ? true
                        : true) &&
                    true &&
                    (true == true) &&
                    (true == true)))
                ? (parentConstraints.hasBoundedHeight
                      ? MainAxisSize.max
                      : MainAxisSize.min)
                : (parentConstraints.hasBoundedHeight
                      ? MainAxisSize.max
                      : MainAxisSize.min)),
            children: [
              (parentConstraints.hasBoundedHeight
                  ? Expanded(
                      flex: 1,
                      child: LayoutBuilder(
                        builder: (context, layoutConstraints) => Container(
                          width: (layoutConstraints.hasBoundedWidth
                              ? layoutConstraints.maxWidth
                              : null),
                          height: (layoutConstraints.hasBoundedHeight
                              ? layoutConstraints.maxHeight
                              : null),
                          constraints: BoxConstraints(
                            minWidth: 32.0,
                            maxWidth: double.infinity,
                            minHeight: 60.0,
                            maxHeight: double.infinity,
                          ),
                          clipBehavior: Clip.none,
                          child: Padding(
                            padding: EdgeInsets.fromLTRB(
                              16.0,
                              16.0,
                              16.0,
                              16.0,
                            ),
                            child: const SizedBox(),
                          ),
                        ),
                      ),
                    )
                  : LayoutBuilder(
                      builder: (context, layoutConstraints) => Container(
                        width: (layoutConstraints.hasBoundedWidth
                            ? layoutConstraints.maxWidth
                            : null),
                        height: (layoutConstraints.hasBoundedHeight
                            ? layoutConstraints.maxHeight
                            : null),
                        constraints: BoxConstraints(
                          minWidth: 32.0,
                          maxWidth: double.infinity,
                          minHeight: 60.0,
                          maxHeight: double.infinity,
                        ),
                        clipBehavior: Clip.none,
                        child: Padding(
                          padding: EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 16.0),
                          child: const SizedBox(),
                        ),
                      ),
                    )),
            ],
          ),
        ),
      ),
    ),
  ),
));
}

class AuthPage extends StatefulWidget {
  const AuthPage();
  @override State<AuthPage> createState() => _AuthPageState();
}
class _AuthPageState extends State<AuthPage> {
    late final DwSupabaseAuth _dwSupabaseAuth_supaAuth = DwSupabaseAuth(
    projectUrl: 'https://pvyblfezvganlttlybky.supabase.co',
    anonKey: 'sb_publishable_Th-TPbQZmeZ_-hXDCpvNng_SLsjF-di',
    isMounted: () => mounted,
    onSignInCompleted: (success, userId, email, errorCode, errorMessage) async {
      if (!mounted) return;
      if (!context.mounted) return; if (mounted) { setState(() { _dwView_txtAuthStatus_text = ("Status: SignIn completed").toString(); }); }
      if (!context.mounted) return; if (mounted) { setState(() { _dwView_txtAuthOutput_text = (userId).toString(); }); }
    },
    onSignUpCompleted: (success, userId, email, errorCode, errorMessage) async {
      if (!mounted) return;
      if (!context.mounted) return; if (mounted) { setState(() { _dwView_txtAuthStatus_text = ("Status: SignUp completed").toString(); }); }
      if (!context.mounted) return; if (mounted) { setState(() { _dwView_txtAuthOutput_text = (email).toString(); }); }
    },
    onOtpSent: (success, errorCode, errorMessage) async {
      if (!mounted) return;
    },
    onPasswordResetSent: (success, errorCode, errorMessage) async {
      if (!mounted) return;
    },
    onUserUpdateCompleted: (success, errorCode, errorMessage) async {
      if (!mounted) return;
    },
    onAuthStateChanged: (isLoggedIn, userId, email) async {
      if (!mounted) return;
      if (!context.mounted) return; if (mounted) { setState(() { _dwView_txtAuthStatus_text = ("Status: Auth state changed").toString(); }); }
      if (!context.mounted) return; if (mounted) { setState(() { _dwView_txtAuthOutput_text = (email).toString(); }); }
    },
  );
late String _dwView_txtAuthStatus_text = "Status: Ready to test Auth";
late String _dwView_txtAuthOutput_text = "Waiting for action...";
late final TextEditingController _dwCtrl_edtAuthEmail = TextEditingController(text: "test@example.com");
String get _dwView_edtAuthEmail_text => _dwCtrl_edtAuthEmail.text;
set _dwView_edtAuthEmail_text(String v) => _dwCtrl_edtAuthEmail.text = v;
late final TextEditingController _dwCtrl_edtAuthPassword = TextEditingController(text: "SecurePass123!");
String get _dwView_edtAuthPassword_text => _dwCtrl_edtAuthPassword.text;
set _dwView_edtAuthPassword_text(String v) => _dwCtrl_edtAuthPassword.text = v;
late final TextEditingController _dwCtrl_edtAuthToken = TextEditingController(text: "123456");
String get _dwView_edtAuthToken_text => _dwCtrl_edtAuthToken.text;
set _dwView_edtAuthToken_text(String v) => _dwCtrl_edtAuthToken.text = v;
  
  
  @override void dispose() { _dwSupabaseAuth_supaAuth.dispose(); _dwCtrl_edtAuthEmail.dispose(); _dwCtrl_edtAuthPassword.dispose(); _dwCtrl_edtAuthToken.dispose(); super.dispose(); }
  @override Widget build(BuildContext context) => DwStatusBarManager(hasStatusBar: true, isDarkIcons: false, statusBarColor: Colors.transparent, child: Scaffold(
  backgroundColor: const Color(0xFF0F172A),
  appBar: null,
  body: SafeArea(
    top: true,
    bottom: true,
    child: LayoutBuilder(
      builder: (context, layoutConstraints) => Container(
        width: (layoutConstraints.hasBoundedWidth
            ? layoutConstraints.maxWidth
            : null),
        height: (layoutConstraints.hasBoundedHeight
            ? layoutConstraints.maxHeight
            : null),
        constraints: BoxConstraints(
          minWidth: 32.0,
          maxWidth: double.infinity,
          minHeight: 60.0,
          maxHeight: double.infinity,
        ),
        clipBehavior: Clip.none,
        child: LayoutBuilder(
          builder: (context, parentConstraints) => Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize:
                ((((MediaQuery.sizeOf(context).width < 600
                        ? true
                        : MediaQuery.sizeOf(context).width < 1024
                        ? true
                        : true) &&
                    true &&
                    (true == true) &&
                    (true == true)))
                ? (parentConstraints.hasBoundedHeight
                      ? MainAxisSize.max
                      : MainAxisSize.min)
                : (parentConstraints.hasBoundedHeight
                      ? MainAxisSize.max
                      : MainAxisSize.min)),
            children: [
              (parentConstraints.hasBoundedHeight
                  ? Expanded(
                      flex: 1,
                      child: LayoutBuilder(
                        builder: (context, layoutConstraints) => Container(
                          width: (layoutConstraints.hasBoundedWidth
                              ? layoutConstraints.maxWidth
                              : null),
                          height: (layoutConstraints.hasBoundedHeight
                              ? layoutConstraints.maxHeight
                              : null),
                          constraints: BoxConstraints(
                            minWidth: 32.0,
                            maxWidth: double.infinity,
                            minHeight: 60.0,
                            maxHeight: double.infinity,
                          ),
                          clipBehavior: Clip.none,
                          child: Padding(
                            padding: EdgeInsets.fromLTRB(
                              16.0,
                              16.0,
                              16.0,
                              16.0,
                            ),
                            child: const SizedBox(),
                          ),
                        ),
                      ),
                    )
                  : LayoutBuilder(
                      builder: (context, layoutConstraints) => Container(
                        width: (layoutConstraints.hasBoundedWidth
                            ? layoutConstraints.maxWidth
                            : null),
                        height: (layoutConstraints.hasBoundedHeight
                            ? layoutConstraints.maxHeight
                            : null),
                        constraints: BoxConstraints(
                          minWidth: 32.0,
                          maxWidth: double.infinity,
                          minHeight: 60.0,
                          maxHeight: double.infinity,
                        ),
                        clipBehavior: Clip.none,
                        child: Padding(
                          padding: EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 16.0),
                          child: const SizedBox(),
                        ),
                      ),
                    )),
            ],
          ),
        ),
      ),
    ),
  ),
));
}

class StoragePage extends StatefulWidget {
  const StoragePage();
  @override State<StoragePage> createState() => _StoragePageState();
}
class _StoragePageState extends State<StoragePage> {
    late final DwSupabaseStorage _dwSupabaseStorage_supaStorage = DwSupabaseStorage(
    projectUrl: 'https://pvyblfezvganlttlybky.supabase.co',
    anonKey: 'sb_publishable_Th-TPbQZmeZ_-hXDCpvNng_SLsjF-di',
    defaultBucket: 'avatars',
    isMounted: () => mounted,
    onUploadSuccess: (bucket, cloudPath, publicUrl) async {
      if (!mounted) return;
      if (!context.mounted) return; if (mounted) { setState(() { _dwView_txtStStatus_text = ("Status: Upload completed successfully").toString(); }); }
      if (!context.mounted) return; if (mounted) { setState(() { _dwView_txtStOutput_text = (publicUrl).toString(); }); }
    },
    onDownloadSuccess: (bucket, cloudPath, filePath) async {
      if (!mounted) return;
      if (!context.mounted) return; if (mounted) { setState(() { _dwView_txtStStatus_text = ("Status: Download completed").toString(); }); }
      if (!context.mounted) return; if (mounted) { setState(() { _dwView_txtStOutput_text = (filePath).toString(); }); }
    },
    onPublicUrlReceived: (bucket, cloudPath, url) async {
      if (!mounted) return;
      if (!context.mounted) return; if (mounted) { setState(() { _dwView_txtStStatus_text = ("Status: Public URL received").toString(); }); }
      if (!context.mounted) return; if (mounted) { setState(() { _dwView_txtStOutput_text = (url).toString(); }); }
    },
    onDeleteSuccess: (bucket, cloudPath) async {
      if (!mounted) return;
      if (!context.mounted) return; if (mounted) { setState(() { _dwView_txtStStatus_text = ("Status: File deleted from bucket").toString(); }); }
      if (!context.mounted) return; if (mounted) { setState(() { _dwView_txtStOutput_text = ("File removed successfully.").toString(); }); }
    },
    onFailure: (operation, cloudPath, errorCode, errorMessage) async {
      if (!mounted) return;
      if (!context.mounted) return; if (mounted) { setState(() { _dwView_txtStStatus_text = ("Status: Storage error").toString(); }); }
      if (!context.mounted) return; if (mounted) { setState(() { _dwView_txtStOutput_text = (errorMessage).toString(); }); }
    },
  );
late String _dwView_txtStStatus_text = "Status: Ready to interact with avatars bucket";
late String _dwView_txtStOutput_text = "Waiting for action...";
late final TextEditingController _dwCtrl_edtStCloudPath = TextEditingController(text: "profile_picture.png");
String get _dwView_edtStCloudPath_text => _dwCtrl_edtStCloudPath.text;
set _dwView_edtStCloudPath_text(String v) => _dwCtrl_edtStCloudPath.text = v;
late final TextEditingController _dwCtrl_edtStLocalPath = TextEditingController(text: "/data/user/0/cache/sample.png");
String get _dwView_edtStLocalPath_text => _dwCtrl_edtStLocalPath.text;
set _dwView_edtStLocalPath_text(String v) => _dwCtrl_edtStLocalPath.text = v;
  
  
  @override void dispose() { _dwSupabaseStorage_supaStorage.dispose(); _dwCtrl_edtStCloudPath.dispose(); _dwCtrl_edtStLocalPath.dispose(); super.dispose(); }
  @override Widget build(BuildContext context) => DwStatusBarManager(hasStatusBar: true, isDarkIcons: false, statusBarColor: Colors.transparent, child: Scaffold(
  backgroundColor: const Color(0xFF0F172A),
  appBar: null,
  body: SafeArea(
    top: true,
    bottom: true,
    child: LayoutBuilder(
      builder: (context, layoutConstraints) => Container(
        width: (layoutConstraints.hasBoundedWidth
            ? layoutConstraints.maxWidth
            : null),
        height: (layoutConstraints.hasBoundedHeight
            ? layoutConstraints.maxHeight
            : null),
        constraints: BoxConstraints(
          minWidth: 32.0,
          maxWidth: double.infinity,
          minHeight: 60.0,
          maxHeight: double.infinity,
        ),
        clipBehavior: Clip.none,
        child: LayoutBuilder(
          builder: (context, parentConstraints) => Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize:
                ((((MediaQuery.sizeOf(context).width < 600
                        ? true
                        : MediaQuery.sizeOf(context).width < 1024
                        ? true
                        : true) &&
                    true &&
                    (true == true) &&
                    (true == true)))
                ? (parentConstraints.hasBoundedHeight
                      ? MainAxisSize.max
                      : MainAxisSize.min)
                : (parentConstraints.hasBoundedHeight
                      ? MainAxisSize.max
                      : MainAxisSize.min)),
            children: [
              (parentConstraints.hasBoundedHeight
                  ? Expanded(
                      flex: 1,
                      child: LayoutBuilder(
                        builder: (context, layoutConstraints) => Container(
                          width: (layoutConstraints.hasBoundedWidth
                              ? layoutConstraints.maxWidth
                              : null),
                          height: (layoutConstraints.hasBoundedHeight
                              ? layoutConstraints.maxHeight
                              : null),
                          constraints: BoxConstraints(
                            minWidth: 32.0,
                            maxWidth: double.infinity,
                            minHeight: 60.0,
                            maxHeight: double.infinity,
                          ),
                          clipBehavior: Clip.none,
                          child: Padding(
                            padding: EdgeInsets.fromLTRB(
                              16.0,
                              16.0,
                              16.0,
                              16.0,
                            ),
                            child: const SizedBox(),
                          ),
                        ),
                      ),
                    )
                  : LayoutBuilder(
                      builder: (context, layoutConstraints) => Container(
                        width: (layoutConstraints.hasBoundedWidth
                            ? layoutConstraints.maxWidth
                            : null),
                        height: (layoutConstraints.hasBoundedHeight
                            ? layoutConstraints.maxHeight
                            : null),
                        constraints: BoxConstraints(
                          minWidth: 32.0,
                          maxWidth: double.infinity,
                          minHeight: 60.0,
                          maxHeight: double.infinity,
                        ),
                        clipBehavior: Clip.none,
                        child: Padding(
                          padding: EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 16.0),
                          child: const SizedBox(),
                        ),
                      ),
                    )),
            ],
          ),
        ),
      ),
    ),
  ),
));
}

class DwStatusBarManager extends StatefulWidget {
  final bool hasStatusBar;
  final bool isDarkIcons;
  final Color statusBarColor;
  final Widget child;

  const DwStatusBarManager({
    super.key,
    required this.hasStatusBar,
    required this.isDarkIcons,
    this.statusBarColor = Colors.transparent,
    required this.child,
  });

  @override
  State<DwStatusBarManager> createState() => _DwStatusBarManagerState();
}

class _DwStatusBarManagerState extends State<DwStatusBarManager> {
  @override
  void initState() {
    super.initState();
    _apply();
  }

  @override
  void didUpdateWidget(covariant DwStatusBarManager oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.hasStatusBar != widget.hasStatusBar ||
        oldWidget.isDarkIcons != widget.isDarkIcons ||
        oldWidget.statusBarColor != widget.statusBarColor) {
      _apply();
    }
  }

  void _apply() {
    if (!widget.hasStatusBar) {
      SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
    } else {
      SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
      SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(
          statusBarColor: widget.statusBarColor,
          statusBarIconBrightness: widget.isDarkIcons ? Brightness.dark : Brightness.light,
          statusBarBrightness: widget.isDarkIcons ? Brightness.light : Brightness.dark,
        ),
      );
    }
  }

  @override
  void dispose() {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark,
        statusBarBrightness: Brightness.light,
      ),
    );
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => widget.child;
}





























class DwAdMobService {
  static const bool testMode = true;
  static const bool autoShowAppOpenOnLaunch = false;

  static bool get _isIos =>
      !kIsWeb && defaultTargetPlatform == TargetPlatform.iOS;

  static String resolveBannerUnitId() => _isIos ? "ca-app-pub-3940256099942544/2934735716" : "ca-app-pub-3940256099942544/6300978111";
  static String resolveNativeUnitId() => _isIos ? "ca-app-pub-3940256099942544/3986624511" : "ca-app-pub-3940256099942544/2247696110";
  static String resolveInterstitialUnitId() =>
      _isIos ? "ca-app-pub-3940256099942544/4411468910" : "ca-app-pub-3940256099942544/1033173712";
  static String resolveRewardedUnitId() => _isIos ? "ca-app-pub-3940256099942544/1712485313" : "ca-app-pub-3940256099942544/5224354917";
  static String resolveAppOpenUnitId() => _isIos ? "ca-app-pub-3940256099942544/5575463023" : "ca-app-pub-3940256099942544/9257395921";
  static String resolveRewardedInterstitialUnitId() =>
      _isIos ? "ca-app-pub-3940256099942544/6978759866" : "ca-app-pub-3940256099942544/5354046379";

  static final Map<String, Future<void> Function()> _adViewLoaders =
      <String, Future<void> Function()>{};

  static void registerAdView(
    String nodeId,
    Future<void> Function() loader,
  ) {
    if (nodeId.isNotEmpty) {
      _adViewLoaders[nodeId] = loader;
    }
  }

  static void unregisterAdView(
    String nodeId, [
    Future<void> Function()? loader,
  ]) {
    if (loader == null || identical(_adViewLoaders[nodeId], loader)) {
      _adViewLoaders.remove(nodeId);
    }
  }

  static Future<void> loadAdView(String nodeId) async {
    final loader = _adViewLoaders[nodeId];
    if (loader != null) {
      await loader();
    }
  }
}

class DwAdMobComponent {
  final String componentName;
  final bool testMode;
  final bool Function()? isMounted;
  final FutureOr<void> Function(String status)? onInitialized;
  final FutureOr<void> Function(String consentStatus, bool canRequestAds)?
      onConsentUpdated;
  final FutureOr<void> Function(String adUnitId)? onInterstitialLoaded;
  final FutureOr<void> Function(String errorCode, String errorMessage)?
      onInterstitialFailedToLoad;
  final FutureOr<void> Function()? onInterstitialDismissed;
  final FutureOr<void> Function(String adUnitId)? onRewardedLoaded;
  final FutureOr<void> Function(String errorCode, String errorMessage)?
      onRewardedFailedToLoad;
  final FutureOr<void> Function(num rewardAmount, String rewardType)?
      onUserEarnedReward;
  final FutureOr<void> Function()? onRewardedDismissed;
  final FutureOr<void> Function(String adUnitId)? onAppOpenAdLoaded;
  final FutureOr<void> Function(String errorCode, String errorMessage)?
      onAppOpenAdFailedToLoad;
  final FutureOr<void> Function()? onAppOpenAdDismissed;
  final FutureOr<void> Function(String errorCode, String errorMessage)?
      onAppOpenAdFailedToShow;
  final FutureOr<void> Function(String adUnitId)? onRewardedInterstitialLoaded;
  final FutureOr<void> Function(String errorCode, String errorMessage)?
      onRewardedInterstitialFailedToLoad;
  final FutureOr<void> Function(num rewardAmount, String rewardType)?
      onRewardedInterstitialEarnedReward;
  final FutureOr<void> Function()? onRewardedInterstitialDismissed;

  InterstitialAd? _interstitialAd;
  RewardedAd? _rewardedAd;
  AppOpenAd? _appOpenAd;
  RewardedInterstitialAd? _rewardedInterstitialAd;
  num _lastRewardAmount = 0;
  String _lastRewardType = '';

  DwAdMobComponent({
    this.componentName = 'adMob1',
    this.testMode = DwAdMobService.testMode,
    this.isMounted,
    this.onInitialized,
    this.onConsentUpdated,
    this.onInterstitialLoaded,
    this.onInterstitialFailedToLoad,
    this.onInterstitialDismissed,
    this.onRewardedLoaded,
    this.onRewardedFailedToLoad,
    this.onUserEarnedReward,
    this.onRewardedDismissed,
    this.onAppOpenAdLoaded,
    this.onAppOpenAdFailedToLoad,
    this.onAppOpenAdDismissed,
    this.onAppOpenAdFailedToShow,
    this.onRewardedInterstitialLoaded,
    this.onRewardedInterstitialFailedToLoad,
    this.onRewardedInterstitialEarnedReward,
    this.onRewardedInterstitialDismissed,
  });

  String resolveUnitId(String customId, {required String kind}) {
    final trimmed = customId.trim();
    if (!testMode && trimmed.isNotEmpty) return trimmed;
    switch (kind) {
      case 'interstitial':
        return DwAdMobService.resolveInterstitialUnitId();
      case 'rewarded':
        return DwAdMobService.resolveRewardedUnitId();
      case 'appOpen':
        return DwAdMobService.resolveAppOpenUnitId();
      case 'rewardedInterstitial':
        return DwAdMobService.resolveRewardedInterstitialUnitId();
      case 'native':
        return DwAdMobService.resolveNativeUnitId();
      case 'banner':
      default:
        return DwAdMobService.resolveBannerUnitId();
    }
  }

  Future<void> initialize() async {
    try {
      await MobileAds.instance.initialize();
      if (isMounted != null && !isMounted!()) return;
      await onInitialized?.call('initialized');
      if (DwAdMobService.autoShowAppOpenOnLaunch) {
        await loadAppOpen(showOnLoad: true);
      }
    } catch (e) {
      await onInitialized?.call('error:$e');
    }
  }

  Future<void> requestConsentInfo({
    bool tagForUnderAgeOfConsent = false,
  }) async {
    final params = ConsentRequestParameters(
      tagForUnderAgeOfConsent: tagForUnderAgeOfConsent,
    );
    ConsentInformation.instance.requestConsentInfoUpdate(
      params,
      () async {
        final status = await ConsentInformation.instance.getConsentStatus();
        final canRequest = await ConsentInformation.instance.canRequestAds();
        if (isMounted != null && !isMounted!()) return;
        await onConsentUpdated?.call(status.name, canRequest);
      },
      (FormError error) async {
        if (isMounted != null && !isMounted!()) return;
        await onConsentUpdated?.call(
          'error:${error.errorCode}:${error.message}',
          false,
        );
      },
    );
  }

  Future<void> showConsentFormIfRequired() async {
    ConsentForm.loadAndShowConsentFormIfRequired((FormError? error) async {
      final status = await ConsentInformation.instance.getConsentStatus();
      final canRequest = await ConsentInformation.instance.canRequestAds();
      if (isMounted != null && !isMounted!()) return;
      await onConsentUpdated?.call(
        error != null ? 'error:${error.message}' : status.name,
        canRequest,
      );
    });
  }

  Future<void> setAppMuted(bool muted) async {
    await MobileAds.instance.setAppMuted(muted);
  }

  Future<void> loadInterstitial({String adUnitId = ''}) async {
    final unitId = resolveUnitId(adUnitId, kind: 'interstitial');
    await InterstitialAd.load(
      adUnitId: unitId,
      request: const AdRequest(),
      adLoadCallback: InterstitialAdLoadCallback(
        onAdLoaded: (InterstitialAd ad) {
          _interstitialAd?.dispose();
          _interstitialAd = ad;
          ad.fullScreenContentCallback = FullScreenContentCallback(
            onAdDismissedFullScreenContent: (ad) {
              ad.dispose();
              if (identical(_interstitialAd, ad)) _interstitialAd = null;
              if (isMounted == null || isMounted!()) {
                onInterstitialDismissed?.call();
              }
            },
            onAdFailedToShowFullScreenContent: (ad, error) {
              ad.dispose();
              if (identical(_interstitialAd, ad)) _interstitialAd = null;
              if (isMounted == null || isMounted!()) {
                onInterstitialFailedToLoad?.call('${error.code}', error.message);
              }
            },
          );
          if (isMounted == null || isMounted!()) {
            onInterstitialLoaded?.call(unitId);
          }
        },
        onAdFailedToLoad: (LoadAdError error) {
          _interstitialAd = null;
          if (isMounted == null || isMounted!()) {
            onInterstitialFailedToLoad?.call('${error.code}', error.message);
          }
        },
      ),
    );
  }

  Future<void> showInterstitial() async {
    final ad = _interstitialAd;
    if (ad == null) return;
    _interstitialAd = null;
    await ad.show();
  }

  Future<void> loadRewarded({String adUnitId = ''}) async {
    final unitId = resolveUnitId(adUnitId, kind: 'rewarded');
    await RewardedAd.load(
      adUnitId: unitId,
      request: const AdRequest(),
      rewardedAdLoadCallback: RewardedAdLoadCallback(
        onAdLoaded: (RewardedAd ad) {
          _rewardedAd?.dispose();
          _rewardedAd = ad;
          ad.fullScreenContentCallback = FullScreenContentCallback(
            onAdDismissedFullScreenContent: (ad) {
              ad.dispose();
              if (identical(_rewardedAd, ad)) _rewardedAd = null;
              if (isMounted == null || isMounted!()) {
                onRewardedDismissed?.call();
              }
            },
            onAdFailedToShowFullScreenContent: (ad, error) {
              ad.dispose();
              if (identical(_rewardedAd, ad)) _rewardedAd = null;
              if (isMounted == null || isMounted!()) {
                onRewardedFailedToLoad?.call('${error.code}', error.message);
              }
            },
          );
          if (isMounted == null || isMounted!()) {
            onRewardedLoaded?.call(unitId);
          }
        },
        onAdFailedToLoad: (LoadAdError error) {
          _rewardedAd = null;
          if (isMounted == null || isMounted!()) {
            onRewardedFailedToLoad?.call('${error.code}', error.message);
          }
        },
      ),
    );
  }

  Future<void> showRewarded() async {
    final ad = _rewardedAd;
    if (ad == null) return;
    _rewardedAd = null;
    await ad.show(
      onUserEarnedReward: (AdWithoutView _, RewardItem reward) {
        _lastRewardAmount = reward.amount;
        _lastRewardType = reward.type;
        if (isMounted == null || isMounted!()) {
          onUserEarnedReward?.call(reward.amount, reward.type);
        }
      },
    );
  }

  Future<void> loadAppOpen({
    String adUnitId = '',
    bool showOnLoad = false,
  }) async {
    final unitId = resolveUnitId(adUnitId, kind: 'appOpen');
    await AppOpenAd.load(
      adUnitId: unitId,
      request: const AdRequest(),
      adLoadCallback: AppOpenAdLoadCallback(
        onAdLoaded: (AppOpenAd ad) async {
          _appOpenAd?.dispose();
          _appOpenAd = ad;
          ad.fullScreenContentCallback = FullScreenContentCallback(
            onAdDismissedFullScreenContent: (ad) {
              ad.dispose();
              if (identical(_appOpenAd, ad)) _appOpenAd = null;
              if (isMounted == null || isMounted!()) {
                onAppOpenAdDismissed?.call();
              }
            },
            onAdFailedToShowFullScreenContent: (ad, error) {
              ad.dispose();
              if (identical(_appOpenAd, ad)) _appOpenAd = null;
              if (isMounted == null || isMounted!()) {
                onAppOpenAdFailedToShow?.call('${error.code}', error.message);
              }
            },
          );
          if (isMounted == null || isMounted!()) {
            await onAppOpenAdLoaded?.call(unitId);
            if (showOnLoad) {
              await showAppOpen();
            }
          }
        },
        onAdFailedToLoad: (LoadAdError error) {
          _appOpenAd = null;
          if (isMounted == null || isMounted!()) {
            onAppOpenAdFailedToLoad?.call('${error.code}', error.message);
          }
        },
      ),
    );
  }

  Future<void> showAppOpen() async {
    final ad = _appOpenAd;
    if (ad == null) {
      if (isMounted == null || isMounted!()) {
        await onAppOpenAdFailedToShow?.call(
          'NOT_READY',
          'App Open ad is not loaded yet.',
        );
      }
      return;
    }
    _appOpenAd = null;
    await ad.show();
  }

  Future<void> loadRewardedInterstitial({String adUnitId = ''}) async {
    final unitId = resolveUnitId(adUnitId, kind: 'rewardedInterstitial');
    await RewardedInterstitialAd.load(
      adUnitId: unitId,
      request: const AdRequest(),
      rewardedInterstitialAdLoadCallback: RewardedInterstitialAdLoadCallback(
        onAdLoaded: (RewardedInterstitialAd ad) {
          _rewardedInterstitialAd?.dispose();
          _rewardedInterstitialAd = ad;
          ad.fullScreenContentCallback = FullScreenContentCallback(
            onAdDismissedFullScreenContent: (ad) {
              ad.dispose();
              if (identical(_rewardedInterstitialAd, ad)) {
                _rewardedInterstitialAd = null;
              }
              if (isMounted == null || isMounted!()) {
                onRewardedInterstitialDismissed?.call();
              }
            },
            onAdFailedToShowFullScreenContent: (ad, error) {
              ad.dispose();
              if (identical(_rewardedInterstitialAd, ad)) {
                _rewardedInterstitialAd = null;
              }
              if (isMounted == null || isMounted!()) {
                onRewardedInterstitialFailedToLoad?.call(
                  '${error.code}',
                  error.message,
                );
              }
            },
          );
          if (isMounted == null || isMounted!()) {
            onRewardedInterstitialLoaded?.call(unitId);
          }
        },
        onAdFailedToLoad: (LoadAdError error) {
          _rewardedInterstitialAd = null;
          if (isMounted == null || isMounted!()) {
            onRewardedInterstitialFailedToLoad?.call(
              '${error.code}',
              error.message,
            );
          }
        },
      ),
    );
  }

  Future<void> showRewardedInterstitial() async {
    final ad = _rewardedInterstitialAd;
    if (ad == null) {
      if (isMounted == null || isMounted!()) {
        await onRewardedInterstitialFailedToLoad?.call(
          'NOT_READY',
          'Rewarded Interstitial ad is not loaded yet.',
        );
      }
      return;
    }
    _rewardedInterstitialAd = null;
    await ad.show(
      onUserEarnedReward: (AdWithoutView ad, RewardItem reward) {
        _lastRewardAmount = reward.amount;
        _lastRewardType = reward.type;
        if (isMounted == null || isMounted!()) {
          onRewardedInterstitialEarnedReward?.call(reward.amount, reward.type);
        }
      },
    );
  }

  bool isInterstitialReady() => _interstitialAd != null;
  bool isRewardedReady() => _rewardedAd != null;
  bool isAppOpenReady() => _appOpenAd != null;
  bool isRewardedInterstitialReady() => _rewardedInterstitialAd != null;
  num getLastRewardAmount() => _lastRewardAmount;
  String getLastRewardType() => _lastRewardType;

  void dispose() {
    _interstitialAd?.dispose();
    _interstitialAd = null;
    _rewardedAd?.dispose();
    _rewardedAd = null;
    _appOpenAd?.dispose();
    _appOpenAd = null;
    _rewardedInterstitialAd?.dispose();
    _rewardedInterstitialAd = null;
  }
}

class DwAdBannerView extends StatefulWidget {
  final String nodeId;
  final String adSize;
  final bool autoLoad;
  final double borderRadius;
  final FutureOr<void> Function()? onAdLoaded;
  final FutureOr<void> Function(int errorCode, String errorMessage)?
      onAdFailedToLoad;
  final FutureOr<void> Function()? onAdOpened;
  final FutureOr<void> Function()? onAdClicked;
  final FutureOr<void> Function()? onAdClosed;

  const DwAdBannerView({
    super.key,
    this.nodeId = '',
    this.adSize = 'banner',
    this.autoLoad = true,
    this.borderRadius = 0.0,
    this.onAdLoaded,
    this.onAdFailedToLoad,
    this.onAdOpened,
    this.onAdClicked,
    this.onAdClosed,
  });

  @override
  State<DwAdBannerView> createState() => _DwAdBannerViewState();
}

class _DwAdBannerViewState extends State<DwAdBannerView> {
  BannerAd? _bannerAd;
  AdSize? _loadedSize;
  bool _isLoaded = false;
  bool _hasFailed = false;
  String? _errorMessage;

  @override
  void initState() {
    super.initState();
    DwAdMobService.registerAdView(widget.nodeId, _loadBanner);
    if (widget.autoLoad) {
      WidgetsBinding.instance.addPostFrameCallback((_) => _loadBanner());
    }
  }

  Future<AdSize> _resolveAdSize() async {
    switch (widget.adSize) {
      case 'largeBanner':
        return AdSize.largeBanner;
      case 'mediumRectangle':
        return AdSize.mediumRectangle;
      case 'fullBanner':
        return AdSize.fullBanner;
      case 'leaderboard':
        return AdSize.leaderboard;
      case 'adaptiveBanner':
        if (mounted) {
          final width = MediaQuery.sizeOf(context).width.truncate();
          final adaptive =
              await AdSize.getCurrentOrientationAnchoredAdaptiveBannerAdSize(
                width > 0 ? width : 320,
              );
          if (adaptive != null) return adaptive;
        }
        return AdSize.banner;
      case 'banner':
      default:
        return AdSize.banner;
    }
  }

  Future<void> _loadBanner() async {
    if (!mounted) return;
    setState(() {
      _hasFailed = false;
      _errorMessage = null;
    });
    _bannerAd?.dispose();
    _bannerAd = null;
    final size = await _resolveAdSize();
    if (!mounted) return;
    final unitId = DwAdMobService.resolveBannerUnitId();
    final ad = BannerAd(
      adUnitId: unitId,
      size: size,
      request: const AdRequest(),
      listener: BannerAdListener(
        onAdLoaded: (ad) {
          if (!mounted) {
            ad.dispose();
            return;
          }
          setState(() {
            _loadedSize = size;
            _isLoaded = true;
            _hasFailed = false;
            _errorMessage = null;
          });
          widget.onAdLoaded?.call();
        },
        onAdFailedToLoad: (ad, error) {
          ad.dispose();
          if (mounted) {
            setState(() {
              _isLoaded = false;
              _hasFailed = true;
              _errorMessage = '${error.code}: ${error.message}';
            });
            widget.onAdFailedToLoad?.call(error.code, error.message);
          }
        },
        onAdOpened: (_) {
          if (mounted) widget.onAdOpened?.call();
        },
        onAdClicked: (_) {
          if (mounted) widget.onAdClicked?.call();
        },
        onAdClosed: (_) {
          if (mounted) widget.onAdClosed?.call();
        },
      ),
    );
    _bannerAd = ad;
    await ad.load();
  }

  @override
  void dispose() {
    DwAdMobService.unregisterAdView(widget.nodeId, _loadBanner);
    _bannerAd?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Widget inner;
    if (_isLoaded && _bannerAd != null && _loadedSize != null) {
      inner = SizedBox(
        width: _loadedSize!.width.toDouble(),
        height: _loadedSize!.height.toDouble(),
        child: AdWidget(ad: _bannerAd!),
      );
    } else if (_hasFailed && !DwAdMobService.testMode) {
      return const SizedBox.shrink();
    } else if (!widget.autoLoad && !DwAdMobService.testMode) {
      return const SizedBox.shrink();
    } else {
      final fallbackH = switch (widget.adSize) {
        'largeBanner' => 100.0,
        'mediumRectangle' => 250.0,
        'fullBanner' => 60.0,
        'leaderboard' => 90.0,
        'adaptiveBanner' => 60.0,
        _ => 50.0,
      };
      final fallbackW = switch (widget.adSize) {
        'mediumRectangle' => 300.0,
        'fullBanner' => 468.0,
        'leaderboard' => 728.0,
        'adaptiveBanner' => double.infinity,
        _ => 320.0,
      };
      final label = _hasFailed
          ? 'AdMob · ${_errorMessage ?? 'Load failed'}'
          : (widget.autoLoad
              ? 'Loading AdMob Banner (${widget.adSize})...'
              : 'AdBanner (${widget.adSize}) · Call AdView load');
      inner = Container(
        width: fallbackW,
        height: fallbackH,
        padding: const EdgeInsets.symmetric(horizontal: 12),
        decoration: BoxDecoration(
          color: const Color(0xFF111827),
          borderRadius: BorderRadius.circular(
            widget.borderRadius > 0 ? widget.borderRadius : 8,
          ),
          border: Border.all(color: const Color(0xFF334155)),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 2),
              decoration: BoxDecoration(
                color: const Color(0xFFFBBC04),
                borderRadius: BorderRadius.circular(4),
              ),
              child: const Text(
                'AD',
                style: TextStyle(
                  fontSize: 9,
                  fontWeight: FontWeight.w800,
                  color: Color(0xFF111827),
                ),
              ),
            ),
            const SizedBox(width: 8),
            Flexible(
              child: Text(
                label,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  fontSize: 11.5,
                  color: Color(0xFFCBD5E1),
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ],
        ),
      );
    }
    if (widget.borderRadius > 0) {
      return ClipRRect(
        borderRadius: BorderRadius.circular(widget.borderRadius),
        child: inner,
      );
    }
    return inner;
  }
}

class DwAdNativeView extends StatefulWidget {
  final String nodeId;
  final String templateType;
  final bool autoLoad;
  final Color adBackgroundColor;
  final Color primaryTextColor;
  final Color ctaBackgroundColor;
  final Color ctaTextColor;
  final double cornerRadius;
  final FutureOr<void> Function()? onAdLoaded;
  final FutureOr<void> Function(int errorCode, String errorMessage)?
      onAdFailedToLoad;
  final FutureOr<void> Function()? onAdOpened;
  final FutureOr<void> Function()? onAdClicked;
  final FutureOr<void> Function()? onAdClosed;

  const DwAdNativeView({
    super.key,
    this.nodeId = '',
    this.templateType = 'medium',
    this.autoLoad = true,
    this.adBackgroundColor = const Color(0xFFFFFFFF),
    this.primaryTextColor = const Color(0xFF0F172A),
    this.ctaBackgroundColor = const Color(0xFF1A73E8),
    this.ctaTextColor = const Color(0xFFFFFFFF),
    this.cornerRadius = 12.0,
    this.onAdLoaded,
    this.onAdFailedToLoad,
    this.onAdOpened,
    this.onAdClicked,
    this.onAdClosed,
  });

  @override
  State<DwAdNativeView> createState() => _DwAdNativeViewState();
}

class _DwAdNativeViewState extends State<DwAdNativeView> {
  NativeAd? _nativeAd;
  bool _isLoaded = false;
  bool _hasFailed = false;
  String? _errorMessage;

  @override
  void initState() {
    super.initState();
    DwAdMobService.registerAdView(widget.nodeId, _loadNative);
    if (widget.autoLoad) {
      WidgetsBinding.instance.addPostFrameCallback((_) => _loadNative());
    }
  }

  Future<void> _loadNative() async {
    if (!mounted) return;
    setState(() {
      _hasFailed = false;
      _errorMessage = null;
    });
    _nativeAd?.dispose();
    _nativeAd = null;
    final unitId = DwAdMobService.resolveNativeUnitId();
    final ad = NativeAd(
      adUnitId: unitId,
      request: const AdRequest(),
      listener: NativeAdListener(
        onAdLoaded: (ad) {
          if (!mounted) {
            ad.dispose();
            return;
          }
          setState(() {
            _isLoaded = true;
            _hasFailed = false;
            _errorMessage = null;
          });
          widget.onAdLoaded?.call();
        },
        onAdFailedToLoad: (ad, error) {
          ad.dispose();
          if (mounted) {
            setState(() {
              _isLoaded = false;
              _hasFailed = true;
              _errorMessage = '${error.code}: ${error.message}';
            });
            widget.onAdFailedToLoad?.call(error.code, error.message);
          }
        },
        onAdOpened: (_) {
          if (mounted) widget.onAdOpened?.call();
        },
        onAdClicked: (_) {
          if (mounted) widget.onAdClicked?.call();
        },
        onAdClosed: (_) {
          if (mounted) widget.onAdClosed?.call();
        },
      ),
      nativeTemplateStyle: NativeTemplateStyle(
        templateType: widget.templateType == 'medium'
            ? TemplateType.medium
            : TemplateType.small,
        mainBackgroundColor: widget.adBackgroundColor,
        cornerRadius: widget.cornerRadius,
        callToActionTextStyle: NativeTemplateTextStyle(
          textColor: widget.ctaTextColor,
          backgroundColor: widget.ctaBackgroundColor,
          style: NativeTemplateFontStyle.bold,
          size: 14.0,
        ),
        primaryTextStyle: NativeTemplateTextStyle(
          textColor: widget.primaryTextColor,
          style: NativeTemplateFontStyle.bold,
          size: 15.0,
        ),
      ),
    );
    _nativeAd = ad;
    await ad.load();
  }

  @override
  void dispose() {
    DwAdMobService.unregisterAdView(widget.nodeId, _loadNative);
    _nativeAd?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final targetH = widget.templateType == 'medium' ? 360.0 : 120.0;
    final Widget inner;
    if (_isLoaded && _nativeAd != null) {
      inner = SizedBox(
        width: double.infinity,
        height: targetH,
        child: AdWidget(ad: _nativeAd!),
      );
    } else if (_hasFailed && !DwAdMobService.testMode) {
      return const SizedBox.shrink();
    } else if (!widget.autoLoad && !DwAdMobService.testMode) {
      return const SizedBox.shrink();
    } else {
      final status = _hasFailed
          ? 'AdNative · ${_errorMessage ?? 'Load failed'}'
          : (widget.autoLoad
              ? 'Loading Native Ad (${widget.templateType})...'
              : 'AdNative (${widget.templateType}) · Call AdView load');
      inner = Container(
        width: double.infinity,
        height: targetH,
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: widget.adBackgroundColor,
          borderRadius: BorderRadius.circular(widget.cornerRadius),
          border: Border.all(
            color: widget.ctaBackgroundColor.withValues(alpha: 0.4),
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 2),
                  decoration: BoxDecoration(
                    color: const Color(0xFFFBBC04),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: const Text(
                    'AD',
                    style: TextStyle(
                      fontSize: 9,
                      fontWeight: FontWeight.w800,
                      color: Color(0xFF111827),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    status,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 12.5,
                      fontWeight: FontWeight.w700,
                      color: widget.primaryTextColor,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      );
    }
    if (widget.cornerRadius > 0) {
      return ClipRRect(
        borderRadius: BorderRadius.circular(widget.cornerRadius),
        child: inner,
      );
    }
    return inner;
  }
}


class DwSupabaseDb {
  final String projectUrl;
  final String anonKey;
  final String defaultTable;
  final bool Function()? isMounted;
  final http.Client? httpClient;
  final bool useMockOnly;

  final Future<void> Function(
    String table,
    List<Map<String, dynamic>> rows,
    String json,
    int rowCount,
  )? onDataLoaded;
  final Future<void> Function(
    String operation,
    String table,
    List<Map<String, dynamic>> rows,
    String json,
    bool success,
  )? onWriteCompleted;
  final Future<void> Function(
    String table,
    String eventType,
    Map<String, dynamic> record,
    String json,
  )? onRealtimeEvent;
  final Future<void> Function(
    String operation,
    String errorCode,
    String errorMessage,
  )? onFailure;
  final Future<void> Function(int count)? onCountSuccess;
  final Future<void> Function(String json)? onRpcSuccess;
  final Future<void> Function(String message)? onError;

  final Map<String, List<Map<String, dynamic>>> _mockTables = {};
  String _lastJson = '[]';
  int _lastRowsCount = 0;
  int _lastCount = 0;
  bool _isListening = false;
  String? _listeningTable;
  String _listeningEventFilter = '*';
  int _nextMockId = 1;
  bool _disposed = false;

  DwSupabaseDb({
    this.projectUrl = '',
    this.anonKey = '',
    this.defaultTable = '',
    this.isMounted,
    this.httpClient,
    this.useMockOnly = false,
    this.onDataLoaded,
    this.onWriteCompleted,
    this.onRealtimeEvent,
    this.onFailure,
    this.onCountSuccess,
    this.onRpcSuccess,
    this.onError,
  });

  bool get _canCallHttp =>
      !useMockOnly &&
      projectUrl.trim().isNotEmpty &&
      anonKey.trim().isNotEmpty;

  String _resolveTable(String table) {
    final t = table.trim();
    return t.isNotEmpty ? t : defaultTable.trim();
  }

  Map<String, String> _headers({String? prefer, String? accessToken}) => {
        'apikey': anonKey.trim(),
        'Authorization':
            'Bearer ${(accessToken != null && accessToken.isNotEmpty) ? accessToken : anonKey.trim()}',
        'Content-Type': 'application/json',
        if (prefer != null && prefer.isNotEmpty) 'Prefer': prefer,
      };

  Map<String, dynamic> _parseMap(dynamic raw) {
    if (raw is Map) {
      return Map<String, dynamic>.from(raw);
    }
    if (raw is String && raw.trim().isNotEmpty) {
      final decoded = jsonDecode(raw.trim());
      if (decoded is Map) {
        return Map<String, dynamic>.from(decoded);
      }
    }
    return <String, dynamic>{};
  }

  List<Map<String, dynamic>> _parseRowsList(dynamic decoded) {
    if (decoded is List) {
      return decoded
          .whereType<Map>()
          .map((e) => Map<String, dynamic>.from(e))
          .toList();
    }
    if (decoded is Map) {
      return [Map<String, dynamic>.from(decoded)];
    }
    return const [];
  }

  String _normalizeHttpErrorCode(int statusCode, String body) {
    final lower = body.toLowerCase();
    if (statusCode == 401 || statusCode == 403 || lower.contains('rls')) {
      return 'rls-denied';
    }
    if (statusCode == 404 || lower.contains('does not exist')) {
      return 'table-not-found';
    }
    if (statusCode == 400 || statusCode == 409 || statusCode == 422) {
      return 'invalid-payload';
    }
    return 'http-$statusCode';
  }

  String _extractErrorMessage(String body, int statusCode) {
    try {
      final decoded = jsonDecode(body);
      if (decoded is Map) {
        return (decoded['message'] ??
                decoded['hint'] ??
                decoded['error'] ??
                'HTTP $statusCode')
            .toString();
      }
    } catch (_) {}
    return body.trim().isNotEmpty ? body.trim() : 'HTTP $statusCode';
  }

  String lastJson() => _lastJson;
  int lastRowsCount() => _lastRowsCount;
  int lastCount() => _lastCount;
  bool isListening() => _isListening;

  static const Set<String> _validOperators = {
    'eq',
    'neq',
    'gt',
    'gte',
    'lt',
    'lte',
    'like',
    'ilike',
    'in',
  };

  static String normalizeOperator(String? operator) {
    final op = (operator ?? '').trim().toLowerCase();
    return _validOperators.contains(op) ? op : 'eq';
  }

  static String formatPostgrestFilter(String? operator, dynamic value) {
    final op = normalizeOperator(operator);
    if (op == 'in') {
      final items = value is List
          ? value.map((e) => e.toString().trim()).where((s) => s.isNotEmpty)
          : '$value'.split(',').map((s) => s.trim()).where((s) => s.isNotEmpty);
      return 'in.(${items.join(',')})';
    }
    return '$op.$value';
  }

  static bool matchesMockFilter(
    dynamic cellValue,
    String? operator,
    dynamic filterValue,
  ) {
    final op = normalizeOperator(operator);
    final cellStr = '${cellValue ?? ''}';
    final valStr = '$filterValue';
    switch (op) {
      case 'neq':
        return cellStr != valStr;
      case 'gt':
      case 'gte':
      case 'lt':
      case 'lte':
        final aNum = cellValue is num ? cellValue : num.tryParse(cellStr);
        final bNum = filterValue is num ? filterValue : num.tryParse(valStr);
        final cmp = (aNum != null && bNum != null)
            ? aNum.compareTo(bNum)
            : cellStr.compareTo(valStr);
        return switch (op) {
          'gt' => cmp > 0,
          'gte' => cmp >= 0,
          'lt' => cmp < 0,
          'lte' => cmp <= 0,
          _ => false,
        };
      case 'like':
      case 'ilike':
        final pattern = StringBuffer('^');
        for (final rune in valStr.runes) {
          final ch = String.fromCharCode(rune);
          if (ch == '%') {
            pattern.write('.*');
          } else if (ch == '_') {
            pattern.write('.');
          } else {
            pattern.write(RegExp.escape(ch));
          }
        }
        pattern.write(r'$');
        return RegExp(
          pattern.toString(),
          caseSensitive: op == 'like',
          dotAll: true,
        ).hasMatch(cellStr);
      case 'in':
        final items = (filterValue is List
                ? filterValue.map((e) => e.toString().trim())
                : valStr.split(',').map((s) => s.trim()))
            .where((s) => s.isNotEmpty)
            .toSet();
        return items.contains(cellStr);
      case 'eq':
      default:
        return cellStr == valStr;
    }
  }

  Future<void> insert({
    String table = '',
    dynamic dataJson = '{}',
    String? accessToken,
  }) async {
    if (_disposed) return;
    final target = _resolveTable(table);
    if (target.isEmpty) {
      await onFailure?.call('insert', 'invalid-payload', 'Table name is required.');
      return;
    }
    late final Map<String, dynamic> payload;
    try {
      payload = _parseMap(dataJson);
    } catch (e) {
      await onFailure?.call('insert', 'invalid-payload', 'Invalid JSON payload: $e');
      return;
    }

    if (!_canCallHttp) {
      final row = Map<String, dynamic>.from(payload);
      row.putIfAbsent('id', () => _nextMockId++);
      _mockTables.putIfAbsent(target, () => []).add(row);
      final rows = [row];
      _lastJson = jsonEncode(rows);
      _lastRowsCount = rows.length;
      if (isMounted?.call() ?? true) {
        await onWriteCompleted?.call('insert', target, rows, _lastJson, true);
        if (_isListening &&
            (_listeningTable == null || _listeningTable == target) &&
            (_listeningEventFilter == '*' || _listeningEventFilter.toUpperCase() == 'INSERT')) {
          await onRealtimeEvent?.call(target, 'INSERT', row, jsonEncode(row));
        }
      }
      return;
    }

    final client = httpClient ?? http.Client();
    final closeAfter = httpClient == null;
    try {
      final base = projectUrl.trim().replaceAll(RegExp(r'/+$'), '');
      final uri = Uri.parse('$base/rest/v1/$target');
      final res = await client.post(
        uri,
        headers: _headers(prefer: 'return=representation', accessToken: accessToken),
        body: jsonEncode(payload),
      );
      if (_disposed || !(isMounted?.call() ?? true)) return;
      if (res.statusCode >= 200 && res.statusCode < 300) {
        final rows = res.body.trim().isEmpty
            ? <Map<String, dynamic>>[payload]
            : _parseRowsList(jsonDecode(res.body));
        _lastJson = jsonEncode(rows);
        _lastRowsCount = rows.length;
        await onWriteCompleted?.call('insert', target, rows, _lastJson, true);
      } else {
        final code = _normalizeHttpErrorCode(res.statusCode, res.body);
        final msg = _extractErrorMessage(res.body, res.statusCode);
        await onWriteCompleted?.call('insert', target, const [], '[]', false);
        await onFailure?.call('insert', code, msg);
      }
    } catch (e) {
      if (_disposed || !(isMounted?.call() ?? true)) return;
      await onWriteCompleted?.call('insert', target, const [], '[]', false);
      await onFailure?.call('insert', 'network-error', e.toString());
    } finally {
      if (closeAfter) client.close();
    }
  }

  Future<void> select({
    String table = '',
    String columns = '*',
    String filterColumn = '',
    String operator = 'eq',
    dynamic filterValue = '',
    String orderBy = '',
    bool ascending = true,
    int limit = 50,
    String? accessToken,
  }) async {
    if (_disposed) return;
    final target = _resolveTable(table);
    if (target.isEmpty) {
      await onFailure?.call('select', 'invalid-payload', 'Table name is required.');
      return;
    }

    if (!_canCallHttp) {
      var rows = (_mockTables[target] ?? const <Map<String, dynamic>>[])
          .map((e) => Map<String, dynamic>.from(e))
          .toList();
      final fCol = filterColumn.trim();
      if (fCol.isNotEmpty) {
        rows = rows
            .where((r) => matchesMockFilter(r[fCol], operator, filterValue))
            .toList();
      }
      final ord = orderBy.trim();
      if (ord.isNotEmpty) {
        rows.sort((a, b) {
          final cmp = '${a[ord] ?? ''}'.compareTo('${b[ord] ?? ''}');
          return ascending ? cmp : -cmp;
        });
      }
      if (limit > 0 && rows.length > limit) {
        rows = rows.take(limit).toList();
      }
      _lastJson = jsonEncode(rows);
      _lastRowsCount = rows.length;
      if (isMounted?.call() ?? true) {
        await onDataLoaded?.call(target, rows, _lastJson, rows.length);
      }
      return;
    }

    final client = httpClient ?? http.Client();
    final closeAfter = httpClient == null;
    try {
      final base = projectUrl.trim().replaceAll(RegExp(r'/+$'), '');
      final queryParams = <String, String>{
        'select': columns.trim().isEmpty ? '*' : columns.trim(),
        if (filterColumn.trim().isNotEmpty)
          filterColumn.trim(): formatPostgrestFilter(operator, filterValue),
        if (orderBy.trim().isNotEmpty)
          'order': '${orderBy.trim()}.${ascending ? 'asc' : 'desc'}',
        if (limit > 0) 'limit': '$limit',
      };
      final uri = Uri.parse('$base/rest/v1/$target')
          .replace(queryParameters: queryParams);
      final res = await client.get(
        uri,
        headers: _headers(accessToken: accessToken),
      );
      if (_disposed || !(isMounted?.call() ?? true)) return;
      if (res.statusCode >= 200 && res.statusCode < 300) {
        final rows = res.body.trim().isEmpty
            ? <Map<String, dynamic>>[]
            : _parseRowsList(jsonDecode(res.body));
        _lastJson = jsonEncode(rows);
        _lastRowsCount = rows.length;
        await onDataLoaded?.call(target, rows, _lastJson, rows.length);
      } else {
        await onFailure?.call(
          'select',
          _normalizeHttpErrorCode(res.statusCode, res.body),
          _extractErrorMessage(res.body, res.statusCode),
        );
      }
    } catch (e) {
      if (_disposed || !(isMounted?.call() ?? true)) return;
      await onFailure?.call('select', 'network-error', e.toString());
    } finally {
      if (closeAfter) client.close();
    }
  }

  Future<void> update({
    String table = '',
    String matchColumn = 'id',
    String operator = 'eq',
    dynamic matchValue = '',
    dynamic dataJson = '{}',
    String? accessToken,
  }) async {
    if (_disposed) return;
    final target = _resolveTable(table);
    final mCol = matchColumn.trim().isEmpty ? 'id' : matchColumn.trim();
    if (target.isEmpty) {
      await onFailure?.call('update', 'invalid-payload', 'Table name is required.');
      return;
    }
    late final Map<String, dynamic> payload;
    try {
      payload = _parseMap(dataJson);
    } catch (e) {
      await onFailure?.call('update', 'invalid-payload', 'Invalid JSON payload: $e');
      return;
    }

    if (!_canCallHttp) {
      final list = _mockTables.putIfAbsent(target, () => []);
      final updated = <Map<String, dynamic>>[];
      for (final row in list) {
        if (matchesMockFilter(row[mCol], operator, matchValue)) {
          row.addAll(payload);
          updated.add(Map<String, dynamic>.from(row));
        }
      }
      _lastJson = jsonEncode(updated);
      _lastRowsCount = updated.length;
      if (isMounted?.call() ?? true) {
        await onWriteCompleted?.call('update', target, updated, _lastJson, true);
        if (_isListening &&
            (_listeningTable == null || _listeningTable == target) &&
            (_listeningEventFilter == '*' || _listeningEventFilter.toUpperCase() == 'UPDATE')) {
          for (final row in updated) {
            await onRealtimeEvent?.call(target, 'UPDATE', row, jsonEncode(row));
          }
        }
      }
      return;
    }

    final client = httpClient ?? http.Client();
    final closeAfter = httpClient == null;
    try {
      final base = projectUrl.trim().replaceAll(RegExp(r'/+$'), '');
      final uri = Uri.parse('$base/rest/v1/$target')
          .replace(queryParameters: {mCol: formatPostgrestFilter(operator, matchValue)});
      final res = await client.patch(
        uri,
        headers: _headers(prefer: 'return=representation', accessToken: accessToken),
        body: jsonEncode(payload),
      );
      if (_disposed || !(isMounted?.call() ?? true)) return;
      if (res.statusCode >= 200 && res.statusCode < 300) {
        final rows = res.body.trim().isEmpty
            ? <Map<String, dynamic>>[]
            : _parseRowsList(jsonDecode(res.body));
        _lastJson = jsonEncode(rows);
        _lastRowsCount = rows.length;
        await onWriteCompleted?.call('update', target, rows, _lastJson, true);
      } else {
        await onWriteCompleted?.call('update', target, const [], '[]', false);
        await onFailure?.call(
          'update',
          _normalizeHttpErrorCode(res.statusCode, res.body),
          _extractErrorMessage(res.body, res.statusCode),
        );
      }
    } catch (e) {
      if (_disposed || !(isMounted?.call() ?? true)) return;
      await onWriteCompleted?.call('update', target, const [], '[]', false);
      await onFailure?.call('update', 'network-error', e.toString());
    } finally {
      if (closeAfter) client.close();
    }
  }

  Future<void> upsert({
    String table = '',
    dynamic dataJson = '{}',
    String onConflict = 'id',
    String? accessToken,
  }) async {
    if (_disposed) return;
    final target = _resolveTable(table);
    final conflictCol = onConflict.trim().isEmpty ? 'id' : onConflict.trim();
    if (target.isEmpty) {
      await onFailure?.call('upsert', 'invalid-payload', 'Table name is required.');
      return;
    }
    late final Map<String, dynamic> payload;
    try {
      payload = _parseMap(dataJson);
    } catch (e) {
      await onFailure?.call('upsert', 'invalid-payload', 'Invalid JSON payload: $e');
      return;
    }

    if (!_canCallHttp) {
      final list = _mockTables.putIfAbsent(target, () => []);
      final keyVal = payload[conflictCol];
      Map<String, dynamic>? existing;
      if (keyVal != null) {
        for (final r in list) {
          if ('${r[conflictCol] ?? ''}' == '$keyVal') {
            existing = r;
            break;
          }
        }
      }
      if (existing != null) {
        existing.addAll(payload);
      } else {
        final row = Map<String, dynamic>.from(payload);
        row.putIfAbsent('id', () => _nextMockId++);
        list.add(row);
        existing = row;
      }
      final rows = [Map<String, dynamic>.from(existing)];
      _lastJson = jsonEncode(rows);
      _lastRowsCount = rows.length;
      if (isMounted?.call() ?? true) {
        await onWriteCompleted?.call('upsert', target, rows, _lastJson, true);
      }
      return;
    }

    final client = httpClient ?? http.Client();
    final closeAfter = httpClient == null;
    try {
      final base = projectUrl.trim().replaceAll(RegExp(r'/+$'), '');
      final uri = Uri.parse('$base/rest/v1/$target')
          .replace(queryParameters: {'on_conflict': conflictCol});
      final res = await client.post(
        uri,
        headers: _headers(
          prefer: 'resolution=merge-duplicates,return=representation',
          accessToken: accessToken,
        ),
        body: jsonEncode(payload),
      );
      if (_disposed || !(isMounted?.call() ?? true)) return;
      if (res.statusCode >= 200 && res.statusCode < 300) {
        final rows = res.body.trim().isEmpty
            ? <Map<String, dynamic>>[payload]
            : _parseRowsList(jsonDecode(res.body));
        _lastJson = jsonEncode(rows);
        _lastRowsCount = rows.length;
        await onWriteCompleted?.call('upsert', target, rows, _lastJson, true);
      } else {
        await onWriteCompleted?.call('upsert', target, const [], '[]', false);
        await onFailure?.call(
          'upsert',
          _normalizeHttpErrorCode(res.statusCode, res.body),
          _extractErrorMessage(res.body, res.statusCode),
        );
      }
    } catch (e) {
      if (_disposed || !(isMounted?.call() ?? true)) return;
      await onWriteCompleted?.call('upsert', target, const [], '[]', false);
      await onFailure?.call('upsert', 'network-error', e.toString());
    } finally {
      if (closeAfter) client.close();
    }
  }

  Future<void> delete({
    String table = '',
    String matchColumn = 'id',
    String operator = 'eq',
    dynamic matchValue = '',
    String? accessToken,
  }) async {
    if (_disposed) return;
    final target = _resolveTable(table);
    final mCol = matchColumn.trim().isEmpty ? 'id' : matchColumn.trim();
    if (target.isEmpty) {
      await onFailure?.call('delete', 'invalid-payload', 'Table name is required.');
      return;
    }

    if (!_canCallHttp) {
      final list = _mockTables[target] ?? [];
      final removed = <Map<String, dynamic>>[];
      list.removeWhere((row) {
        final matches = matchesMockFilter(row[mCol], operator, matchValue);
        if (matches) removed.add(Map<String, dynamic>.from(row));
        return matches;
      });
      _lastJson = jsonEncode(removed);
      _lastRowsCount = removed.length;
      if (isMounted?.call() ?? true) {
        await onWriteCompleted?.call('delete', target, removed, _lastJson, true);
        if (_isListening &&
            (_listeningTable == null || _listeningTable == target) &&
            (_listeningEventFilter == '*' || _listeningEventFilter.toUpperCase() == 'DELETE')) {
          for (final row in removed) {
            await onRealtimeEvent?.call(target, 'DELETE', row, jsonEncode(row));
          }
        }
      }
      return;
    }

    final client = httpClient ?? http.Client();
    final closeAfter = httpClient == null;
    try {
      final base = projectUrl.trim().replaceAll(RegExp(r'/+$'), '');
      final uri = Uri.parse('$base/rest/v1/$target')
          .replace(queryParameters: {mCol: formatPostgrestFilter(operator, matchValue)});
      final res = await client.delete(
        uri,
        headers: _headers(prefer: 'return=representation', accessToken: accessToken),
      );
      if (_disposed || !(isMounted?.call() ?? true)) return;
      if (res.statusCode >= 200 && res.statusCode < 300) {
        final rows = res.body.trim().isEmpty
            ? <Map<String, dynamic>>[]
            : _parseRowsList(jsonDecode(res.body));
        _lastJson = jsonEncode(rows);
        _lastRowsCount = rows.length;
        await onWriteCompleted?.call('delete', target, rows, _lastJson, true);
      } else {
        await onWriteCompleted?.call('delete', target, const [], '[]', false);
        await onFailure?.call(
          'delete',
          _normalizeHttpErrorCode(res.statusCode, res.body),
          _extractErrorMessage(res.body, res.statusCode),
        );
      }
    } catch (e) {
      if (_disposed || !(isMounted?.call() ?? true)) return;
      await onWriteCompleted?.call('delete', target, const [], '[]', false);
      await onFailure?.call('delete', 'network-error', e.toString());
    } finally {
      if (closeAfter) client.close();
    }
  }

  Future<void> count({
    String table = '',
    String filterColumn = '',
    String operator = 'eq',
    dynamic filterValue = '',
    String? accessToken,
  }) async {
    if (_disposed) return;
    final target = _resolveTable(table);
    if (target.isEmpty) {
      const msg = 'Table name is required.';
      await onError?.call(msg);
      await onFailure?.call('count', 'invalid-payload', msg);
      return;
    }

    if (!_canCallHttp) {
      var rows = _mockTables[target] ?? const <Map<String, dynamic>>[];
      final fCol = filterColumn.trim();
      if (fCol.isNotEmpty) {
        rows = rows
            .where((r) => matchesMockFilter(r[fCol], operator, filterValue))
            .toList();
      }
      _lastCount = rows.length;
      if (isMounted?.call() ?? true) {
        await onCountSuccess?.call(_lastCount);
      }
      return;
    }

    final client = httpClient ?? http.Client();
    final closeAfter = httpClient == null;
    try {
      final base = projectUrl.trim().replaceAll(RegExp(r'/+$'), '');
      final queryParams = <String, String>{
        'select': '*',
        if (filterColumn.trim().isNotEmpty)
          filterColumn.trim(): formatPostgrestFilter(operator, filterValue),
      };
      final uri = Uri.parse('$base/rest/v1/$target')
          .replace(queryParameters: queryParams);
      final res = await client.get(
        uri,
        headers: {
          ..._headers(prefer: 'count=exact', accessToken: accessToken),
          'Range': '0-0',
        },
      );
      if (_disposed || !(isMounted?.call() ?? true)) return;
      if (res.statusCode >= 200 && res.statusCode < 300) {
        int? parsedCount;
        final contentRange = res.headers['content-range'] ?? '';
        final slashIdx = contentRange.lastIndexOf('/');
        if (slashIdx != -1) {
          parsedCount = int.tryParse(
            contentRange.substring(slashIdx + 1).trim(),
          );
        }
        if (parsedCount == null && res.body.trim().isNotEmpty) {
          parsedCount = _parseRowsList(jsonDecode(res.body)).length;
        }
        _lastCount = parsedCount ?? 0;
        await onCountSuccess?.call(_lastCount);
      } else {
        final msg = _extractErrorMessage(res.body, res.statusCode);
        await onError?.call(msg);
        await onFailure?.call(
          'count',
          _normalizeHttpErrorCode(res.statusCode, res.body),
          msg,
        );
      }
    } catch (e) {
      if (_disposed || !(isMounted?.call() ?? true)) return;
      final msg = e.toString();
      await onError?.call(msg);
      await onFailure?.call('count', 'network-error', msg);
    } finally {
      if (closeAfter) client.close();
    }
  }

  Future<void> rpc({
    String functionName = '',
    dynamic params = const <String, dynamic>{},
    String? accessToken,
  }) async {
    if (_disposed) return;
    final fn = functionName.trim();
    if (fn.isEmpty) {
      const msg = 'Function name is required.';
      await onError?.call(msg);
      await onFailure?.call('rpc', 'invalid-payload', msg);
      return;
    }
    late final Map<String, dynamic> payload;
    try {
      payload = _parseMap(params);
    } catch (e) {
      final msg = 'Invalid RPC params: $e';
      await onError?.call(msg);
      await onFailure?.call('rpc', 'invalid-payload', msg);
      return;
    }

    if (!_canCallHttp) {
      _lastJson = jsonEncode({'function': fn, 'params': payload});
      if (isMounted?.call() ?? true) {
        await onRpcSuccess?.call(_lastJson);
      }
      return;
    }

    final client = httpClient ?? http.Client();
    final closeAfter = httpClient == null;
    try {
      final base = projectUrl.trim().replaceAll(RegExp(r'/+$'), '');
      final uri = Uri.parse('$base/rest/v1/rpc/$fn');
      final res = await client.post(
        uri,
        headers: _headers(accessToken: accessToken),
        body: jsonEncode(payload),
      );
      if (_disposed || !(isMounted?.call() ?? true)) return;
      if (res.statusCode >= 200 && res.statusCode < 300) {
        _lastJson = res.body.trim().isEmpty ? '{}' : res.body;
        await onRpcSuccess?.call(_lastJson);
      } else {
        final msg = _extractErrorMessage(res.body, res.statusCode);
        await onError?.call(msg);
        await onFailure?.call(
          'rpc',
          _normalizeHttpErrorCode(res.statusCode, res.body),
          msg,
        );
      }
    } catch (e) {
      if (_disposed || !(isMounted?.call() ?? true)) return;
      final msg = e.toString();
      await onError?.call(msg);
      await onFailure?.call('rpc', 'network-error', msg);
    } finally {
      if (closeAfter) client.close();
    }
  }

  void listenRealtime({String table = '', String eventFilter = '*'}) {
    if (_disposed) return;
    _isListening = true;
    final t = _resolveTable(table);
    _listeningTable = t.isEmpty ? null : t;
    _listeningEventFilter = eventFilter.trim().isEmpty ? '*' : eventFilter.trim();
  }

  void stopRealtime() {
    _isListening = false;
    _listeningTable = null;
  }

  void dispose() {
    _disposed = true;
    stopRealtime();
    _mockTables.clear();
  }
}

class DwSupabaseAuth {
  final String projectUrl;
  final String anonKey;
  final bool Function()? isMounted;
  final http.Client? httpClient;
  final bool useMockOnly;

  final Future<void> Function(
    bool success,
    String userId,
    String email,
    String errorCode,
    String errorMessage,
  )? onSignInCompleted;
  final Future<void> Function(
    bool success,
    String userId,
    String email,
    String errorCode,
    String errorMessage,
  )? onSignUpCompleted;
  final Future<void> Function(
    bool success,
    String errorCode,
    String errorMessage,
  )? onOtpSent;
  final Future<void> Function(
    bool success,
    String errorCode,
    String errorMessage,
  )? onPasswordResetSent;
  final Future<void> Function(
    bool success,
    String errorCode,
    String errorMessage,
  )? onUserUpdateCompleted;
  final Future<void> Function(
    bool isLoggedIn,
    String userId,
    String email,
  )? onAuthStateChanged;

  final Map<String, ({String userId, String password, Map<String, dynamic> data})>
      _mockUsers = {};
  bool _isLoggedIn = false;
  String _userId = '';
  String _email = '';
  String _accessToken = '';
  bool _disposed = false;

  DwSupabaseAuth({
    this.projectUrl = '',
    this.anonKey = '',
    this.isMounted,
    this.httpClient,
    this.useMockOnly = false,
    this.onSignInCompleted,
    this.onSignUpCompleted,
    this.onOtpSent,
    this.onPasswordResetSent,
    this.onUserUpdateCompleted,
    this.onAuthStateChanged,
  });

  bool get _canCallHttp =>
      !useMockOnly &&
      projectUrl.trim().isNotEmpty &&
      anonKey.trim().isNotEmpty;

  Map<String, String> _headers({String? bearer}) => {
        'apikey': anonKey.trim(),
        'Authorization':
            'Bearer ${(bearer != null && bearer.isNotEmpty) ? bearer : anonKey.trim()}',
        'Content-Type': 'application/json',
      };

  Map<String, dynamic> _parseMap(dynamic raw) {
    if (raw is Map) return Map<String, dynamic>.from(raw);
    if (raw is String && raw.trim().isNotEmpty) {
      final decoded = jsonDecode(raw.trim());
      if (decoded is Map) return Map<String, dynamic>.from(decoded);
    }
    return <String, dynamic>{};
  }

  String _normalizeError(int statusCode, String body) {
    final lower = body.toLowerCase();
    if (lower.contains('already registered') || lower.contains('user_already_exists')) {
      return 'user-already-exists';
    }
    if (lower.contains('weak') || lower.contains('password')) {
      if (statusCode == 422) return 'weak-password';
    }
    if (lower.contains('email not confirmed')) return 'email-not-confirmed';
    if (lower.contains('invalid login credentials') || statusCode == 400) {
      return 'invalid-credentials';
    }
    if (lower.contains('otp') || lower.contains('token')) return 'invalid-otp';
    return 'auth-$statusCode';
  }

  String _extractMessage(String body, int statusCode) {
    try {
      final decoded = jsonDecode(body);
      if (decoded is Map) {
        return (decoded['msg'] ??
                decoded['error_description'] ??
                decoded['message'] ??
                decoded['error'] ??
                'HTTP $statusCode')
            .toString();
      }
    } catch (_) {}
    return body.trim().isNotEmpty ? body.trim() : 'HTTP $statusCode';
  }

  bool isLoggedIn() => _isLoggedIn;
  String currentUserId() => _userId;
  String currentUserEmail() => _email;
  String accessToken() => _accessToken;

  Future<void> _setSession({
    required bool loggedIn,
    required String userId,
    required String email,
    required String token,
  }) async {
    final changed =
        _isLoggedIn != loggedIn || _userId != userId || _email != email;
    _isLoggedIn = loggedIn;
    _userId = userId;
    _email = email;
    _accessToken = token;
    if (changed && (isMounted?.call() ?? true)) {
      await onAuthStateChanged?.call(_isLoggedIn, _userId, _email);
    }
  }

  Future<void> signUp({
    required String email,
    required String password,
    dynamic dataJson = '{}',
  }) async {
    if (_disposed) return;
    final cleanEmail = email.trim();
    if (cleanEmail.isEmpty || !cleanEmail.contains('@')) {
      await onSignUpCompleted?.call(false, '', cleanEmail, 'invalid-email', 'Please enter a valid email.');
      return;
    }
    if (password.length < 6) {
      await onSignUpCompleted?.call(false, '', cleanEmail, 'weak-password', 'Password must be at least 6 characters.');
      return;
    }
    final metadata = _parseMap(dataJson);

    if (!_canCallHttp) {
      if (_mockUsers.containsKey(cleanEmail)) {
        await onSignUpCompleted?.call(false, '', cleanEmail, 'user-already-exists', 'User already registered.');
        return;
      }
      final uid = 'supa_${cleanEmail.hashCode.abs()}';
      _mockUsers[cleanEmail] = (userId: uid, password: password, data: metadata);
      await _setSession(
        loggedIn: true,
        userId: uid,
        email: cleanEmail,
        token: 'mock_jwt_$uid',
      );
      if (isMounted?.call() ?? true) {
        await onSignUpCompleted?.call(true, uid, cleanEmail, '', '');
      }
      return;
    }

    final client = httpClient ?? http.Client();
    final closeAfter = httpClient == null;
    try {
      final base = projectUrl.trim().replaceAll(RegExp(r'/+$'), '');
      final res = await client.post(
        Uri.parse('$base/auth/v1/signup'),
        headers: _headers(),
        body: jsonEncode({
          'email': cleanEmail,
          'password': password,
          if (metadata.isNotEmpty) 'data': metadata,
        }),
      );
      if (_disposed || !(isMounted?.call() ?? true)) return;
      if (res.statusCode >= 200 && res.statusCode < 300) {
        final json = jsonDecode(res.body) as Map<String, dynamic>;
        final user = json['user'] as Map<String, dynamic>? ?? json;
        final uid = (user['id'] ?? '').toString();
        final token = (json['access_token'] ?? '').toString();
        if (token.isNotEmpty) {
          await _setSession(loggedIn: true, userId: uid, email: cleanEmail, token: token);
        }
        await onSignUpCompleted?.call(true, uid, cleanEmail, '', '');
      } else {
        await onSignUpCompleted?.call(
          false,
          '',
          cleanEmail,
          _normalizeError(res.statusCode, res.body),
          _extractMessage(res.body, res.statusCode),
        );
      }
    } catch (e) {
      if (_disposed || !(isMounted?.call() ?? true)) return;
      await onSignUpCompleted?.call(false, '', cleanEmail, 'network-error', e.toString());
    } finally {
      if (closeAfter) client.close();
    }
  }

  Future<void> signInWithPassword({
    required String email,
    required String password,
  }) async {
    if (_disposed) return;
    final cleanEmail = email.trim();
    if (!_canCallHttp) {
      final existing = _mockUsers[cleanEmail];
      if (existing != null && existing.password != password) {
        await onSignInCompleted?.call(false, '', cleanEmail, 'invalid-credentials', 'Invalid login credentials.');
        return;
      }
      final uid = existing?.userId ?? 'supa_${cleanEmail.hashCode.abs()}';
      _mockUsers.putIfAbsent(
        cleanEmail,
        () => (userId: uid, password: password, data: const {}),
      );
      await _setSession(
        loggedIn: true,
        userId: uid,
        email: cleanEmail,
        token: 'mock_jwt_$uid',
      );
      if (isMounted?.call() ?? true) {
        await onSignInCompleted?.call(true, uid, cleanEmail, '', '');
      }
      return;
    }

    final client = httpClient ?? http.Client();
    final closeAfter = httpClient == null;
    try {
      final base = projectUrl.trim().replaceAll(RegExp(r'/+$'), '');
      final res = await client.post(
        Uri.parse('$base/auth/v1/token?grant_type=password'),
        headers: _headers(),
        body: jsonEncode({'email': cleanEmail, 'password': password}),
      );
      if (_disposed || !(isMounted?.call() ?? true)) return;
      if (res.statusCode >= 200 && res.statusCode < 300) {
        final json = jsonDecode(res.body) as Map<String, dynamic>;
        final user = json['user'] as Map<String, dynamic>? ?? const {};
        final uid = (user['id'] ?? '').toString();
        final resolvedEmail = (user['email'] ?? cleanEmail).toString();
        final token = (json['access_token'] ?? '').toString();
        await _setSession(loggedIn: true, userId: uid, email: resolvedEmail, token: token);
        await onSignInCompleted?.call(true, uid, resolvedEmail, '', '');
      } else {
        await onSignInCompleted?.call(
          false,
          '',
          cleanEmail,
          _normalizeError(res.statusCode, res.body),
          _extractMessage(res.body, res.statusCode),
        );
      }
    } catch (e) {
      if (_disposed || !(isMounted?.call() ?? true)) return;
      await onSignInCompleted?.call(false, '', cleanEmail, 'network-error', e.toString());
    } finally {
      if (closeAfter) client.close();
    }
  }

  Future<void> signInWithOtp({required String emailOrPhone}) async {
    if (_disposed) return;
    final clean = emailOrPhone.trim();
    if (!_canCallHttp) {
      if (clean.isEmpty) {
        await onOtpSent?.call(false, 'invalid-email', 'Email or phone is required.');
        return;
      }
      if (isMounted?.call() ?? true) {
        await onOtpSent?.call(true, '', '');
      }
      return;
    }

    final client = httpClient ?? http.Client();
    final closeAfter = httpClient == null;
    try {
      final base = projectUrl.trim().replaceAll(RegExp(r'/+$'), '');
      final isEmail = clean.contains('@');
      final res = await client.post(
        Uri.parse('$base/auth/v1/otp'),
        headers: _headers(),
        body: jsonEncode({if (isEmail) 'email': clean else 'phone': clean}),
      );
      if (_disposed || !(isMounted?.call() ?? true)) return;
      if (res.statusCode >= 200 && res.statusCode < 300) {
        await onOtpSent?.call(true, '', '');
      } else {
        await onOtpSent?.call(
          false,
          _normalizeError(res.statusCode, res.body),
          _extractMessage(res.body, res.statusCode),
        );
      }
    } catch (e) {
      if (_disposed || !(isMounted?.call() ?? true)) return;
      await onOtpSent?.call(false, 'network-error', e.toString());
    } finally {
      if (closeAfter) client.close();
    }
  }

  Future<void> verifyOtp({
    required String emailOrPhone,
    required String token,
    String otpType = 'email',
  }) async {
    if (_disposed) return;
    final clean = emailOrPhone.trim();
    if (!_canCallHttp) {
      if (token.trim().isEmpty) {
        await onSignInCompleted?.call(false, '', clean, 'invalid-otp', 'OTP token is required.');
        return;
      }
      final uid = 'supa_otp_${clean.hashCode.abs()}';
      await _setSession(
        loggedIn: true,
        userId: uid,
        email: clean,
        token: 'mock_jwt_$uid',
      );
      if (isMounted?.call() ?? true) {
        await onSignInCompleted?.call(true, uid, clean, '', '');
      }
      return;
    }

    final client = httpClient ?? http.Client();
    final closeAfter = httpClient == null;
    try {
      final base = projectUrl.trim().replaceAll(RegExp(r'/+$'), '');
      final isEmail = clean.contains('@');
      final res = await client.post(
        Uri.parse('$base/auth/v1/verify'),
        headers: _headers(),
        body: jsonEncode({
          if (isEmail) 'email': clean else 'phone': clean,
          'token': token.trim(),
          'type': otpType.trim().isEmpty ? 'email' : otpType.trim(),
        }),
      );
      if (_disposed || !(isMounted?.call() ?? true)) return;
      if (res.statusCode >= 200 && res.statusCode < 300) {
        final json = jsonDecode(res.body) as Map<String, dynamic>;
        final user = json['user'] as Map<String, dynamic>? ?? const {};
        final uid = (user['id'] ?? '').toString();
        final resolvedEmail = (user['email'] ?? clean).toString();
        final jwt = (json['access_token'] ?? '').toString();
        await _setSession(loggedIn: true, userId: uid, email: resolvedEmail, token: jwt);
        await onSignInCompleted?.call(true, uid, resolvedEmail, '', '');
      } else {
        await onSignInCompleted?.call(
          false,
          '',
          clean,
          _normalizeError(res.statusCode, res.body),
          _extractMessage(res.body, res.statusCode),
        );
      }
    } catch (e) {
      if (_disposed || !(isMounted?.call() ?? true)) return;
      await onSignInCompleted?.call(false, '', clean, 'network-error', e.toString());
    } finally {
      if (closeAfter) client.close();
    }
  }

  Future<void> sendPasswordReset({required String email}) async {
    if (_disposed) return;
    final cleanEmail = email.trim();
    if (!_canCallHttp) {
      if (cleanEmail.isEmpty) {
        await onPasswordResetSent?.call(false, 'invalid-email', 'Email is required.');
        return;
      }
      if (isMounted?.call() ?? true) {
        await onPasswordResetSent?.call(true, '', '');
      }
      return;
    }

    final client = httpClient ?? http.Client();
    final closeAfter = httpClient == null;
    try {
      final base = projectUrl.trim().replaceAll(RegExp(r'/+$'), '');
      final res = await client.post(
        Uri.parse('$base/auth/v1/recover'),
        headers: _headers(),
        body: jsonEncode({'email': cleanEmail}),
      );
      if (_disposed || !(isMounted?.call() ?? true)) return;
      if (res.statusCode >= 200 && res.statusCode < 300) {
        await onPasswordResetSent?.call(true, '', '');
      } else {
        await onPasswordResetSent?.call(
          false,
          _normalizeError(res.statusCode, res.body),
          _extractMessage(res.body, res.statusCode),
        );
      }
    } catch (e) {
      if (_disposed || !(isMounted?.call() ?? true)) return;
      await onPasswordResetSent?.call(false, 'network-error', e.toString());
    } finally {
      if (closeAfter) client.close();
    }
  }

  Future<void> updateUser({
    String email = '',
    String password = '',
    dynamic dataJson = '{}',
  }) async {
    if (_disposed) return;
    final metadata = _parseMap(dataJson);
    if (!_canCallHttp) {
      if (!_isLoggedIn) {
        await onUserUpdateCompleted?.call(false, 'not-authenticated', 'No active user session.');
        return;
      }
      if (email.trim().isNotEmpty) _email = email.trim();
      if (isMounted?.call() ?? true) {
        await onUserUpdateCompleted?.call(true, '', '');
      }
      return;
    }

    final client = httpClient ?? http.Client();
    final closeAfter = httpClient == null;
    try {
      final base = projectUrl.trim().replaceAll(RegExp(r'/+$'), '');
      final body = <String, dynamic>{
        if (email.trim().isNotEmpty) 'email': email.trim(),
        if (password.isNotEmpty) 'password': password,
        if (metadata.isNotEmpty) 'data': metadata,
      };
      final res = await client.put(
        Uri.parse('$base/auth/v1/user'),
        headers: _headers(bearer: _accessToken),
        body: jsonEncode(body),
      );
      if (_disposed || !(isMounted?.call() ?? true)) return;
      if (res.statusCode >= 200 && res.statusCode < 300) {
        if (email.trim().isNotEmpty) _email = email.trim();
        await onUserUpdateCompleted?.call(true, '', '');
      } else {
        await onUserUpdateCompleted?.call(
          false,
          _normalizeError(res.statusCode, res.body),
          _extractMessage(res.body, res.statusCode),
        );
      }
    } catch (e) {
      if (_disposed || !(isMounted?.call() ?? true)) return;
      await onUserUpdateCompleted?.call(false, 'network-error', e.toString());
    } finally {
      if (closeAfter) client.close();
    }
  }

  Future<void> signOut() async {
    if (_disposed) return;
    if (_canCallHttp && _accessToken.isNotEmpty) {
      final client = httpClient ?? http.Client();
      final closeAfter = httpClient == null;
      try {
        final base = projectUrl.trim().replaceAll(RegExp(r'/+$'), '');
        await client.post(
          Uri.parse('$base/auth/v1/logout'),
          headers: _headers(bearer: _accessToken),
        );
      } catch (_) {
      } finally {
        if (closeAfter) client.close();
      }
    }
    await _setSession(loggedIn: false, userId: '', email: '', token: '');
  }

  void dispose() {
    _disposed = true;
    _mockUsers.clear();
  }
}

class DwSupabaseStorage {
  final String projectUrl;
  final String anonKey;
  final String defaultBucket;
  final bool Function()? isMounted;
  final http.Client? httpClient;
  final bool useMockOnly;

  final Future<void> Function(
    String bucket,
    String cloudPath,
    String publicUrl,
  )? onUploadSuccess;
  final Future<void> Function(
    String bucket,
    String cloudPath,
    String filePath,
  )? onDownloadSuccess;
  final Future<void> Function(
    String bucket,
    String cloudPath,
    String url,
  )? onPublicUrlReceived;
  final Future<void> Function(String bucket, String cloudPath)? onDeleteSuccess;
  final Future<void> Function(
    String operation,
    String cloudPath,
    String errorCode,
    String errorMessage,
  )? onFailure;

  final Map<String, List<int>> _mockFiles = {};
  final Set<String> _activeUploads = {};
  String _lastUrl = '';
  bool _disposed = false;

  DwSupabaseStorage({
    this.projectUrl = '',
    this.anonKey = '',
    this.defaultBucket = '',
    this.isMounted,
    this.httpClient,
    this.useMockOnly = false,
    this.onUploadSuccess,
    this.onDownloadSuccess,
    this.onPublicUrlReceived,
    this.onDeleteSuccess,
    this.onFailure,
  });

  bool get _canCallHttp =>
      !useMockOnly &&
      projectUrl.trim().isNotEmpty &&
      anonKey.trim().isNotEmpty;

  String _resolveBucket(String bucket) {
    final b = bucket.trim();
    return b.isNotEmpty ? b : defaultBucket.trim();
  }

  String _buildPublicUrl(String bucket, String cloudPath) {
    final cleanPath = cloudPath.trim().replaceFirst(RegExp(r'^/+'), '');
    if (projectUrl.trim().isEmpty) {
      return 'https://supabase.mock/storage/v1/object/public/$bucket/$cleanPath';
    }
    final base = projectUrl.trim().replaceAll(RegExp(r'/+$'), '');
    return '$base/storage/v1/object/public/$bucket/$cleanPath';
  }

  Map<String, String> _headers({String? accessToken, String? contentType, bool upsert = false}) => {
        'apikey': anonKey.trim(),
        'Authorization':
            'Bearer ${(accessToken != null && accessToken.isNotEmpty) ? accessToken : anonKey.trim()}',
        if (contentType != null) 'Content-Type': contentType,
        if (upsert) 'x-upsert': 'true',
      };

  String lastUrl() => _lastUrl;
  bool isUploading([String cloudPath = '']) =>
      cloudPath.trim().isEmpty
          ? _activeUploads.isNotEmpty
          : _activeUploads.contains(cloudPath.trim());

  Future<void> uploadFile({
    String bucket = '',
    required String cloudPath,
    required String localFilePath,
    bool upsert = true,
    String? accessToken,
  }) async {
    if (_disposed) return;
    final b = _resolveBucket(bucket);
    final cPath = cloudPath.trim().replaceFirst(RegExp(r'^/+'), '');
    if (b.isEmpty || cPath.isEmpty) {
      await onFailure?.call('upload', cPath, 'invalid-argument', 'Bucket and cloudPath are required.');
      return;
    }

    _activeUploads.add(cPath);
    try {
      if (!_canCallHttp) {
        if (localFilePath.trim().isEmpty) {
          await onFailure?.call('upload', cPath, 'file-not-found', 'Local file path is empty.');
          return;
        }
        final file = File(localFilePath);
        final bytes = await file.exists()
            ? await file.readAsBytes()
            : utf8.encode('mock_content:$localFilePath');
        _mockFiles['$b/$cPath'] = bytes;
        _lastUrl = _buildPublicUrl(b, cPath);
        if (isMounted?.call() ?? true) {
          await onUploadSuccess?.call(b, cPath, _lastUrl);
        }
        return;
      }

      final file = File(localFilePath);
      if (!await file.exists()) {
        await onFailure?.call('upload', cPath, 'file-not-found', 'Local file does not exist: $localFilePath');
        return;
      }
      final bytes = await file.readAsBytes();
      final client = httpClient ?? http.Client();
      final closeAfter = httpClient == null;
      try {
        final base = projectUrl.trim().replaceAll(RegExp(r'/+$'), '');
        final res = await client.post(
          Uri.parse('$base/storage/v1/object/$b/$cPath'),
          headers: _headers(
            accessToken: accessToken,
            contentType: 'application/octet-stream',
            upsert: upsert,
          ),
          body: bytes,
        );
        if (_disposed || !(isMounted?.call() ?? true)) return;
        if (res.statusCode >= 200 && res.statusCode < 300) {
          _lastUrl = _buildPublicUrl(b, cPath);
          await onUploadSuccess?.call(b, cPath, _lastUrl);
        } else {
          await onFailure?.call('upload', cPath, 'http-${res.statusCode}', res.body);
        }
      } finally {
        if (closeAfter) client.close();
      }
    } catch (e) {
      if (_disposed || !(isMounted?.call() ?? true)) return;
      await onFailure?.call('upload', cPath, 'network-error', e.toString());
    } finally {
      _activeUploads.remove(cPath);
    }
  }

  Future<void> downloadFile({
    String bucket = '',
    required String cloudPath,
    required String localSavePath,
    String? accessToken,
  }) async {
    if (_disposed) return;
    final b = _resolveBucket(bucket);
    final cPath = cloudPath.trim().replaceFirst(RegExp(r'^/+'), '');
    if (b.isEmpty || cPath.isEmpty || localSavePath.trim().isEmpty) {
      await onFailure?.call('download', cPath, 'invalid-argument', 'Bucket, cloudPath, and localSavePath are required.');
      return;
    }

    try {
      if (!_canCallHttp) {
        final bytes = _mockFiles['$b/$cPath'];
        if (bytes == null) {
          await onFailure?.call('download', cPath, 'object-not-found', 'Object not found in mock storage.');
          return;
        }
        final outFile = File(localSavePath);
        await outFile.parent.create(recursive: true);
        await outFile.writeAsBytes(bytes);
        if (isMounted?.call() ?? true) {
          await onDownloadSuccess?.call(b, cPath, outFile.path);
        }
        return;
      }

      final client = httpClient ?? http.Client();
      final closeAfter = httpClient == null;
      try {
        final base = projectUrl.trim().replaceAll(RegExp(r'/+$'), '');
        final res = await client.get(
          Uri.parse('$base/storage/v1/object/$b/$cPath'),
          headers: _headers(accessToken: accessToken),
        );
        if (_disposed || !(isMounted?.call() ?? true)) return;
        if (res.statusCode >= 200 && res.statusCode < 300) {
          final outFile = File(localSavePath);
          await outFile.parent.create(recursive: true);
          await outFile.writeAsBytes(res.bodyBytes);
          await onDownloadSuccess?.call(b, cPath, outFile.path);
        } else {
          await onFailure?.call(
            'download',
            cPath,
            res.statusCode == 404 ? 'object-not-found' : 'http-${res.statusCode}',
            res.body,
          );
        }
      } finally {
        if (closeAfter) client.close();
      }
    } catch (e) {
      if (_disposed || !(isMounted?.call() ?? true)) return;
      await onFailure?.call('download', cPath, 'network-error', e.toString());
    }
  }

  Future<void> getPublicUrl({
    String bucket = '',
    required String cloudPath,
  }) async {
    if (_disposed) return;
    final b = _resolveBucket(bucket);
    final cPath = cloudPath.trim().replaceFirst(RegExp(r'^/+'), '');
    if (b.isEmpty || cPath.isEmpty) {
      await onFailure?.call('getPublicUrl', cPath, 'invalid-argument', 'Bucket and cloudPath are required.');
      return;
    }
    _lastUrl = _buildPublicUrl(b, cPath);
    if (isMounted?.call() ?? true) {
      await onPublicUrlReceived?.call(b, cPath, _lastUrl);
    }
  }

  Future<void> createSignedUrl({
    String bucket = '',
    required String cloudPath,
    int expiresInSeconds = 3600,
    String? accessToken,
  }) async {
    if (_disposed) return;
    final b = _resolveBucket(bucket);
    final cPath = cloudPath.trim().replaceFirst(RegExp(r'^/+'), '');
    if (b.isEmpty || cPath.isEmpty) {
      await onFailure?.call('createSignedUrl', cPath, 'invalid-argument', 'Bucket and cloudPath are required.');
      return;
    }

    if (!_canCallHttp) {
      _lastUrl = '${_buildPublicUrl(b, cPath)}?token=mock_signed_$expiresInSeconds';
      if (isMounted?.call() ?? true) {
        await onPublicUrlReceived?.call(b, cPath, _lastUrl);
      }
      return;
    }

    final client = httpClient ?? http.Client();
    final closeAfter = httpClient == null;
    try {
      final base = projectUrl.trim().replaceAll(RegExp(r'/+$'), '');
      final res = await client.post(
        Uri.parse('$base/storage/v1/object/sign/$b/$cPath'),
        headers: _headers(accessToken: accessToken, contentType: 'application/json'),
        body: jsonEncode({'expiresIn': expiresInSeconds}),
      );
      if (_disposed || !(isMounted?.call() ?? true)) return;
      if (res.statusCode >= 200 && res.statusCode < 300) {
        final json = jsonDecode(res.body) as Map<String, dynamic>;
        final signedPath = (json['signedURL'] ?? '').toString();
        _lastUrl = signedPath.startsWith('http')
            ? signedPath
            : '$base/storage/v1$signedPath';
        await onPublicUrlReceived?.call(b, cPath, _lastUrl);
      } else {
        await onFailure?.call('createSignedUrl', cPath, 'http-${res.statusCode}', res.body);
      }
    } catch (e) {
      if (_disposed || !(isMounted?.call() ?? true)) return;
      await onFailure?.call('createSignedUrl', cPath, 'network-error', e.toString());
    } finally {
      if (closeAfter) client.close();
    }
  }

  Future<void> deleteFile({
    String bucket = '',
    required String cloudPath,
    String? accessToken,
  }) async {
    if (_disposed) return;
    final b = _resolveBucket(bucket);
    final cPath = cloudPath.trim().replaceFirst(RegExp(r'^/+'), '');
    if (b.isEmpty || cPath.isEmpty) {
      await onFailure?.call('delete', cPath, 'invalid-argument', 'Bucket and cloudPath are required.');
      return;
    }

    if (!_canCallHttp) {
      _mockFiles.remove('$b/$cPath');
      if (isMounted?.call() ?? true) {
        await onDeleteSuccess?.call(b, cPath);
      }
      return;
    }

    final client = httpClient ?? http.Client();
    final closeAfter = httpClient == null;
    try {
      final base = projectUrl.trim().replaceAll(RegExp(r'/+$'), '');
      final res = await client.delete(
        Uri.parse('$base/storage/v1/object/$b'),
        headers: _headers(accessToken: accessToken, contentType: 'application/json'),
        body: jsonEncode({'prefixes': [cPath]}),
      );
      if (_disposed || !(isMounted?.call() ?? true)) return;
      if (res.statusCode >= 200 && res.statusCode < 300) {
        await onDeleteSuccess?.call(b, cPath);
      } else {
        await onFailure?.call('delete', cPath, 'http-${res.statusCode}', res.body);
      }
    } catch (e) {
      if (_disposed || !(isMounted?.call() ?? true)) return;
      await onFailure?.call('delete', cPath, 'network-error', e.toString());
    } finally {
      if (closeAfter) client.close();
    }
  }

  void dispose() {
    _disposed = true;
    _mockFiles.clear();
    _activeUploads.clear();
  }
}



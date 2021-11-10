use neli::consts::genl::{Cmd, NlAttrType};
use neli::impl_var;
use std::fmt;

impl_var!(
    /// nl80211Commands
    ///
    /// Enumeration from nl80211/nl80211.h:880
    pub Nl80211Cmd, u8,
    Unspec                  => 0,
    GetWiphy                => 1,
    SetWiphy                => 2,
    NewWiphy                => 3,
    DelWiphy                => 4,
    GetInterface            => 5,
    SetInterface            => 6,
    NewInterface            => 7,
    DelInterface            => 8,
    GetKey                  => 9,
    SetKey                  => 10,
    NewKey                  => 11,
    DelKey                  => 12,
    GetBeacon               => 13,
    SetBeacon               => 14,
    StartAp                 => 15,
    NewBeacon               => 15,//StartAp,
    StopAp                  => 16,
    DelBeacon               => 16,//StopAp,
    GetStation              => 17,
    SetStation              => 18,
    NewStation              => 19,
    DelStation              => 20,
    GetMpath                => 21,
    SetMpath                => 22,
    NewMpath                => 23,
    DelMpath                => 24,
    SetBss                  => 25,
    SetReg                  => 26,
    ReqSetReg               => 27,
    GetMeshConfig           => 28,
    SetMeshConfig           => 29,
    SetMgmtExtraIe          => 30,
    GetReg                  => 31,
    GetScan                 => 32,
    TriggerScan             => 33,
    NewScanResults          => 34,
    ScanAborted             => 35,
    RegChange               => 36,
    Authenticate            => 37,
    Associate               => 38,
    Deauthenticate          => 39,
    Disassociate            => 40,
    MichaelMicFailure       => 41,
    RegBeaconHint           => 42,
    JoinIbss                => 43,
    LeaveIbss               => 44,
    Testmode                => 45,
    Connect                 => 46,
    Roam                    => 47,
    Disconnect              => 48,
    SetWiphyNetns           => 49,
    GetSurvey               => 50,
    NewSurveyResults        => 51,
    SetPmksa                => 52,
    DelPmksa                => 53,
    FlushPmksa              => 54,
    RemainOnChannel         => 55,
    CancelRemainOnChannel   => 56,
    SetTxBitrateMask        => 57,
    RegisterFrame           => 58,
    RegisterAction          => 58,//RegisterFrame,
    Frame                   => 59,
    Action                  => 59,//Frame,
    FrameTxStatus           => 60,
    ActionTxStatus          => 60,//FrameTxStatus,
    SetPowerSave            => 61,
    GetPowerSave            => 62,
    SetCqm                  => 63,
    NotifyCqm               => 64,
    SetChannel              => 65,
    SetWdsPeer              => 66,
    FrameWaitCancel         => 67,
    JoinMesh                => 68,
    LeaveMesh               => 69,
    UnprotDeauthenticate    => 70,
    UnprotDisassociate      => 71,
    NewPeerCandidate        => 72,
    GetWowlan               => 73,
    SetWowlan               => 74,
    StartSchedScan          => 75,
    StopSchedScan           => 76,
    SchedScanResults        => 77,
    SchedScanStopped        => 78,
    SetRekeyOffload         => 79,
    PmksaCandidate          => 80,
    TdlsOper                => 81,
    TdlsMgmt                => 82,
    UnexpectedFrame         => 83,
    ProbeClient             => 84,
    RegisterBeacons         => 85,
    Unexpected4addrFrame    => 86,
    SetNoackMap             => 87,
    ChSwitchNotify          => 88,
    StartP2pDevice          => 89,
    StopP2pDevice           => 90,
    ConnFailed              => 91,
    SetMcastRate            => 92,
    SetMacAcl               => 93,
    RadarDetect             => 94,
    GetProtocolFeatures     => 95,
    UpdateFtIes             => 96,
    FtEvent                 => 97,
    CritProtocolStart       => 98,
    CritProtocolStop        => 99,
    GetCoalesce             => 100,
    SetCoalesce             => 101,
    ChannelSwitch           => 102,
    Vendor                  => 103,
    SetQosMap               => 104,
    AddTxTs                 => 105,
    DelTxTs                 => 106,
    GetMpp                  => 107,
    JoinOcb                 => 108,
    LeaveOcb                => 109,
    ChSwitchStartedNotify   => 110,
    TdlsChannelSwitch       => 111,
    TdlsCancelChannelSwitch => 112,
    WiphyRegChange          => 113,
    AbortScan               => 114,
    StartNan                => 115,
    StopNan                 => 116,
    AddNanFunction          => 117,
    DelNanFunction          => 118,
    ChangeNanConfig         => 119,
    NanMatch                => 120,
    AfterLast               => 121,
    AttrMax                 => 120
);

impl Cmd for Nl80211Cmd {}

impl_var!(
    /// nl80211Attrs
    ///
    /// Enumeration from nl80211/nl80211.h:1929
    pub Nl80211Attr, u16,
    Unspec                       => 0,
    Wiphy                        => 1,
    WiphyName                    => 2,
    Ifindex                      => 3,
    Ifname                       => 4,
    Iftype                       => 5,
    Mac                          => 6,
    KeyData                      => 7,
    KeyIdx                       => 8,
    KeyCipher                    => 9,
    KeySeq                       => 10,
    KeyDefault                   => 11,
    BeaconInterval               => 12,
    DtimPeriod                   => 13,
    BeaconHead                   => 14,
    BeaconTail                   => 15,
    StaAid                       => 16,
    StaFlags                     => 17,
    StaListenInterval            => 18,
    StaSupportedRates            => 19,
    StaVlan                      => 20,
    StaInfo                      => 21,
    WiphyBands                   => 22,
    MntrFlags                    => 23,
    MeshId                       => 24,
    StaPlinkAction               => 25,
    MpathNextHop                 => 26,
    MpathInfo                    => 27,
    BssCtsProt                   => 28,
    BssShortPreamble             => 29,
    BssShortSlotTime             => 30,
    HtCapability                 => 31,
    SupportedIftypes             => 32,
    RegAlpha2                    => 33,
    RegRules                     => 34,
    MeshConfig                   => 35,
    BssBasicRates                => 36,
    WiphyTxqParams               => 37,
    WiphyFreq                    => 38,
    WiphyChannelType             => 39,
    KeyDefaultMgmt               => 40,
    MgmtSubtype                  => 41,
    Ie                           => 42,
    MaxNumScanSsids              => 43,
    ScanFrequencies              => 44,
    ScanSsids                    => 45,
    Generation                   => 46,
    Bss                          => 47,
    RegInitiator                 => 48,
    RegType                      => 49,
    SupportedCommands            => 50,
    Frame                        => 51,
    Ssid                         => 52,
    AuthType                     => 53,
    ReasonCode                   => 54,
    KeyType                      => 55,
    MaxScanIeLen                 => 56,
    CipherSuites                 => 57,
    FreqBefore                   => 58,
    FreqAfter                    => 59,
    FreqFixed                    => 60,
    WiphyRetryShort              => 61,
    WiphyRetryLong               => 62,
    WiphyFragThreshold           => 63,
    WiphyRtsThreshold            => 64,
    TimedOut                     => 65,
    UseMfp                       => 66,
    StaFlags2                    => 67,
    ControlPort                  => 68,
    Testdata                     => 69,
    Privacy                      => 70,
    DisconnectedByAp             => 71,
    StatusCode                   => 72,
    CipherSuitesPairwise         => 73,
    CipherSuiteGroup             => 74,
    WpaVersions                  => 75,
    AkmSuites                    => 76,
    ReqIe                        => 77,
    RespIe                       => 78,
    PrevBssid                    => 79,
    Key                          => 80,
    Keys                         => 81,
    Pid                          => 82,
    Addr4                        => 83,
    SurveyInfo                   => 84,
    Pmkid                        => 85,
    MaxNumPmkids                 => 86,
    Duration                     => 87,
    Cookie                       => 88,
    WiphyCoverageClass           => 89,
    TxRates                      => 90,
    FrameMatch                   => 91,
    Ack                          => 92,
    PsState                      => 93,
    Cqm                          => 94,
    LocalStateChange             => 95,
    ApIsolate                    => 96,
    WiphyTxPowerSetting          => 97,
    WiphyTxPowerLevel            => 98,
    TxFrameTypes                 => 99,
    RxFrameTypes                 => 100,
    FrameType                    => 101,
    ControlPortEthertype         => 102,
    ControlPortNoEncrypt         => 103,
    SupportIbssRsn               => 104,
    WiphyAntennaTx               => 105,
    WiphyAntennaRx               => 106,
    McastRate                    => 107,
    OffchannelTxOk               => 108,
    BssHtOpmode                  => 109,
    KeyDefaultTypes              => 110,
    MaxRemainOnChannelDuration   => 111,
    MeshSetup                    => 112,
    WiphyAntennaAvailTx          => 113,
    WiphyAntennaAvailRx          => 114,
    SupportMeshAuth              => 115,
    StaPlinkState                => 116,
    WowlanTriggers               => 117,
    WowlanTriggersSupported      => 118,
    SchedScanInterval            => 119,
    InterfaceCombinations        => 120,
    SoftwareIftypes              => 121,
    RekeyData                    => 122,
    MaxNumSchedScanSsids         => 123,
    MaxSchedScanIeLen            => 124,
    ScanSuppRates                => 125,
    HiddenSsid                   => 126,
    IeProbeResp                  => 127,
    IeAssocResp                  => 128,
    StaWme                       => 129,
    SupportApUapsd               => 130,
    RoamSupport                  => 131,
    SchedScanMatch               => 132,
    MaxMatchSets                 => 133,
    PmksaCandidate               => 134,
    TxNoCckRate                  => 135,
    TdlsAction                   => 136,
    TdlsDialogToken              => 137,
    TdlsOperation                => 138,
    TdlsSupport                  => 139,
    TdlsExternalSetup            => 140,
    DeviceApSme                  => 141,
    DontWaitForAck               => 142,
    FeatureFlags                 => 143,
    ProbeRespOffload             => 144,
    ProbeResp                    => 145,
    DfsRegion                    => 146,
    DisableHt                    => 147,
    HtCapabilityMask             => 148,
    NoackMap                     => 149,
    InactivityTimeout            => 150,
    RxSignalDbm                  => 151,
    BgScanPeriod                 => 152,
    Wdev                         => 153,
    UserRegHintType              => 154,
    ConnFailedReason             => 155,
    SaeData                      => 156,
    VhtCapability                => 157,
    ScanFlags                    => 158,
    ChannelWidth                 => 159,
    CenterFreq1                  => 160,
    CenterFreq2                  => 161,
    P2pCtwindow                  => 162,
    P2pOppps                     => 163,
    LocalMeshPowerMode           => 164,
    AclPolicy                    => 165,
    MacAddrs                     => 166,
    MacAclMax                    => 167,
    RadarEvent                   => 168,
    ExtCapa                      => 169,
    ExtCapaMask                  => 170,
    StaCapability                => 171,
    StaExtCapability             => 172,
    ProtocolFeatures             => 173,
    SplitWiphyDump               => 174,
    DisableVht                   => 175,
    VhtCapabilityMask            => 176,
    Mdid                         => 177,
    IeRic                        => 178,
    CritProtId                   => 179,
    MaxCritProtDuration          => 180,
    PeerAid                      => 181,
    CoalesceRule                 => 182,
    ChSwitchCount                => 183,
    ChSwitchBlockTx              => 184,
    CsaIes                       => 185,
    CsaCOffBeacon                => 186,
    CsaCOffPresp                 => 187,
    RxmgmtFlags                  => 188,
    StaSupportedChannels         => 189,
    StaSupportedOperClasses      => 190,
    HandleDfs                    => 191,
    Support5Mhz                  => 192,
    Support10Mhz                 => 193,
    OpmodeNotif                  => 194,
    VendorId                     => 195,
    VendorSubcmd                 => 196,
    VendorData                   => 197,
    VendorEvents                 => 198,
    QosMap                       => 199,
    MacHint                      => 200,
    WiphyFreqHint                => 201,
    MaxApAssocSta                => 202,
    TdlsPeerCapability           => 203,
    SocketOwner                  => 204,
    CsaCOffsetsTx                => 205,
    MaxCsaCounters               => 206,
    TdlsInitiator                => 207,
    UseRrm                       => 208,
    WiphyDynAck                  => 209,
    Tsid                         => 210,
    UserPrio                     => 211,
    AdmittedTime                 => 212,
    SmpsMode                     => 213,
    OperClass                    => 214,
    MacMask                      => 215,
    WiphySelfManagedReg          => 216,
    ExtFeatures                  => 217,
    SurveyRadioStats             => 218,
    NetnsFd                      => 219,
    SchedScanDelay               => 220,
    RegIndoor                    => 221,
    MaxNumSchedScanPlans         => 222,
    MaxScanPlanInterval          => 223,
    MaxScanPlanIterations        => 224,
    SchedScanPlans               => 225,
    Pbss                         => 226,
    BssSelect                    => 227,
    StaSupportP2pPs              => 228,
    Pad                          => 229,
    IftypeExtCapa                => 230,
    MuMimoGroupData              => 231,
    MuMimoFollowMacAddr          => 232,
    ScanStartTimeTsf             => 233,
    ScanStartTimeTsfBssid        => 234,
    MeasurementDuration          => 235,
    MeasurementDurationMandatory => 236,
    MeshPeerAid                  => 237,
    NanMasterPref                => 238,
    NanDual                      => 239,
    NanFunc                      => 240,
    NanMatch                     => 241,
    AfterLast                    => 242,
    NumAttr                          => 242,//__AttrAfterLast,
    AttrMax                          => 241//__AttrAfterLast - 1
);

impl fmt::Display for Nl80211Attr {
    fn fmt(&self, f: &mut fmt::Formatter) -> fmt::Result {
        write!(f, "{:?}", self)
    }
}

impl NlAttrType for Nl80211Attr {}

impl_var!(
    /// nl80211Iftype
    ///
    /// Enumeration from nl80211/nl80211.h:2384
    pub Nl80211Iftype, u16,
    IftypeUnspecified => 0,
    IftypeAdhoc       => 1,
    IftypeStation     => 2,
    IftypeAp          => 3,
    IftypeApVlan      => 4,
    IftypeWds         => 5,
    IftypeMonitor     => 6,
    IftypeMeshPoint   => 7,
    IftypeP2pClient   => 8,
    IftypeP2pGo       => 9,
    IftypeP2pDevice   => 10,
    IftypeOcb         => 11,
    IftypeNan         => 12,
    NumIftypes        => 13,
    IftypeMax         => 12
);

impl_var!(
    // nl80211StaFlags as declared in nl80211/nl80211.h:2428
    Nl80211StaFlags, u16,
    StaFlagInvalid       => 0,
    StaFlagAuthorized    => 1,
    StaFlagShortPreamble => 2,
    StaFlagWme           => 3,
    StaFlagMfp           => 4,
    StaFlagAuthenticated => 5,
    StaFlagTdlsPeer      => 6,
    StaFlagAssociated    => 7,
    StaFlagAfterLast     => 8,
    StaFlagMax           => 7
);

impl_var!(
    ///nl80211StaP2pPsStatus
    ///
    /// Enumeration from nl80211/nl80211.h:2450
    Nl80211StaP2pPsStatus, u16,
    P2pPsUnsupported => 0,
    P2pPsSupported   => 1,
    NumP2pPsStatus   => 2
);

impl_var!(
    /// nl80211RateInfo
    ///
    /// Enumeration from nl80211/nl80211.h:2505
    Nl80211RateInfo, u16,
    RateInfoInvalid       => 0,
    RateInfoBitrate       => 1,
    RateInfoMcs           => 2,
    RateInfo40MhzWidth    => 3,
    RateInfoShortGi       => 4,
    RateInfoBitrate32     => 5,
    RateInfoVhtMcs        => 6,
    RateInfoVhtNss        => 7,
    RateInfo80MhzWidth    => 8,
    RateInfo80p80MhzWidth => 9,
    RateInfo160MhzWidth   => 10,
    RateInfo10MhzWidth    => 11,
    RateInfo5MhzWidth     => 12,
    RateInfoAfterLast     => 13,
    RateInfoMax           => 12
);

impl_var!(
    /// nl80211StaBssParam
    ///
    /// Enumeration from nl80211/nl80211.h:2542
    Nl80211StaBssParam, u16,
    StaBssParamInvalid        => 0,
    StaBssParamCtsProt        => 1,
    StaBssParamShortPreamble  => 2,
    StaBssParamShortSlotTime  => 3,
    StaBssParamDtimPeriod     => 4,
    StaBssParamBeaconInterval => 5,
    StaBssParamAfterLast      => 6,
    StaBssParamMax            => 5
);

impl_var!(
    /// nl80211StaInfo
    ///
    /// Enumeration from nl80211/nl80211.h:2620
    Nl80211StaInfo, u16,
    StaInfoInvalid            => 0,
    StaInfoInactiveTime       => 1,
    StaInfoRxBytes            => 2,
    StaInfoTxBytes            => 3,
    StaInfoLlid               => 4,
    StaInfoPlid               => 5,
    StaInfoPlinkState         => 6,
    StaInfoSignal             => 7,
    StaInfoTxBitrate          => 8,
    StaInfoRxPackets          => 9,
    StaInfoTxPackets          => 10,
    StaInfoTxRetries          => 11,
    StaInfoTxFailed           => 12,
    StaInfoSignalAvg          => 13,
    StaInfoRxBitrate          => 14,
    StaInfoBssParam           => 15,
    StaInfoConnectedTime      => 16,
    StaInfoStaFlags           => 17,
    StaInfoBeaconLoss         => 18,
    StaInfoTOffset            => 19,
    StaInfoLocalPm            => 20,
    StaInfoPeerPm             => 21,
    StaInfoNonpeerPm          => 22,
    StaInfoRxBytes64          => 23,
    StaInfoTxBytes64          => 24,
    StaInfoChainSignal        => 25,
    StaInfoChainSignalAvg     => 26,
    StaInfoExpectedThroughput => 27,
    StaInfoRxDropMisc         => 28,
    StaInfoBeaconRx           => 29,
    StaInfoBeaconSignalAvg    => 30,
    StaInfoTidStats           => 31,
    StaInfoRxDuration         => 32,
    StaInfoPad                => 33,
    StaInfoAfterLast          => 34,
    StaInfoMax                => 33
);

impl_var!(
    /// nl80211TidStats
    ///
    /// Enumeration from nl80211/nl80211.h:2675
    Nl80211TidStats, u16,
    TidStatsInvalid       => 0,
    TidStatsRxMsdu        => 1,
    TidStatsTxMsdu        => 2,
    TidStatsTxMsduRetries => 3,
    TidStatsTxMsduFailed  => 4,
    TidStatsPad           => 5,
    NumTidStats           => 6,
    TidStatsMax           => 5
);

impl_var!(
    /// nl80211MpathFlags
    ///
    /// Enumeration from nl80211/nl80211.h:2697
    Nl80211MpathFlags, u16,
    MpathFlagActive    => 1 << 0,
    MpathFlagResolving => 1 << 1,
    MpathFlagSnValid   => 1 << 2,
    MpathFlagFixed     => 1 << 3,
    MpathFlagResolved  => 1 << 4
);

impl_var!(
    /// nl80211MpathFlags
    ///
    /// Enumeration from nl80211/nl80211.h:2697
    Nl80211MpathInfo, u16,
    MpathInfoInvalid          => 0,
    MpathInfoFrameQlen        => 1,
    MpathInfoSn               => 2,
    MpathInfoMetric           => 3,
    MpathInfoExptime          => 4,
    MpathInfoFlags            => 5,
    MpathInfoDiscoveryTimeout => 6,
    MpathInfoDiscoveryRetries => 7,
    MpathInfoAfterLast        => 8,
    MpathInfoMax              => 7
);

impl_var!(
    /// nl80211BandAttr
    ///
    /// Enumeration from nl80211/nl80211.h:2757
    Nl80211BandAttr, u16,
    BandAttrInvalid        => 0,
    BandAttrFreqs          => 1,
    BandAttrRates          => 2,
    BandAttrHtMcsSet       => 3,
    BandAttrHtCapa         => 4,
    BandAttrHtAmpduFactor  => 5,
    BandAttrHtAmpduDensity => 6,
    BandAttrVhtMcsSet      => 7,
    BandAttrVhtCapa        => 8,
    BandAttrAfterLast      => 9,
    BandAttrMax            => 8
);

impl_var!(
    /// nl80211FrequencyAttr
    ///
    /// Enumeration from nl80211/nl80211.h:2833
    Nl80211FrequencyAttr, u16,
    FrequencyAttrInvalid      => 0,
    FrequencyAttrFreq         => 1,
    FrequencyAttrDisabled     => 2,
    FrequencyAttrNoIr         => 3,
    FrequencyAttrNoIbss       => 4,
    FrequencyAttrRadar        => 5,
    FrequencyAttrMaxTxPower   => 6,
    FrequencyAttrDfsState     => 7,
    FrequencyAttrDfsTime      => 8,
    FrequencyAttrNoHt40Minus  => 9,
    FrequencyAttrNoHt40Plus   => 10,
    FrequencyAttrNo80mhz      => 11,
    FrequencyAttrNo160mhz     => 12,
    FrequencyAttrDfsCacTime   => 13,
    FrequencyAttrIndoorOnly   => 14,
    FrequencyAttrIrConcurrent => 15,
    FrequencyAttrNo20mhz      => 16,
    FrequencyAttrNo10mhz      => 17,
    FrequencyAttrAfterLast    => 18,
    FrequencyAttrMax          => 17
);

impl_var!(
    /// nl80211BitrateAttr
    ///
    /// Enumeration from nl80211/nl80211.h:2873
    Nl80211BitrateAttr, u16,
    BitrateAttrInvalid           => 0,
    BitrateAttrRate              => 1,
    BitrateAttr2ghzShortpreamble => 2,
    BitrateAttrAfterLast         => 3,
    BitrateAttrMax               => 2
);

impl_var!(
    /// nl80211RegInitiator
    ///
    /// Enumeration from nl80211/nl80211.h:2899
    Nl80211RegInitiator, u16,
    RegdomSetByCore      => 0,
    RegdomSetByUser      => 1,
    RegdomSetByDriver    => 2,
    RegdomSetByCountryIe => 3
);

impl_var!(
    /// nl80211RegType
    ///
    /// Enumeration from nl80211/nl80211.h:2922
    Nl80211RegType, u16,
    RegdomTypeCountry      => 0,
    RegdomTypeWorld        => 1,
    RegdomTypeCustomWorld  => 2,
    RegdomTypeIntersection => 3
);

impl_var!(
    /// nl80211RegRuleAttr
    ///
    /// Enumeration from nl80211/nl80211.h:2954
    Nl80211RegRuleAttr, u16,
    RegRuleAttrInvalid      => 0,
    AttrRegRuleFlags        => 1,
    AttrFreqRangeStart      => 2,
    AttrFreqRangeEnd        => 3,
    AttrFreqRangeMaxBw      => 4,
    AttrPowerRuleMaxAntGain => 5,
    AttrPowerRuleMaxEirp    => 6,
    AttrDfsCacTime          => 7,
    RegRuleAttrAfterLast    => 8,
    RegRuleAttrMax          => 7
);

impl_var!(
    /// nl80211SchedScanMatchAttr
    ///
    /// Enumeration from nl80211/nl80211.h:2989
    Nl80211SchedScanMatchAttr, u16,
    SchedScanMatchAttrInvalid   => 0,
    SchedScanMatchAttrSsid      => 1,
    SchedScanMatchAttrRssi      => 2,
    SchedScanMatchAttrAfterLast => 3,
    SchedScanMatchAttrMax       => 2
);

impl_var!(
    /// nl80211RegRuleFlags
    ///
    /// Enumeration from nl80211/nl80211.h:3026
    Nl80211RegRuleFlags, u16,
    RrfNoOfdm       => 1 << 0,
    RrfNoCck        => 1 << 1,
    RrfNoIndoor     => 1 << 2,
    RrfNoOutdoor    => 1 << 3,
    RrfDfs          => 1 << 4,
    RrfPtpOnly      => 1 << 5,
    RrfPtmpOnly     => 1 << 6,
    RrfNoIr         => 1 << 7,
    RrfNoIbss       => 1 << 8,
    RrfAutoBw       => 1 << 11,
    RrfIrConcurrent => 1 << 12,
    RrfNoHt40minus  => 1 << 13,
    RrfNoHt40plus   => 1 << 14,
    RrfNo80mhz      => 1 << 15
    // RrfNo160mhz   => 1 << 16
);

impl_var!(
    /// nl80211DfsRegions
    ///
    /// Enumeration from nl80211/nl80211.h:3061
    Nl80211DfsRegions, u16,
    DfsUnset => 0,
    DfsFcc   => 1,
    DfsEtsi  => 2,
    DfsJp    => 3
);

impl_var!(
    /// nl80211UserRegHintType
    ///
    /// Enumeration from nl80211/nl80211.h:3085
    Nl80211UserRegHintType, u16,
    UserRegHintUser     => 0,
    UserRegHintCellBase => 1,
    UserRegHintIndoor   => 2
);

impl_var!(
    /// nl80211SurveyInfo
    ///
    /// Enumeration from nl80211/nl80211.h:3118
    Nl80211SurveyInfo, u16,
    SurveyInfoInvalid     => 0,
    SurveyInfoFrequency   => 1,
    SurveyInfoNoise       => 2,
    SurveyInfoInUse       => 3,
    SurveyInfoTime        => 4,
    SurveyInfoTimeBusy    => 5,
    SurveyInfoTimeExtBusy => 6,
    SurveyInfoTimeRx      => 7,
    SurveyInfoTimeTx      => 8,
    SurveyInfoTimeScan    => 9,
    SurveyInfoPad         => 10,
    SurveyInfoAfterLast   => 11,
    SurveyInfoMax         => 10
);

impl_var!(
    /// nl80211MntrFlags
    ///
    /// Enumeration from nl80211/nl80211.h:3162
    Nl80211MntrFlags, u16,
    MntrFlagInvalid    => 0,
    MntrFlagFcsfail    => 1,
    MntrFlagPlcpfail   => 2,
    MntrFlagControl    => 3,
    MntrFlagOtherBss   => 4,
    MntrFlagCookFrames => 5,
    MntrFlagActive     => 6,
    MntrFlagAfterLast  => 7,
    MntrFlagMax        => 6
);

impl_var!(
    /// nl80211MeshPowerMode
    ///
    /// Enumeration from nl80211/nl80211.h:3194
    Nl80211MeshPowerMode, u16,
    MeshPowerUnknown    => 0,
    MeshPowerActive     => 1,
    MeshPowerLightSleep => 2,
    MeshPowerDeepSleep  => 3,
    MeshPowerAfterLast  => 4,
    MeshPowerMax        => 3
);

impl_var!(
    /// nl80211MeshconfParams
    ///
    /// Enumeration from nl80211/nl80211.h:3312
    Nl80211MeshconfParams, u16,
    MeshconfInvalid                  => 0,
    MeshconfRetryTimeout             => 1,
    MeshconfConfirmTimeout           => 2,
    MeshconfHoldingTimeout           => 3,
    MeshconfMaxPeerLinks             => 4,
    MeshconfMaxRetries               => 5,
    MeshconfTtl                      => 6,
    MeshconfAutoOpenPlinks           => 7,
    MeshconfHwmpMaxPreqRetries       => 8,
    MeshconfPathRefreshTime          => 9,
    MeshconfMinDiscoveryTimeout      => 10,
    MeshconfHwmpActivePathTimeout    => 11,
    MeshconfHwmpPreqMinInterval      => 12,
    MeshconfHwmpNetDiamTrvsTime      => 13,
    MeshconfHwmpRootmode             => 14,
    MeshconfElementTtl               => 15,
    MeshconfHwmpRannInterval         => 16,
    MeshconfGateAnnouncements        => 17,
    MeshconfHwmpPerrMinInterval      => 18,
    MeshconfForwarding               => 19,
    MeshconfRssiThreshold            => 20,
    MeshconfSyncOffsetMaxNeighbor    => 21,
    MeshconfHtOpmode                 => 22,
    MeshconfHwmpPathToRootTimeout    => 23,
    MeshconfHwmpRootInterval         => 24,
    MeshconfHwmpConfirmationInterval => 25,
    MeshconfPowerMode                => 26,
    MeshconfAwakeWindow              => 27,
    MeshconfPlinkTimeout             => 28,
    MeshconfAttrAfterLast            => 29,
    MeshconfAttrMax                  => 28
);

impl_var!(
    /// nl80211MeshSetupParams
    ///
    /// Enumeration from nl80211/nl80211.h:3397
    Nl80211MeshSetupParams, u16,
    MeshSetupInvalid             => 0,
    MeshSetupEnableVendorPathSel => 1,
    MeshSetupEnableVendorMetric  => 2,
    MeshSetupIe                  => 3,
    MeshSetupUserspaceAuth       => 4,
    MeshSetupUserspaceAmpe       => 5,
    MeshSetupEnableVendorSync    => 6,
    MeshSetupUserspaceMpm        => 7,
    MeshSetupAuthProtocol        => 8,
    MeshSetupAttrAfterLast       => 9,
    MeshSetupAttrMax             => 8
);

impl_var!(
    /// nl80211TxqAttr
    ///
    /// Enumeration from nl80211/nl80211.h:3427
    Nl80211TxqAttr, u16,
    TxqAttrInvalid   => 0,
    TxqAttrAc        => 1,
    TxqAttrTxop      => 2,
    TxqAttrCwmin     => 3,
    TxqAttrCwmax     => 4,
    TxqAttrAifs      => 5,
    TxqAttrAfterLast => 6,
    TxqAttrMax       => 5
);

impl_var!(
    /// nl80211Ac
    ///
    /// Enumeration from nl80211/nl80211.h:3440
    Nl80211Ac, u16,
    AcVo   => 0,
    AcVi   => 1,
    AcBe   => 2,
    AcBk   => 3,
    NumAcs => 4
);

impl_var!(
    /// nl80211ChannelType
    ///
    /// Enumeration from nl80211/nl80211.h:3464
    Nl80211ChannelType, u16,
    ChanNoHt      => 0,
    ChanHt20      => 1,
    ChanHt40minus => 2,
    ChanHt40plus  => 3
);

impl_var!(
    /// nl80211ChanWidth
    ///
    /// Enumeration from nl80211/nl80211.h:3490
    Nl80211ChanWidth, u16,
    ChanWidth20Noht => 0,
    ChanWidth20     => 1,
    ChanWidth40     => 2,
    ChanWidth80     => 3,
    ChanWidth80p80  => 4,
    ChanWidth160    => 5,
    ChanWidth5      => 6,
    ChanWidth10     => 7
);

impl_var!(
    /// nl80211BssScanWidth
    ///
    /// Enumeration from nl80211/nl80211.h:3510
    Nl80211BssScanWidth, u16,
    BssChanWidth20 => 0,
    BssChanWidth10 => 1,
    BssChanWidth5  => 2
);

impl_var!(
    /// nl80211Bss
    ///
    /// Enumeration from nl80211/nl80211.h:3565
    Nl80211Bss, u16,
    BssInvalid             => 0,
    BssBssid               => 1,
    BssFrequency           => 2,
    BssTsf                 => 3,
    BssBeaconInterval      => 4,
    BssCapability          => 5,
    BssInformationElements => 6,
    BssSignalMbm           => 7,
    BssSignalUnspec        => 8,
    BssStatus              => 9,
    BssSeenMsAgo           => 10,
    BssBeaconIes           => 11,
    BssChanWidth           => 12,
    BssBeaconTsf           => 13,
    BssPrespData           => 14,
    BssLastSeenBoottime    => 15,
    BssPad                 => 16,
    BssParentTsf           => 17,
    BssParentBssid         => 18,
    BssAfterLast           => 19,
    BssMax => 18
);

impl_var!(
    /// nl80211BssStatus
    ///
    /// Enumeration from nl80211/nl80211.h:3603
    Nl80211BssStatus, u16,
    BssStatusAuthenticated => 0,
    BssStatusAssociated    => 1,
    BssStatusIbssJoined    => 2
);

impl_var!(
    /// nl80211AuthType
    ///
    /// Enumeration from nl80211/nl80211.h:3623
    Nl80211AuthType, u16,
    AuthtypeOpenSystem => 0,
    AuthtypeSharedKey  => 1,
    AuthtypeFt         => 2,
    AuthtypeNetworkEap => 3,
    AuthtypeSae        => 4,
    AuthtypeNum        => 5,
    AuthtypeMax        => 4,
    AuthtypeAutomatic  => 5
);

impl_var!(
    /// nl80211KeyType
    ///
    /// Enumeration from nl80211/nl80211.h:3643
    Nl80211KeyType, u16,
    KeytypeGroup    => 0,
    KeytypePairwise => 1,
    KeytypePeerkey  => 2,
    NumKeytypes     => 3
);

impl_var!(
    /// nl80211Mfp
    ///
    /// Enumeration from nl80211/nl80211.h:3656
    Nl80211Mfp, u16,
    MfpNo       => 0,
    MfpRequired => 1
);

impl_var!(
    /// nl80211WpaVersions
    ///
    /// Enumeration from nl80211/nl80211.h:3661
    Nl80211WpaVersions, u16,
    WpaVersion1 => 1 << 0,
    WpaVersion2 => 1 << 1
);

impl_var!(
    /// nl80211KeyDefaultTypes
    ///
    /// Enumeration from nl80211/nl80211.h:3675
    Nl80211KeyDefaultTypes, u16,
    KeyDefaultTypeInvalid   => 0,
    KeyDefaultTypeUnicast   => 1,
    KeyDefaultTypeMulticast => 2,
    NumKeyDefaultTypes      => 3
);

impl_var!(
    /// nl80211KeyAttributes
    ///
    /// Enumeration from nl80211/nl80211.h:3705
    Nl80211KeyAttributes, u16,
    KeyInvalid      => 0,
    KeyData         => 1,
    KeyIdx          => 2,
    KeyCipher       => 3,
    KeySeq          => 4,
    KeyDefault      => 5,
    KeyDefaultMgmt  => 6,
    KeyType         => 7,
    KeyDefaultTypes => 8,
    KeyAfterLast    => 9,
    KeyMax          => 8
);

impl_var!(
    /// nl80211TxRateAttributes
    ///
    /// Enumeration from nl80211/nl80211.h:3736
    Nl80211TxRateAttributes, u16,
    TxrateInvalid   => 0,
    TxrateLegacy    => 1,
    TxrateHt        => 2,
    TxrateVht       => 3,
    TxrateGi        => 4,
    TxrateAfterLast => 5,
    TxrateMax       => 4
);

impl_var!(
    /// nl80211TxrateGi
    ///
    /// Enumeration from nl80211/nl80211.h:3759
    Nl80211TxrateGi, u16,
    TxrateDefaultGi => 0,
    TxrateForceSgi  => 1,
    TxrateForceLgi  => 2
);

impl_var!(
    /// nl80211Band
    ///
    /// Enumeration from nl80211/nl80211.h:3773
    Nl80211Bandc, u16,
    Band2ghz  => 0,
    Band5ghz  => 1,
    Band60ghz => 2,
    NumBands  => 3
);

impl_var!(
    /// nl80211PsState
    ///
    /// Enumeration from nl80211/nl80211.h:3786
    Nl80211PsState, u16,
    PsDisabled => 0,
    PsEnabled  => 1
);

impl_var!(
    /// nl80211AttrCqm
    ///
    /// Enumeration from nl80211/nl80211.h:3819
    Nl80211AttrCqm, u16,
    AttrCqmInvalid            => 0,
    AttrCqmRssiThold          => 1,
    AttrCqmRssiHyst           => 2,
    AttrCqmRssiThresholdEvent => 3,
    AttrCqmPktLossEvent       => 4,
    AttrCqmTxeRate            => 5,
    AttrCqmTxePkts            => 6,
    AttrCqmTxeIntvl           => 7,
    AttrCqmBeaconLossEvent    => 8,
    AttrCqmAfterLast          => 9,
    AttrCqmMax                => 8
);

impl_var!(
    /// nl80211CqmRssiThresholdEvent
    ///
    /// Enumeration from nl80211/nl80211.h:3843
    Nl80211CqmRssiThresholdEvent, u16,
    CqmRssiThresholdEventLow  => 0,
    CqmRssiThresholdEventHigh => 1,
    CqmRssiBeaconLossEvent    => 2
);

impl_var!(
    /// nl80211TxPowerSetting
    ///
    /// Enumeration from nl80211/nl80211.h:3856
    Nl80211TxPowerSetting, u16,
    TxPowerAutomatic => 0,
    TxPowerLimited   => 1,
    TxPowerFixed     => 2
);

impl_var!(
    /// nl80211PacketPatternAttr
    ///
    /// Enumeration from nl80211/nl80211.h:3883
    Nl80211PacketPatternAttr, u16,
    PktpatInvalid => 0,
    PktpatMask    => 1,
    PktpatPattern => 2,
    PktpatOffset  => 3,
    NumPktpat     => 4,
    MaxPktpat     => 3
);

impl_var!(
    /// nl80211WowlanTriggers
    ///
    /// Enumeration from nl80211/nl80211.h:4011
    Nl80211WowlanTriggers, u16,
    WowlanTrigInvalid               => 0,
    WowlanTrigAny                   => 1,
    WowlanTrigDisconnect            => 2,
    WowlanTrigMagicPkt              => 3,
    WowlanTrigPktPattern            => 4,
    WowlanTrigGtkRekeySupported     => 5,
    WowlanTrigGtkRekeyFailure       => 6,
    WowlanTrigEapIdentRequest       => 7,
    WowlanTrig4wayHandshake         => 8,
    WowlanTrigRfkillRelease         => 9,
    WowlanTrigWakeupPkt80211        => 10,
    WowlanTrigWakeupPkt80211Len     => 11,
    WowlanTrigWakeupPkt8023         => 12,
    WowlanTrigWakeupPkt8023Len      => 13,
    WowlanTrigTcpConnection         => 14,
    WowlanTrigWakeupTcpMatch        => 15,
    WowlanTrigWakeupTcpConnlost     => 16,
    WowlanTrigWakeupTcpNomoretokens => 17,
    WowlanTrigNetDetect             => 18,
    WowlanTrigNetDetectResults      => 19,
    NumWowlanTrig                   => 20,
    MaxWowlanTrig                   => 19
);

impl_var!(
    /// nl80211WowlanTcpAttrs
    ///
    /// Enumeration from nl80211/nl80211.h:4129
    Nl80211WowlanTcpAttrs, u16,
    WowlanTcpInvalid          => 0,
    WowlanTcpSrcIpv4          => 1,
    WowlanTcpDstIpv4          => 2,
    WowlanTcpDstMac           => 3,
    WowlanTcpSrcPort          => 4,
    WowlanTcpDstPort          => 5,
    WowlanTcpDataPayload      => 6,
    WowlanTcpDataPayloadSeq   => 7,
    WowlanTcpDataPayloadToken => 8,
    WowlanTcpDataInterval     => 9,
    WowlanTcpWakePayload      => 10,
    WowlanTcpWakeMask         => 11,
    NumWowlanTcp              => 12,
    MaxWowlanTcp              => 11
);

impl_var!(
    /// nl80211AttrCoalesceRule
    ///
    /// Enumeration from nl80211/nl80211.h:4174
    Nl80211AttrCoalesceRule, u16,
    CoalesceRuleInvalid        => 0,
    AttrCoalesceRuleDelay      => 1,
    AttrCoalesceRuleCondition  => 2,
    AttrCoalesceRulePktPattern => 3,
    NumAttrCoalesceRule        => 4,
    AttrCoalesceRuleMax        => 3
);

impl_var!(
    /// nl80211CoalesceCondition
    ///
    /// Enumeration from nl80211/nl80211.h:4192
    Nl80211CoalesceCondition, u16,
    CoalesceConditionMatch   => 0,
    CoalesceConditionNoMatch => 1
);

impl_var!(
    /// nl80211IfaceLimitAttrs
    ///
    /// Enumeration from nl80211/nl80211.h:4207
    Nl80211IfaceLimitAttrs, u16,
    IfaceLimitUnspec => 0,
    IfaceLimitMax    => 1,
    IfaceLimitTypes  => 2,
    NumIfaceLimit    => 3,
    MaxIfaceLimit    => 2
);

impl_var!(
    /// nl80211IfCombinationAttrs
    ///
    /// Enumeration from nl80211/nl80211.h:4263
    Nl80211IfCombinationAttrs, u16,
    IfaceCombUnspec             => 0,
    IfaceCombLimits             => 1,
    IfaceCombMaxnum             => 2,
    IfaceCombStaApBiMatch       => 3,
    IfaceCombNumChannels        => 4,
    IfaceCombRadarDetectWidths  => 5,
    IfaceCombRadarDetectRegions => 6,
    NumIfaceComb                => 7,
    MaxIfaceComb                => 6
);

impl_var!(
    /// nl80211PlinkState
    ///
    /// Enumeration from nl80211/nl80211.h:4296
    Nl80211PlinkState, u16,
    PlinkListen    => 0,
    PlinkOpnSnt    => 1,
    PlinkOpnRcvd   => 2,
    PlinkCnfRcvd   => 3,
    PlinkEstab     => 4,
    PlinkHolding   => 5,
    PlinkBlocked   => 6,
    NumPlinkStates => 7,
    MaxPlinkStates => 6
);

impl_var!(
    /// plinkActions
    ///
    /// Enumeration from nl80211/nl80211.h:4318
    PlinkActions, u16,
    PlinkActionNoAction => 0,
    PlinkActionOpen     => 1,
    PlinkActionBlock    => 2,
    NumPlinkActions     => 3
);

impl_var!(
    /// nl80211RekeyData
    ///
    /// Enumeration from nl80211/nl80211.h:4340
    Nl80211RekeyData, u16,
    RekeyDataInvalid   => 0,
    RekeyDataKek       => 1,
    RekeyDataKck       => 2,
    RekeyDataReplayCtr => 3,
    NumRekeyData       => 4,
    MaxRekeyData       => 3
);

impl_var!(
    /// nl80211HiddenSsid
    ///
    /// Enumeration from nl80211/nl80211.h:4360
    Nl80211HiddenSsid, u16,
    HiddenSsidNotInUse     => 0,
    HiddenSsidZeroLen      => 1,
    HiddenSsidZeroContents => 2
);

impl_var!(
    /// nl80211StaWmeAttr
    ///
    /// Enumeration from nl80211/nl80211.h:4376
    Nl80211StaWmeAttr, u16,
    StaWmeInvalid     => 0,
    StaWmeUapsdQueues => 1,
    StaWmeMaxSp       => 2,
    StaWmeAfterLast   => 3,
    StaWmeMax         => 2
);

impl_var!(
    /// nl80211PmksaCandidateAttr
    ///
    /// Enumeration from nl80211/nl80211.h:4398
    Nl80211PmksaCandidateAttr, u16,
    PmksaCandidateInvalid => 0,
    PmksaCandidateIndex   => 1,
    PmksaCandidateBssid   => 2,
    PmksaCandidatePreauth => 3,
    NumPmksaCandidate     => 4,
    MaxPmksaCandidate     => 3
);

impl_var!(
    /// nl80211TdlsOperation
    ///
    /// Enumeration from nl80211/nl80211.h:4417
    Nl80211TdlsOperation, u16,
    TdlsDiscoveryReq => 0,
    TdlsSetup        => 1,
    TdlsTeardown     => 2,
    TdlsEnableLink   => 3,
    TdlsDisableLink  => 4
);

impl_var!(
    /// nl80211FeatureFlags
    ///
    /// Enumeration from nl80211/nl80211.h:4526
    Nl80211FeatureFlags, u16,
    FeatureSkTxStatus                => 1 << 0,
    FeatureHtIbss                    => 1 << 1,
    FeatureInactivityTimer           => 1 << 2,
    FeatureCellBaseRegHints          => 1 << 3,
    FeatureP2pDeviceNeedsChannel     => 1 << 4,
    FeatureSae                       => 1 << 5,
    FeatureLowPriorityScan           => 1 << 6,
    FeatureScanFlush                 => 1 << 7,
    FeatureApScan                    => 1 << 8,
    FeatureVifTxpower                => 1 << 9,
    FeatureNeedObssScan              => 1 << 10,
    FeatureP2pGoCtwin                => 1 << 11,
    FeatureP2pGoOppps                => 1 << 12,
    FeatureAdvertiseChanLimits       => 1 << 14,
    FeatureFullApClientState         => 1 << 15
    // FeatureUserspaceMpm           => 1 << 16,
    // FeatureActiveMonitor          => 1 << 17,
    // FeatureApModeChanWidthChange  => 1 << 18,
    // FeatureDsParamSetIeInProbes   => 1 << 19,
    // FeatureWfaTpcIeInProbes       => 1 << 20,
    // FeatureQuiet                  => 1 << 21,
    // FeatureTxPowerInsertion       => 1 << 22,
    // FeatureAcktoEstimation        => 1 << 23,
    // FeatureStaticSmps             => 1 << 24,
    // FeatureDynamicSmps            => 1 << 25,
    // FeatureSupportsWmmAdmission   => 1 << 26,
    // FeatureMacOnCreate            => 1 << 27,
    // FeatureTdlsChannelSwitch      => 1 << 28,
    // FeatureScanRandomMacAddr      => 1 << 29,
    // FeatureSchedScanRandomMacAddr => 1 << 30,
    // FeatureNdRandomMacAddr        => 1 << 31
);

impl_var!(
    /// nl80211ExtFeatureIndex
    ///
    /// Enumeration from nl80211/nl80211.h:4595
    Nl80211ExtFeatureIndex, u16,
    ExtFeatureVhtIbss          => 0,
    ExtFeatureRrm              => 1,
    ExtFeatureMuMimoAirSniffer => 2,
    ExtFeatureScanStartTime    => 3,
    ExtFeatureBssParentTsf     => 4,
    ExtFeatureSetScanDwell     => 5,
    ExtFeatureBeaconRateLegacy => 6,
    ExtFeatureBeaconRateHt     => 7,
    ExtFeatureBeaconRateVht    => 8,
    NumExtFeatures             => 9,
    MaxExtFeatures             => 8
);

impl_var!(
    /// nl80211ProbeRespOffloadSupportAttr
    ///
    /// Enumeration from nl80211/nl80211.h:4625
    Nl80211ProbeRespOffloadSupportAttr, u16,
    ProbeRespOffloadSupportWps    => 1 << 0,
    ProbeRespOffloadSupportWps2   => 1 << 1,
    ProbeRespOffloadSupportP2p    => 1 << 2,
    ProbeRespOffloadSupport80211u => 1 << 3
);

impl_var!(
    /// nl80211ConnectFailedReason
    ///
    /// Enumeration from nl80211/nl80211.h:4638
    Nl80211ConnectFailedReason, u16,
    ConnFailMaxClients    => 0,
    ConnFailBlockedClient => 1
);

impl_var!(
    /// nl80211ScanFlags
    ///
    /// Enumeration from nl80211/nl80211.h:4667
    Nl80211ScanFlags, u16,
    ScanFlagLowPriority => 1 << 0,
    ScanFlagFlush       => 1 << 1,
    ScanFlagAp          => 1 << 2,
    ScanFlagRandomAddr  => 1 << 3
);

impl_var!(
    /// nl80211AclPolicy
    ///
    /// Enumeration from nl80211/nl80211.h:4687
    Nl80211AclPolicy, u16,
    AclPolicyAcceptUnlessListed => 0,
    AclPolicyDenyUnlessListed   => 1
);

impl_var!(
    /// nl80211SmpsMode
    ///
    /// Enumeration from nl80211/nl80211.h:4702
    Nl80211SmpsMode, u16,
    SmpsOff       => 0,
    SmpsStatic    => 1,
    SmpsDynamic   => 2,
    SmpsAfterLast => 3,
    SmpsMax       => 2
);

impl_var!(
    /// nl80211RadarEvent
    ///
    /// Enumeration from nl80211/nl80211.h:4726
    Nl80211RadarEvent, u16,
    RadarDetected    => 0,
    RadarCacFinished => 1,
    RadarCacAborted  => 2,
    RadarNopFinished => 3
);

impl_var!(
    /// nl80211DfsState
    ///
    /// Enumeration from nl80211/nl80211.h:4744
    Nl80211DfsState, u16,
    DfsUsable      => 0,
    DfsUnavailable => 1,
    DfsAvailable   => 2
);

impl_var!(
    /// nl80211ProtocolFeatures
    ///
    /// Enumeration from nl80211/nl80211.h:4758
    Nl80211ProtocolFeatures, u16,
    ProtocolFeatureSplitWiphyDump => 1 << 0
);

impl_var!(
    /// nl80211CritProtoId
    ///
    /// Enumeration from nl80211/nl80211.h:4771
    Nl80211CritProtoId, u16,
    CritProtoUnspec => 0,
    CritProtoDhcp   => 1,
    CritProtoEapol  => 2,
    CritProtoApipa  => 3,
    NumCritProto    => 4
);

impl_var!(
    /// nl80211RxmgmtFlags
    ///
    /// Enumeration from nl80211/nl80211.h:4790
    Nl80211RxmgmtFlags, u16,
    RxmgmtFlagAnswered => 1 << 0
);

impl_var!(
    /// nl80211TdlsPeerCapability
    ///
    /// Enumeration from nl80211/nl80211.h:4824
    Nl80211TdlsPeerCapability, u16,
    TdlsPeerHt  => 1 << 0,
    TdlsPeerVht => 1 << 1,
    TdlsPeerWmm => 1 << 2
);

impl_var!(
    /// nl80211SchedScanPlan
    ///
    /// Enumeration from nl80211/nl80211.h:4843
    Nl80211SchedScanPlan, u16,
    SchedScanPlanInvalid    => 0,
    SchedScanPlanInterval   => 1,
    SchedScanPlanIterations => 2,
    SchedScanPlanAfterLast  => 3,
    SchedScanPlanMax        => 2
);

impl_var!(
    /// nl80211BssSelectAttr
    ///
    /// Enumeration from nl80211/nl80211.h:4887
    Nl80211BssSelectAttr, u16,
    BssSelectAttrInvalid    => 0,
    BssSelectAttrRssi       => 1,
    BssSelectAttrBandPref   => 2,
    BssSelectAttrRssiAdjust => 3,
    BssSelectAttrAfterLast  => 4,
    BssSelectAttrMax        => 3
);

impl_var!(
    /// nl80211NanDualBandConf
    ///
    /// Enumeration from nl80211/nl80211.h:4907
    Nl80211NanDualBandConf, u16,
    NanBandDefault => 1 << 0,
    NanBand2ghz    => 1 << 1,
    NanBand5ghz    => 1 << 2
);

impl_var!(
    /// nl80211NanFunctionType
    ///
    /// Enumeration from nl80211/nl80211.h:4922
    Nl80211NanFunctionType, u16,
    NanFuncPublish       => 0,
    NanFuncSubscribe     => 1,
    NanFuncFollowUp      => 2,
    NanFuncTypeAfterLast => 3,
    NanFuncMaxType       => 2
);

impl_var!(
    /// nl80211NanPublishType
    ///
    /// Enumeration from nl80211/nl80211.h:4940
    Nl80211NanPublishType, u16,
    NanSolicitedPublish   => 1 << 0,
    NanUnsolicitedPublish => 1 << 1
);

impl_var!(
    /// nl80211NanFuncTermReason
    ///
    /// Enumeration from nl80211/nl80211.h:4954
    Nl80211NanFuncTermReason, u16,
    NanFuncTermReasonUserRequest => 0,
    NanFuncTermReasonTtlExpired  => 1,
    NanFuncTermReasonError       => 2
);

impl_var!(
    /// nl80211NanFuncAttributes
    ///
    /// Enumeration from nl80211/nl80211.h:5006
    Nl80211NanFuncAttributes, u16,
    NanFuncInvalid         => 0,
    NanFuncType            => 1,
    NanFuncServiceId       => 2,
    NanFuncPublishType     => 3,
    NanFuncPublishBcast    => 4,
    NanFuncSubscribeActive => 5,
    NanFuncFollowUpId      => 6,
    NanFuncFollowUpReqId   => 7,
    NanFuncFollowUpDest    => 8,
    NanFuncCloseRange      => 9,
    NanFuncTtl             => 10,
    NanFuncServiceInfo     => 11,
    NanFuncSrf             => 12,
    NanFuncRxMatchFilter   => 13,
    NanFuncTxMatchFilter   => 14,
    NanFuncInstanceId      => 15,
    NanFuncTermReason      => 16,
    NumNanFuncAttr         => 17,
    NanFuncAttrMax         => 16
);

impl_var!(
    /// nl80211NanSrfAttributes
    ///
    /// Enumeration from nl80211/nl80211.h:5045
    Nl80211NanSrfAttributes, u16,
    NanSrfInvalid   => 0,
    NanSrfInclude   => 1,
    NanSrfBf        => 2,
    NanSrfBfIdx     => 3,
    NanSrfMacAddrs  => 4,
    NumNanSrfAttr   => 5,
    NanSrfAttrMax   => 4
);

impl_var!(
    /// nl80211NanMatchAttributes
    ///
    /// Enumeration from nl80211/nl80211.h:5070
    Nl80211NanMatchAttributes, u16,
    NanMatchInvalid   => 0,
    NanMatchFuncLocal => 1,
    NanMatchFuncPeer  => 2,
    NumNanMatchAttr   => 3,
    NanMatchAttrMax   => 2
);

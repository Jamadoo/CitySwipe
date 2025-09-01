unit CitySwipe_u;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes,
  System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.Edit,
  FMX.Controls.Presentation, FMX.StdCtrls, FMX.Effects, FMX.Objects,
  FMX.Layouts,
  FMX.TabControl, FMX.ImgList, System.ImageList, FMX.Ani, System.IOUtils,
  dmDataComponents_u, System.Sensors, System.Sensors.Components,
  FMX.DialogService, Coordinate_u, GoogleMaps_u,
  FireDAC.Phys.SQLiteWrapper.Stat, GoogleMapClass_u,
  System.Generics.Collections, System.Threading, FMX.Filter.Effects,
  FMX.Platform, VibrateHelper_u, Deepseek, Deepseek.Types,
  JSON, JsonRead_u, FMX.Memo.Types, FMX.ScrollBox, FMX.Memo,
  System.Net.HttpClient, System.Net.URLClient, System.Net.HttpClientComponent,
  System.NetEncoding, Math, Rest.JSON, System.Generics.Defaults, FMX.TextLayout,
  URLLauncher_u, System.JSON.Serializers, System.StrUtils, System.DateUtils, frmGroupCreation_u;

type
  TfrmCitySwipe = class(TForm)
    StyleBook1: TStyleBook;
    pcTabs: TTabControl;
    tbNewTrip: TTabItem;
    imgBackground: TImage;
    recTop: TRectangle;
    recCitySelector: TRectangle;
    imgSelectorIcon: TImage;
    edtCitySelector: TEdit;
    ShadowEffect1: TShadowEffect;
    recDistanceSelector: TRectangle;
    edtMaxDistance: TLabel;
    trkDistanceSlider: TTrackBar;
    lblDistance: TLabel;
    btnNewTrip: TLayout;
    imgNewTripIcon: TImage;
    lblNewTripText: TLabel;
    bntExplore: TLayout;
    imgExploreIcon: TImage;
    lblExploreTab: TLabel;
    btnPreviousTrips: TLayout;
    imgPreviousTripsIcon: TImage;
    lblPreviousTrips: TLabel;
    btnGroups: TLayout;
    imgGroupsIcon: TImage;
    lblGroupsText: TLabel;
    rcBackground: TRectangle;
    ShadowEffect2: TShadowEffect;
    pcScreens: TTabControl;
    tbStepOne: TTabItem;
    lay1Background: TLayout;
    layButton: TLayout;
    btnNextQeustion: TButton;
    lblNewTripSub: TLabel;
    lblNewTripTitle: TLabel;
    ShadowEffect3: TShadowEffect;
    layOptions: TFlowLayout;
    recOptionOne: TRectangle;
    lblOptionOne: TLabel;
    lblStepOne: TLabel;
    tbStepTwo: TTabItem;
    lay2Background: TLayout;
    recOptionTwo: TRectangle;
    layOptionTwoButton: TLayout;
    btn2Next: TButton;
    layOptionTwoOptions: TFlowLayout;
    rec2OptionOne: TRectangle;
    lblTwoOptionOne: TLabel;
    rec2OptionTwo: TRectangle;
    lbl2OptionTwo: TLabel;
    lblOptionTwoTitle: TLabel;
    lblOptionTwoText: TLabel;
    ShadowEffect4: TShadowEffect;
    rec2OptionThree: TRectangle;
    lbl2OptionThree: TLabel;
    tbStepThree: TTabItem;
    lay3Background: TLayout;
    rc3Background: TRectangle;
    lbl3Title: TLabel;
    lbl3Question: TLabel;
    ShadowEffect5: TShadowEffect;
    trkActivityCount: TTrackBar;
    lay3QuestionOne: TLayout;
    lblActivityCount: TLabel;
    lay3QeustionTwo: TLayout;
    trkBugetPerPerson: TTrackBar;
    lblBugetPerPerson: TLabel;
    lbl3QeustionTwo: TLabel;
    tbStepFour: TTabItem;
    lay4Background: TLayout;
    rec4Background: TRectangle;
    layLunchOptions: TFlowLayout;
    recLunchSkip: TRectangle;
    lblLunchSkip: TLabel;
    lbl4Title: TLabel;
    lblLunchQeustion: TLabel;
    ShadowEffect6: TShadowEffect;
    recLunchSnack: TRectangle;
    lblLunchSnack: TLabel;
    lbl4MainQuestion: TLabel;
    layBreakfastOptions: TFlowLayout;
    recBreakfastSkip: TRectangle;
    lblBreakfastSkip: TLabel;
    recBreakfastSnack: TRectangle;
    lblBreakfastSnack: TLabel;
    lblBreakfast: TLabel;
    layDinnerOptions: TFlowLayout;
    recDinnerSkip: TRectangle;
    lblDinnerSkip: TLabel;
    recDinnerSnack: TRectangle;
    lblDinnerSnack: TLabel;
    lblDinner: TLabel;
    tbSwipeScreen: TTabItem;
    laySwipeBackground: TLayout;
    layCards: TLayout;
    laySwipeButtons: TLayout;
    recNoButton: TRectangle;
    imgNoIcon: TImage;
    btnOpenLink: TRectangle;
    imgOpenLink: TImage;
    recYesButton: TRectangle;
    imgYesIcon: TImage;
    recBack: TRectangle;
    recback2: TRectangle;
    layBubbles: TFlowLayout;
    lblPrice: TLabel;
    lblCaption: TLabel;
    lblLocation: TLabel;
    lblPlaceTitle: TLabel;
    recPlaceDetails: TRectangle;
    tbFinalPlan: TTabItem;
    layFinalBackground: TLayout;
    recFinalBackground: TRectangle;
    pcCatagories: TTabControl;
    layTabButtons: TFlowLayout;
    recActivites: TRectangle;
    ShadowEffect7: TShadowEffect;
    lblActivites: TLabel;
    recResturants: TRectangle;
    lblResturants: TLabel;
    ShadowEffect8: TShadowEffect;
    tbActivites: TTabItem;
    recBudgetSummary: TRectangle;
    lblBudgetSummary: TLabel;
    imgPriceIcon: TImage;
    scrAcivityItems: TScrollBox;
    recPlaceTemplate: TRectangle;
    imgPlaceImage: TImage;
    layDetails: TLayout;
    lblTitle: TLabel;
    lblBubbleText: TLabel;
    recBubbleBackground: TRectangle;
    layBubbleTemplate: TLayout;
    layInfo: TFlowLayout;
    Layout1: TLayout;
    Rectangle3: TRectangle;
    Image2: TImage;
    lblPlaceDistance: TLabel;
    Layout3: TLayout;
    Rectangle5: TRectangle;
    Image3: TImage;
    lblPlacePrice: TLabel;
    layPlaceButtons: TLayout;
    recOpenMap: TRectangle;
    ShadowEffect9: TShadowEffect;
    lblOpenMap: TLabel;
    ShadowEffect10: TShadowEffect;
    ShadowEffect11: TShadowEffect;
    recChangeActivity: TRectangle;
    ShadowEffect13: TShadowEffect;
    lblChangeActivity: TLabel;
    layOpenTimes: TLayout;
    imgOpenTimes: TImage;
    lblOpenTimes: TLabel;
    tbResturants: TTabItem;
    scrResturantItems: TScrollBox;
    tbLoading: TTabItem;
    layLoading: TLayout;
    lblLoading: TLabel;
    recLoadingBase: TRectangle;
    recLoadingBar: TRectangle;
    aniLoadingTrip: TFloatAnimation;
    locLocationSensor: TLocationSensor;
    recPopup: TRectangle;
    recPopupFade: TRectangle;
    recPopupContents: TRectangle;
    imgReusedIcons: TImageList;
    imgPopupIcon: TGlyph;
    lblPopupTitle: TLabel;
    lblPopupSubtitle: TLabel;
    btnClosePopup: TRectangle;
    lblClosePopup: TLabel;
    recAutocomplete: TRectangle;
    scrlAutocomplete: TScrollBox;
    imgLoadingAuto: TImage;
    aniLoadingSpin: TFloatAnimation;
    tmrCitySelectorDropdown: TTimer;
    lblCitySelectorPlace: TLabel;
    recSuggestion1: TRectangle;
    Label2: TLabel;
    recSuggestion6: TRectangle;
    Label3: TLabel;
    recSuggestion7: TRectangle;
    Label4: TLabel;
    recSuggestion8: TRectangle;
    Label5: TLabel;
    recSuggestion9: TRectangle;
    Label6: TLabel;
    recSuggestion2: TRectangle;
    Label7: TLabel;
    recSuggestion3: TRectangle;
    Label8: TLabel;
    recSuggestion4: TRectangle;
    Label9: TLabel;
    recSuggestion5: TRectangle;
    Label10: TLabel;
    lblNoResults: TLabel;
    transTabFade: TFadeTransitionEffect;
    aniTabFade: TFloatAnimation;
    aniLoadingSize: TFloatKeyAnimation;
    lblTripStatus: TLabel;
    layMainCard: TLayout;
    imgCardSwipe: TImage;
    aniDragCardOp: TFloatAnimation;
    aniDragCardRot: TFloatAnimation;
    aniDragCardPosX: TFloatAnimation;
    aniDragCardPosY: TFloatAnimation;
    aniMainPosY: TFloatAnimation;
    aniMainRotation: TFloatAnimation;
    aniMainOp: TFloatAnimation;
    recBreakfastMeal: TRectangle;
    Label11: TLabel;
    recLunchMeal: TRectangle;
    Label12: TLabel;
    recDinnerMeal: TRectangle;
    Label13: TLabel;
    lblSubTitlePrice: TLabel;
    aniHideText: TFloatAnimation;
    aniShowText: TFloatAnimation;
    recDarkenCard: TRectangle;
    aniDarkenCard: TFloatAnimation;
    aniLightenCard: TFloatAnimation;
    lblPlaceType: TLabel;
    ShadowEffect12: TShadowEffect;
    imgIcon: TGlyph;
    imgBubbleIcons: TImageList;
    imgMainCard: TImage;
    btn2Back: TButton;
    Layout2: TLayout;
    Button1: TButton;
    Button2: TButton;
    Layout4: TLayout;
    Button3: TButton;
    Button4: TButton;
    laySaveAndClose: TLayout;
    btnSaveAndClose: TButton;
    tbPrevious: TTabItem;
    layMainTab1: TLayout;
    layMainTab2: TLayout;
    imgBackground2: TImage;
    recTripTemplate: TRectangle;
    ShadowEffect14: TShadowEffect;
    layTripDetails: TLayout;
    layThreeDots: TLayout;
    btnThreeDots: TImage;
    recTripName: TRectangle;
    lnlTripname: TLabel;
    lblTripSummary: TLabel;
    layDate: TLayout;
    recTripDate: TRectangle;
    lblTripDate: TLabel;
    Image1: TImage;
    btnViewTrip: TRectangle;
    lblViewTrip: TLabel;
    ShadowEffect15: TShadowEffect;
    layMainTabs: TLayout;
    lblNoTrips: TLabel;
    recTripSettings: TRectangle;
    lblDeleteTrip: TLabel;
    lblRenameTrip: TLabel;
    recHitTest: TRectangle;
    tbGroups: TTabItem;
    layBackgroundGroups: TLayout;
    RectAnimation1: TRectAnimation;
    recSelectModelBox: TRectangle;
    btnSwitchModel: TRectangle;
    lblModel: TLabel;
    ShadowEffect16: TShadowEffect;
    scrlPreviousTrips: TVertScrollBox;
    Image4: TImage;
    btnCreateNewGroup: TButton;
    scrlGroups: TVertScrollBox;
    recGroupsTemplate: TRectangle;
    recGroupName: TRectangle;
    lblGroupName: TLabel;
    layGroupButtons: TLayout;
    btnDelete: TImage;
    btnRename: TImage;
    lblTripCount: TLabel;
    btnSwitchGroup: TButton;
    procedure TrackbarSliderChange(Sender: TObject);
    procedure SetupForm(Sender: TObject);
    procedure RequestLocationPremission();
    procedure OnGeocodeDataRecieved(const Address: TCivicAddress);
    procedure NewLocationPulled(Sender: TObject;
      const OldLocation, NewLocation: TLocationCoord2D);
    procedure ShowScreenPopup(iImage: integer; sMainText, sSubText: string;
      bButton: boolean; bDisableVibrate : Boolean = false);
    procedure btnClosePopupClick(Sender: TObject);
    procedure edtCitySelectorTyping(Sender: TObject);
    procedure StartPullCityInfo();
    procedure OnAutoCompleteClick(Sender: TObject);
    function CreateAutocompleteDesign(): TLabel;
    procedure HideAutocomplete(Sender: TObject; var Text: string);
    procedure tmrCitySelectorDropdownTimer(Sender: TObject);
    procedure TrackbarSliderPaint(Sender: TObject; Canvas: TCanvas;
      const ARect: TRectF);
    procedure edtCitySelectorChange(Sender: TObject);
    procedure btnQuestionNext(Sender: TObject);
    procedure recOptionSelect(Sender: TObject);
    procedure SwitchScreenTab(iTabTo: integer; layTabTo: TLayout;
      tcTabControl: TTabControl);
    procedure aniTabFadeFinish(Sender: TObject);
    procedure GetSwipeablePlaces();
    procedure RecievedAiCards(Sender: TObject; Value: TChat);
    procedure DisplayError(Sender: TObject; sError: string);
    procedure SendDeepseekRequest(onProgress: TProc<TObject, TChat>);
    procedure RemoveUserCoordinate();
    procedure FillPlaceCard(objPlace: TAiPlace);
    procedure SwipeCard(objNewPlace: TAiPlace);
    procedure recSwipeButtonClick(Sender: TObject);
    procedure AddImage(sPlaceID: string);
    procedure StartLoadingScreen();
    procedure GetFinalTrip();
    function CreateFinalTripInput(): string;
    procedure RecievedAiTrip(Sender: TObject; Value: TChat);
    procedure CreateTripPlace(objPlace: TAiPlace; scrTab: TScrollBox ; iIndex : integer ; recClone : TRectangle = nil; bShowSwape : boolean = true);
    procedure lblCaptionClick(Sender: TObject);
    procedure btnOpenLinkClick(Sender: TObject);
    procedure ChangeFinalTripTab(Sender: TObject);
    procedure recChangeActivityClick(Sender: TObject);
    procedure GetPlaceObjectsFromPlaceId(arrIds : TList<string> ; out arrPlaces : TList<TAiPlace>);
    procedure ResetMenu();
    procedure btn2BackClick(Sender: TObject);
    procedure btnSaveAndCloseClick(Sender: TObject);
    function ProcessStream(Value : TChat) : boolean;
    procedure ChangeMainMenuTab(Sender: TObject);
    procedure UpdatePreviousTripsUI();
    procedure LoadPreviousTrip(Sender : TObject);
    procedure SelectMainMenuTabButton(ctrlSelected : TControl);
    procedure recHitTestClick(Sender: TObject);
    procedure btnThreeDotsClick(Sender: TObject);
    procedure DeleteTrip(Sender : TObject);
    procedure RenameTrip(Sender : TObject);
    procedure btnSwitchModelClick(Sender: TObject);
    procedure UpdateGroupsUI();
    procedure ClickSwitchProfile(Sender : TObject);
    procedure DeleteGroup(Sender : TObject);
    procedure RenameGroup(Sender : TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnCreateNewGroupClick(Sender: TObject);
    procedure ResetOnClose(Sender: TObject; var Action: TCloseAction);
  private
    gecoGeocoder: TGeocoder;
    objUserCoordinate: TCoordinate;
    objGoogleMaps: TGoogleMaps;
    iPopupOriginalHeight: Single;
    iAutocomIndex, iNextScreen, iDeepseekAttempts, iSwipeIndex,
      iTextOpenCount, iSnackCount, iRestaurantCount: integer;
    arrPredictions: TList<TPlacePrediction>;
    rTimerValue: real;
    bUpdateSuggestions, bCanSelectCity, bOnlyRestaurants, bNextDebounce,
      bSwipeDebounce, bLoadingTrip: boolean;
    dicRadioGroup: TDictionary<integer, string>;
    jsonNewTripSettings: TJsonObject;
    iCurrentGroupId: integer;
    objDeepseek: IDeepseek;
    sPrompt, sAIReponse, sDeepseekAPI, sResponse: string;
    arrSwipePlaces: TList<TAiPlace>;
    arrLiked, arrDisliked, arrHonrableAct, arrHonrableRest, arrFinalAct, arrFinalRest: TList<TAiPlace>;
    dicImages: TDictionary<string, TBitmap>;
    dtAiStart : TDateTime;
    pcWorkingTabControl : TTabControl;
    rTripTotal : Real;
    sDeepseekModel : string;
  const
    sSuperuserPassword = 'Superuser';
    clrSelectedValue: TAlphaColor = $FF1C3759;
    clrUnselectedValue: TAlphaColor = $FF0C1A2C;
    TripAdjectives: array[0..9] of string = (
      'awesome',
      'cool',
      'amazing',
      'unforgettable',
      'epic',
      'fantastic',
      'relaxing',
      'scenic',
      'fun',
      'wild'
    );
  public
  end;

var
  frmCitySwipe: TfrmCitySwipe;

implementation

{$IFDEF ANDROID}

// Only Andriod Devices Support These Uses
uses
  System.Permissions, AndroidApi.Helpers, AndroidApi.Jni.Os;
{$ENDIF}
{$R *.fmx}

/// --- UI Functions --- \\\
procedure TfrmCitySwipe.TrackbarSliderChange(Sender: TObject);
var
  ActiveTrackRect: TRectangle;
  TrackRect: TRectangle;
  trkTrackbar: TTrackBar;
  lblLabel: TLabel;
  sTemplate: string;
begin
  // Get Tracker And Label
  if Sender.ClassType <> TTrackBar then
    exit;
  trkTrackbar := TTrackBar(Sender);
  lblLabel := TLabel(trkTrackbar.TagObject);
  // Set Active Track
  ActiveTrackRect := TRectangle(trkTrackbar.FindStyleResource('activetrack'));
  TrackRect := TRectangle(trkTrackbar.FindStyleResource('hthumb'));
  if (ActiveTrackRect <> nil) and (TrackRect <> nil) and (TrackRect <> nil) then
  begin
    ActiveTrackRect.Width := TrackRect.Position.X + (TrackRect.Width / 4);
  end;
  // Set Text
  if Assigned(lblLabel) then
  begin
    sTemplate := lblLabel.TagString;
    if (trkTrackbar.Value < trkTrackbar.Max) or (trkTrackbar.TagString = '')
    then
      lblLabel.Text := sTemplate.Replace('%', Round(trkTrackbar.Value).ToString)
    else
      lblLabel.Text := trkTrackbar.TagString;
  end;
end;

procedure TfrmCitySwipe.TrackbarSliderPaint(Sender: TObject; Canvas: TCanvas;
  const ARect: TRectF);
begin
  // When Trckbar is Initilized, draw the active track
  TrackbarSliderChange(Sender);
  TTrackBar(Sender).OnPaint := nil;
end;

/// --- Location Methods --- \\\
// Request Location Premission
procedure TfrmCitySwipe.RequestLocationPremission();
var
  PermissionAccessCoarseLocation, PermissionAccessFineLocation: string;
begin
  // Check If On Andriod System
  // Location is Event Driven, next code is under OnGeocodeDataRecieved
{$IFDEF ANDROID}
  // Get Required Premission Values
  PermissionAccessCoarseLocation :=
    JStringToString(TJManifest_permission.JavaClass.ACCESS_COARSE_LOCATION);
  PermissionAccessFineLocation :=
    JStringToString(TJManifest_permission.JavaClass.ACCESS_FINE_LOCATION);

  // Request Premission
  TPermissionsService.DefaultService.RequestPermissions
    (TArray<string>.Create(PermissionAccessCoarseLocation,
    PermissionAccessFineLocation),

    // Fires After The User Grants Or Declines Premmission
    procedure(const APermissions: TClassicStringDynArray;
      const AGrantResults: TClassicPermissionStatusDynArray)
    begin
      // Its just one popup, so if one premission is granted, both is granted
      if AGrantResults[0] = TPermissionStatus.Granted then
        // TLocationSensor is event driven, so i need to enable it and then
        // catch the next time it pulls the location of the user
        locLocationSensor.Active := true
      else
        // or else show a error stating we count get their lcoation
        ShowScreenPopup(1, 'Unable To Get Your GPS Location',
          'We were unable to get your GPS location. Please select the correct city in the city selector at the top of your screen.',
          true);
    end,

  // Fires When The User Requets a Reason For Premissions
  // aka, fires when the user declines one or more premissions
    procedure(const APermissions: TClassicStringDynArray;
      const APostRationaleProc: TProc)
    var
      sMsg: string;
    begin
      sMsg := 'CitySwipe Uses Your Location To Accuratly Find Activities In Your Area. Please Reconsidor Granting CitySwipe Location Premissions';
      TDialogService.ShowMessage(sMsg,
        // Fires when the user closes the popup
        procedure(const AResult: TModalResult)
        begin
          // APostRationaleProc is a build-in function which request premissions again.
          APostRationaleProc;
        end);
    end)
{$ELSE}
  ShowScreenPopup(1, 'Unable To Get Your GPS Location',
    'We were unable to get your GPS location. Please select the correct city in the city selector at the top of your screen.',
    true);
{$ENDIF}
end;

// When Location Data Is Recieved By The GeoCoder
procedure TfrmCitySwipe.OnGeocodeDataRecieved(const Address: TCivicAddress);
var
  sCity, sProvince, sCountry, sStreetAddress, sAreaCode: string;
begin
  // Get CityData
  sCity := Address.SubLocality;
  sProvince := Address.SubAdminArea;
  sCountry := Address.CountryName;
  sStreetAddress := Address.SubThoroughfare + ' ' + Address.Thoroughfare;
  sAreaCode := sStreetAddress + ', ' + sCity + ', ' + sProvince + ', '
    + sCountry;
  // Fill Inputbox
  edtCitySelector.Text := sAreaCode;
  // Update User Location
  if not Assigned(objUserCoordinate) then
  begin
    ShowScreenPopup(1, 'Error',
      'Unable To Create User Coordinate. Please restart your app', false);
    exit;
  end;
  objUserCoordinate.SetCity(sCity);
  objUserCoordinate.fCountry := sCountry;
  objUserCoordinate.fState := sProvince;

  // Pull City Data
  StartPullCityInfo();
end;

// When TLocationSensor Pulls a New Location
procedure TfrmCitySwipe.NewLocationPulled(Sender: TObject;
const OldLocation, NewLocation: TLocationCoord2D);
begin
  // Setup an instance of TGeocoder
  try
    // Assigned -> Check if value is nill
    if not Assigned(gecoGeocoder) then
    begin
      // Check if the device has a GeoCoder
      if Assigned(TGeocoder.Current) then
        gecoGeocoder := TGeocoder.Current.Create;
      // .Create may return nill, ensure no silent errors happened
      if Assigned(gecoGeocoder) then
        gecoGeocoder.OnGeocodeReverse := OnGeocodeDataRecieved;
    end;
  except
    ShowScreenPopup(1, 'Unable To Get Your GPS Location',
      'We were unable to get your GPS location. Please select the correct city in the city selector at the top of your screen.',
      true);
  end;

  // Update User Location
  if not Assigned(objUserCoordinate) then
    objUserCoordinate := TCoordinate.Create(NewLocation.Latitude,
      NewLocation.Longitude);

  // Disable Sensor
  locLocationSensor.Active := false;

  // Pull Address Data From GPS Location
  if Assigned(gecoGeocoder) and not gecoGeocoder.Geocoding then
    gecoGeocoder.GeocodeReverse(NewLocation);
end;

/// --- Other Methods --- \\\
procedure TfrmCitySwipe.RemoveUserCoordinate;
begin
  objUserCoordinate := nil;
end;

/// --- Reused Methods --- \\\
procedure TfrmCitySwipe.ShowScreenPopup(iImage: integer;
sMainText, sSubText: string; bButton: boolean; bDisableVibrate : Boolean = false);
var
  iNewHeight, iMargin: integer;
  bVibrate: boolean;
begin
  // Direct This To The Main Thread (some calls are made in external threads)
  TThread.Synchronize(nil,
    procedure
    begin
      bVibrate := not recPopup.Visible;
      // Set Controls
      btnClosePopup.Visible := bButton;
      lblPopupTitle.Text := sMainText;
      lblPopupSubtitle.Text := sSubText;
      // 0 = Info ; 1 = Error
      imgPopupIcon.ImageIndex := iImage;
      recPopup.Visible := true;
      recPopup.HitTest := true;
      // Recalculates Heights To Use In Calculations
      recPopup.RecalcSize;
      lblPopupTitle.RecalcSize;
      lblPopupSubtitle.RecalcSize;
      // Calc New Height
      iNewHeight := 0;
      iMargin := 20;
      inc(iNewHeight, Round(recPopupContents.Padding.Top));
      inc(iNewHeight, Round(recPopupContents.Padding.Bottom));
      inc(iNewHeight, Round(imgPopupIcon.Height) + iMargin);
      inc(iNewHeight, Round(lblPopupTitle.Height) + iMargin);
      inc(iNewHeight, Round(lblPopupSubtitle.Height));
      if bButton then
        inc(iNewHeight, Round(btnClosePopup.Height));
      recPopupContents.Height := iNewHeight;
      // Center Rec
      recPopupContents.Position.X := (recPopup.Width / 2) -
        (recPopupContents.Width / 2);
      recPopupContents.Position.Y := (recPopup.Height / 2) -
        (recPopupContents.Height / 2);
      // Recalc Height To Update Them In UI
      recPopup.RecalcSize;
      lblPopupTitle.RecalcSize;
      lblPopupSubtitle.RecalcSize;
      // Repaint To Update Text and Images On UI
      recPopup.Repaint;
      imgPopupIcon.Repaint;
      lblPopupTitle.Repaint;
      lblPopupSubtitle.Repaint;
      // Vibrate
      if (bVibrate) and (not bDisableVibrate) then
      begin
        TVibrateHelper.TryVibrate(250);
      end;
    end);
end;

procedure TfrmCitySwipe.StartPullCityInfo();
var
  iRecordCount, iDistance: integer;
  jsonConfig : TJsonObject;
  objPreviousLocation : TCoordinate;
  jsonPreviousLocation : TJsonObject;
begin
  // We Pull the city data only after getting the current city name
  // That way we check if our cities changed from our last visit
  ShowScreenPopup(0, 'Grabbing Your City’s Data',
    'Please Wait While We Talk To Google Maps To Get All The Data We Need. This Might take Up To 60 Seconds',
    false);
  // Update GoogleMapsAPI
  objGoogleMaps.UpdateUserCoordinate(objUserCoordinate);
  // Check If Same City
  // Using a new thread to keep UI updated
  TTask.Run(
    procedure
    begin
      // Get CityInfo Record Count
      with dmDataComponents.qryDatabase do
      begin
        SQL.Text := 'Select * From CityInfo';
        Open();
        iRecordCount := RecordCount;
        Close();
      end;
      // Get Distance Between New Place And Old Place
      jsonConfig := TJsonReader.LoadJSONFromFile(dmDataComponents.sConfigPath);
      iDistance := 0;
      if jsonConfig.TryGetValue<TJsonObject>('PreviousCoordinate', jsonPreviousLocation) then
      begin
        objPreviousLocation := TJson.JsonToObject<TCoordinate>(jsonPreviousLocation);
        iDistance := objGoogleMaps.CalcPlacesDistance(objUserCoordinate, objPreviousLocation);
      end;

      // If (objUserCoordinate exsists) and (Theres no citydata, in a new city or user moved 50 km)
      if (Assigned(objUserCoordinate)) and (
        (iRecordCount <= 0) or (not objGoogleMaps.IsSameCity(objUserCoordinate.GetCityAddress)) or (iDistance > 50)
        ) then
      begin
        // Pull City Info
        objGoogleMaps.PullCityData();
      end
      else
      begin
        // Just Update The Distances
        ShowScreenPopup(0, 'Updating Distances',
          'Holdon While We Update Your Distance From Everything', false);
        objGoogleMaps.RecalculateDistances();
      end;
    end);
end;

function TfrmCitySwipe.CreateAutocompleteDesign(): TLabel;
var
  recAutocompleteTemp: TRectangle;
  lblCityName: TLabel;
begin
  // Create the rectangle
  recAutocompleteTemp := TRectangle.Create(nil);
  with recAutocompleteTemp do
  begin
    Align := TAlignLayout.Top;
    Fill.Color := $FF0C1A2C;
    Padding.Left := 12;
    Padding.Right := 12;
    Margins.Bottom := 8;
    Size.PlatformDefault := false;
    Stroke.Kind := TBrushKind.None;
    Visible := true;
    OnClick := OnAutoCompleteClick;
    XRadius := 15;
    YRadius := 15;
  end;

  // Create the label and set its properties
  lblCityName := TLabel.Create(recAutocompleteTemp);
  with lblCityName do
  begin
    // Create Label
    Parent := recAutocompleteTemp;
    Align := TAlignLayout.Client;
    StyledSettings := [TStyledSetting.Size, TStyledSetting.Style];
    Opacity := 0.8;
    Size.PlatformDefault := false;
    TextSettings.Font.Family := 'Inter';
    TextSettings.FontColor := TAlphaColors.White;
    TextSettings.WordWrap := false;
    // Contribute for scalling, habibi is tired
    AutoSize := false;
    HitTest := false;
    Visible := true;
  end;

  Result := lblCityName;
end;

function FindFirstChildOfClass(objParent: TControl; AClass: TClass; bInclesive : Boolean = false): TFmxObject;
var
  I: integer;
begin
  Result := nil;
  for I := 0 to objParent.ControlsCount - 1 do
  begin
    if objParent.Controls[I] is AClass then
    begin
      Result := objParent.Controls[I];
      exit;
    end;
  end;

  if bInclesive then
  begin
    for I := 0 to objParent.ControlsCount - 1 do
    begin
      Result := FindFirstChildOfClass(objParent.Controls[I], AClass, true);
      if Result <> nil then
        exit;
    end;
  end;
end;

procedure TfrmCitySwipe.StartLoadingScreen();
begin
  pcScreens.ActiveTab := tbLoading;
  aniLoadingTrip.Start;
  aniLoadingTrip.StopValue := recLoadingBase.Width - recLoadingBar.Width;
  aniLoadingSize.Start;
  lblTripStatus.Text := 'Status: Loading AI';
end;

function FindByTag(conBase: TControl; iTag: integer): TControl;
var
  I: integer;
  ctrlChild, ctrlResult: TControl;
begin
  Result := nil;
  for I := 0 to conBase.ControlsCount - 1 do
  begin
    ctrlChild := conBase.Controls[I];

    // Check the tag, if match, exit and return
    if ctrlChild.Tag = iTag then
    begin
      Result := ctrlChild;
      exit();
    end;

    // Recursively check this ctrlChild's children
    ctrlResult := FindByTag(ctrlChild, iTag);
    if ctrlResult <> nil then
    begin
      Result := ctrlResult;
      exit();
    end;
  end;
end;

procedure ResetSelection(ctrlParent : TControl);
var
  crtlChild : TControl;
begin
  for crtlChild in ctrlParent.Controls do
  begin
    if crtlChild is TRectangle then
    begin
      TRectangle(crtlChild).Fill.Color := TfrmCitySwipe.clrUnselectedValue;
    end;
  end;
end;

procedure ClearUI(crtlParent : TControl ; ctrlTemplate : TControl);
var
  crtlChild : TControl;
  i : integer;
begin
  for i := crtlParent.ControlsCount - 1 downto 0 do
  begin
    crtlChild := crtlParent.Controls[i];
    if (crtlChild is TRectangle) and (crtlChild <> ctrlTemplate) then
    begin
      crtlChild.Free;
    end;
  end;
end;

procedure TfrmCitySwipe.SelectMainMenuTabButton(ctrlSelected : TControl);
var
  ctrlChild : TControl;
begin
    // Update Tab Buttons
  for ctrlChild in layMainTabs.Controls do
  begin
    ctrlChild.Opacity := 0.5;
  end;
  ctrlSelected.Opacity := 1;
end;

procedure TfrmCitySwipe.ResetMenu();
begin
  // Reset UI
  ResetSelection(layOptions);
  ClearUI(scrAcivityItems.Content, recPlaceTemplate);
  ClearUI(scrResturantItems.Content, recPlaceTemplate);
  SelectMainMenuTabButton(btnNewTrip);
  // Free Objects
  jsonNewTripSettings.Free;
  jsonNewTripSettings := nil;
  arrHonrableAct.Free;
  arrHonrableAct := nil;
  arrHonrableRest.Free;
  arrHonrableRest := nil;
  dicImages.Free;
  dicImages := nil;
  // Reset selection dictionary
  dicRadioGroup.Free;
  dicRadioGroup := nil;
  dicRadioGroup := TDictionary<integer, string>.Create();
  // Set Tabindex
  pcScreens.TabIndex := 0;
  bLoadingTrip := false;
end;

function TfrmCitySwipe.ProcessStream(Value : TChat) : boolean;
begin
  Result := false;
  // Check if valid
  if (Value = nil) or (Length(Value.Choices) <= 0) then
    exit;
  // Check If Thinking
  if not Value.Choices[0].Delta.ReasoningContent.IsEmpty then
  begin
    lblTripStatus.Text := 'AI Is Processing Input Data. This Might Take Up To 5 Minutes.'
                          + sLineBreak + ' Attempt: ' + iDeepseekAttempts.ToString
                          //+ sLineBreak + ' Current Token: ' + Value.Choices[0].Delta.ReasoningContent
                          + sLinebreak + 'Processing Time: ' + FormatDateTime('hh:mm:ss' ,Now - dtAiStart);
    exit;
  end;
  // Check if streaming
  if (Value.Usage = nil) then
  begin
    lblTripStatus.Text := 'AI Is Creating An Output. This Might Take Up To 2 Minutes.'
                          + sLineBreak + ' Attempt: ' + iDeepseekAttempts.ToString
                          //+ sLineBreak + ' Current Token: ' + Value.Choices[0].Delta.Content
                          + sLinebreak + 'Processing Time: ' + FormatDateTime('hh:mm:ss' ,Now - dtAiStart);
    sResponse := sResponse + Value.Choices[0].Delta.Content.Replace('\n', '#10');
    exit;
  end;
  // If Final Token (Usage <> nil) then output is complete
  sResponse := sResponse + Value.Choices[0].Delta.Content.Replace('\n', '#10');

  Result := true;
end;

procedure TfrmCitySwipe.SendDeepseekRequest(onProgress: TProc<TObject, TChat>);
begin
  // Reset
  inc(iDeepseekAttempts, 1);
  sAIReponse := '';
  lblTripStatus.Text :=
    'Status: Starting AI. Attempt: '
    + iDeepseekAttempts.ToString;

  { // Save Prompt For Debugging
  var txt : Textfile;
  AssignFile(txt, 'Text.txt');
  Rewrite(txt);
  Writeln(txt, sPrompt);
  CloseFile(txt);}


  // Attempt To Send API Request
  try
    // Create Agent
    sResponse := '';
    dtAiStart := Now;
    if not Assigned(objDeepseek) then
      objDeepseek := TDeepseekFactory.CreateInstance(sDeepseekAPI);
    // Set Timeouts
    with objDeepSeek.ClientHttp do
    begin
      ConnectionTimeout := 60_000;   // 1 min to connect
      SendTimeout       := 60_000;   // 1 min to upload the JSON body
      ResponseTimeout   := 180_000;  // 3 min to wait for the first byte
      // ResponseTimeout := 0;       // 0 = wait indefinitely
    end;

    objDeepseek.Chat.AsynCreateStream(
      procedure(Params: TChatParams)
      begin
        Params.Model(sDeepseekModel);
        Params.Messages([FromUser(sPrompt)]);
        Params.MaxTokens(8192);
        Params.Stream(true);
        if sDeepseekModel = 'deepseek-chat' then // deepseek-reasoner does not understand json_object, even tho it supports it
          Params.ResponseFormat(TResponseFormat.json_object);
      end,
      function: TAsynChatStream
      begin
        Result.OnProgress  := onProgress;
        Result.OnError := DisplayError;
      end);
  except
    on E: Exception do
    begin
      frmCitySwipe.ShowScreenPopup(1, 'Network Error', E.Message, true);
      exit;
    end;
  end;
end;

/// --- Global UI Button Methods --- \\\
procedure TfrmCitySwipe.tmrCitySelectorDropdownTimer(Sender: TObject);
var
  lblAutoOption: TLabel;
  recAutoOption: TRectangle;
  iIndex: integer;
  sInput, sStuckup: string;
  objPrediction: TPlacePrediction;
begin
  // Var work
  if not bUpdateSuggestions then
    exit;
  rTimerValue := rTimerValue + tmrCitySelectorDropdown.Interval;
  // Check if 2000ms Passed
  if (rTimerValue >= 1000) and (scrlAutocomplete.Visible) then
  begin
    // Save Index
    iIndex := iAutocomIndex;
    // Ensure Timers doesnt go off again
    bUpdateSuggestions := false;
    tmrCitySelectorDropdown.Enabled := false;
    // If so, create a new thread and show sugestions
    TTask.Run(
      procedure()
      begin
        // Get Autocomplete
        sInput := edtCitySelector.Text;
        if sInput = '' then
          exit;
        arrPredictions := objGoogleMaps.GetAutocomplete(sInput);
        // If Autocmplete Failed > Error inside GetAutocomplete
        if arrPredictions = nil then
        begin
          HideAutocomplete(Sender, sStuckup);
          exit;
        end;
        // Jump Back To MainThread to do UI work
        TThread.Synchronize(nil,
          procedure
          var
            // Loops needs a localscope Var
            I, iControl: integer;
            rSize: Single;
          begin
            // Ensure User Didnt Type While We Were Sending PostRequest
            if (iIndex <> iAutocomIndex) then
              exit;
            // Setup
            scrlAutocomplete.PrepareForPaint;
            iControl := 0;
            rSize := Round(scrlAutocomplete.Height / 3);
            for I := arrPredictions.Count - 1 downto 0 do
            begin
              // Delphi freezes when trying to create a bulk amount of dynamic objects
              // (actually not, after testing i found its the request freezing everything, oops)
              if recAutocomplete.Controls.Count - 1 >= iControl then
              begin
                // Get Control From Pool
                recAutoOption := TRectangle(recAutocomplete.Controls[iControl]);
                lblAutoOption := TLabel(recAutoOption.Controls[0]);
              end
              else
              begin
                // Or else create a new reusable control
                lblAutoOption := CreateAutocompleteDesign();
                recAutoOption := TRectangle(lblAutoOption.Parent);
              end;

              // Edit Control
              objPrediction := arrPredictions.Items[I];
              lblAutoOption.Text := objPrediction.Text.Text;
              lblAutoOption.TextSettings.Font.Size := rSize / 2;
              recAutoOption.Height := rSize;
              recAutoOption.Visible := true;
              // Set Vars
              recAutoOption.Tag := I;
              recAutoOption.Parent := recAutocomplete;

              inc(iControl);
            end;
            // Check No Results
            lblNoResults.Visible := arrPredictions.Count = 0;
            // Set Size
            recAutocomplete.Height := recAutocomplete.ChildrenRect.Size.cy +
              recAutocomplete.Padding.Top + recAutocomplete.Padding.Bottom;
            // Disable Loading
            imgLoadingAuto.Visible := false;
            aniLoadingSpin.Enabled := false;
            // Redraw
            scrlAutocomplete.Repaint;
          end);
      end);
  end;
end;

procedure TfrmCitySwipe.OnAutoCompleteClick(Sender: TObject);
var
  objPlace: TPlacePrediction;
  objPlaceCoordinate: TCoordinate;
  sExcuse: string;
begin
  if not bCanSelectCity then
    exit;
  bCanSelectCity := false;
  // Popup!
  ShowScreenPopup(0, 'Loading Location',
    'Please Wait While We Load The Selected Location', false);
  // New Thread > Dont Freeze UI
  TTask.Run(
    procedure()
    begin
      // Get Selected Place
      objPlace := arrPredictions[(Sender as TRectangle).Tag];
      // Update Edit With New Address
      edtCitySelector.Text := objPlace.Text.Text;
      // Set New Location
      objPlaceCoordinate := objGoogleMaps.GetPlaceLocation(objPlace.placeId);
      if not Assigned(objPlaceCoordinate) then
      begin
        // Error Message Displayed Inside GetPlaceLocation
        exit;
      end;
      objUserCoordinate := objPlaceCoordinate;
      // Hide Autocomplete
      HideAutocomplete(Sender, sExcuse);
      // Update Edit
      edtCitySelector.Text := objUserCoordinate.formattedAddress;
      StartPullCityInfo();
      // Be Free!
      arrPredictions.Free;
      arrPredictions := nil;
    end);
end;

procedure TfrmCitySwipe.edtCitySelectorChange(Sender: TObject);
begin
  lblCitySelectorPlace.Visible := edtCitySelector.Text = '';
end;

procedure TfrmCitySwipe.edtCitySelectorTyping(Sender: TObject);
var
  I: integer;
begin
  lblCitySelectorPlace.Visible := edtCitySelector.Text = '';
  bCanSelectCity := true;
  // Position/Size Dropdown
  // Allginment Modes were off, we now its our job
  scrlAutocomplete.Position.X := recCitySelector.Position.X;
  scrlAutocomplete.Width := recCitySelector.Width;
  recAutocomplete.Width := scrlAutocomplete.Width;
  recAutocomplete.Height := scrlAutocomplete.Height;
  // Hide Controls To Be Reused (more optimized then dynamic objects)
  for I := 0 to recAutocomplete.ControlsCount - 1 do
  begin
    recAutocomplete.Controls[I].Visible := false;
  end;
  // Show Dropdown
  imgLoadingAuto.Visible := true;
  aniLoadingSpin.Enabled := true;
  scrlAutocomplete.Visible := true;
  lblNoResults.Visible := false;
  // Get Index
  inc(iAutocomIndex);
  // Enable Timer
  rTimerValue := 0;
  bUpdateSuggestions := true;
  tmrCitySelectorDropdown.Enabled := true;
end;

procedure TfrmCitySwipe.HideAutocomplete(Sender: TObject; var Text: string);
begin
  scrlAutocomplete.Visible := false;
  aniLoadingSpin.Enabled := false;
  tmrCitySelectorDropdown.Enabled := false;
  lblCitySelectorPlace.Visible := edtCitySelector.Text = '';
end;

procedure TfrmCitySwipe.btnClosePopupClick(Sender: TObject);
begin
  recPopup.Visible := false;
  recPopup.HitTest := false;
end;

procedure TfrmCitySwipe.ChangeMainMenuTab(Sender: TObject);
var
  layNextFrame : TLayout;
  tbNextTab : TTabItem;
  iIndexTo : integer;
begin
  if bLoadingTrip then
    exit;
  // Get Layout
  iIndexTo := TControl(Sender).Tag;
  tbNextTab := pcTabs.Tabs[iIndexTo];
  layNextFrame := TLayout(FindFirstChildOfClass(tbNextTab, TLayout, true));
  SelectMainMenuTabButton(TControl(Sender));
  // Update Which Needs To Be Updated
  if tbNextTab = tbPrevious then
    UpdatePreviousTripsUI()
  else if tbNextTab = tbGroups then
    UpdateGroupsUI;
  // Change tab
  SwitchScreenTab(iIndexTo, layNextFrame, pcTabs);
end;

/// --- Display Groups Methods --- \\\
procedure TfrmCitySwipe.UpdateGroupsUI();
var
  recClone : TRectangle;
  lblLabel : Tlabel;
  imgButton : TImage;
  btnSwitch : TButton;
begin
  // Clear UI
  scrlPreviousTrips.ScrollBy(0,0);
  ClearUI(scrlGroups.Content, recGroupsTemplate);
  // Open Database
  with dmDataComponents do
  begin
    // Open table and get TripCount as a new field
    qryDatabase.SQL.Text := 'Select g.GroupID, g.GroupName, (Select COUNT(*) From PreviousTrips as pt Where pt.GroupID = g.GroupID) as TripCount';
    qryDatabase.Sql.Add('From Groups as g');
    qryDatabase.Open();
    qryDatabase.First;

    // Loop through data base
    while not qryDatabase.Eof do
    begin
      // Create Clone
      recClone := TRectangle(recGroupsTemplate.Clone(frmCitySwipe));
      // Set control info
      // 1 = GroupName; 4 = TripCount
      lblLabel := TLabel(FindByTag(recClone, 1));
      lblLabel.Text := qryDatabase['GroupName'];
      lblLabel := TLabel(FindByTag(recClone, 4));
      lblLabel.Text := qryDatabase.FieldByName('TripCount').AsString + ' Trips';
      // 2 = DeleteButton ; 3 = RenameButton
      imgButton := TImage(FindByTag(recClone, 2));
      imgButton.TagFloat := qryDatabase['GroupID'];
      imgButton.OnClick := DeleteGroup;

      imgButton := TImage(FindByTag(recClone, 3));
      imgButton.TagFloat := qryDatabase['GroupID'];
      imgButton.TagString := qryDatabase['GroupName'];
      imgButton.TagObject := recClone;
      imgButton.OnClick := RenameGroup;
      // 5 = SwitchProfileButton
      btnSwitch := TButton(FindByTag(recClone, 5));
      btnSwitch.TagString := qryDatabase['GroupID'];
      btnSwitch.OnClick := ClickSwitchProfile;
      // Color
      if qryDatabase['GroupID'] = iCurrentGroupId then
        recClone.Fill.Color := $FF070F1A;
      // Parent and view
      recClone.Parent := scrlGroups.Content;
      recClone.Repaint;
      recClone.Visible := true;
      qryDatabase.Next;
    end;

    // Close Database
    qryDatabase.Close;

    scrlPreviousTrips.ScrollBy(0,1);
    scrlPreviousTrips.ScrollBy(0,0);
  end;
end;

procedure TfrmCitySwipe.ClickSwitchProfile(Sender : TObject);
var
  ctrlSender : TControl;
  iId : integer;
begin
  ctrlSender := TControl(Sender);
  if not Integer.TryParse(ctrlSender.TagString, iId) then
    exit;

  iCurrentGroupId := iId;
  ShowScreenPopup(0, 'Group Selected', 'We have selected your new group', true);
  UpdateGroupsUI();
end;

procedure TfrmCitySwipe.DeleteGroup(Sender : TObject);
var
  sGroupID : string;
begin
  // Check Not Using Group
  sGroupID := Trunc(TControl(Sender).TagFloat).ToString();
  if sGroupID = iCurrentGroupId.ToString then
  begin
    ShowScreenPopup(1, 'Cant Delete This Group', 'Please Switch To Another Group Before Deleting This One', true);
    exit;
  end;

  // Confirm
  TDialogService.MessageDialog('Are You Sure You Want To Delete This Group?', TMsgDlgType.mtWarning, [TMsgDlgBtn.mbYes, TMsgDlgBtn.mbNo], TMsgDlgBtn.mbNo,
  0, procedure(const AResult: TModalResult)
  begin
    if AResult = mrYes then
    begin
      // Delete Record

      with dmDataComponents do
      begin
        qryDatabase.SQL.Text := 'DELETE FROM Groups Where GroupID = ' + sGroupID;
        qryDatabase.ExecSQL;
        qryDatabase.Close;
      end;
      // Update UI
      UpdateGroupsUI();
    end;
  end);
end;

procedure TfrmCitySwipe.RenameGroup(Sender : TObject);
var
  ctrlSender : TControl;
  sGroupID : string;
  lblTitle : TLabel;
begin
  ctrlSender := TControl(Sender);
  sGroupID := Trunc(ctrlSender.TagFloat).ToString();
  // Get New Name
  TDialogService.InputQuery('Group Name',
                            ['Please Enter a New Name For This Group: '],
                            [ctrlSender.TagString],
  procedure(const AResult: TModalResult; const AValues: array of string)
  begin
    if AResult = mrOK then
    begin
      // Edit Record
      with dmDataComponents do
      begin
        qryDatabase.SQL.Text := 'Update Groups';
        qryDatabase.SQL.Add('Set GroupName = ' + QuotedStr(AValues[0]));
        qryDatabase.SQL.Add('Where GroupID = ' + sGroupID);
        qryDatabase.ExecSQL;
        qryDatabase.Close;
      end;
      // Modify Name Label
      lblTitle := TLabel(FindByTag(TControl(ctrlSender.TagObject), 1));
      lblTitle.Text := AValues[0];
      ctrlSender.TagString := AValues[0];
    end;
  end);
end;

procedure TfrmCitySwipe.ResetOnClose(Sender: TObject; var Action: TCloseAction);
begin
  if Action = TCloseAction.caHide then
  begin
    frmGroupCreation.OnClose := nil;
    UpdateGroupsUI();
  end;
end;

procedure TfrmCitySwipe.btnCreateNewGroupClick(Sender: TObject);
begin
  frmGroupCreation.OnShow := frmGroupCreation.StartGroupCreation;
  frmGroupCreation.OnClose := ResetOnClose;
  frmGroupCreation.btnCancel.OnClick := frmGroupCreation.btnCancelClick;
  frmGroupCreation.layCancelButton.Visible := true;
  frmGroupCreation.Show(); // ShowModal not supported by Andriod
end;

/// --- Previous Trips Methods --- \\\
procedure JsonArrayToAIPlace(jsonArray : TJsonArray ; out arrArray : TList<TAiPlace>);
var
  i : integer;
  objPlace : TAiPlace;
begin
  for i := 0 to jsonArray.Count-1 do
  begin
    objPlace := TJson.JsonToObject<TAiPlace>(jsonArray[i] as TJSONObject);
    arrArray.Add(objPlace);
  end;
end;

procedure TfrmCitySwipe.UpdatePreviousTripsUI();
var
  recClone : TRectangle;
  lblLabel : TLabel;
  imgButton : TImage;
  recButton : TRectangle;
  layBubbleText : TTextLayout;
begin
  // Clear UI
  scrlPreviousTrips.ScrollBy(0,0);
  ClearUI(scrlPreviousTrips.Content, recTripTemplate);
  // Open Database
  with dmDataComponents do
  begin
    qryDatabase.SQL.Text := 'Select * From PreviousTrips Where GroupID = ' + iCurrentGroupId.ToString;
    qryDatabase.Open;
    qryDatabase.First;
    // Loop Through Data
    while not qryDatabase.Eof do
    begin
      // Clone
      recClone := TRectangle(recTripTemplate.Clone(frmCitySwipe));
      // Update Text
      // 1 = Title ; 2 = Items ; 3 = Date ; 4 = View Button ; 5 = Three Dots
      lblLabel := TLabel(FindByTag(recClone, 1));
      lblLabel.Text := qryDatabase['TripName'];
      lblLabel := TLabel(FindByTag(recClone, 2));
      lblLabel.Text := qryDatabase['ActivityNameList'];
      lblLabel := TLabel(FindByTag(recClone, 3));
      lblLabel.Text := qryDatabase['DateAdded'];
      // Set Button TagString And Event
      recButton := TRectangle(FindByTag(recClone, 4));
      recButton.OnClick := LoadPreviousTrip;
      recButton.TagString := qryDatabase['TripFile'];
      recButton.TagFloat := qryDatabase['BudgetPerPerson'];
      imgButton := TImage(FindByTag(recClone, 5));
      imgButton.TagFloat := qryDatabase['TripID'];
      imgButton.TagString := qryDatabase['TripName'];
      imgButton.OnClick := btnThreeDotsClick;
      // Get Bubble Width ; 6 = Clock Icon TImage
      imgButton := TImage(FindByTag(recClone, 6));
      layBubbleText := TTextLayoutManager.DefaultTextLayout.Create();
      with layBubbleText do
      begin
        BeginUpdate;
        Font.Assign(lblLabel.TextSettings.Font);
        MaxSize := TSizeF.Create(100000, lblLabel.Height);
        WordWrap := false;
        Text := lblLabel.Text;
        HorizontalAlign := TTextAlign.Leading;
        VerticalAlign := TTextAlign.Center;
        EndUpdate;
      end;
      TRectangle(lblLabel.Parent).Width := imgButton.Width + imgButton.Margins.Left + imgButton.Margins.Right + 10 + layBubbleText.Width;
      layBubbleText.Free;
      // Parent And View
      recClone.Parent := scrlPreviousTrips.Content;
      recClone.Visible := true;
      recClone.Repaint;
      qryDatabase.Next;
    end;

    lblNoTrips.Visible := qryDatabase.RecordCount <= 0;

    scrlPreviousTrips.Content.UpdateRect;
    scrlPreviousTrips.ScrollBy(0,1);
    scrlPreviousTrips.ScrollBy(0,0);

    qryDatabase.Close;
  end;
end;

procedure TfrmCitySwipe.LoadPreviousTrip(Sender : TObject);
var
  jsonLoad : TJsonObject;
  sFilePath : string;
  ctrlButton : TControl;
begin
  if bLoadingTrip then
    exit;
  bLoadingTrip := true;

  ctrlButton := TControl(Sender);
  sFilePath := ctrlButton.TagString;
  if not FileExists(sFilePath) then
  begin
    ShowScreenPopup(1, 'No Save File', 'We Are Unable To Find The Save File For This Trip', true);
    bLoadingTrip := false;
    exit;
  end;

  // Enter Loading Screen
  pcTabs.TabIndex := 0;
  StartLoadingScreen();
  lblTripStatus.Text := 'Loading Trip File';
  // Get Previous Trip File
  jsonLoad := TJsonReader.LoadJSONFromFile(sFilePath);
  // Load Arrays Into Memory
  arrFinalAct := TList<TAiPlace>.Create;
  arrFinalRest := TList<TAiPlace>.Create;
  JsonArrayToAIPlace(jsonLoad.GetValue<TJsonArray>('Activities'), arrFinalAct);
  JsonArrayToAIPlace(jsonLoad.GetValue<TJsonArray>('Restaurants'), arrFinalRest);
  // Load Images - New Thread
  if dicImages <> nil then
    dicImages.Free;
  dicImages := TDictionary<string, TBitmap>.Create();
  lblTripStatus.Text := 'Loading Images';
  TTask.Run(procedure()
  var
    objPlace : TAiPlace;
  begin
    // Load Images
    try
      for objPlace in arrFinalAct do
      begin
        AddImage(objPlace.PlaceID)
      end;
      for objPlace in arrFinalRest do
      begin
        AddImage(objPlace.PlaceID)
      end;
    except
      on E: Exception do
      begin
        frmCitySwipe.ShowScreenPopup(1, 'Unable To Load Images', 'Network Error: ' + E.Message, true);
      end;
    end;
    /// Display UI - Back to main thread
    TThread.Synchronize(nil, procedure()
    var
      objPlace : TAiPlace;
    begin
      // Clear UI
      ClearUI(scrAcivityItems.Content, recPlaceTemplate);
      ClearUI(scrResturantItems.Content, recPlaceTemplate);
      // Set Text
      lblBudgetSummary.Text := 'Est. Per Person: ' + FloatToStrF(ctrlButton.TagFloat,
        ffCurrency, 8, 2);
      // Reset Tab
      pcCatagories.TabIndex := 0;
      recResturants.Opacity := 0.5;
      recActivites.Opacity := 1;
      // Fill Activities
      for objPlace in arrFinalAct do
      begin
        CreateTripPlace(objPlace, scrAcivityItems, 0, nil, false);
      end;
      // Fill Restaurants
      for objPlace in arrFinalRest do
      begin
        CreateTripPlace(objPlace, scrResturantItems, 0, nil, false);
      end;
      scrResturantItems.RecalcSize;
      scrResturantItems.RecalcUpdateRect;
      scrResturantItems.UpdateRect;
      scrAcivityItems.RecalcSize;
      scrAcivityItems.RecalcUpdateRect;
      scrAcivityItems.UpdateRect;
      // Set To Dont Save (0 = Dont Save ; 1 = Save)
      btnSaveAndClose.Tag := 0;
      btnSaveAndClose.Text := 'Close';
      // Switch To Tab
      SwitchScreenTab(5, layFinalBackground, pcScreens);
      // Focus on scrollbars
      scrAcivityItems.SetFocus;
    end);
    // Debounce
    TThread.Sleep(1000);
    bLoadingTrip := false;
  end);
end;

procedure TfrmCitySwipe.recHitTestClick(Sender: TObject);
var
  ctrlSender : TControl;
begin
  ctrlSender := TControl(Sender);
  if (ctrlSender.TagObject <> nil) and (ctrlSender.TagObject is TControl) then
  begin
    TControl(ctrlSender.TagObject).Visible := false;
    ctrlSender.Visible := false;
  end;
end;

procedure TfrmCitySwipe.btnThreeDotsClick(Sender: TObject);
var
  recOptions, recHit : TRectangle;
  lblDelete, lblRename : TLabel;
  ctrlSender : TControl;
begin
  ctrlSender := TControl(Sender);
  // Get UI Objects
  recOptions := TRectangle(FindFirstChildOfClass(ctrlSender, TRectangle));
  recHit := TRectangle(FindFirstChildOfClass(TControl(ctrlSender.Parent), TRectangle));
  // Set Close Area
  recHit.OnClick := recHitTestClick;
  recHit.TagObject := recOptions;
  // Show UI
  recHit.Visible := true;
  recOptions.Visible := true;

  /// Register Buttons
  // Get Buttons: 11 = Delete ; 12 = Rename
  lblDelete := TLabel(FindByTag(ctrlSender, 11));
  lblRename := TLabel(FindByTag(TControl(lblDelete.Parent), 12));

  lblDelete.TagFloat := ctrlSender.TagFloat;
  lblDelete.OnClick := DeleteTrip;

  lblRename.TagObject := TControl(ctrlSender.Parent.Parent);
  lblRename.TagFloat := ctrlSender.TagFloat;
  lblRename.TagString := ctrlSender.TagString;
  lblRename.OnClick := RenameTrip;  
end;

procedure TfrmCitySwipe.DeleteTrip(Sender : TObject);
var
  sTripID, sFolderPath, sFilePath : string;
begin
  // Confirm
  TDialogService.MessageDialog('Are You Sure You Want To Delete This Trip?', TMsgDlgType.mtWarning, [TMsgDlgBtn.mbYes, TMsgDlgBtn.mbNo], TMsgDlgBtn.mbNo,
  0, procedure(const AResult: TModalResult)
  begin
    if AResult = mrYes then
    begin
      // Get TripFile
      sTripID := Trunc(TControl(Sender).TagFloat).ToString();
      sFolderPath := TPath.Combine(dmDataComponents.sDataFolder, 'SavedTrips');
      sFilePath := TPath.Combine(sFolderPath, sTripID + '.json');
      if FileExists(sFilePath) then
        TFile.Delete(sFilePath);
      // Delete Record
      with dmDataComponents do
      begin
        qryDatabase.SQL.Text := 'DELETE FROM PreviousTrips Where TripID = ' + sTripID;
        qryDatabase.ExecSQL;
        qryDatabase.Close;
      end;
      // Update UI
      UpdatePreviousTripsUI();
    end;
  end);
end;

procedure TfrmCitySwipe.RenameTrip(Sender : TObject);
var
  ctrlSender : TControl;
  sTripID : string;
  lblTitle : TLabel;
  recClose : TRectangle;
begin
  ctrlSender := TControl(Sender);
  sTripID := Trunc(ctrlSender.TagFloat).ToString();
  // Get New Name
  TDialogService.InputQuery('Trip Name', 
                            ['Please Enter a New Name For This Trip: '],
                            [ctrlSender.TagString],
  procedure(const AResult: TModalResult; const AValues: array of string)
  begin
    if AResult = mrOK then
    begin
      // Edit Record
      with dmDataComponents do
      begin
        qryDatabase.SQL.Text := 'Update PreviousTrips';
        qryDatabase.SQL.Add('Set TripName = ' + QuotedStr(AValues[0]));
        qryDatabase.SQL.Add('Where TripId = ' + sTripID);
        qryDatabase.ExecSQL;
        qryDatabase.Close;
      end;
      // Modify Name Label
      lblTitle := TLabel(FindByTag(TControl(ctrlSender.TagObject), 1));
      lblTitle.Text := AValues[0];
      ctrlSender.TagString := AValues[0];
      // Close Popup; Tag = 13
      recClose := TRectangle(FindByTag(TControl(ctrlSender.TagObject), 13));
      recClose.OnClick(recClose);   
    end;  
  end);
end;


/// --- Trip Settings Methods --- \\\
procedure TfrmCitySwipe.aniTabFadeFinish(Sender: TObject);
begin
  pcWorkingTabControl.TabIndex := iNextScreen;
  transTabFade.Enabled := false;
  aniTabFade.Enabled := false;
  bNextDebounce := false;
end;

procedure TfrmCitySwipe.SwitchScreenTab(iTabTo: integer; layTabTo: TLayout;
tcTabControl: TTabControl);
begin
  // Setup
  iNextScreen := iTabTo;
  transTabFade.Parent := tcTabControl.Tabs[tcTabControl.TabIndex];
  transTabFade.Progress := 0;
  transTabFade.Enabled := true;
  pcWorkingTabControl := tcTabControl;
  // Start
  transTabFade.Target.Assign(layTabTo.MakeScreenshot);
  aniTabFade.Start;
end;

procedure TfrmCitySwipe.recOptionSelect(Sender: TObject);
var
  recSelectedValue: TRectangle;
  recChild: TControl;
  lblValueText: TLabel;
begin
  recSelectedValue := TRectangle(Sender);
  lblValueText := TLabel(recSelectedValue.Controls[0]);
  // Set Selected Value
  dicRadioGroup.AddOrSetValue(recSelectedValue.Tag, lblValueText.Text);
  // Reset Color
  for recChild in TControl(recSelectedValue.Parent).Controls do
  begin
    TRectangle(recChild).Fill.Color := clrUnselectedValue;
    TRectangle(recChild).Repaint;
  end;
  // Set Selected Color
  recSelectedValue.Fill.Color := clrSelectedValue;
  recSelectedValue.Repaint;
end;

procedure TfrmCitySwipe.btnQuestionNext(Sender: TObject);
var
  layTabTo: TLayout;
  tbTabFrom: TTabItem;
  ctrlTabTo, crtlChild: TControl;
  sOption, sBudget, sInput: string;
  bUsesRadiogroup: boolean;
  iTab, i: integer;
  jsonMeals: TJsonObject;
  recMain : TRectangle;
begin
  // Ensure We Have a Coordinate
  if not Assigned(objUserCoordinate) then
  begin
    ShowScreenPopup(1, 'Please Select a City',
      'Please Select a City Before Starting a Trip', true);
    exit;
  end;

  if bNextDebounce then
    exit;
  bNextDebounce := true;
  // Get Requirements
  iTab := pcScreens.TabIndex;
  ctrlTabTo := TControl(pcScreens.Tabs[iTab + 1].Controls[0]);
  layTabTo := TLayout(FindFirstChildOfClass(ctrlTabTo, TLayout));
  tbTabFrom := pcScreens.Tabs[iTab];
  // tbTabFrom.Tag is the minium amount of options the user needs to select
  bUsesRadiogroup := tbTabFrom.Tag > 0;
  // Check If User Selected a Value
  if bUsesRadiogroup then
  begin
    if dicRadioGroup.Count < tbTabFrom.Tag then
    begin
      ShowScreenPopup(1, 'Please Select a Option',
        'Please Select a Option Before You Click The Next Button', true);
      bNextDebounce := false;
      exit;
    end;
    sOption := dicRadioGroup.Items[0];
  end;
  // Create and Save Selected Option
  if jsonNewTripSettings = nil then
    jsonNewTripSettings := TJsonObject.Create;
  case pcScreens.TabIndex of
    // StepOne
    0:
      bOnlyRestaurants := not(sOption = 'Looking For Activites');
    // StepTwo
    1:
      jsonNewTripSettings.AddPair('IndoorOutdoorPreference', sOption);
    // StepThree
    2:
      begin
        jsonNewTripSettings.AddPair('ActivityCount', Round(trkActivityCount.Value));
        if (trkBugetPerPerson.Value = trkBugetPerPerson.Max) and
          (trkBugetPerPerson.TagString <> '') then
          sBudget := trkBugetPerPerson.TagString
        else
          sBudget := FloatToStrF(trkBugetPerPerson.Value, ffCurrency, 8, 0);
        jsonNewTripSettings.AddPair('BudgetPerPerson', sBudget);
      end;
    3:
      begin
        // Count Restaurants
        iRestaurantCount := 0;
        iSnackCount := 0;
        for i := 0 to dicRadioGroup.Count-1 do
        begin
          sInput := dicRadioGroup.Items[i];
          if sInput <> 'Skip' then
            inc(iRestaurantCount);
          if sInput = 'Snack' then
            Inc(iSnackCount);
        end;
        // Input Data
        jsonMeals := TJsonObject.Create;
        jsonMeals.AddPair('Breakfast', dicRadioGroup.Items[0]);
        jsonMeals.AddPair('Lunch', dicRadioGroup.Items[1]);
        jsonMeals.AddPair('Dinner', dicRadioGroup.Items[2]);
        jsonNewTripSettings.AddPair('EatingPlan', jsonMeals)
      end;
  end;
  // Clear Selection UI in next tab
  recMain := TRectangle(layTabTo.Controls[0]);
  for crtlChild in recMain.Controls do
  begin
    if (crtlChild is TFlowLayout) and (crtlChild.Tag = 1) then
    begin
      ResetSelection(crtlChild);
    end;
  end;
  // Clear Selected Dictionary
  dicRadioGroup.Clear;
  if iTab <> 3 then
    // Move To Next Tab
    SwitchScreenTab(iTab + 1, layTabTo, pcScreens)
  else
    // Create Swipe Screen
    GetSwipeablePlaces();
end;

procedure TfrmCitySwipe.btn2BackClick(Sender: TObject);
var
  layTabTo: TLayout;
  ctrlTabTo, crtlChild: TControl;
  iTab: integer;
  recMain : TRectangle;
begin
  if iTab = 0 then
    exit;
  // Get data
  iTab := pcScreens.TabIndex;
  ctrlTabTo := TControl(pcScreens.Tabs[iTab - 1].Controls[0]);
  layTabTo := TLayout(FindFirstChildOfClass(ctrlTabTo, TLayout));
  // Deselect
  recMain := TRectangle(layTabTo.Controls[0]);
  for crtlChild in recMain.Controls do
  begin
    if (crtlChild is TFlowLayout) and (crtlChild.Tag = 1) then
    begin
      ResetSelection(crtlChild);
    end;
  end;
  // Move To Next Tab
  SwitchScreenTab(iTab - 1, layTabTo, pcScreens);
end;

procedure TfrmCitySwipe.btnSwitchModelClick(Sender: TObject);
var
  recSender : TRectangle;
begin
  TDialogService.InputQuery('Enter Superuser Password', ['Enter Superuser Password: '], [''],
  procedure(const AResult: TModalResult; const AValues: array of string)
  begin
    if AValues[0] <> sSuperuserPassword then
      exit;

    recSender := TRectangle(TControl(Sender));
    // -1 = Reasoner ; 0 = Chat
    if recSender.Tag = -1 then
    begin
      sDeepseekModel := 'deepseek-chat';
      recSender.Fill.Color := clrUnselectedValue;
      recSender.Tag := 0;
    end
    else
    begin
      sDeepseekModel := 'deepseek-reasoner';
      recSender.Fill.Color := clrSelectedValue;
      recSender.Tag := -1;
    end;
  end);
end;

/// --- Get Swipeable Cards Methods --- \\\
procedure TfrmCitySwipe.GetSwipeablePlaces();
var
  sInput, sBase: string;
begin
  /// [DEBUGGING] Skip Swiping \\\
  {dicImages := TDictionary<string, TBitmap>.Create();
  var txt : textfile;
  AssignFile(txt, 'FinalTrip.txt');
  Reset(txt);
  var s : string;
  Readln(txt, s);
  CloseFile(txt);
  var chat := TJson.JsonToObject<TChat>(s);

  AssignFile(txt, 'arrLiked.txt');
  Reset(txt);
  Readln(txt, s);
  CloseFile(txt);
  arrLiked := TJson.JsonToObject<TList<TAiPlace>>(s);

  RecievedAiTrip(TObject(frmCitySwipe), chat);
  exit;}
  /// END \\\
  /// [DEBUGGING] Load Swipeable Places \\\
  {AssignFile(txt, 'SwipeableCards.txt');
  Reset(txt);
  var s : string;
  Read(txt, s);
  CloseFile(txt);
  var jsonResponse : TJsonObject;
  jsonResponse := TJsonReader.StringToJSONObject(s);
  var JSONArr : TJsonArray;
  // Serilize
  arrSwipePlaces := TList<TAiPlace>.Create();
  if jsonResponse.TryGetValue<TJSONArray>('Activities', JSONArr) then
    arrSwipePlaces.AddRange(TJsonReader.DeserializeAiPlaces(JSONArr,
      'Activity'));
  if jsonResponse.TryGetValue<TJSONArray>('Restaurants', JSONArr) then
    arrSwipePlaces.AddRange(TJsonReader.DeserializeAiPlaces(JSONArr,
      'Restaurant'));
  // Load First 5 Images
  lblTripStatus.Text := 'Status: Loading Images';
  dicImages := TDictionary<string, TBitmap>.Create();
  for var I := 0 to Min(1, arrSwipePlaces.Count - 1) do
  begin
    AddImage(arrSwipePlaces[I].placeId);
  end;
  // Pull GoogleMapsLink
  objGoogleMaps.FillGoogleLink(arrSwipePlaces);
  // Reset Liked Disliked
  arrLiked := TList<TAiPlace>.Create();
  arrDisliked := TList<TAiPlace>.Create();
  // Now Update UI, so do it im the main thread
  iSwipeIndex := 0;
  TThread.Synchronize(nil, procedure()
  begin
    // Create Card
    FillPlaceCard(arrSwipePlaces[iSwipeIndex]);
    // Display
    SwitchScreenTab(6, laySwipeBackground, tbLoading);
  end);
  exit; }
  ///  END \\\

  if bLoadingTrip then
    exit;
  bLoadingTrip := true;

  // Start Loading Screen
  bNextDebounce := false;
  StartLoadingScreen();
  // Get Input Data As a Json
  sInput := objGoogleMaps.GetPlacesPrompt(Round(trkDistanceSlider.Value),
    iCurrentGroupId, jsonNewTripSettings.GetValue<string>
    ('IndoorOutdoorPreference'), objUserCoordinate.GetCityAddress);
  if sInput = '' then
    // Error Displayed Inside GetPlacesPrompt
    exit;
  /// Send To AI
  // Create Prompt
  sBase := TFile.ReadAllText(TPath.Combine(dmDataComponents.sDataFolder,
    'prompt_GetCards5.txt'));
  sBase := sBase.Replace('%a', jsonNewTripSettings.GetValue<integer>('ActivityCount').ToString);
  sBase := sBase.Replace('%r', iRestaurantCount.ToString);
  sBase := sBase.Replace('%s', iSnackCount.ToString);
  sBase := sBase.Replace('%d', (iRestaurantCount - iSnackCount).ToString);
  sPrompt := sBase + sInput + sLineBreak + '```';
  // Global Var > Refrence when retrying
  // Send Request
  iDeepseekAttempts := 0;
  SendDeepseekRequest(RecievedAiCards);
end;

procedure TfrmCitySwipe.RecievedAiCards(Sender: TObject; Value: TChat);
begin
  // Process Stream
  if not ProcessStream(Value) then
    exit;

  // Save (debugging)
  {$IFDEF MSWINDOWS}
  var txt : Textfile;
  AssignFile(txt, 'SwipeableCards.txt');
  Rewrite(txt);
  Writeln(txt, sResponse);
  CloseFile(txt);
  {$ENDIF}

  // Check if infinite whitespace glitch
  if sResponse.Trim = '' then
  begin
    if iDeepseekAttempts >= 3 then
    begin
      ShowScreenPopup(1, 'Error',
        'Deepseek Glitched And Returned a Empty Object', true);
      ResetMenu();
    end
    else
      // Ask Deepseek To Try Again
      ShowScreenPopup(0, 'Information',
        'Deepseek Glitched And Returned a Empty Object, we are retrying', true);
      SendDeepseekRequest(RecievedAiCards);
    exit;
  end;
  if sResponse[sResponse.Length] <> '}' then
    sResponse := sResponse + '}';

  // Some stuff will load, so we'll keep everything in a diffrent thread
  TTask.Run(procedure()
  var
    jsonResponse: TJsonObject;
    JSONArr: TJSONArray;
    bError: boolean;
    I: integer;
  begin
    // Check Reponse
    if not TJsonReader.IsValidJSON(sResponse, jsonResponse) then
    begin
      if iDeepseekAttempts >= 3 then
      begin
        ShowScreenPopup(1, 'Error',
          'Deepseek Could Not Provide Us a Valid Json File', true);
        ResetMenu();
      end
      else
        // Ask Deepseek To Try Again
        ShowScreenPopup(0, 'Information',
          'Deepseek Could Not Provide Us a Valid Json File, We are retrying', true);
        SendDeepseekRequest(RecievedAiCards);
      exit;
    end;
    // Check If AI Returned a error
    if jsonResponse.TryGetValue<boolean>('Error', bError) then
    begin
      ShowScreenPopup(1, 'Error',
        'Deepseek Returned The Following Error. Please Restart Your App: ' +
        sLineBreak + jsonResponse.GetValue<string>('Message'), true);
      ResetMenu();
      exit;
    end;
    // Serilize
    if arrSwipePlaces <> nil then
    begin
      arrSwipePlaces.Free;
      arrSwipePlaces := nil;
    end;
    arrSwipePlaces := TList<TAiPlace>.Create();
    if jsonResponse.TryGetValue<TJSONArray>('Activities', JSONArr) then
      arrSwipePlaces.AddRange(TJsonReader.DeserializeAiPlaces(JSONArr,
        'Activity'));
    if jsonResponse.TryGetValue<TJSONArray>('Restaurants', JSONArr) then
      arrSwipePlaces.AddRange(TJsonReader.DeserializeAiPlaces(JSONArr,
        'Restaurant'));
    // Load First 5 Images
    dicImages.Free;
    dicImages := nil;
    lblTripStatus.Text := 'Status: Loading Images';
    dicImages := TDictionary<string, TBitmap>.Create();
    for I := 0 to Min(1, arrSwipePlaces.Count - 1) do
    begin
      AddImage(arrSwipePlaces[I].placeId);
    end;
    // Pull GoogleMapsLink
    objGoogleMaps.FillGoogleLink(arrSwipePlaces);
    /// Reset Liked Disliked
    // Memory Management
    arrLiked.Free;
    arrLiked := nil;
    arrDisliked.Free;
    arrDisliked := nil;
    // Create lists
    arrLiked := TList<TAiPlace>.Create();
    arrDisliked := TList<TAiPlace>.Create();
    // Now Update UI, so do it im the main thread
    iSwipeIndex := 0;
    TThread.Synchronize(nil, procedure()
    begin
      // Create Card
      FillPlaceCard(arrSwipePlaces[iSwipeIndex]);
      // Display
      SwitchScreenTab(6, laySwipeBackground, pcScreens);
    end);
    bLoadingTrip := false;
  end);
end;

procedure TfrmCitySwipe.DisplayError(Sender: TObject; sError: string);
begin
  ShowScreenPopup(1, 'Error While Contacting Our AI',
    'Please Restart Your App And Chek Your Internet Connection. Error: ' + sLineBreak + sError, true);
  ResetMenu;
end;

/// --- Actual Swipe Cards Methods --- \\\
procedure TfrmCitySwipe.AddImage(sPlaceID: string);
var
  ms: TMemoryStream;
  httpCli: TNetHTTPClient;
  respResponse: IHTTPResponse;
  bmpTemp: TBitmap;
  sImageUrl: string;
begin
  if dicImages.ContainsKey(sPlaceID) then
    exit;
  // Get ImageUrl
  sImageUrl := objGoogleMaps.PullImageUrl(sPlaceID,
    Round(imgMainCard.Size.Height));
  if sImageUrl = '' then
  begin
    dicImages.Add(sPlaceID, imgReusedIcons.Bitmap(TSize.Create(480, 720), 2));
    exit;
  end;
  // Start Client
  httpCli := TNetHTTPClient.Create(nil);
  try
    // Create Memoery Stream To Stream Image
    httpCli.UserAgent := 'Delphi/4.0 (compatible; Delphi; HttpClient)';
    ms := TMemoryStream.Create();
    try
      // Get Image
      respResponse := httpCli.Get(sImageUrl, ms);
      if respResponse.StatusCode <> 200 then
      begin
        ShowScreenPopup(1, 'Error While Loading Image',
          Format('HTTP Error=%s %s', [respResponse.StatusCode,
          respResponse.StatusText]), true);
      end
      else
      begin
        // Load Image Into Bitmap Array
        ms.Position := 0;
        bmpTemp := TBitmap.Create;
        try
          bmpTemp.LoadFromStream(ms);
          // Check Again, incase threads were out of sync or user already exited swiping
          if (dicImages = nil) or (dicImages.ContainsKey(sPlaceID)) then
            exit;
          // Add To Dictionary
          dicImages.Add(sPlaceID, bmpTemp);
        except
          bmpTemp.Free;
          raise;
        end;
      end;
    finally
      ms.Free;
    end;
  finally
    httpCli.Free;
  end;
end;

function GetOpaqueBounds(Bmp: TBitmap; AlphaThreshold: Byte = 0): TRectF;
var
  Data          : TBitmapData;
  x, y          : Integer;
  C             : TAlphaColorRec;
  MinX, MinY,
  MaxX, MaxY    : Integer;
begin
  Result := TRectF.Empty;

  if (Bmp = nil) or (Bmp.Width = 0) or (Bmp.Height = 0) then
    Exit;

  if not Bmp.Map(TMapAccess.Read, Data) then
    Exit;
  try
    MinX :=  Bmp.Width;   MinY :=  Bmp.Height;
    MaxX := -1;           MaxY := -1;

    for y := 0 to Bmp.Height - 1 do
      for x := 0 to Bmp.Width - 1 do
      begin
        C := TAlphaColorRec(Data.GetPixel(x, y));
        if C.A > AlphaThreshold then
        begin
          if x < MinX then MinX := x;
          if x > MaxX then MaxX := x;
          if y < MinY then MinY := y;
          if y > MaxY then MaxY := y;
        end;
      end;

    if (MaxX >= MinX) and (MaxY >= MinY) then
      // +1 on right/bottom because TRectF’s Right/Bottom are open bounds
      Result := TRectF.Create(MinX, MinY, MaxX + 1, MaxY + 1);
  finally
    Bmp.Unmap(Data);
  end;
end;

procedure AssignImage(DestImage : TImage; SrcBitmap : TBitmap; CornerRad : Single = 20);
var
  TargetW, TargetH : Integer;
  FinalW, FinalH : Single;
  Scale : Single;
  DstLeft, DstDown : Single;
  TmpBmp, FinalBmp : TBitmap;
  Path : TPathData;
  SrcRect : TRectF;
begin
  // All FMX canvas work must happen on the main thread
  TThread.Synchronize(nil,
    procedure
    begin
      // Crop Transparent Edges
      SrcRect := GetOpaqueBounds(SrcBitmap, 8);
      // If no edges, use original size
      if SrcRect.IsEmpty then
        SrcRect := TRectF.Create(0, 0, SrcBitmap.Width, SrcBitmap.Height);

      // 2. Scaling / centering
      TargetW := Round(DestImage.Width);
      TargetH := Round(DestImage.Height);
      if (TargetW = 0) or (TargetH = 0) then
      begin
        TargetW := Round(SrcRect.Width);   // sane fallback
        TargetH := Round(SrcRect.Height);
      end;

      // Use the larger scale factor so that both axes fill
      Scale   := Max(TargetW / SrcRect.Width, TargetH / SrcRect.Height);
      FinalW  := SrcRect.Width * Scale;
      FinalH  := SrcRect.Height * Scale;

      DstLeft := (TargetW - FinalW) / 2;
      DstDown  := (TargetH - FinalH) / 2;

      // Draw the cropped bitmap into a temporary surface
      TmpBmp := TBitmap.Create;
      try
        TmpBmp.SetSize(TargetW, TargetH);
        // fully transparent background
        TmpBmp.Clear(TAlphaColors.Null);

        TmpBmp.Canvas.BeginScene;
        try
          TmpBmp.Canvas.DrawBitmap(
            SrcBitmap,
            TRectF.Create(0, 0, SrcBitmap.Width, SrcBitmap.Height),    // source
            TRectF.Create(DstLeft, DstDown, DstLeft + FinalW, DstDown + FinalH), // dest
            1.0,   // full opacity
            True   // high-quality sampling
          );
        finally
          TmpBmp.Canvas.EndScene;
        end;

        // Paint that temporary bitmap through a rounded mask
        FinalBmp := TBitmap.Create;
        try
          FinalBmp.SetSize(TargetW, TargetH);
          FinalBmp.Clear(TAlphaColors.Null);

          // Build a rounded-rectangle path that covers the whole target
          Path := TPathData.Create;
          try
            Path.AddRectangle(TRectF.Create(0, 0, TargetW, TargetH),
                              CornerRad, CornerRad,
                              AllCorners, TCornerType.Round);

            FinalBmp.Canvas.BeginScene;
            try
              FinalBmp.Canvas.Fill.Kind := TBrushKind.Bitmap;
              FinalBmp.Canvas.Fill.Bitmap.Bitmap   := TmpBmp;
              FinalBmp.Canvas.Fill.Bitmap.WrapMode := TWrapMode.Tile; // 1-to-1 mapping
              FinalBmp.Canvas.FillPath(Path, 1.0);  // draw through the mask
            finally
              FinalBmp.Canvas.EndScene;
            end;
          finally
            Path.Free;
          end;

          // Assign Image
          DestImage.Bitmap.Assign(FinalBmp);
        finally
          FinalBmp.Free;
        end;
      finally
        TmpBmp.Free;
      end;
    end);
end;

procedure TfrmCitySwipe.FillPlaceCard(objPlace: TAiPlace);
var
  objBubble : TBubbleText;
  layBubble : TLayout;
  imgBubbleImage : TGlyph;
  lblBubbleText : TLabel;
  layBubbleText : TTextLayout;
  i : integer;
begin
  // Reset Caption
  recDarkenCard.Opacity := 0;
  lblCaption.Height := lblCaption.Tag;
  lblLocation.Height := lblLocation.Tag;
  lblPlaceTitle.Height := lblPlaceTitle.Tag;
  lblCaption.TagFloat := -1;
  lblLocation.TagFloat := -1;
  lblPlaceTitle.TagFloat := -1;
  // Set Type
  lblPlaceType.Text := 'Swipe On This ' + objPlace.PlaceType;
  // Fill The Active Card With New Place Info
  lblPlaceTitle.Text := objPlace.ActivityName;
  lblLocation.Text := 'Inside ' + objPlace.DisplayName;
  lblCaption.Text := objPlace.Description;
  lblPrice.Text := objPlace.AvgPrice;
  // FIll GoogleMapsLink Button
  btnOpenLink.TagString := objPlace.GoogleMapsLink;
  /// Fill Bubbles
  // Clear Bubbles
  for i := layBubbles.ControlsCount-1 downto 0 do
  begin
    if (layBubbles.Controls[i] is TLayout) and (TLayout(layBubbles.Controls[i]) <> layBubbleTemplate) then
    begin
      layBubbles.Controls[i].Free;
    end;
  end;
  layBubbleTemplate.Visible := false;
  // Create Bubbles (only first 2, if theres more then 2)
  layBubbleText := TTextLayoutManager.DefaultTextLayout.Create();
  for i := 0 to Math.Min(1, length(objPlace.BubbleText)-1) do
  begin
    objBubble := objPlace.BubbleText[i];
    layBubble := TLayout(layBubbleTemplate.Clone(frmCitySwipe));
    // 1 = Image ; 2 = Text
    imgBubbleImage := TGlyph(FindByTag(layBubble, 1));
    imgBubbleImage.ImageIndex := objBubble.Icon;
    lblBubbleText := TLabel(FindByTag(layBubble, 2));
    lblBubbleText.Text := objBubble.Text;
    layBubble.Parent := layBubbles;
    layBubble.Visible := true;
    // Set Size
    with layBubbleText do
    begin
      BeginUpdate;
      Font.Assign(lblBubbleText.TextSettings.Font);
      MaxSize := TSizeF.Create(100000, lblBubbleText.Height);
      WordWrap := false;
      Text := lblBubbleText.Text;
      HorizontalAlign := TTextAlign.Leading;
      VerticalAlign := TTextAlign.Center;
      EndUpdate;
    end;
    layBubble.Width := imgBubbleImage.Width + (imgBubbleImage.Margins.Left * 2) + imgBubbleImage.Margins.Right + layBubbleText.Width + 5;
  end;
  layBubbleText.Free;
  // Get Image Or Wait For Image To Be Loaded
  TTask.Run(
    procedure()
    var
      bmImage: TBitmap;
      iCurrentIndex: integer;
    begin
      iCurrentIndex := iSwipeIndex;
      // Load Default
      imgMainCard.WrapMode := TImageWrapMode.Stretch;
      AssignImage(imgMainCard, imgReusedIcons.Bitmap(TSize.Create(480, 720), 2));

      // Wait For Image To Download
      while (dicImages <> nil) and (not dicImages.TryGetValue(objPlace.placeId, bmImage)) do
        TThread.Sleep(1000);

      // If user exited the trip before image loaded
      if dicImages = nil then
        exit;

      // Check if User is on same place
      if iCurrentIndex = iSwipeIndex then
      begin
        imgMainCard.WrapMode := TImageWrapMode.Fit;
        AssignImage(imgMainCard, bmImage);
      end;
    end);
  // Redraw
  layMainCard.Repaint;
  // Load Future Image, In a New Thread
  TTask.Run(
    procedure
    begin
      if arrSwipePlaces.Count - 3 > iSwipeIndex then
      begin
        AddImage(arrSwipePlaces[iSwipeIndex + 2].placeId);
      end;
    end);
end;

procedure TfrmCitySwipe.SwipeCard(objNewPlace: TAiPlace);
var
  bmPreviousCard: TBitmap;
begin
  // Create And Set Screenshot
  bmPreviousCard := layMainCard.MakeScreenshot();
  imgCardSwipe.Bitmap.Assign(bmPreviousCard);
  imgCardSwipe.Visible := true;
  // Set Card Details
  FillPlaceCard(objNewPlace);
  // Start DragCard Animations
  aniDragCardOp.Start;
  aniDragCardRot.Start;
  aniDragCardPosX.Start;
  aniDragCardPosY.Start;
  // Start MainCard Animation
  aniMainPosY.Start;
  aniMainRotation.Start;
  aniMainOp.Start;
end;

procedure TfrmCitySwipe.recSwipeButtonClick(Sender: TObject);
var
  iDir: integer;
begin
  // Debounce
  if bSwipeDebounce then
    exit;
  bSwipeDebounce := true;
  TTask.Run(
    procedure()
    begin
      TThread.Sleep(500);
      bSwipeDebounce := false;
    end);
  // Set Animation Direction
  iDir := TButton(Sender).Tag;
  aniDragCardRot.StopValue := Abs(aniDragCardRot.StopValue) * iDir;
  aniDragCardPosX.StopValue := Abs(aniDragCardPosX.StopValue) * iDir;
  aniMainRotation.StartValue := Abs(aniMainRotation.StartValue) * iDir * -1;
  // Add Object To Array
  if iDir = 1 then
    arrLiked.Add(arrSwipePlaces[iSwipeIndex])
  else
    arrDisliked.Add(arrSwipePlaces[iSwipeIndex]);
  // Swipe
  if iSwipeIndex < arrSwipePlaces.Count - 1 then
  begin
    iSwipeIndex := iSwipeIndex + 1;
    SwipeCard(arrSwipePlaces[iSwipeIndex]);
  end
  else
  begin
    GetFinalTrip();
  end;
end;

procedure TfrmCitySwipe.lblCaptionClick(Sender: TObject);
var
  Layout: TTextLayout;
  lblLabel: TLabel;
  MaxHeight: Single;
begin
  lblLabel := TLabel(Sender);
  // Check Open or Close
  // Pos = Currently Open ; Neg = Currently Closed
  if lblLabel.TagFloat <= 0 then
  begin
    if lblLabel.TagFloat = 0 then
      lblLabel.TagFloat := -1;
    // Get Caption Size
    Layout := TTextLayoutManager.DefaultTextLayout.Create;
    try
      Layout.BeginUpdate;
      Layout.Font.Assign(lblLabel.TextSettings.Font);
      Layout.MaxSize := TSizeF.Create(lblLabel.Width, 1000);
      // fixed width, variable height
      Layout.WordWrap := true;
      Layout.Text := lblLabel.Text;
      Layout.HorizontalAlign := TTextAlign.Leading;
      Layout.VerticalAlign := TTextAlign.Leading;
      Layout.EndUpdate;

      MaxHeight := Layout.Height + 10;
    finally
      Layout.Free;
    end;
    // Set and Start Animations
    aniShowText.Parent := lblLabel;
    aniShowText.StopValue := MaxHeight;
    aniShowText.Start;
    aniDarkenCard.Start;
    // Increase Count
    iTextOpenCount := iTextOpenCount + 1;
  end
  else
  begin
    aniHideText.Parent := lblLabel;
    aniHideText.StopValue := lblLabel.Tag;
    aniHideText.Start;
    // If user opens 2 texts, and closes one, keep the background dim.
    iTextOpenCount := iTextOpenCount - 1;
    if iTextOpenCount <= 0 then
      aniLightenCard.Start;
  end;

  lblLabel.TagFloat := lblLabel.TagFloat * -1;
end;

procedure TfrmCitySwipe.btnOpenLinkClick(Sender: TObject);
var
  btnButton: TControl;
begin
  // Check If Valid Link
  btnButton := TControl(Sender);
  if btnButton.TagString = '' then
  begin
    ShowScreenPopup(1, 'Cant Open Link',
      'We Are Unable To Find This Place GoogleMapsLink', true);
    exit;
  end;

  // Open Link
  TURLLauncher.Open(btnButton.TagString);
end;

/// --- Get Final Trip --- \\\
function SearchForPlaceID(arrArray: TList<TAiPlace>; sPlaceID: string)
  : TAiPlace;
var
  objPlace: TAiPlace;
begin
  for objPlace in arrArray do
  begin
    if objPlace.placeId = sPlaceID then
    begin
      Result := objPlace;
      exit;
    end;
  end;
end;

procedure FillJsonArray(out jsonArray: TJSONArray; arrArray: TList<TAiPlace>);
var
  objPlace: TAiPlace;
  jsonTemp: TJsonObject;
  objBubble: TBubbleText;
  sBubble: string;
begin
  jsonArray := TJSONArray.Create();
  for objPlace in arrArray do
  begin
    jsonTemp := TJson.ObjectToJsonObject(objPlace);
    jsonTemp.RemovePair('Distance');
    jsonTemp.RemovePair('BubbleText');

    sBubble := '';
    for objBubble in objPlace.BubbleText do
      sBubble := sBubble + objBubble.Text;
    jsonTemp.AddPair('Highlights', sBubble);

    jsonArray.Add(jsonTemp);
  end;
end;

function TfrmCitySwipe.CreateFinalTripInput(): string;
var
  jsonFinal, jsonGroupSettings: TJsonObject;
  jsonLiked, jsonDisliked: TJSONArray;
  sFinal: string;
begin
  Result := '';
  // Fill Selection
  FillJsonArray(jsonLiked, arrLiked);
  FillJsonArray(jsonDisliked, arrDisliked);
  // Group Personality
  objGoogleMaps.GetGroupSettings(jsonGroupSettings, iCurrentGroupId);
  // Trip Settings Already Created
  if jsonNewTripSettings = nil then
  begin
    ShowScreenPopup(1, 'Unable To Get Trip Settings',
      'We are unable to get your trip settings, please restart your app',
      false);
    exit;
  end;
  // Create Input
  jsonFinal := TJsonObject.Create;
  jsonFinal.AddPair('LikedPlaces', jsonLiked);
  jsonFinal.AddPair('DislikedPlaces', jsonDisliked);
  jsonFinal.AddPair('GroupPersonality', jsonGroupSettings);
  jsonFinal.AddPair('TripSettings', jsonNewTripSettings);
  // Convert To String
  sFinal := jsonFinal.ToJSON([]);
  sFinal := sFinal.Replace('\/', '/');
  Result := sFinal;
end;

procedure TfrmCitySwipe.GetFinalTrip();
var
  sBase, sInput: string;
begin
  bLoadingTrip := true;
  StartLoadingScreen();
  // Get Input
  sInput := CreateFinalTripInput();
  if sInput = '' then
    exit;
  // Create Prompt
  sBase := TFile.ReadAllText(TPath.Combine(dmDataComponents.sDataFolder,
    'prompt_GetRoute5.txt'));
  sPrompt := sBase + sInput + sLineBreak + '```';
  // Global Var > Refrence when retrying

  // Save Prompt (debugging)
  {
  var txt : tectfile;
  AssignFile(txt, 'FinalTripPrompt.txt');
  Rewrite(txt);
  Writeln(txt, sPrompt);
  CloseFile(txt);
  }

  /// Send To AI
  // Send Request
  lblTripStatus.Text :=
    'Status: Waiting For Ai To Create Trip. This Might Up To 5 Minutes';
  iDeepseekAttempts := 0;
  SendDeepseekRequest(RecievedAiTrip);
end;

function JsonArrayToList(jsonArray: TJSONArray): TList<string>;
var
  V: TJSONValue;
begin
  Result := TList<string>.Create;
  for V in jsonArray do
    if V is TJSONString then
      Result.Add(TJSONString(V).Value)
    else
      // fallback for numbers, objects…
      Result.Add(V.ToJSON);
end;

procedure TfrmCitySwipe.GetPlaceObjectsFromPlaceId(arrIds : TList<string> ; out arrPlaces : TList<TAiPlace>);
var
  sId : string;
  objPlace : TAiPlace;
begin
  arrPlaces := TList<TAiPlace>.Create;
  if (arrIds = nil) or (arrIds.Count <= 0) then
  begin
    exit;
  end;
  for sId in arrIds do
  begin
    objPlace := SearchForPlaceID(arrLiked, sId);
    arrPlaces.Add(objPlace);
  end;
end;

procedure TfrmCitySwipe.RecievedAiTrip(Sender: TObject; Value: TChat);
var
  sID: string;
  jsonResponse: TJsonObject;
  jsonHonrable : TJsonArray;
  arrActIds, arrRestIds, arrHonActIds, arrHonRestIds: TList<string>;
  bError: boolean;
  objPlace: TAiPlace;
  I: integer;
  ImageArray: TArray<TPair<string, TBitmap>>;
  sImageID: string;
begin
  // Process Stream
  if not ProcessStream(Value) then
    exit;

  // Check if infinite whitespace glitch
  if sResponse.Trim = '' then
  begin
    if iDeepseekAttempts >= 3 then
    begin
      ShowScreenPopup(1, 'Error',
        'Deepseek Glitched And Returned a Empty Object', true);
      ResetMenu();
    end
    else
      // Ask Deepseek To Try Again
      ShowScreenPopup(0, 'Information',
        'Deepseek Glitched And Returned a Empty Object, we are retrying', true);
      SendDeepseekRequest(RecievedAiCards);
    exit;
  end;
  if sResponse[sResponse.Length] <> '}' then
    sResponse := sResponse + '}';

  // Check Response
  if not TJsonReader.IsValidJSON(sResponse, jsonResponse) then
  begin
    if iDeepseekAttempts >= 3 then
    begin
      ShowScreenPopup(1, 'Error',
        'Deepseek Could Not Provide Us a Valid Json File', true);
      ResetMenu;
    end
    else
      // Ask Deepseek To Try Again
      ShowScreenPopup(0, 'Information',
        'Deepseek Could Not Provide Us a Valid Json File, We are retrying', true);
      SendDeepseekRequest(RecievedAiTrip);
    exit;
  end;
  // Check If AI Returned a error
  if jsonResponse.TryGetValue<boolean>('Error', bError) then
  begin
    ShowScreenPopup(1, 'Error',
      'Deepseek Returned The Following Error. Please Restart Your App: ' +
      sLineBreak + jsonResponse.GetValue<string>('Message'), true);
    ResetMenu;
    exit;
  end;
  // Save For Debugging
  {$IFDEF MSWINDOWS}
  var txt : Textfile;
  AssignFile(txt, 'FinalTrip.txt');
  Rewrite(txt);
  Writeln(txt, TJson.ObjectToJsonString(Value));
  CloseFile(txt);
  AssignFile(txt, 'arrLiked.txt');
  Rewrite(txt);
  Writeln(txt, TJson.ObjectToJsonString(arrLiked));
  CloseFile(txt);
  {$ENDIF}
  // Clean Old Memory
  arrHonrableAct.Free;
  arrHonrableAct := nil;
  arrHonrableRest.Free;
  arrHonrableRest := nil;
  // Convert JsonObject To JsonArray
  arrActIds := JsonArrayToList(jsonResponse.GetValue<TJSONArray>('Activities'));
  arrRestIds := JsonArrayToList(jsonResponse.GetValue<TJSONArray>('Restaurants'));
  rTripTotal := jsonResponse.GetValue<real>('Total');
  // Get Honrable Mentions
  arrHonActIds := TList<string>.Create();
  arrHonRestIds := TList<string>.Create();
  if jsonResponse.TryGetValue<TJsonArray>('HonorableActivities', jsonHonrable) then
    arrHonActIds := JsonArrayToList(jsonHonrable);
  if jsonResponse.TryGetValue<TJsonArray>('HonorableRestaurants', jsonHonrable) then
    arrHonRestIds := JsonArrayToList(jsonHonrable);

  GetPlaceObjectsFromPlaceId(arrHonActIds, arrHonrableAct);
  GetPlaceObjectsFromPlaceId(arrHonRestIds, arrHonrableRest);
  // Delete Images From Memoery, Which Is Not Included In Final Trip
  ImageArray := dicImages.ToArray;
  for I := High(ImageArray) downto 0 do
  begin
    sImageID := ImageArray[I].Key;
    if (not arrActIds.Contains(sImageID)) and
      (not arrRestIds.Contains(sImageID)) and
      (not arrHonActIds.Contains(sImageID)) and
      (not arrHonRestIds.Contains(sImageID)) then
      dicImages.Remove(sImageID);
  end;
  /// Fill UI
  // Clear UI
  ClearUI(scrAcivityItems.Content, recPlaceTemplate);
  ClearUI(scrResturantItems.Content, recPlaceTemplate);
  // Set Text
  lblBudgetSummary.Text := 'Est. Per Person: ' + FloatToStrF(rTripTotal,
    ffCurrency, 8, 2);
  // Reset Tab
  pcCatagories.TabIndex := 0;
  recResturants.Opacity := 0.5;
  recActivites.Opacity := 1;
  // Fill Activities
  I := 0;
  arrFinalAct := TList<TAiPlace>.Create();
  for sID in arrActIds do
  begin
    objPlace := SearchForPlaceID(arrLiked, sID);
    CreateTripPlace(objPlace, scrAcivityItems, I);
    arrFinalAct.Add(objPlace);
    inc(I);
  end;
  scrAcivityItems.RecalcSize;
  scrAcivityItems.RecalcUpdateRect;
  scrAcivityItems.UpdateRect;
  // Fill Restaurants
  I := 0;
  arrFinalRest := TList<TAiPlace>.Create;
  for sID in arrRestIds do
  begin
    objPlace := SearchForPlaceID(arrLiked, sID);
    CreateTripPlace(objPlace, scrResturantItems, I);
    arrFinalRest.Add(objPlace);
    inc(I);
  end;
  scrResturantItems.RecalcSize;
  scrResturantItems.RecalcUpdateRect;
  scrResturantItems.UpdateRect;
  // Set To Dont Save (0 = Dont Save ; 1 = Save)
  btnSaveAndClose.Tag := 1;
  btnSaveAndClose.Text := 'Save And Close';
  // Free Some Objects
  dicRadioGroup.Free;
  dicRadioGroup := nil;
  arrSwipePlaces.Free;
  arrSwipePlaces := nil;
  arrLiked.Free;
  arrLiked := nil;
  arrDisliked.Free;
  arrDisliked := nil;
  arrActIds.Free;
  arrRestIds.Free;
  arrHonActIds.Free;
  arrHonRestIds.Free;
  // Display Screen
  SwitchScreenTab(5, layFinalBackground, pcScreens);
  bLoadingTrip := false;
end;

procedure TfrmCitySwipe.CreateTripPlace(objPlace: TAiPlace; scrTab: TScrollBox; iIndex : integer; recClone : TRectangle = nil; bShowSwape : boolean = true);
var
  imgImage: TImage;
  bmpImage: TBitmap;
  lblText: TLabel;
  ctrlButton: TControl;
  iPos : Single;
begin
  // Clone Template Or Else Skip And Just Edit
  if recClone = nil then
    recClone := TRectangle(recPlaceTemplate.Clone(frmCitySwipe))
  else
    iPos := recClone.Position.Y;
  recClone.Name := '';
  // Update Text
  // 1 = Image
  imgImage := TImage(FindByTag(recClone, 1));
  if dicImages.TryGetValue(objPlace.placeId, bmpImage) then
    AssignImage(imgImage, bmpImage)
  else
    AssignImage(imgImage, imgReusedIcons.Bitmap(TSize.Create(480, 720), 2));
  // 2 = Title ; 3 = Distance ; 4 = Price ; 5 = Open Times
  lblText := TLabel(FindByTag(recClone, 2));
  lblText.Text := objPlace.ActivityName;
  lblText := TLabel(FindByTag(recClone, 3));
  lblText.Text := FloatToStr(objPlace.Distance) + ' km';
  lblText := TLabel(FindByTag(recClone, 4));
  lblText.Text := objPlace.AvgPrice;
  lblText := TLabel(FindByTag(recClone, 5));
  lblText.Text := objPlace.OpenTimes;
  // 6 = Open Maps
  ctrlButton := TControl(FindByTag(recClone, 6));
  ctrlButton.TagString := objGoogleMaps.GetMapsLink(objPlace.placeId);
  ctrlButton.OnClick := btnOpenLinkClick;
  // 7 = Swap Item
  ctrlButton := TControl(FindByTag(recClone, 7));
  ctrlButton.TagFloat := iIndex; // Save Position in arrFinal
  ctrlButton.Parent.Tag := IfThen(objPlace.PlaceType = 'Restaurant', 1, 0);
  ctrlButton.OnClick := recChangeActivityClick;
  ctrlButton.Visible := bShowSwape;
  // Parent Or Reposition To Keep Layout Order
  if recClone.Parent <> scrTab then
    recClone.Parent := scrTab.Content
  else
    recClone.Position.Y := iPos;
  // Visible
  recClone.Visible := true;
end;

/// --- Final Trip Button --- \\\
procedure TfrmCitySwipe.ChangeFinalTripTab(Sender: TObject);
begin
  pcCatagories.TabIndex := TControl(Sender).Tag;
  recResturants.Opacity := 0.5;
  recActivites.Opacity := 0.5;
  TRectangle(Sender).Opacity := 1;
end;

procedure TfrmCitySwipe.recChangeActivityClick(Sender: TObject);

  procedure ReplaceCard(out arrHonrablePlaces, arrAllPlaces : TList<TAiPlace> ; ctrlBase : TFmxObject ; iIndex : Real);
  var
    objNewPlace : TAiPlace;
    scrlParent : TScrollBox;
  begin
    if (arrHonrablePlaces <> nil) and (arrHonrablePlaces.Count > 0) then
    begin
      // Get New Place
      objNewPlace := arrHonrablePlaces[0];
      // Update Arrays
      arrAllPlaces[Trunc(iIndex)] := objNewPlace;
      arrHonrablePlaces.Remove(objNewPlace);
      // Update UI
      if objNewPlace.PlaceType = 'Restaurant' then
        scrlParent := scrResturantItems
      else
        scrlParent := scrAcivityItems;
      scrlParent.BeginUpdate;
      CreateTripPlace(objNewPlace, scrlParent, Trunc(iIndex), TRectangle(ctrlBase));
      scrlParent.EndUpdate;
    end
    else
    begin
      ShowScreenPopup(1, 'No More SwapOuts', 'We Have No More Places To Swap Out. Sorry.', true)
    end;
  end;

var
  ctrlControl, ctrlBase : TFmxObject;
begin
  // Find Rectangle Containing All Trip Info (first ancestor of class TRec)
  // Type Place stored in parent's tag, to be able to search for the button again by its tag of 7
  ctrlControl := TControl(Sender).Parent;
  ctrlBase := ctrlControl;
  repeat
    ctrlBase := ctrlBase.Parent;
  until ctrlBase is TRectangle;
  // 0: Activity ; 1: Restaurant
  if ctrlControl.Tag = 0 then
  begin
    ReplaceCard(arrHonrableAct, arrFinalAct , ctrlBase, TControl(Sender).TagFloat);
  end
  else if ctrlControl.Tag = 1 then
  begin
    ReplaceCard(arrHonrableRest, arrFinalRest, ctrlBase, TControl(Sender).TagFloat);
  end;
end;

function ListToJsonArray(arrList : TList<TAiPlace>) : TJsonArray;
var
  objPlace : TAiPlace;
begin
  Result := TJSONArray.Create;
  for objPlace in arrList do
    Result.AddElement(TJson.ObjectToJsonObject(objPlace));
end;

procedure TfrmCitySwipe.btnSaveAndCloseClick(Sender: TObject);
var
  sFolderPath, sNameList, sFilePath, sTripName : string;
  iKey : integer;
  jsonTrip : TJsonObject;
begin
  if TControl(Sender).Tag = 1 then
  begin
    // Create Save Folder
    sFolderPath := TPath.Combine(dmDataComponents.sDataFolder, 'SavedTrips');
    if not TDirectory.Exists(sFolderPath) then
      TDirectory.CreateDirectory(sFolderPath);

    /// Save Trip Database
    with dmDataComponents do
    begin
      // Set Feilds
      qryDatabase.SQL.Text := 'Insert Into PreviousTrips(GroupID, TripName, ActivityNameList, TripFile, DateAdded, BudgetPerPerson)';
      qryDatabase.SQL.Add('VALUES (:GroupID, :TripName, :NameList, :TripFile, :Date, :BudgetPerPerson)');

      TDialogService.InputQuery('Trip Name', ['Please Enter a Name For This Trip: '], [TripAdjectives[Random(Length(TripAdjectives))] + ' Trip'],
      procedure(const AResult: TModalResult; const AValues: array of string)
      var
        objPlace : TAiPlace;
      begin
        sTripName := AValues[0];

        qryDatabase.ParamByName('GroupID').AsInteger := iCurrentGroupId;
        qryDatabase.ParamByName('TripName').AsString := STripName;
        qryDatabase.ParamByName('TripFile').AsString := sFilePath;
        qryDatabase.ParamByName('Date').AsString := FormatDateTime('dd MMMM yyyy hh:mm', Now);
        qryDatabase.ParamByName('BudgetPerPerson').AsFloat := rTripTotal;

        sNameList := '';
        for objPlace in arrFinalAct do
          sNameList := sNameList + objPlace.ActivityName + ', ';
        qryDatabase.ParamByName('NameList').AsString := Copy(sNameList.Trim, 0, sNameList.Trim.Length - 1);
        // Exucute
        qryDatabase.ExecSQL;

        /// Save Trip File
        // Get New Primary Key
        qryDatabase.SQL.Text := 'Select TripID From PreviousTrips Order By TripID DESC';
        qryDatabase.Open();
        qryDatabase.First;
        iKey := qryDatabase.FieldByName('TripID').AsInteger;
        qryDatabase.Close;
        // Get FileSave
        sFilePath := TPath.Combine(sFolderPath, iKey.ToString + '.json');
        // Create Json
        jsonTrip := TJSONObject.Create;
        jsonTrip.AddPair('Activities', ListToJsonArray(arrFinalAct));
        jsonTrip.AddPair('Restaurants', ListToJsonArray(arrFinalRest));
        // Save
        TJsonReader.SaveJSONToFile(sFilePath, jsonTrip);

        // Return To Homepage
        ResetMenu();
      end);
    end;
  end
  else
    ResetMenu();
end;

/// --- Startup Methods --- \\\    \
procedure TfrmCitySwipe.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  if Action = TCloseAction.caHide then
  begin
    frmGroupCreation.OnClose := nil;
    SetupForm(frmCitySwipe);
  end;
end;
// OnShow
procedure TfrmCitySwipe.SetupForm(Sender: TObject);
var
  jsonConfig: TJsonObject;
  Point : TPointF;
begin
  frmCitySwipe.OnShow := nil;
  frmGroupCreation.Close();
  frmGroupCreation.Visible := false;
  /// UI And Data Reset Work
  dicRadioGroup := TDictionary<integer, string>.Create;
  bLoadingTrip := false;
  sDeepseekModel := 'deepseek-chat';
  // Setup Trackbar Refs
  trkDistanceSlider.TagObject := lblDistance;
  trkActivityCount.TagObject := lblActivityCount;
  trkBugetPerPerson.TagObject := lblBugetPerPerson;
  trkBugetPerPerson.TagString := 'None';
  lblDistance.TagString := '%km';
  lblActivityCount.TagString := '%';
  lblBugetPerPerson.TagString := 'R%';
  // Reset Tabs
  pcScreens.TabIndex := 0;
  pcTabs.TabIndex := 0;
  // Reset Popup
  iPopupOriginalHeight := recPopupContents.Height;
  ShowScreenPopup(0, 'Checking Groups',
    'Please Wait While We Check Our Groups Table', false);
  // Posiiotn Some Non-responsive UI Manually
  Point := TPointF.Create(0,0);
  Point.X := rcBackground.Position.X + (rcBackground.Width/2) - (recSelectModelBox.Width/2);
  Point.Y := rcBackground.Position.Y + rcBackground.Height - (recSelectModelBox.Height/2) + 9;
  recSelectModelBox.Position := TPosition.Create(Point);

  // Get API Keys
  jsonConfig := TJsonReader.LoadJSONFromFile(dmDataComponents.sConfigPath);
  sDeepseekAPI := jsonConfig.GetValue<string>('DeepseekAPI');

  // Create Google Maps API
  if not Assigned(objGoogleMaps) then
    objGoogleMaps := TGoogleMaps.Create();

  /// Check Group Table Record Count And Select First GroupID
  with dmDataComponents do
  begin
    qryDatabase.SQL.Text := 'Select * From Groups';
    qryDatabase.Open();

    if qryDatabase.RecordCount <= 0 then
    begin
      // Start Welcome Screen ****
      frmGroupCreation.OnShow := frmGroupCreation.StartWelcomeScreen;
      frmGroupCreation.layCancelButton.Visible := false;
      frmGroupCreation.OnClose := FormClose;

      // Queue Thread To Wait For Form To Load Before Displaying (andriod support)
      TThread.ForceQueue(nil, procedure()
      begin
        {$IFDEF ANDROID}
        frmGroupCreation.WindowState := TWindowState.wsMaximized;
        frmGroupCreation.BorderStyle := TFmxFormBorderStyle.None;
        {$ENDIF}
        frmGroupCreation.Show(); // ShowModal not supported by Andriod
      end);


      qryDatabase.Close();
      exit; // Dont Try to pull location yet.
    end
    else
    begin
      qryDatabase.First;
      iCurrentGroupId := qryDatabase.FieldByName('GroupID').AsInteger;
    end;

    qryDatabase.Close();
  end;

  // Get GPS Location
  ShowScreenPopup(0, 'Getting Your Current Location',
    'Please Wait While We Get Your Current Location', false);
  // Start New Thread, To Keep UI Updated
  // Using a Qeeue so the code waits till the UI loads before starting
  TThread.Queue(nil,
    procedure
    begin
      RequestLocationPremission();
    end);
  // City Info Pulled Inside NewLocationPulled
end;

end.

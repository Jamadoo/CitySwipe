unit GoogleMaps_u;

interface

uses
  Coordinate_u, dmDataComponents_u, JsonRead_u,
  System.SysUtils, System.StrUtils, System.Types, System.UITypes, System.Classes,
  System.Variants, System.JSON, FMX.Forms, System.Generics.Collections,
  System.Net.HttpClient, System.Net.URLClient, System.Net.HttpClientComponent,
  System.NetEncoding, FMX.DialogService, GoogleMapClass_u, Math, FireDAC.Stan.Param,
  REST.Json,  System.IOUtils, DateUtils;

type
  TGoogleMaps = class(TObject)
  private
    fCoordinate: TCoordinate;
    sApiKey : string;
    // Helper Functions
    function CreateLocationBias(Longitude, Latitude: Double; Radius: Double) : TJSONObject;
    function SendAPIReqesut(sUrl : string ; jsonBody: TJSONObject = nil ; sFieldMask : string = '';
      sMethod : string = 'POST'): IHTTPResponse;
    function SearchPlaces(sFieldMask: string;
      sSearchKeyword: string; iPlaceTotal: integer): TList<TPlace>;
    function NearbySearch(sFieldMask: string; iPlaceCount: integer; jsonIncludeType: TJSONArray)
      : TList<TPlace>;
    procedure SaveArrayToDatabase(arrPlaces: TList<TPlace>; sType: string);
  public
    constructor Create();
    // Main Functions
    procedure PullCityData();
    procedure FilterPlacesInDistance(iDistance: integer);
    function IsSameCity(sCurrentCity: string): boolean;
    function PullImageUrl(sPlaceID: string ; iMaxHeigh : integer): string;
    function GetAutocomplete(sText : string) : TList<TPlacePrediction>;
    function GetPlacesPrompt(iDistance, iGroupId: integer ; sPlacePrefe, sCityAddress : string): string;
    function GetPlaceLocation(sPlaceID : string) : TCoordinate;
    procedure RecalculateDistances();
    procedure GetGroupSettings(out jsonGroupSettings : TJsonObject ; iGroupId : integer);
    function GetMapsLink(sPlaceID : string) : string;
    procedure FillGoogleLink(out arrList : TList<TAiPlace>);
    function CalcPlacesDistance(objFromPoint : TCoordinate; objToPoint: TCoordinate) : integer;
    // Setters
    procedure UpdateUserCoordinate(objNewCoordinate : TCoordinate);
  end;

implementation

uses CitySwipe_u;

{ TGoogleMaps }

/// ---  Common Stuff --- \\\
constructor TGoogleMaps.Create();
var
  jsonConfig : TJSONObject;
begin
  // Get API Key
  jsonConfig := TJsonReader.LoadJSONFromFile(dmDataComponents.sConfigPath);
  if not Assigned(jsonConfig) then
  begin
    // If Config is missing, just say F you
    TDialogService.ShowMessage('Config File Missing. I will now die');
    Application.Terminate;
  end;
  sApiKey := jsonConfig.GetValue<string>('GoogleAPI');
end;
procedure TGoogleMaps.UpdateUserCoordinate(objNewCoordinate : TCoordinate);
begin
  fCoordinate := objNewCoordinate;
end;

/// --- Private Methods --- \\\
function TGoogleMaps.CreateLocationBias(Longitude, Latitude: Double; Radius: Double)
  : TJSONObject;
var
  Root, Circle, Center: TJSONObject;
begin
  // Create main object
  Root := TJSONObject.Create;

  // Nested structure: locationRestriction > circle > center
  Center := TJSONObject.Create;
  Center.AddPair('latitude', TJSONNumber.Create(Latitude));
  Center.AddPair('longitude', TJSONNumber.Create(Longitude));

  Circle := TJSONObject.Create;
  Circle.AddPair('center', Center);
  Circle.AddPair('radius', TJSONNumber.Create(Radius));

  Root.AddPair('circle', Circle);

  // Return the constructed object
  Result := Root;
end;

function TGoogleMaps.SendAPIReqesut(sUrl : string;
  jsonBody: TJSONObject ; sFieldMask: string ; sMethod : string): IHTTPResponse;
var
  HttpClient: TNetHTTPClient;
  HttpRequest: TNetHTTPRequest;
  HttpResponse: IHTTPResponse;
  sStringContent: TStringStream;
begin
  // Create Http Objects
  Result := nil;
  HttpClient := TNetHTTPClient.Create(nil);
  HttpRequest := TNetHTTPRequest.Create(nil);
  try
    // Setup
    HttpRequest.Client := HttpClient;
    HttpRequest.MethodString := sMethod;
    HttpRequest.CustomHeaders['Content-Type'] := 'application/json';
    HttpRequest.CustomHeaders['X-Goog-Api-Key'] := sApiKey;
    // Autocomplete baby doesnt want a fieldmask, so we gotta check
    if sFieldMask <> '' then
      HttpRequest.CustomHeaders['X-Goog-FieldMask'] := sFieldMask;
    // Create Body
    sStringContent := nil;
    if Assigned(jsonBody) then
      sStringContent := TStringStream.Create(jsonBody.ToJSON, TEncoding.UTF8);
    // Send Reqeust
    try
      if sMethod = 'POST' then
        HttpResponse := HttpRequest.Post(sUrl, sStringContent)
      else if sMethod = 'GET' then
        HttpResponse := HttpRequest.Get(sUrl, sStringContent);

      sStringContent.Free;
    except on E: Exception do
    begin
      frmCitySwipe.ShowScreenPopup(1, 'Network Error', E.Message, true);
      sStringContent.Free;
      exit;
    end;
    end;
  finally
    // Cleanup
    HttpClient.Free;
    HttpRequest.Free;
    jsonBody.Free;

    Result := HttpResponse;
  end;
end;

function TGoogleMaps.SearchPlaces(sFieldMask: string;
  sSearchKeyword: string; iPlaceTotal: integer): TList<TPlace>;
var
  sUrl, sPageToken: string;
  jsonActivitiesRequest, jsonLocationBias, jsonResponse: TJSONObject;
  JSONArr : TJsonArray;
  HttpResponse: IHTTPResponse;
  iPlaceRemaining: integer;
  arrPlaces, arrResponseArray: TList<TPlace>;
begin
  /// If we need more then 20 items > Use page tokens
  iPlaceRemaining := iPlaceTotal;
  sPageToken := '';
  arrPlaces := TObjectList<TPlace>.Create;
  repeat
    // Build Json Request
    jsonActivitiesRequest := TJSONObject.Create();
    // Get LocationBias
    jsonLocationBias := CreateLocationBias(fCoordinate.GetLongitude,
      fCoordinate.GetLatitude, 50000);
    // Put All Together - Keywords Based
    jsonActivitiesRequest.AddPair('textQuery',
      sSearchKeyword + fCoordinate.GetCity);
    jsonActivitiesRequest.AddPair('locationBias', jsonLocationBias);
    jsonActivitiesRequest.AddPair('pageSize', iPlaceRemaining);
    // Set Url
    sUrl := 'https://places.googleapis.com/v1/places:searchText';
    // Check PageToken
    if sPageToken <> '' then
    begin
      jsonActivitiesRequest.AddPair('pageToken', sPageToken);
    end;

    // Send Request
    HttpResponse := SendAPIReqesut(sUrl, jsonActivitiesRequest, sFieldMask);
    if HttpResponse = nil then
    begin
      Result := nil;
      exit;
    end;
    // Check Response
    if HttpResponse.StatusCode <> 200 then
    begin
      TDialogService.ShowMessage('Error While Contacting Google Maps: Code ' +
        HttpResponse.StatusText + #13#10 + HttpResponse.ContentAsString(TEncoding.UTF8));
      exit;
    end;
    // Serlilize Response
    jsonResponse := TJsonReader.StringToJSONObject
      (HttpResponse.ContentAsString(TEncoding.UTF8));
    if not Assigned(jsonResponse) then
    begin
      TDialogService.ShowMessage('Unable To Phrase Google Maps Response');
      exit;
    end;
    // Convert Json To Array of TPlace
    arrResponseArray := TList<TPlace>.Create();
    if jsonResponse.TryGetValue<TJSONArray>('places', JSONArr) then
      arrResponseArray := TJsonReader.DeserializePlaces(JSONArr);
    arrPlaces.AddRange(arrResponseArray);
    // Get PageToken
    jsonResponse.TryGetValue<string>('nextPageToken', sPageToken);
    iPlaceRemaining := Math.Max(iPlaceRemaining - 20, 0);
  until (iPlaceRemaining <= 0) or (sPageToken = '');

  arrResponseArray.Free;
  jsonResponse.Free;
  Result := arrPlaces;
end;

function TGoogleMaps.NearbySearch(sFieldMask: string; iPlaceCount: integer; jsonIncludeType: TJSONArray)
  : TList<TPlace>;
var
  jsonActivitiesRequest, jsonResponse: TJSONObject;
  JSONArr : TJsonArray;
  jsonLocationBias: TJSONObject;
  HttpResponse: IHTTPResponse;
  sUrl: string;
  arrPlaces: TList<TPlace>;
begin
  // Build Json Request
  jsonActivitiesRequest := TJSONObject.Create();
  // Get LocationBias
  jsonLocationBias := CreateLocationBias(fCoordinate.GetLongitude,
    fCoordinate.GetLatitude, 50000);
  // Put All Together
  jsonActivitiesRequest.AddPair('includedTypes', jsonIncludeType);
  jsonActivitiesRequest.AddPair('maxResultCount', iPlaceCount);
  jsonActivitiesRequest.AddPair('locationRestriction', jsonLocationBias);
  // Set Url
  sUrl := 'https://places.googleapis.com/v1/places:searchNearby';
  // Remove nextPage FieldMask
  sFieldMask := sFieldMask.Replace(',nextPageToken', '');

  // Send Request
  HttpResponse := SendAPIReqesut(sUrl, jsonActivitiesRequest, sFieldMask);
  if HttpResponse = nil then
  begin
    Result := nil;
    exit;
  end;
  // Check Response
  if HttpResponse.StatusCode <> 200 then
  begin
    TDialogService.ShowMessage('Error While Contacting Google Maps: Code ' +
      HttpResponse.StatusText + #13#10 + HttpResponse.ContentAsString(TEncoding.UTF8));
    exit;
  end;
  // Serlilize Response
  jsonResponse := TJsonReader.StringToJSONObject(HttpResponse.ContentAsString(TEncoding.UTF8));
  if not Assigned(jsonResponse) then
  begin
    TDialogService.ShowMessage('Unable To Phrase Google Maps Response');
    exit;
  end;
  // Convert Json To Array of TPlace
  arrPlaces := TList<TPlace>.Create();
  if jsonResponse.TryGetValue<TJSONArray>('places', JSONArr) then
    arrPlaces := TJsonReader.DeserializePlaces(JSONArr);
  // Free Memoery
  jsonResponse.Free;
  // Return
  Result := arrPlaces;
end;
function TGoogleMaps.GetPlaceLocation(sPlaceID : string) : TCoordinate;
var
  sUrl, sFieldMask, sLocality, sCountry, sState : string;
  HttpResponse : IHTTPResponse;
  jsonResponse : TJSONObject;
  objPlace : TPlace;
  objPlaceCoordinate : TCoordinate;
  objComp : TComponent;
begin
  // Get Place Details
  sUrl := 'https://places.googleapis.com/v1/places/' + sPlaceID;
  sFieldMask := 'location,addressComponents,formattedAddress';
  HttpResponse := SendAPIReqesut(sUrl, nil, sFieldMask, 'GET');
  if HttpResponse = nil then
  begin
    Result := nil;
    exit;
  end;
  // Check Response
  if HttpResponse.StatusCode <> 200 then
  begin
    frmCitySwipe.ShowScreenPopup(1, 'Error While Contacting Google Maps', 'Code' + HttpResponse.StatusText, true);
    exit;
  end;
  // Get Place
  jsonResponse := TJsonReader.StringToJSONObject(HttpResponse.ContentAsString(TEncoding.UTF8));
  objPlace := TJSON.JsonToObject<TPlace>(jsonResponse);
  // Get Location
  objPlaceCoordinate := TCoordinate.Create(objPlace.location.latitude, objPlace.location.longitude);
  objPlaceCoordinate.formattedAddress := objPlace.formattedAddress;
  // Get City
  sLocality := '';
  sCountry := '';
  sState := '';
  for objComp in objPlace.addressComponents do
  begin
    if Assigned(objComp.types) then
    begin
       if TArray.IndexOf<string>(objComp.types, 'locality') >= 0 then
       begin
         sLocality := objComp.longText;
       end
       else if TArray.IndexOf<string>(objComp.types, 'country') >= 0 then
       begin
         sCountry := objComp.longText;
       end
       else if TArray.IndexOf<string>(objComp.types, 'administrative_area_level_1') >= 0 then
       begin
         sState := objComp.longText;
       end;
    end;
  end;
  objPlaceCoordinate.SetCity(sLocality);
  objPlaceCoordinate.fCountry := sCountry;
  objPlaceCoordinate.fState := sState;
  // Return
  Result := objPlaceCoordinate;
end;

/// --- PlaceToDatabase Methods --- \\\
function AvgPrice(const Range : TPriceRange) : Integer;
var
  S, E : Integer;
begin
  Result := -1;
  if (not Assigned(Range)) or (not Assigned(Range.startPrice)) then
    exit;

  // Units come in as strings – convert safely; fallback to 0.
  // If theres only a fixed price
  S := StrToIntDef(Range.startPrice.units, 0);
  if not Assigned(Range.endPrice) then
  begin
    Result := S;
    exit;
  end;

  E := StrToIntDef(Range.endPrice.units  , 0);
  if (S <> 0) and (E <> 0) then
    Result := (S + E) div 2;
end;
function TGoogleMaps.CalcPlacesDistance(objFromPoint : TCoordinate ; objToPoint: TCoordinate) : integer;
const
  EarthRadiusKm = 6371.0; // Radius of Earth in kilometers
var
  dLat, dLon, a, c, lat1, lat2, lon1, lon2: Double;
begin
  // Covert Degrees to Rad
  lat1 := DegToRad(objFromPoint.GetLatitude);
  lon1 := DegToRad(objFromPoint.GetLongitude);
  lat2 := DegToRad(objToPoint.GetLatitude);
  lon2 := DegToRad(objToPoint.GetLongitude);
  // Get Diffrence
  dLat := lat2 - lat1;
  dLon := lon2 - lon1;
  // Fancy Math
  a := Sin(dLat / 2) * Sin(dLat / 2) +
       Cos(lat1) * Cos(lat2) *
       Sin(dLon / 2) * Sin(dLon / 2);
  c := 2 * ArcTan2(Sqrt(a), Sqrt(1 - a));

  // Convert to kilometers, then round to nearest integer
  Result := Round(EarthRadiusKm * c);
end;
function AccessibilityToString(objAcc : TAccessibilityOptions): string;
var
  sString : TStringBuilder;
begin
  Result := '';
  if not Assigned(objAcc) then
   exit;

  sString := TStringBuilder.Create;
  sString.AppendLine('wheelchairAccessibleParking: ' + BoolToStr(objAcc.wheelchairAccessibleParking, true));
  sString.AppendLine('wheelchairAccessibleEntrance: ' + BoolToStr(objAcc.wheelchairAccessibleEntrance, true));
  sString.AppendLine('wheelchairAccessibleRestroom: ' + BoolToStr(objAcc.wheelchairAccessibleRestroom, true));
  sString.AppendLine('wheelchairAccessibleSeating: ' + BoolToStr(objAcc.wheelchairAccessibleSeating, true));
  Result := sString.ToString;
end;
procedure TGoogleMaps.SaveArrayToDatabase(arrPlaces: TList<TPlace>; sType: string);
var
  objCurrentPlace: TPlace;
begin
  with dmDataComponents do
  begin
    // Start Transaction
    // If something fails, we roll back
    // Transactions also has a big performance win
    conDatabase.StartTransaction;
    // Setup Insert Command
    with qryDatabase do
    begin
      // Put Insert Command And Setup Params
      SQL.Clear;
      SQL.Add('INSERT INTO CityInfo (' +
        '  PlaceId, Distance, DisplayName, GoogleMapsLink, PhotoRef, PlaceTypes, PrimaryTypeDisplayName, '
        + '  AccessibilityOptions, CurrentOpeningHours, AvePrice, Rating, RatingCount, '
        + '  GenerativeSummary, EditorialSummary, ' +
        '  AllowsDogs, HasDelivery, HasDineIn, GoodForChildren, GoodForGroups, '
        + '  HasKidsMenu, IsReservable, ServesBeer, CitySwipeType, Location) ');
      SQL.Add('VALUES (' +
        '  :PlaceId, :Distance, :DisplayName, :GoogleMapsLink, :PhotoRef, :PlaceTypes, :PrimaryTypeDisplayName,'
        + '  :AccessibilityOptions, :CurrentOpeningHours, :AvePrice, :Rating, :RatingCount, '
        + '  :GenerativeSummary, :EditorialSummary, ' +
        '  :AllowsDogs, :HasDelivery, :HasDineIn, :GoodForChildren, :GoodForGroups,'
        + '  :HasKidsMenu, :IsReservable, :ServesBeer, :CitySwipeType, :Location)');
      // Speed Up Repeated ExecSQL With Prepare
      // qryDatabase.Prepared := True;
      // Loop Through Array
      try
        for objCurrentPlace in arrPlaces do
        begin
          if objCurrentPlace <> nil then
          begin
            // String
            qryDatabase.ParamByName('PlaceId').AsString := objCurrentPlace.iD;
            qryDatabase.ParamByName('Location').AsString := FloatToStr(objCurrentPlace.location.latitude) + ';' + FloatToStr(objCurrentPlace.location.longitude);
            // Calculations
            qryDatabase.ParamByName('Distance').AsInteger := CalcPlacesDistance(fCoordinate, objCurrentPlace.location);
            qryDatabase.ParamByName('GoogleMapsLink').AsString  := objCurrentPlace.googleMapsLinks.placeUri;
            qryDatabase.ParamByName('AvePrice').AsInteger := AvgPrice(objCurrentPlace.PriceRange);
            qryDatabase.ParamByName('Rating').AsFloat   := objCurrentPlace.Rating;
            qryDatabase.ParamByName('RatingCount').AsFloat   := objCurrentPlace.userRatingCount;

            // Checked Values, IfThen() raises an error.
            // Ugly, but would be ineffective to make effective
            if Assigned(objCurrentPlace.types) and (Length(objCurrentPlace.types) > 0) then
              qryDatabase.ParamByName('PlaceTypes').AsString  := string.Join(',', objCurrentPlace.Types)
            else
              qryDatabase.ParamByName('PlaceTypes').AsString  := '';
            if Assigned(objCurrentPlace.DisplayName) then
              qryDatabase.ParamByName('DisplayName').AsString := objCurrentPlace.DisplayName.Text
            else
              qryDatabase.ParamByName('DisplayName').AsString := '';
            if Assigned(objCurrentPlace.PrimaryTypeDisplayName) then
              qryDatabase.ParamByName('PrimaryTypeDisplayName').AsString := objCurrentPlace.PrimaryTypeDisplayName.Text
            else
              qryDatabase.ParamByName('PrimaryTypeDisplayName').AsString := '';
            if Length(objCurrentPlace.Photos) > 0 then
              qryDatabase.ParamByName('PhotoRef').AsString  := objCurrentPlace.Photos[0].Name
            else
              qryDatabase.ParamByName('PhotoRef').AsString := '';
            if Assigned(objCurrentPlace.CurrentOpeningHours) then
              qryDatabase.ParamByName('CurrentOpeningHours').AsString  :=
                string.Join(sLineBreak, objCurrentPlace.CurrentOpeningHours.weekdayDescriptions)
            else
              qryDatabase.ParamByName('CurrentOpeningHours').AsString  := 'Unknown';
            if objCurrentPlace.GenerativeSummary <> nil then
              qryDatabase.ParamByName('GenerativeSummary').AsString  :=
                objCurrentPlace.GenerativeSummary.overview.Text
            else
              qryDatabase.ParamByName('GenerativeSummary').AsString  := 'Unknown';
            if objCurrentPlace.EditorialSummary <> nil then
              qryDatabase.ParamByName('EditorialSummary').AsString  :=
                objCurrentPlace.EditorialSummary.Text
            else
              qryDatabase.ParamByName('EditorialSummary').AsString  := 'Unknown';

            // Booleans
            qryDatabase.ParamByName('AccessibilityOptions').AsString  := AccessibilityToString(objCurrentPlace.AccessibilityOptions);
            qryDatabase.ParamByName('AllowsDogs').AsString := BoolToStr(objCurrentPlace.AllowsDogs, true);
            qryDatabase.ParamByName('HasDelivery').AsString := BoolToStr(objCurrentPlace.Delivery, true);
            qryDatabase.ParamByName('HasDineIn').AsString := BoolToStr(objCurrentPlace.DineIn, true);
            qryDatabase.ParamByName('GoodForChildren').AsString := BoolToStr(objCurrentPlace.GoodForChildren, true);
            qryDatabase.ParamByName('GoodForGroups').AsString := BoolToStr(objCurrentPlace.GoodForGroups, true);
            qryDatabase.ParamByName('HasKidsMenu').AsString := BoolToStr(objCurrentPlace.MenuForChildren, true);
            qryDatabase.ParamByName('IsReservable').AsString := BoolToStr(objCurrentPlace.Reservable, true);
            qryDatabase.ParamByName('ServesBeer').AsString := BoolToStr(objCurrentPlace.ServesBeer, true);

            // CitySwipeType
            qryDatabase.ParamByName('CitySwipeType').AsString := sType;

            // End Single Command
            qryDatabase.ExecSQL;
          end;
        end;

        // All good – commit and end transaction
        conDatabase.Commit;
        qryDatabase.Close;
        // Close Popups
        frmCitySwipe.recPopup.Visible := false;
        frmCitySwipe.recPopup.HitTest := false;
      except on Error: Exception do
        begin
          // Error? Rollback to previous database
          conDatabase.Rollback;
          qryDatabase.Close;
          frmCitySwipe.ShowScreenPopup(1, 'An Error Occorded',
          'While Trying To Save CityInfo. Please Restart The App. Error: ' + sLineBreak+sLineBreak + Error.Message,
          false)
        end;
      end;
      // Free Memory
      if Assigned(objCurrentPlace) then
        objCurrentPlace.Free;
    end;
  end;
end;
procedure TGoogleMaps.RecalculateDistances();
var
  arrCoordinate : TArray<string>;
  rLat, rLong : real;
  objPlaceCoordinate : TCoordinate;
  iDistance, i, iCount : integer;
begin
  // Ensure Theres Records
  with dmDataComponents do
  begin
    qryDatabase.SQL.Text := 'Select * from CityInfo';
    qryDatabase.Open();
    iCount := qryDatabase.RecordCount;
    if iCount <= 0 then
      exit;
    // Start Transaction
    qryDatabase.First;
    conDatabase.StartTransaction;
    // Loop Through
    i := 0;
    try
      while not qryDatabase.Eof do
      begin
        inc(i);
        // Get Place Coordinate
        arrCoordinate := qryDatabase.FieldByName('Location').AsString.Split([';']);
        rLat := StrToFloat(arrCoordinate[0]);
        rLong := StrToFloat(arrCoordinate[1]);
        objPlaceCoordinate := TCoordinate.Create(rLat, rLong);
        // GetSet Distance
        iDistance := CalcPlacesDistance(fCoordinate, objPlaceCoordinate);
        // Avoid Reentering Data (raises error)
        if iDistance <> qryDatabase['Distance'] then
        begin
          // We're using this gr. 11 method because SQL functions issnt supported
          // Each row needs a unique value
          qryDatabase.Edit;
          qryDatabase['Distance'] := iDistance;
          qryDatabase.Post;
        end;

        qryDatabase.Next;
        // User feedback (sometimes this takes a while)
        frmCitySwipe.ShowScreenPopup(0, 'Updating Distances',
          'Holdon While We Update Your Distance From Everything. Row ' +
           i.ToString + '/' + iCount.ToString, false);
      end;
      // Save
      conDatabase.Commit;
      // Close Popups
      frmCitySwipe.recPopup.Visible := false;
      frmCitySwipe.recPopup.HitTest := false;
    except on Error: Exception do
      begin
        // Error! Pull Back!
        conDatabase.Rollback;
        frmCitySwipe.ShowScreenPopup(1, 'An Error Occorded',
            'While Trying To Calculate Distances: ' + sLineBreak + Error.Message,
            true);
        // Force Files to be overwritten - DEBUG
        // dmDataComponents.conDatabase.Connected := false;
        // TFile.Delete(dmDataComponents.sDBPath);
        // TFile.Delete(dmDataComponents.sConfigPath);
      end;
    end;
    qryDatabase.Close();
  end;
end;


/// --- Public Methods --- \\\
procedure TGoogleMaps.FilterPlacesInDistance(iDistance: integer);
begin
  with dmDataComponents do
  begin
    qryDatabase.SQL.Text := 'Select * From CityInfo Where Distance <= ' + iDistance.ToString;
    qryDatabase.Open();
  end;
end;

procedure TGoogleMaps.GetGroupSettings(out jsonGroupSettings : TJsonObject ; iGroupId : integer);
var
  i : integer;
begin
  with dmDataComponents do
  begin
    // Filter To Group ID
    qryDatabase.SQL.Text := 'Select * From Groups Where GroupID = ' + iGroupId.ToString;
    qryDatabase.Open();
    if qryDatabase.RecordCount <= 0 then
    begin
      frmCitySwipe.ShowScreenPopup(1, 'Error!', 'Unable To Find Group Settings With GroupID', true);
      exit;
    end;
    qryDatabase.First;
    // Loop through Fields And Add To jsonGroupSettings
    jsonGroupSettings := TJSONObject.Create;
    for i := 0 to qryDatabase.FieldCount - 1 do
    begin
      var Field := qryDatabase.Fields[i];
      jsonGroupSettings.AddPair(Field.FieldName, Field.AsString);
    end;
  end;
end;

function TGoogleMaps.GetMapsLink(sPlaceID: string): string;
begin
  with dmDataComponents do
  begin
    qryDatabase.SQL.Text := 'Select GoogleMapsLink From CityInfo Where PlaceId = ' + QuotedStr(sPlaceID);
    qryDatabase.Open();

    if qryDatabase.RecordCount <= 0 then
    begin
      Result := '';
      exit;
    end;

    qryDatabase.First;
    Result := qryDatabase['GoogleMapsLink'];
    qryDatabase.Close();
  end;
end;

function TGoogleMaps.GetPlacesPrompt(iDistance, iGroupId: integer ; sPlacePrefe, sCityAddress : string): string;
var
  jsonTripPlace, jsonRequest, jsonGroupSettings : TJsonObject;
  jsonPlacesArray : TJsonArray;
  sOutput, sField : string;
begin
  result := '';
  jsonRequest := TJSONObject.Create;
  jsonPlacesArray := TJSONArray.Create;
  with dmDataComponents do
  begin
    // Get Places In Distance
    FilterPlacesInDistance(iDistance);
    // Start Loop
    qryDatabase.First;
    while not qryDatabase.Eof do
    begin
      // Create/Reset New Json
      jsonTripPlace := TJSONObject.Create;
      // Loop Through Fields
      for var Field in qryDatabase.Fields do
      begin
        if (Field.FieldName.ToLower <> 'photoref')
          and (Field.FieldName.ToLower <> 'googlemapslink') then
        begin
          sField := Field.AsString;
          if Field.FieldName.ToLower <> 'currentopeninghours' then
            sField.Replace('/r/n', '. ');

          jsonTripPlace.AddPair(Field.FieldName, sField);
        end;
      end;
      // Add Place To Array
      jsonPlacesArray.AddElement(jsonTripPlace);
      // Next Record
      qryDatabase.Next;
    end;
    // Add Places To Main Json Object
    jsonRequest.AddPair('Places', jsonPlacesArray);
    /// Add Group Settings
    GetGroupSettings(jsonGroupSettings, iGroupId);
    // Add To Final Json
    jsonRequest.AddPair('GroupPersonality', jsonGroupSettings);
    // Add single fields
    jsonRequest.AddPair('IndoorOutdoorPreference', sPlacePrefe);
    jsonRequest.AddPair('UserLocation', sCityAddress);
    jsonRequest.AddPair('RequestDate', FormatSettings.LongDayNames[DayOfWeek(Now)]);
    // Close Database
    qryDatabase.Close;
  end;
  // Return
  sOutput := jsonRequest.ToJSON([]);
  sOutput := sOutput.Replace('\/', '/');
  Result := sOutput;
end;

function TGoogleMaps.GetAutocomplete(sText : string) : TList<TPlacePrediction>;
var
  jsonLocationBias, jsonBody, jsonResponse : TJsonObject;
  HttpResponse : IHTTPResponse;
  arrPredictions :  TList<TPlacePrediction>;
  sUrl : string;
begin
  // Create Body
  jsonBody := TJsonObject.Create();
  jsonBody.AddPair('input', sText);
  // Gps Error > Saved No Coordinate
  if Assigned(fCoordinate) then
  begin
    jsonLocationBias := CreateLocationBias(fCoordinate.GetLongitude, fCoordinate.GetLatitude, 50000);
    jsonBody.AddPair('locationBias', jsonLocationBias);
  end;
  // Send Request
  sUrl := 'https://places.googleapis.com/v1/places:autocomplete';
  HttpResponse := SendAPIReqesut(sUrl, jsonBody);
  if HttpResponse = nil then
  begin
    Result := nil;
    exit;
  end;
  // Check Response
  if HttpResponse.StatusCode <> 200 then
  begin
    frmCitySwipe.ShowScreenPopup(1, 'Error While Contacting Google Maps', 'Code' + HttpResponse.StatusText, true);
    exit;
  end;
  // Derserilize
  jsonResponse := TJsonReader.StringToJSONObject(HttpResponse.ContentAsString(TEncoding.UTF8));
  arrPredictions := TJsonReader.DeserializePredictions(jsonResponse);
  // Free Memory
  jsonResponse.Free;
  // Return
  Result := arrPredictions;
end;

function TGoogleMaps.IsSameCity(sCurrentCity: string): boolean;
var
  jsonConfig : TJsonObject;
  sPreviousCity : string;
begin
  jsonConfig := TJsonReader.LoadJSONFromFile(dmDataComponents.sConfigPath);
  sPreviousCity := jsonConfig.GetValue<string>('PreviousCity');
  Result := sPreviousCity = sCurrentCity;
end;

procedure TGoogleMaps.PullCityData();
var
  sFieldMask: string;
  jsonConfig: TJSONObject;
  arrFieldMask, arrFunIncludeTypes: TJSONArray;
  arrActivities, arrGiftShops, arrResturants, arrFunShops: TList<TPlace>;
const
  sActivityTag = 'Activity';
  sResturantTag = 'Resturant';
begin
  // Get API Key
  jsonConfig := TJsonReader.LoadJSONFromFile(dmDataComponents.sConfigPath);
  if not Assigned(jsonConfig) then
  begin
    // If Config is missing, just say F you
    TDialogService.ShowMessage('Config File Missing. Idiot');
    Application.Terminate;
  end;
  // Get FieldMask
  arrFieldMask := jsonConfig.GetValue<TJSONArray>('FieldMask');
  // Convert FieldMask array to comma-separated string
  sFieldMask := '';
  for var i := 0 to arrFieldMask.Count - 1 do
  begin
    sFieldMask := sFieldMask + arrFieldMask.Items[i].Value;
    if i < arrFieldMask.Count - 1 then
      sFieldMask := sFieldMask + ',';
  end;

  // Search Places
  arrActivities := SearchPlaces(sFieldMask, 'Fun Activity Entertainment ', 45);
  arrGiftShops := SearchPlaces(sFieldMask, 'Specialty Shops ', 15);
  arrResturants := SearchPlaces(sFieldMask, 'Restaurant ', 25);

  // Get Fun Snack Places (chocloate shop, icecream shop, etc)
  arrFunIncludeTypes := jsonConfig.GetValue<TJSONArray>('ResturantInclude');
  arrFunShops := NearbySearch(sFieldMask, 15, arrFunIncludeTypes);

  // Check If Any Request Failed
  if (not Assigned(arrActivities)) or (not Assigned(arrGiftShops))
    or (not Assigned(arrResturants)) or (not Assigned(arrFunShops)) then
  begin
    // Error Displayed Inside SendAPIRequest
    frmCitySwipe.RemoveUserCoordinate;
    exit;
  end;


  { Thought about using json intead of a database, after i wrote the code
    to save to a database. The thought of having to rewrite stopped me. }
  {
  // Check For City Folder
  sCityFolder := TPath.Combine(dmDataComponents.sDataFolder, fCoordinate.GetCity);
  if TDirectory.Exists(sCityFolder) then
    TDirectory.Delete(sCityFolder, true);
  // Create Folder For City
  TDirectory.CreateDirectory(sCityFolder);
  // Save Arrays
  TJsonReader.SaveArrayToFile(arrActivities, TPath.Combine(sCityFolder, 'arrActivities'));
  TJsonReader.SaveArrayToFile(arrGiftShops, TPath.Combine(sCityFolder, 'arrGiftShops'));
  TJsonReader.SaveArrayToFile(arrResturants, TPath.Combine(sCityFolder, 'arrResturants'));
  TJsonReader.SaveArrayToFile(arrFunShops, TPath.Combine(sCityFolder, 'arrFunShops'));
  }

  // Clear Database
  dmDataComponents.qryDatabase.SQL.Text := 'DELETE FROM CityInfo';
  dmDataComponents.qryDatabase.ExecSQL;

  // Save Array To Database
  SaveArrayToDatabase(arrActivities, sActivityTag);
  SaveArrayToDatabase(arrGiftShops, sActivityTag);
  SaveArrayToDatabase(arrFunShops, sActivityTag);
  SaveArrayToDatabase(arrResturants, sResturantTag);

  // Modify Config With New CityName
  // Load again, cause somewhere we modfiy resturantinclude to 8.4252342 (????)
  jsonConfig := TJsonReader.LoadJSONFromFile(dmDataComponents.sConfigPath);
  jsonConfig.RemovePair('PreviousCity');
  jsonConfig.AddPair('PreviousCity', fCoordinate.GetCityAddress);
  jsonConfig.RemovePair('PreviousCoordinate');
  jsonConfig.AddPair('PreviousCoordinate', TJson.ObjectToJsonObject(fCoordinate));
  TJsonReader.SaveJSONToFile(dmDataComponents.sConfigPath, jsonConfig);

  // Cleanup
  //arrActivities.Free;
  //arrGiftShops.free;
  //arrResturants.Free;
  //arrFunShops.Free;
  jsonConfig.free;
end;

function TGoogleMaps.PullImageUrl(sPlaceID: string ; iMaxHeigh : integer): string;
var
  sImageRef : string;
  sUrl : string;
begin
  Result := '';

  with dmDataComponents do
  begin
    qryDatabase.SQL.Text := 'Select PhotoRef From CityInfo Where PlaceId = ' + QuotedStr(sPlaceID);
    qryDatabase.Open();
    if qryDatabase.RecordCount <= 0 then
      exit;
    qryDatabase.First;
    sImageRef := qryDatabase['PhotoRef'];
    qryDatabase.Close;
  end;

  sUrl := Format('https://places.googleapis.com/v1/%s/media?key=%s&maxHeightPx=%s',
                [sImageRef, sApiKey, iMaxHeigh.ToString]);

  Result := sUrl;
end;

procedure TGoogleMaps.FillGoogleLink(out arrList: TList<TAiPlace>);
var
  objPlace : TAiPlace;
begin
  with dmDataComponents do
  begin
    for objPlace in arrList do
    begin
      qryDatabase.SQL.Text := 'Select GoogleMapsLink From CityInfo Where PlaceId = ' + QuotedStr(objPlace.PlaceID);
      qryDatabase.Open();

      if qryDatabase.RecordCount > 0 then
      begin
        qryDatabase.First;
        objPlace.GoogleMapsLink := qryDatabase['GoogleMapsLink'];
      end;
    end;

    qryDatabase.Close;
  end;
end;

end.

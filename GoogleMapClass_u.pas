unit GoogleMapClass_u;

interface

uses
  System.Generics.Collections, Coordinate_u;

  /// --- Subclasses --- \\\
            {TPlace}
  type
  TLocalizedText = class
  public
    Text: string;
    LanguageCode: string;
  end;

  TPhoto = class
  public
    Name: string;
    WidthPx: Integer;
    HeightPx: Integer;
  end;

  TOpeningHours = class
  public
    OpenNow: Boolean;
    weekdayDescriptions: TArray<string>;
  end;

  TDescription = class
  public
    text : string;
  end;

  TGenerativeSummary = class
  public
    overview: TLocalizedText;
  end;

  TAccessibilityOptions = class
  public
    wheelchairAccessibleParking: Boolean;
    wheelchairAccessibleEntrance: Boolean;
    wheelchairAccessibleRestroom: Boolean;
    wheelchairAccessibleSeating: Boolean;
  end;

  TMoney = class
  public
    units: string;
  end;

  TPriceRange = class
  public
    startPrice: TMoney;
    endPrice: TMoney;
  end;

  TText = class
    public
      text : string;
  end;

  TComponent = class
    public
      longText : string;
      types : TArray<string>;
  end;

  TGoogleMapsLinks = class
    public
      placeUri : string;
  end;

              {TAiPlace}
  TBubbleText = class
    Icon : integer;
    Text : string;
  end;

  /// --- Main Classes --- \\\
  TAiPlace = class
    public
      PlaceID : string;
      GoogleMapsLink : string;
      PlaceType : string;
      OpenTimes : string;
      DisplayName : string;
      Description : string;
      ActivityName : string;
      AvgPrice : string;
      BubbleText : TArray<TBubbleText>;
      Distance : Real;
      Score : Real;
  end;

  TPlace = class
  public
    // Direct Fields
    iD: string;
    sCitySwipeType : string;
    formattedAddress : string;
    types: TArray<string>;
    Distance : integer;
    allowsDogs: Boolean;
    delivery: Boolean;
    dineIn: Boolean;
    goodForChildren: Boolean;
    goodForGroups: Boolean;
    menuForChildren: Boolean;
    reservable: Boolean;
    servesBeer: Boolean;
    rating: Double;
    userRatingCount: integer;

    // Object Fields
    location : TCoordinate;
    googleMapsLinks : TGoogleMapsLinks;
    displayName: TLocalizedText;
    photos: TArray<TPhoto>;
    primaryTypeDisplayName: TLocalizedText;
    currentOpeningHours: TOpeningHours;
    priceRange: TPriceRange;
    generativeSummary: TGenerativeSummary;
    editorialSummary: TLocalizedText;
    accessibilityOptions: TAccessibilityOptions;
    addressComponents : TArray<TComponent>;
  end;
  TPlacePrediction = class
    public
      place : string;
      placeId : string;
      text : TText;
  end;

implementation

end.

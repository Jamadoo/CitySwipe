unit TPlace_u;

interface

uses
  System.Generics.Collections, Coordinate_u;

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
    description: TDescription;
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

  TPlace = class
  public
    // Direct Fields
    iD: string;
    googleMapsUri: string;
    types: TArray<string>;
    allowsDogs: Boolean;
    delivery: Boolean;
    dineIn: Boolean;
    goodForChildren: Boolean;
    goodForGroups: Boolean;
    menuForChildren: Boolean;
    reservable: Boolean;
    servesBeer: Boolean;
    rating: Double;

    // Object Fields
    location : TCoordinate;
    displayName: TLocalizedText;
    photos: TArray<TPhoto>;
    primaryTypeDisplayName: TLocalizedText;
    currentOpeningHours: TOpeningHours;
    priceRange: TPriceRange;
    generativeSummary: TGenerativeSummary;
    editorialSummary: TLocalizedText;
    accessibilityOptions: TAccessibilityOptions;
  end;

implementation

end.

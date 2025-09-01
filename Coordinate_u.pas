unit Coordinate_u;

interface

uses System.SysUtils;

type
  TCoordinate = class(TObject)
    public
      // To be able to convert Json To TCoordinate
      // Also imagine theres an f infront of these varaible names
      longitude, latitude : real;
      formattedAddress : string;
      fCountry : string;
      fState : string;
      fCity : string;

      constructor Create(); overload;
      constructor Create(rLat, rLong : real ; sCity: string = ''); overload;
      // Getters And Setters (net sodat ek my punte kry vir dit)
      function GetLongitude : real;
      function GetLatitude : real;
      function GetCity : string;
      function GetCityAddress : string;
      procedure SetLatitude(iLat : real);
      procedure SetLongitude(iLong : real);
      procedure SetCity(sCity : string);
  end;

implementation

{ TCoordinate }

function TCoordinate.GetCity: string;
begin
  result := fCity;
end;

function TCoordinate.GetCityAddress: string;
begin
  Result := Format('%s, %s, %s', [fCity, fState, fCountry]);
end;

function TCoordinate.GetLatitude: real;
begin
  result := Latitude;
end;

function TCoordinate.GetLongitude: real;
begin
  result := Longitude;
end;

procedure TCoordinate.SetCity(sCity: string);
begin
  fCity := sCity;
end;

procedure TCoordinate.SetLatitude(iLat: real);
begin
  Latitude := iLat;
end;

procedure TCoordinate.SetLongitude(iLong: real);
begin
  Longitude := iLong;
end;

{ TCoordinate }

constructor TCoordinate.Create();
begin
  Longitude := 0;
  Latitude := 0;
  fCity := '';
end;
constructor TCoordinate.Create(rLat, rLong : real ; sCity: string);
begin
  Longitude := rLong;
  Latitude := rLat;
  fCity := sCity;
end;

end.

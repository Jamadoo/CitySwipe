unit JsonRead_u;

interface

uses
  System.SysUtils, System.Classes, System.JSON, GoogleMapClass_u,
  REST.Json, System.Generics.Collections, FMX.DialogService,
  FMX.Forms;

type
  TJsonReader = class(TObject)
    private
    public
      class procedure SaveJSONToFile(FileName: string; JSONObject: TJSONObject); static;
      class function LoadJSONFromFile(FileName: string) : TJSONObject; static;
      class function DeserializePredictions(jsonInput: TJSONObject): TList<TPlacePrediction>;
      class function DeserializePlaces(JSONArr: TJSONArray): TList<TPlace>; static;
      class function DeserializeAiPlaces(JSONArr: TJSONArray; sType : string): TList<TAiPlace>; static;
      class function StringToJSONObject(const JSONStr: string): TJSONObject; static;
      class procedure SaveArrayToFile(arrArray: TList<TPlace>; sFileName: string); static;
      class function IsValidJSON(AJSONString: string; out jsonResponse : TJsonObject): Boolean; static;
  end;

implementation

{ TJsonReader }

class function TJsonReader.DeserializePlaces(JSONArr: TJSONArray): TList<TPlace>;
var
  Places: TList<TPlace>;
  I    : Integer;
begin
  Places := TList<TPlace>.Create();
  try
    for I := 0 to JSONArr.Count - 1 do
      Places.Add(TJson.JsonToObject<TPlace>(JSONArr.Items[I] as TJSONObject));
    Result := Places;          // success – return the populated list
  except
    Places.Free;               // make sure we don’t leak memory on error
    raise;                    // re-raise the exception
  end;
end;
class function TJsonReader.DeserializeAiPlaces(JSONArr: TJSONArray; sType : string): TList<TAiPlace>;
var
  Places: TList<TAiPlace>;
  objPlace : TAiPlace;
  I    : Integer;
begin
  Places := TList<TAiPlace>.Create();
  try
    for I := 0 to JSONArr.Count - 1 do
    begin
      objPlace := TJson.JsonToObject<TAiPlace>(JSONArr.Items[I] as TJSONObject);
      objPlace.PlaceType := sType;
      Places.Add(objPlace);
    end;
    // success – return the populated list
    Result := Places;
  except

  end;
end;

class function TJsonReader.DeserializePredictions(jsonInput: TJSONObject): TList<TPlacePrediction>;
var
  jsonArr: TJSONArray;
  jsonWrapper, jsonPrediction : TJsonObject;
  arrPlaces : TList<TPlacePrediction>;
begin
  arrPlaces := TList<TPlacePrediction>.Create();
  try
    if jsonInput.TryGetValue<TJSONArray>('suggestions', jsonArr) then
    begin
      for var i := 0 to jsonArr.Count - 1 do
      begin
        // Get The JsonObject, cause google doesnt just give a array like searching
        // Google Gives "placePrediction": {}
        jsonWrapper := jsonArr.Items[i] as TJSONObject;

        // Now get the actual prediction object
        if jsonWrapper.TryGetValue<TJSONObject>('placePrediction', jsonPrediction) then
        begin
          arrPlaces.Add(TJson.JsonToObject<TPlacePrediction>(jsonPrediction));
        end;
      end;
    end;
  except

  end;

  result := arrPlaces;
end;

class function TJsonReader.LoadJSONFromFile(FileName: string): TJSONObject;
var
  JSONString: string;
  StringList: TStringList;
begin
  Result := nil;
  if not FileExists(FileName) then
    Exit;

  StringList := TStringList.Create;
  try
    StringList.LoadFromFile(FileName, TEncoding.UTF8);
    JSONString := StringList.Text.Trim;
    Result := TJSONObject.ParseJSONValue(JSONString) as TJSONObject;
  finally
    StringList.Free;
  end;
end;

class procedure TJsonReader.SaveJSONToFile(FileName: string; JSONObject: TJSONObject);
var
  StringList: TStringList;
begin
  StringList := TStringList.Create;
  try
    StringList.Text := JSONObject.ToJSON;
    StringList.SaveToFile(FileName, TEncoding.UTF8);
  finally
    StringList.Free;
  end;
end;

class procedure TJsonReader.SaveArrayToFile(arrArray: TList<TPlace>; sFileName: string);
var
  jsonRootArray : TJSONArray;
  jsonJSONObj : TJSONObject;
  objItem : TObject;
  SL : TStringList;
begin
  // build a JSON array of the given objects
  jsonRootArray := TJSONArray.Create;
  try
    for objItem in arrArray do
    begin
      if Assigned(objItem) then
        jsonJSONObj := TJson.ObjectToJsonObject(objItem)
      else
        // serialise a nil as empty object
        jsonJSONObj := TJSONObject.Create;

      // ownership transferred
      jsonRootArray.AddElement(jsonJSONObj);
    end;

    // write the JSON text to disk in UTF8
    SL := TStringList.Create;
    try
      SL.Text := jsonRootArray.ToJSON();
      SL.SaveToFile(sFileName, TEncoding.UTF8);
    finally
      SL.Free;
    end;
  finally
    // free the array structure itself
    jsonRootArray.Free;
  end;
end;

class function TJsonReader.StringToJSONObject(const JSONStr: string): TJSONObject;
var
  JSONValue: TJSONValue;
begin
  Result := nil;
  JSONValue := TJSONObject.ParseJSONValue(JSONStr);
  if Assigned(JSONValue) and (JSONValue is TJSONObject) then
    Result := TJSONObject(JSONValue)
  else
    JSONValue.Free;
end;

class function TJsonReader.IsValidJSON(AJSONString: string; out jsonResponse : TJsonObject): Boolean;
var
  JSONValue: TJSONValue;
begin
  Result := False;
  try
    JSONValue := TJSONObject.ParseJSONValue(AJSONString, False);
    if JSONValue is TJSONObject then
    begin
      jsonResponse := TJSONObject(JSONValue);
      Result := True;
    end
    else
      JSONValue.Free; // Free if it's not a TJSONObject
  except
    jsonResponse := nil;
    Result := False;
  end;
end;

end.

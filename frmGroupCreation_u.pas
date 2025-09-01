unit frmGroupCreation_u;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.TabControl,
  FMX.Objects, FMX.Effects, FMX.StdCtrls, FMX.Layouts, FMX.Controls.Presentation,
  FMX.Memo.Types, FMX.ScrollBox, FMX.Memo, System.Generics.Collections, REST.Json, JSON,
  JsonRead_u, dmDataComponents_u, System.IOUtils, Math, System.Rtti, System.Threading,
   FMX.TextLayout, Data.DB, System.ImageList, FMX.ImgList;

type
  TQeustion = class
    public
      QeustionType : string;
      QeustionStatement : string;
      DatabaseField : string;
      iMin, iMax : integer;
      Options : TArray<string>;
      Answer : string;
      NotRequired : boolean;
    private
  end;

  TfrmGroupCreation = class(TForm)
    imgBackground: TImage;
    tbTabs: TTabControl;
    StyleBook2: TStyleBook;
    tbMultichoice: TTabItem;
    tbInput: TTabItem;
    tbSpinEdit: TTabItem;
    layMultiChoice: TLayout;
    recMultiChoice: TRectangle;
    layMultiChoiceButtons: TLayout;
    btnMultiNext: TButton;
    btn2Back: TButton;
    layMultiChoiceOptions: TFlowLayout;
    recChoiceTemplate: TRectangle;
    lblChoiceText: TLabel;
    lblMultiChoiceTItle: TLabel;
    lblMultiChoiceQeustion: TLabel;
    ShadowEffect4: TShadowEffect;
    layInput: TLayout;
    recInput: TRectangle;
    layInputButtons: TLayout;
    btnInputNext: TButton;
    Button2: TButton;
    lblInputTitle: TLabel;
    lblInputQeustion: TLabel;
    ShadowEffect1: TShadowEffect;
    memInput: TMemo;
    laySpin: TLayout;
    recSpin: TRectangle;
    laySpinButtons: TLayout;
    btnSpinNext: TButton;
    Button4: TButton;
    lblSpinTitle: TLabel;
    lblSpinQeustion: TLabel;
    ShadowEffect2: TShadowEffect;
    laySpinOption: TLayout;
    trkSpinOption: TTrackBar;
    lblSpinOption: TLabel;
    layCancelButton: TLayout;
    btnCancel: TButton;
    tbSections: TTabControl;
    tbGroupCreation: TTabItem;
    tbWelcome: TTabItem;
    imgDisplayScreens: TGlyph;
    imgWelcomeScreens: TImageList;
    recClickBox: TRectangle;

  procedure TrackbarSliderPaint(Sender: TObject; Canvas: TCanvas; const ARect: TRectF);
  procedure TrackbarSliderChange(Sender: TObject);
  procedure LoadQeustion(objQeustion : TQeustion);
  procedure StartGroupCreation(Sender: TObject);
  procedure SelectOption(Sender : TObject);
  procedure Next(Sender : TObject);
  procedure GoBack(Sender : TObject);
  procedure SaveAndClose();
  procedure memInputChangeTracking(Sender: TObject);
  procedure btnCancelClick(Sender: TObject);
  procedure StartWelcomeScreen(Sender : TObject);
  procedure GoToNextScreen(Sender: TObject);
  private
    arrQeustions : TList<TQeustion>;
    iQeustion : integer;
    sSelectedOption : string;
  public
    const
      clrSelectedValue: TAlphaColor = $FF1C3759;

      clrUnselectedValue: TAlphaColor = $FF0C1A2C;
  end;

var
  frmGroupCreation: TfrmGroupCreation;

implementation

{$R *.fmx}

/// --- UI Functions --- \\\
procedure TfrmGroupCreation.TrackbarSliderChange(Sender: TObject);
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

procedure TfrmGroupCreation.TrackbarSliderPaint(Sender: TObject; Canvas: TCanvas;
  const ARect: TRectF);
begin
  // When Trckbar is Initilized, draw the active track
  TrackbarSliderChange(Sender);
  TTrackBar(Sender).OnPaint := nil;
end;

procedure TfrmGroupCreation.memInputChangeTracking(Sender: TObject);
var
  ctrlLabel : TfmxObject;
begin
  ctrlLabel := memInput.FindStyleResource('placeholder');
  if ctrlLabel <> nil then
    TControl(ctrlLabel).Visible := memInput.Lines.Text = '';
end;

/// --- Start --- \\\
procedure TfrmGroupCreation.StartGroupCreation(Sender: TObject);
var
  jsonQeustions : TJsonObject;
  jsonArray : TJsonArray;
  i: Integer;
  objQeustion : TQeustion;
begin
  frmGroupCreation.OnShow := nil;

  tbSections.TabIndex := 0;

  btnMultiNext.Text := 'Next';
  btnInputNext.Text := 'Next';
  btnSpinNext.Text := 'Next';

  // Set UI Props
  trkSpinOption.TagObject := lblSpinOption;
  lblSpinOption.TagString := '%';

  // Load Qeustions File
  jsonQeustions := TJsonReader.LoadJSONFromFile(TPath.Combine(dmDataComponents.sDataFolder, 'GroupCreation.json'));
  jsonArray := jsonQeustions.GetValue<TJsonArray>('Qeustions');

  arrQeustions.Free;
  arrQeustions := nil;
  arrQeustions := TList<TQeustion>.Create;
  for i := 0 to jsonArray.Count-1 do
  begin
    objQeustion := TJson.JsonToObject<TQeustion>(jsonArray[i] as TJsonObject);
    arrQeustions.Add(objQeustion);
  end;
  // Start First Qeusiton
  iQeustion := 0;
  LoadQeustion(arrQeustions[iQeustion]);
end;

procedure TfrmGroupCreation.StartWelcomeScreen(Sender : TObject);
begin
  tbSections.TabIndex := 1;
  imgDisplayScreens.ImageIndex := 0;
end;

/// ---- Group Creation --- \\\
procedure TfrmGroupCreation.btnCancelClick(Sender: TObject);
begin
  frmGroupCreation.Close;
end;

procedure TfrmGroupCreation.SaveAndClose;
var
  objQeustion : TQeustion;
  fCurrentField : TField;
begin
  with dmDataComponents do
  begin
    // Start transaction to rollback if a error happens
    conDatabase.StartTransaction;
    try
      qryDatabase.Open('Select * From Groups');
      qryDatabase.Append;
      for objQeustion in arrQeustions do
      begin
        fCurrentField := qryDatabase.FieldByName(objQeustion.DatabaseField);

        // Convert To Datatype
        if fCurrentField.DataType in [ftInteger, ftSmallint, ftWord, ftLargeint] then
          fCurrentField.AsInteger := StrToIntDef(objQeustion.Answer, 0)
        else
          fCurrentField.AsString  := objQeustion.Answer;
      end;

      // Save Database
      qryDatabase.Post;
      conDatabase.Commit;
      qryDatabase.Close;

      // Close Form
      frmGroupCreation.Close();
    except
      // Undo Changes and error
      conDatabase.Rollback;
      raise;
    end;
  end;
end;

procedure TfrmGroupCreation.Next(Sender : TObject);
var
  objQeustion : TQeustion;
begin
  // Save Option
  objQeustion := arrQeustions[iQeustion];
  if (objQeustion.QeustionType.ToLower = 'multichoice') then
  begin
    if (sSelectedOption.Trim = '') and (objQeustion.NotRequired = false) then
    begin
      ShowMessage('Please Select a Option');
      exit;
    end;

    arrQeustions[iQeustion].Answer := sSelectedOption;
  end
  else if (objQeustion.QeustionType.ToLower = 'input') then
  begin
    if (memInput.Text.Trim = '') and (objQeustion.NotRequired = false) then
    begin
      ShowMessage('Please Input Something');
      exit;
    end;

    arrQeustions[iQeustion].Answer := memInput.Lines.Text
  end
  else if objQeustion.QeustionType.ToLower = 'spinedit' then
    arrQeustions[iQeustion].Answer := Round(trkSpinOption.Value).ToString();

  // Check Finish
  inc(iQeustion);
  if iQeustion > arrQeustions.Count-1 then
  begin
    // Save To Database and close
    SaveAndClose();
    exit;
  end
  else if iQeustion = arrQeustions.Count-1 then
  begin
    btnMultiNext.Text := 'Finish';
    btnInputNext.Text := 'Finish';
    btnSpinNext.Text := 'Finish';
  end
  else
  begin
    btnMultiNext.Text := 'Next';
    btnInputNext.Text := 'Next';
    btnSpinNext.Text := 'Next';
  end;

  // Go To Next Screen
  LoadQeustion(arrQeustions[iQeustion]);
end;

procedure TfrmGroupCreation.GoBack(Sender : TObject);
begin
  Dec(iQeustion);
  LoadQeustion(arrQeustions[iQeustion]);
end;

procedure TfrmGroupCreation.SelectOption(Sender : TObject);
var
  ctrlOption : TControl;
begin
  sSelectedOption := TControl(Sender).TagString;
  for ctrlOption in layMultiChoiceOptions.Controls do
  begin
    if ctrlOption is TRectangle then
      if ctrlOption = Sender as TControl then
        TRectangle(ctrlOption).Fill.Color := clrSelectedValue
      else
        TRectangle(ctrlOption).Fill.Color := clrUnselectedValue;
  end;
end;

procedure TfrmGroupCreation.LoadQeustion(objQeustion : TQeustion);
var
  i, iAnswer : integer;
  sOption : string;
  recClone : TRectangle;
  lblOption : TLabel;
  rSize, rMaxHeight : Real;
  ctrlOption : TControl;
  layTextSize : TTextLayout;
begin
  sSelectedOption := '';

  if objQeustion.QeustionType.ToLower = 'multichoice' then
  begin
    lblMultiChoiceQeustion.Text := objQeustion.QeustionStatement;
    layMultiChoiceOptions.BeginUpdate;
    // Clear Selection
    for i := layMultiChoiceOptions.ControlsCount-1 downto 0 do
    begin
      if layMultiChoiceOptions.Controls[i] <> recChoiceTemplate then
        layMultiChoiceOptions.Controls[i].Free;
    end;
    // Loop Througn Strings
    layTextSize := TTextLayoutManager.DefaultTextLayout.Create();
    for sOption in objQeustion.Options do
    begin
      // Create Clone
      recClone := TRectangle(recChoiceTemplate.Clone(frmGroupCreation));
      lblOption := recClone.Controls[0] as TLabel;
      // Set Values
      lblOption.Text := sOption;
      recClone.TagString := sOption;
      recClone.OnClick := SelectOption;
      // Check Selected
      if objQeustion.Answer = sOption then
      begin
        recClone.Fill.Color := clrSelectedValue;
        sSelectedOption := sOption;
      end;
      // Calc Size
      layTextSize.BeginUpdate;
      layTextSize.Font.Assign(lblOption.Font);
      layTextSize.Font.Size := lblOption.Font.Size;
      layTextSize.HorizontalAlign := TTextAlign.Center;
      layTextSize.VerticalAlign := TTextAlign.Center;
      layTextSize.MaxSize := TPointF.Create(layMultiChoiceOptions.Width - recClone.Padding.Left - recClone.Padding.Right - 8, 100000);
      layTextSize.WordWrap := true;
      layTextSize.Text := lblOption.Text;
      layTextSize.EndUpdate;
      recClone.Width := layTextSize.TextWidth + recClone.Padding.Left + recClone.Padding.Right + 8;
      recClone.Height := layTextSize.TextHeight + recClone.Padding.Bottom + recClone.Padding.Top; // idk why werk maar net as jy mall met 2
      // Parent and visible
      recClone.Parent := layMultiChoiceOptions;
      recClone.Visible := true;
    end;
    layTextSize.Free;

    // Force UI Update
    layMultiChoiceOptions.EndUpdate;

    // Caluclate Size
    rSize := recMultiChoice.Height - layMultiChoiceOptions.Height;
    rMaxHeight := 0;
    for i := 0 to layMultiChoiceOptions.ControlsCount - 1 do
    begin
      ctrlOption := layMultiChoiceOptions.Controls[I];
      if ctrlOption.Visible then
        rMaxHeight := Max(rMaxHeight, (ctrlOption.Position.Y + ctrlOption.Height));
    end;
    rSize := rSize + rMaxHeight;
    recMultiChoice.Height := rSize;

    // Set Tab
    tbTabs.TabIndex := 0;
  end
  else if objQeustion.QeustionType.ToLower = 'input' then
  begin
    lblInputQeustion.Text := objQeustion.QeustionStatement;
    memInput.Lines.Clear;
    memInput.Lines.Text := objQeustion.Answer;
    memInput.SetFocus;
    tbTabs.TabIndex := 1;
  end
  else if objQeustion.QeustionType.ToLower = 'spinedit' then
  begin
    lblSpinQeustion.Text := objQeustion.QeustionStatement;
    trkSpinOption.Min := objQeustion.iMin;
    trkSpinOption.Max := objQeustion.iMax;
    trkSpinOption.Value := 0;
    trkSpinOption.OnChange(trkSpinOption);
    tbTabs.TabIndex := 2;

    if integer.TryParse(objQeustion.Answer, iAnswer) then
      trkSpinOption.Value := iAnswer;
  end;
end;

/// --- Welcome Screen --- \\\
procedure TfrmGroupCreation.GoToNextScreen(Sender: TObject);
begin
  // Last Image? Start Group Creation
  if imgDisplayScreens.ImageIndex = imgWelcomeScreens.Count-1 then
  begin
    StartGroupCreation(Sender);
  end;
  // Ele Go To Next Screen
  imgDisplayScreens.ImageIndex := imgDisplayScreens.ImageIndex + 1;
end;

end.

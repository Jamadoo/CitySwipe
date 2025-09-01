object dmDataComponents: TdmDataComponents
  OnCreate = DataModuleCreate
  Height = 455
  Width = 488
  PixelsPerInch = 120
  object conDatabase: TFDConnection
    LoginPrompt = False
    Left = 128
    Top = 216
  end
  object qryDatabase: TFDQuery
    Connection = conDatabase
    Left = 216
    Top = 216
  end
  object dsrDatabase: TDataSource
    Left = 304
    Top = 216
  end
  object WhatTheHellAnator: TFDPhysSQLiteDriverLink
    Left = 128
    Top = 136
  end
end

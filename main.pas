unit main;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, StdCtrls;

type

  { TForm1 }

  TForm1 = class(TForm)
    fileBrowseButton: TButton;
    folderEdit: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    selectFolderDialog: TSelectDirectoryDialog;
    pdfFiles: TStringList;
    procedure fileBrowseButtonClick(Sender: TObject);
    procedure findFiles();
  private
    { private declarations }
    folder: String;
  public
    { public declarations }

  end;

var
  Form1: TForm1;

implementation

{$R *.lfm}

{ TForm1 }


procedure TForm1.fileBrowseButtonClick(Sender: TObject);
begin
      if selectFolderDialog.Execute then
      begin
        folder := selectFolderDialog.FileName;
        folderEdit.text := folder;
        findFiles()
      end;
end;

procedure TForm1.findFiles();
begin
      pdfFiles := FindAllFiles(folder, '*.pas;*.pp;*.p;*.*', False);
      try
          showmessage(Format('Found %d Pascal source files',[pdfFiles.Count]));
      finally
          pdfFiles.Free;
      end;
end;

end.


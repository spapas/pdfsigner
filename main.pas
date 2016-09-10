unit main;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, StdCtrls, Process;

type

  { TForm1 }

  TForm1 = class(TForm)
    GroupBox1: TGroupBox;
    signPdfsButton: TButton;
    fileBrowseButton: TButton;
    folderEdit: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    pdfDescriptionLabel: TLabel;
    selectFolderDialog: TSelectDirectoryDialog;
    pdfFiles: TStringList;
    procedure fileBrowseButtonClick(Sender: TObject);
    procedure findFiles();
    procedure signPdfsButtonClick(Sender: TObject);
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
      pdfFiles := FindAllFiles(folder, '*.pdf;*.*', False);
      try
          //showmessage(Format('Found %d pdf files',[pdfFiles.Count]));
          pdfDescriptionLabel.Caption:=Format('Found %d pdf files',[pdfFiles.Count]);
          if pdfFiles.Count > 0 then
          begin
               signPdfsButton.Enabled:=true;
          end
      finally
          pdfFiles.Free;
      end;
end;

procedure TForm1.signPdfsButtonClick(Sender: TObject);
var s: ansistring;
begin
    showmessage('Will try to run JSignPDF to sign all pdfs of folder ' + folder +'...');

    if RunCommand('D:\Util\curl.exe', ['www.google.com'], s) then
    begin
         showmessage('Success!');
         showmessage(s) ;
    end
    else
    begin
        showmessage('Error while trying to run JSignPDF') ;
    end;
end;


end.


unit main;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls,
  Graphics, Dialogs, StdCtrls, Process, LConvEncoding,
  Windows, LCLIntf, Menus, ShlObj  ;

type

  { TForm1 }

  TForm1 = class(TForm)
    changeJsignpdfLocation: TButton;
    selectFileDialog: TOpenDialog;
    propertiesLocation: TEdit;
    jsignpdfLocation: TEdit;
    GroupBox1: TGroupBox;
    Label4: TLabel;
    Label5: TLabel;
    signPdfsButton: TButton;
    fileBrowseButton: TButton;
    folderEdit: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    pdfDescriptionLabel: TLabel;
    selectFolderDialog: TSelectDirectoryDialog;
    pdfFiles: TStringList;
    procedure changePropertiesLocationClick(Sender: TObject);
    procedure changeJsignpdfLocationClick(Sender: TObject);
    procedure fileBrowseButtonClick(Sender: TObject);
    procedure findFiles();
    procedure FormShow(Sender: TObject);
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

procedure TForm1.changeJsignpdfLocationClick(Sender: TObject);
begin
     if selectFolderDialog.Execute then
     begin
        jsignpdfLocation.text := selectFolderDialog.FileName;
     end;
end;

procedure TForm1.changePropertiesLocationClick(Sender: TObject);
begin
     if selectFileDialog.Execute then
     begin
        propertiesLocation.text := selectFileDialog.FileName;
     end;
end;

procedure TForm1.findFiles();
begin
      //pdfFiles := FindAllFiles(folder, '*.pdf;*.*', False);
      pdfFiles := FindAllFiles(folder, '*.pdf', False);
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

procedure TForm1.FormShow(Sender: TObject);
var
  PIDL : PItemIDList;
  homedir : array[0..MAX_PATH] of Char;
  const CSIDL_PROFILE = 40;
begin
  homedir:='';
  SHGetSpecialFolderLocation(0, CSIDL_PROFILE, PIDL);
  SHGetPathFromIDList(PIDL, homedir);
  propertiesLocation.text:=homedir+'\.JSignPdf';
end;


procedure TForm1.signPdfsButtonClick(Sender: TObject);
var s: ansistring;
begin
    showmessage('Will try to run JSignPDF to sign all pdfs found in folder ' + folder +'...');

    if RunCommandIndir(folder,
       jsignpdfLocation.text+'\JSignPdfC.exe',
       ['-lpf', propertiesLocation.Text, '*.pdf'],
       //['-lpf', 'C:\Users\serafeim\.JSignPdf', '*.pdf'],
       //['-lpf C:\Users\serafeim\.JSignPdf *.pdf'],
       s
       )
    then
    begin
         showmessage('Success!');
         // showmessage(CP1253ToUTF8 (s)) ;
    end
    else
    begin
        if length(s)>0
        then
        begin
                showmessage('Errors while trying to run JSignPDF. Press Ok to see the output and try to correct problems!') ;
                showmessage(CP1253ToUTF8 (s)) ;
        end
        else
        begin
                showmessage('Unable to run JSignPdf. Have you selected the correct location?') ;
        end;
    end;
end;


end.


unit Main;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMXTee.Engine,
  FMXTee.Series, FMX.StdCtrls, FMXTee.Procs, FMXTee.Chart, FMX.TabControl,
  FMX.Controls.Presentation, FMX.Edit;

type
  TForm1 = class(TForm)
    ToolBar1: TToolBar;
    TabControl1: TTabControl;
    TabItem1: TTabItem;
    TabItem2: TTabItem;
    Chart1: TChart;
    Button1: TButton;
    Series1: TLineSeries;
    Label1: TLabel;
    EditXn: TEdit;
    Label2: TLabel;
    EditXk: TEdit;
    TrackBar1: TTrackBar;
    Label3: TLabel;
    Button2: TButton;
    procedure Button1Click(Sender: TObject);
    procedure TrackBar1Change(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
    xn:double;
    xk:double;
    step:double;
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.fmx}

function myf(x:double):double;
begin
  if(x>0) and (x<10) then myf:=sin(x)
  else if(x>10) and (x<20)  then myf:=x;
end;

procedure TForm1.Button1Click(Sender: TObject);
var x,y:double;
begin
  xn:=double.Parse(EditXn.Text);
  xk:=double.Parse(EditXk.Text);
  step:=TrackBar1.Value;
  x:=xn;
  Chart1.Series[0].Clear;
while xk>x do
begin
  y:=myf(x);
  x:=x+step;
  Chart1.Series[0].AddXY(x,y);
end;
end;

procedure TForm1.Button2Click(Sender: TObject);
var f:textfile; arr:array [1..3] of double; i:integer;
begin
  arr[1]:=double.Parse(EditXn.Text);
  arr[2]:=double.Parse(EditXk.Text);
  arr[3]:=TrackBar1.Value;

  AssignFile(f,'c:\myfile.txt');
  Rewrite(f);

  for i:=1 to 3 do
  begin
    write(f,arr[i]);
  end;

  CloseFile(f);

end;

procedure TForm1.FormShow(Sender: TObject);
var f:textfile; arr:array [1..3] of double; i:integer;
begin
  if FileExists('c:\myfile.txt') then
  begin
    AssignFile(f,'c:\myfile.txt');
    Reset(f);

    for i:=1 to 3 do
    begin
      read(f,arr[i]);
    end;

    CloseFile(f);

    EditXn.Text:=arr[1].ToString;
    EditXk.Text:=arr[2].ToString;
    TrackBar1.Value:=arr[3];
  end;
end;

procedure TForm1.TrackBar1Change(Sender: TObject);
begin
  Label3.Text:=TrackBar1.Value.ToString;
  step:=TrackBar1.Value;
end;

end.

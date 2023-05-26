program toCreateFIle;

{$APPTYPE CONSOLE}

{$R *.res}

uses
  System.SysUtils;


type

  Tdata = packed record
    title: string[50];
    yearOfStart: integer;
    yearOfEnd: integer;
    yearsOfWork: integer;
    genre: string[10];
    theme: string[10];
    place: string[15];
    materials: string[20];
    shortDescr: string[200];
    userRate: integer;
    userComment: string[100];
    isToBeChanged: boolean;
    isFavourite: boolean;
    filename: string[25];
    imgBuffer: integer;
  end;



  TArray = array of Tdata;
  TShortStr  = string[10];
  TStr = array of TShortStr;

var
  fileToRead, fileToWrite: file of Tdata;

  info: TArray;
  i: integer;
  fileCount: integer;
  Current: Tdata;
  flag: boolean = false;
  datasetFiles: array[0..19] of string = ('apopheo', 'dance-rose', 'austria', 'evening', 'job-c', 'flower', 'lermitage', 'maria', 'master', 'portrait', 'marushka', 'ruby-c', 'monaco', 'salome', 'season', 'slav-epic', 'slavia', 'spirit', 'the-quill', 'zodiak' );

  datasetNames: array[0..19] of string = ( 'The Apotheosis of the Slavs', 'The Arts: Dance', 'Austria', 'Evening reverie (nocturnal slumber)', 'Job', 'Flower',  'The Hermitage',
  'Maria Young Girl In A Moravian Costume', 'Master Jan Hus Preaching at the Bethlehem Chapel', 'Portrait of Jaroslava', 'Portrait of Marushka, Artist s Wife', 'Ruby',
  'Monaco Monte Carlo', 'Salome',  'Seasons', 'The Slav Epic', 'Slavia', 'Spirit Of Spring',  'The Quill', '������');

  datasetYoS: array[0..19] of integer = (1925, 1898, 1899, 1899, 1896, 1897, 1898, 1920, 1916, 1930, 1905, 1899, 1897, 1897, 1896, 1928, 1896, 1894, 1899, 1896);
  datasetYoE: array[0..19] of integer = (1925, 1898, 1900, 1900, 1896, 1897, 1898, 1921, 1918, 1931, 1905, 1899, 1897, 1897, 1900, 1929, 1896, 1895, 1900, 1896);
  datasetGenre: array[0..19] of string = ('���������', '�� ����', '�� ����', '�� ����', '�� ����', '�� ����', '�� ����', '���������', '���������', '���������', '���������', '�� ����', '�� ����', '�� ����', '�� ����', '���������', '�� ����', '���������', '�� ����', '�� ����');
  datasetTheme: array[0..19] of string = ('�������', '���������', '���������', '���������', '�������', '���������', '�������',' ����', '�������', '����', '����', '���������', '�������', '���������', '���������', '�������', '�������', '���������', '���������', '���������');
  datasetPlace: array[0..19] of string = ('�����', '�����', '�����', '�����', '�����', '�����', '�����', '�����', '�����', '�����', '�����', '�����', '�����', '�����', '�����', '�����', '�����', '�����', '�����', '�����');
  datasetMats: array[0..19] of string = ('�����, �����', '������� ����������', '������� ����������', '������� ����������', '������� ����������', '������� ����������', '������� ����������', '�����, �����', '�����, �������', '�����, �����', '�����, �����', '������� ����������', '������� ����������', '������� ����������', '������� ����������', '�����, �����', '������� ����������', '�����, �����', '������� ����������', '������� ����������');

  datasetDescr: array[0..19] of string = ('� ��������� ���� ���������� ������ ����� ��� ����������� ������ ���� � ������� ������. ���������� ������� � ����� ����� � ������ ������ ���� ������� ������������� ������� �������.',
'������ ��������� �������, ������� ���������� ������ ������� ����������� �� ������� �����, ������������. ��� ������� �������� �������������� ������ ���� ������� ���� ������� � ���������. ',
'�� ������� ���������� ��� ������� - ���� ��� �� ������, ��� ������������� ������� �������. ������ ������������ ��������� ����������� ������, ��� ��� ������� ����� ������������ ��� ��������.',
'�� ������� ���������� ������� ������� � ������� ������, ������� � ����. ��� ��������� ������, ������� ����� � �������, ���������� ����� � ���� ������. ������ �� ������ �����.',
'����� � ������������ �������, ������� ����� �������� �Job�, ���������� ������������ ������. ������������� ����� - �������, ��������� � ����������, ������������ ������� ���������� � �������.',
'��� �������� ������������ ������� � �������� ��������, ��������� �����. ������� ���������������������� ������� �������� ���������� ������, ���������� ��, ���������� � ������ � ����������� � ������. ',
'�� ������� ���������� ������� �� ����������� ������. ��� ������� � ������ ����, ��� ���� ����������� ������ ������� � ������������ ����� � ����� �������, ����� ������� ���������� � ���������� �����. ',
'�� ������� ���������� ������� ������� � ��������� ������������ �������. ',
'��������� ������ �� ���, ������� ����������� ������� � ����� � 15 ����. ���� ��������� ���� � ����� ������. ������ ���� ����������� ������������� ������ ���������� �����, �� �������� �� �����. ',
'�� ������� ���������� ������� � ����� ������, ��������� ���������. ��� ����� � ������� ���������, ���������� � �������, ������ ��� ����� � �����, � �� ���� �������� ����������� � ������. ',
'�� ������� ���������� ���� ��������� �������, � ����� ���������. ��� ������� ����� � ����� ������� � ������� �� ���� � �� ������ ����� �������� � �����.',
'���� ������ ���������� ����, ������ ������� ������ ������ ����������� ���������� ��������. � ���������� ���� ����������� ������� ����, ������ ����� � �������. ',
'�� ���� �������� ������������ ��������� ������, ��������� �� ��������� ������� ������, ���������, �������� � ������.',
'������� �������� ���� �������� � ��������� � ����� ���������� ������� � ������������� �������. �� ������������ ����� ������� ���������, ������� ������� ���� � ����� ������� �������������� ��������. ',
'�� ������ ������� ���������� ������� �������, �������������� ����������� ���������� �������, � ��� ����� ����������� �������� �����, ���������� ���������� ������� ������� ����. ',
'�� ������� ���������� ������� � ���������� �������, � �� ��� � ���� ���������� �����. ',
'������, ���������� ����� � ������ ��� ����������� ����������. ',
'������� �������� ���� ���� ������ � ���������� � �������� ������������ ���������. �� �������� ������, ������� ������� ������� � �� ������ ������� � ������������� ��������. ',
'�� ������� ���������� ������� � �����, ������� ������, �������� ���� � ����. ��� ������� �� ����, �������������� �������� ������ ������, � �� ���� ����� �������� ������ � �����������. ',
' ������� ��� ������ ������� ���� �� ��������� � ����������� ��������. ���� ������� ���������� ������ ������� � ������������ ���� �� ������� �������, ��� �������� ����� �� ������� ������� ����. ');


procedure createDataSet(start, stop: integer; name: string);
begin
      Setlength(info, 20);

  Rewrite(fileToWrite, name);
  for i := start to stop do
  begin
    info[i].title := datasetNames[i];
    info[i].yearOfStart := datasetYoS[i];
    info[i].yearOfEnd := datasetYoE[i];
    info[i].yearsOfWork := info[i].yearOfEnd - info[i].yearOfStart;
    info[i].genre := datasetGenre[i];
    info[i].theme := datasetTheme[i];
    info[i].place := datasetPlace[i];
    info[i].materials := datasetMats[i];
    info[i].shortDescr := datasetDescr[i];
    info[i].userRate := Random(5);
    info[i].userComment := '';
    info[i].isToBeChanged := flag;
    info[i].isFavourite := flag;
    info[i].filename := datasetFiles[i]  + '.bmp';
    info[i].imgBuffer := 0;
    write(fileToWrite, info[i]);
  end;

  closeFile(fileToWrite);
end;

procedure createListFile();
var
  fileWriteString: textFile;
  namesOfAlbums: array of string;
begin
  setlength(namesOfAlbums, 4);
  namesOfAlbums := ['�������.pics'];

  AssignFile(fileWriteString, 'enumerate.albums');
  Rewrite(fileWriteString);
  for i := 0 to high(namesOfAlbums) do
  begin

    writeln(fileWriteString, namesOfAlbums[i]);
  end;


  CloseFile(fileWriteString);


end;


begin


//  createDataSet(0, 9, '������.pics');
//  createDataSet(5, 14, '������.pics');
//  createDataSet(10, high(info), '������.pics');
  createListFile();

  createDataSet(0, 19, '�������.pics');

end.

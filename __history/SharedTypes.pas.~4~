unit SharedTypes;

interface

uses
  Vcl.Graphics;

type
  TData = packed record
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
    userComment: string[50];
    isToBeChanged: boolean;
    isFavourite: boolean;
    filename: string[25];
    imgBuffer: TPicture;
  end;

  PPicElem = ^TPicElems;

  TPicElems = record
    data: TData;
    Next: PPicElem;
  end;



implementation

end.

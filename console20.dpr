program console20;

uses
  System.SysUtils;

type
  PPicElem=^TPicElems;

  Tdata = packed record
    title: string[20];
    year: integer;
    genre: string[10];
    place: string[15];
    shortDescr: string[100];
    userRate: integer;
    filename: string[15];
  end;


  TPicElems = record
    data: Tdata;
    Next: PPicElem;
  end;

  TSortMethod = function(elem1, elem2: TData; direction: integer): integer;

var
  choice: integer;
  sortChoice: integer;
  sortDirection: integer;
  head: PPicElem;
  sortedHead: PPicElem;
  a: integer;


  // choice - user option what to do;
  // head - of a main pic list;

procedure clearConsole();
var
  i: integer;
  choice: char;
begin
  for i := 0 to 100 do
    writeln;
end;


procedure printList(head: PPicElem);
var
  list: PPicElem;
begin
  list := head;

  while list^.Next <> nil do
  begin
    writeln('--------------- Another picture -----------------');
    writeln('-------------- ', list^.data.title, ' -------------');

    writeln(list^.data.year);
    writeln(list^.data.genre);
    writeln(list^.data.place);
    writeln(list^.data.shortDescr);
    writeln(list^.data.userRate);
    writeln(list^.data.filename);

    list := list^.Next;

  end;
end;

procedure FetchAllPics(var head: PPicElem);
var
  RedPicList: PPicElem;
  storageFile: file of Tdata;
  current: TData;


begin

  Reset(storageFile, 'dataset.pics');

  new(redPicList);
  head := redPicList;
  repeat

    Read(storageFile, Current);

    redPicList^.data.title := current.title;
    redPicList^.data.year := current.year;
    redPicList^.data.genre := current.genre;
    redPicList^.data.place := current.place;
    redPicList^.data.shortDescr := current.shortDescr;
    redPicList^.data.userRate := current.userRate;
    redPicList^.data.filename := current.filename;


       new(redPicList^.Next);
    redPicList := redPicList^.Next;

  until Eof(storageFile);


  redPicList := nil;
  closeFile(storageFile);



  writeln;


end;

function cmpYear(elem1, elem2: TData; direction: integer): integer;
begin


  if (elem1.year > elem2.year) then
    result := 1*direction;
  if (elem1.year < elem2.year) then
    result := -1*direction;
  if (elem1.year = elem2.year) then
    result := 0;

end;

function cmpTitle(elem1, elem2: TData; direction: integer): integer;
begin

  if (elem1.title > elem2.title) then
    result := 1*direction;
  if (elem1.title < elem2.title) then
    result := -1*direction;
  if (elem1.title = elem2.title) then
    result := 0;

end;

function cmpUserRate(elem1, elem2: TData; direction: integer): integer;
begin

  if (elem1.userRate > elem2.userRate) then
    result := 1*direction;
  if (elem1.userRate < elem2.userRate) then
    result := -1*direction;
  if (elem1.userRate = elem2.userRate) then
    result := 0;

end;

function FindMiddle(headFind: PPicElem): PPicElem;
var
  slow, fast: PPicElem;
begin
  slow := headFind;
  fast := headFind^.Next;
  while (fast <> nil) do
  begin
    fast := fast^.Next;
    if (fast <> nil) then
    begin
      slow := slow^.Next;
      fast := fast^.Next;
    end;
  end;
  FindMiddle := slow;
end;

function MergeSort(head: PPicElem; sortDirection: integer; compare: TSortMethod): PPicElem;
var
  middle, right, left, newHead, tail: PPicElem;
  isExit: boolean;
begin
  isExit := false;


    if (head = nil) or (head^.Next = nil) then
    begin
      MergeSort := head;
      isExit := true;
    end;

  if not isExit then
  begin
    middle := FindMiddle(head);
    right := middle^.Next;
    middle^.Next := nil;
    left := head;

    left := MergeSort(left, sortDirection, compare);
    right := MergeSort(right, sortDirection, compare);

    newHead := nil;
    tail := nil;

    while (left <> nil) and (right <> nil) do
    begin
      if compare(left^.data, right^.data, sortDirection) < 0 then
      begin
        if newHead = nil then
          newHead := left;
        if tail <> nil then
          tail^.Next := left;
        tail := left;
        left := left^.Next;
      end
      else
      begin
        if newHead = nil then
          newHead := right;
        if tail <> nil then
          tail^.Next := right;
        tail := right;
        right := right^.Next;
      end;
    end;

    if left <> nil then
    begin
      if newHead = nil then
        newHead := left;
      if tail <> nil then
        tail^.Next := left;
    end
    else
    begin
      if newHead = nil then
        newHead := right;
      if tail <> nil then
        tail^.Next := right;
    end;

    MergeSort := newHead;
  end;
end;

begin

   FetchAllPics(head);

   repeat

        writeln('Please choose an option:');
        writeln('1. ����������� ��� �������');
        writeln('2. ����������� �������');
        writeln('3. IN DEV ����������� �������');
        writeln('4. IN DEV �������� ������� � ���������');
        writeln('5. IN DEV �������� ������� ������������ ������');
        writeln('6. IN DEV ��������� �����-���');
        writeln('7. IN DEV �������� �������� �������');
        writeln('8. IN DEV �������� �������');
        writeln('9. IN DEV ������� �������');
        writeln('10. IN DEV ����������� ��������� ���������');
        writeln('11. IN DEV ����������� ���������� � ���������');
        writeln('12. IN DEV ����������� ������� ����������� ������� ����� ���������');
        writeln('0. To exit');
        readln(choice);

        case choice of
            1: // ����������� �������
            begin
              clearConsole();
              writeln('������� ����� ����������� ��� �������');

              printList(head);
            end;
            2: // ����������� �������
            begin
              clearConsole();
              writeln('������� ����� ����������� �������');
              writeln('��� �����������?');
              writeln('1. ������ �������');
              writeln('2. �������� �������');
              repeat

                readln(sortDirection);

                case sortDirection of

                  1: ;
                  2: sortDirection := -(sortDirection div 2);
                  else
                  begin
                    writeln('�� ����� �������� �����. ��������� ����:');
                  end;
                end;

              until (sortDirection = 1) or (sortDirection = -1);

              writeln('�������� ������� ����������: ');
              writeln('1. �� ��������');
              writeln('2. �� ����');
              writeln('3. �� ������ ������������');

              repeat
                readln(sortChoice);

                case sortChoice of
                  1:
                  begin

                    sortedHead := mergeSort(head, sortDirection, cmpTitle);

                    writeln;
                  end;
                  2:
                  begin

                    sortedHead := mergeSort(head, sortDirection, cmpYear);
                  end;
                  3:
                  begin

                    sortedHead := mergeSort(head, sortDirection, cmpUserRate);

                  end;
                  else
                  begin
                    writeln('�� ����� �������� �����. ��������� ����:');
                  end;
                end;

              until (sortChoice = 1) or (sortChoice = 2) or (sortChoice = 3);




               writeln('IN DEVELOPMENT');

            end;
            3:
            begin
              clearConsole();
              writeln('IN DEVELOPMENT');
            end;
            4:
            begin
              clearConsole();
              writeln('IN DEVELOPMENT');
            end;
            5:
            begin
              clearConsole();
               writeln('IN DEVELOPMENT');
            end;
            6:
            begin
              clearConsole();
               writeln('IN DEVELOPMENT');
            end;
            7:
            begin
              clearConsole();
              writeln('IN DEVELOPMENT');
            end;
            8:
            begin
              clearConsole();
              writeln('IN DEVELOPMENT');
            end;
            9:
            begin
              clearConsole();
              writeln('IN DEVELOPMENT');
            end;
            10:
            begin
              clearConsole();
              writeln('IN DEVELOPMENT');
            end;
            11:
            begin
              clearConsole();
              writeln('IN DEVELOPMENT');
            end;
            12:
            begin
              clearConsole();
              writeln('IN DEVELOPMENT');
            end;
            else
            begin
                clearConsole();
                writeln('Invalid choice, please try again.');
            end;
        end;

    until choice = 0;


end.

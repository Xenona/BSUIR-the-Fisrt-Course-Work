program console20;

uses
  System.SysUtils;

type
  PPicElem=^TPicElems;

  Tdata = packed record
    title: string[50];
    yearOfStart: integer;
    yearOfEnd: integer;
    yearsOfWork: integer;
    genre: string[10];
    theme: string[10];
    place: string[15];
    materials: string[15];
    shortDescr: string[100];
    userRate: integer;
    userComment: string[50];
    isToBeChanged: boolean;
    isFavourite: boolean;
    filename: string[25];
    imgBuffer: Integer;
  end;


  TPicElems = record
    data: Tdata;
    Next: PPicElem;
  end;

  TSortMethod = function(elem1, elem2: TData; direction: integer): integer;

var
  head: PPicElem;
  choice: integer;

  sortChoice: integer;
  sortDirection: integer;
  sortedHead: PPicElem;

  searchChoice: integer;
  searchString: string;
  searchedHead: PPicElem;



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

  while list <> nil do
  begin
    writeln('--------------- Another picture -----------------');

    writeln(list^.data.title);
    writeln(list^.data.yearOfStart);
    writeln(list^.data.yearOfEnd);
    writeln(list^.data.yearsOfWork);
    writeln(list^.data.genre);
    writeln(list^.data.theme);
    writeln(list^.data.place);
    writeln(list^.data.materials);
    writeln(list^.data.shortDescr);
    writeln(list^.data.userRate);
    writeln(list^.data.userComment);
    writeln(list^.data.isToBeChanged);
    writeln(list^.data.isFavourite);
    writeln(list^.data.filename);

    list := list^.Next;

  end;
  writeln('---------------------------------------------------');
  writeln;
end;

procedure FetchAllPics(var head: PPicElem);
var
  readPicList: PPicElem;
  storageFile: file of Tdata;
  current: TData;


begin

  Reset(storageFile, 'dataset.pics');

  new(readPicList);
      head := readPicList;


  repeat

      new(readPicList^.Next);
      readPicList := readPicList^.Next;

      Read(storageFile, Current);

      readPicList^.data.title := current.title;
      readPicList^.data.yearOfStart := current.yearOfStart;
      readPicList^.data.yearOfEnd := current.yearOfEnd;
      readPicList^.data.yearsOfWork := current.yearsOfWork;
      readPicList^.data.genre := current.genre;
      readPicList^.data.theme := current.theme;
      readPicList^.data.place := current.place;
      readPicList^.data.materials := current.materials;
      readPicList^.data.shortDescr := current.shortDescr;
      readPicList^.data.userRate := current.userRate;
      readPicList^.data.userComment := current.userComment;
      readPicList^.data.isToBeChanged := current.isToBeChanged;
      readPicList^.data.isFavourite := current.isFavourite;
      readPicList^.data.userComment := current.userComment;
      readPicList^.data.filename := current.filename;

  until Eof(storageFile);

    readPicList := nil;

  closeFile(storageFile);

    readPicList := head;
    head := readPicList^.Next;
    dispose(readPicList);


  writeln;


end;

// COMPARATORS SECTION BEGIN

function cmpYearStart(elem1, elem2: TData; direction: integer): integer;
begin


  if (elem1.yearOfStart > elem2.yearOfStart) then
    result := 1*direction;
  if (elem1.yearOfStart < elem2.yearOfStart) then
    result := -1*direction;
  if (elem1.yearOfStart = elem2.yearOfStart) then
    result := 0;

end;

function cmpYearEnd(elem1, elem2: TData; direction: integer): integer;
begin


  if (elem1.yearOfEnd > elem2.yearOfEnd) then
    result := 1*direction;
  if (elem1.yearOfEnd < elem2.yearOfEnd) then
    result := -1*direction;
  if (elem1.yearOfEnd = elem2.yearOfEnd) then
    result := 0;

end;

function cmpYearsWork(elem1, elem2: TData; direction: integer): integer;
begin


  if (elem1.yearsOfWork > elem2.yearsOfWork) then
    result := 1*direction;
  if (elem1.yearsOfWork < elem2.yearsOfWork) then
    result := -1*direction;
  if (elem1.yearsOfWork = elem2.yearsOfWork) then
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

// COMPARATORS SECTION END

// SORT SECTION BEGIN

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
  result := slow;
end;

function CopyList(head: PPicElem): PPicElem;
var
  current, newHead, newNode: PPicElem;
begin
  newHead := nil;
  current := head;

  while (current <> nil) do
  begin
    newNode := New(PPicElem);
    newNode^.data := current^.data;
    newNode^.Next := nil;

    if (newHead = nil) then
    begin
      newHead := newNode;
    end
    else
    begin
      newNode^.Next := newHead;
      newHead := newNode;
    end;

    current := current^.Next;
  end;

  result := newHead;
end;

function MergeSort(head: PPicElem; sortDirection: integer; compare: TSortMethod): PPicElem;
var
  middle, right, left, newHead, tail, tempHead: PPicElem;
  isExit: boolean;
begin
  isExit := false;

  tempHead := CopyList(head);

  if (tempHead = nil) or (tempHead^.Next = nil) then
  begin
    result := tempHead;
    isExit := true;
  end;

  if not isExit then
  begin
    middle := FindMiddle(tempHead);
    right := middle^.Next;
    middle^.Next := nil;
    left := tempHead;

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
    if tail <> nil then
      tail^.Next := nil;

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

    result := newHead;

    // Free the copied list
    while (tempHead <> nil) do
    begin
      tail := tempHead;
      tempHead := tempHead^.Next;
      Dispose(tail);
    end;
  end;
end;


// SORT SECTION END

// SEARCH SECTION BEGIN

function isRecordMatch(const data: Tdata; const searchStr: string; field: integer): boolean;
begin

  if field = 1 then   // title
  begin
       Result :=
    (Pos(searchStr, data.title) > 0)
  end
  else
  if field = 2 then   // years of start
  begin


    Result := (Pos(searchStr, IntToStr(data.yearOfStart)) > 0)

  end
  else
  if field = 3 then   // years of end
  begin
     Result := (Pos(searchStr, IntToStr(data.yearOfEnd)) > 0)
  end
  else
  if field = 4 then // years of work
  begin
       Result := (Pos(searchStr, IntToStr(data.yearsOfWork)) > 0)
  end
  else
  if field = 5 then // gengre
  begin
      Result :=  (Pos(searchStr, data.genre) > 0)
  end
  else
  if field = 6 then //theme
  begin
      Result :=     (Pos(searchStr, data.theme) > 0)
  end
  else
  if field = 7 then // place
  begin
    Result :=   (Pos(searchStr, data.place) > 0)
  end
  else
  if field = 8 then // materials
  begin
    Result :=   (Pos(searchStr, data.materials) > 0)
  end
  else
  if field = 9 then // short description
  begin
     Result :=   (Pos(searchStr, data.shortDescr) > 0)
  end
  else
  if field = 10 then // user rate
  begin
     Result :=  (Pos(searchStr, IntToStr(data.userRate)) > 0)
  end
  else
  if field = 11 then // user comment
  begin
       Result :=  (Pos(searchStr, data.userComment) > 0)
  end
  else
  begin      // all

     Result :=
    (Pos(searchStr, data.title) > 0) or
    (Pos(searchStr, IntToStr(data.yearOfStart)) > 0) or
    (Pos(searchStr, IntToStr(data.yearOfEnd)) > 0) or
    (Pos(searchStr, IntToStr(data.yearsOfWork)) > 0) or
    (Pos(searchStr, data.genre) > 0) or
    (Pos(searchStr, data.theme) > 0) or
    (Pos(searchStr, data.place) > 0) or
    (Pos(searchStr, data.materials) > 0) or
    (Pos(searchStr, data.shortDescr) > 0) or
    (Pos(searchStr, IntToStr(data.userRate)) > 0) or
    (Pos(searchStr, data.userComment) > 0) or
    (Pos(searchStr, data.filename) > 0);


  end;




end;

function searchData(head: PPicElem; infoToSearch: string; fieldSearch: integer ): PPicElem;
var
  curElem: PPicElem;
  newList: PPicElem;
  // curElem - current elem of init list being processed;
  // newHead - list of records that fulfill the search condition;

  // head of created list returns in 'return' var;
begin
  curElem := head;
  newList := nil;
  result := nil;

  while curElem <> nil do
  begin
    if isRecordMatch(curElem^.data, infoToSearch, fieldSearch) then
    begin
      if newList = nil then
      begin
        new(newList);
        newList^.data := curElem^.data;
        result := newList;
      end
      else
      begin
        new(newList^.Next);
        newList := newList^.Next;
        newList^.data := CurElem^.data;
        newList^.Next := nil;
      end;
    end;
    curElem := curElem^.Next;
  end;

end;

// SEARCH SECTION END

// IMPLEMENT SECTION BEGIN
// procedure printPic(picture: integer = 0; str: string = 'lalala'; tree: string = 'strrrrrrr');
//begin
//  writeln('pic ', picture);
//  writeln('str ', str);
//  writeln('tree ', tree);
//end;



// IMPLEMENT SECTION END



begin


//    printPic(tree := 'fff');


   FetchAllPics(head);

   repeat

        writeln('Please choose an option:');
        writeln('1. Просмотреть все картины');
        writeln('2. Сортировать картины');
        writeln('3. Поиск картины');
        writeln('4. IN DEV Фильтровать картины');
        writeln('5. IN DEV Добавить картину в избранное');
        writeln('6. IN DEV Добавить картине персональную оценку');
        writeln('7. IN DEV Составить слайд-шоу');
        writeln('8. IN DEV Изменить описание картины');
        writeln('9. IN DEV Добавить картину');
        writeln('10. IN DEV Удалить картину');
        writeln('11. IN DEV Просмотреть биографию художника');
        writeln('12. IN DEV Просмотреть информацию о программе');
        writeln('13. IN DEV Просмотреть картины конкретного периода жизни художника');
        writeln('0. To exit');
        readln(choice);

        case choice of
            1: // ПРОСМОТРЕТЬ КАРТИНЫ ------------------------------------------------------------
            begin
              clearConsole();
              writeln('Выбрана опция просмотреть все картины');

              printList(head);
            end;
            2: // СОРТИРОВАТЬ КАРТИНЫ ------------------------------------------------------------
            begin
              clearConsole();
              writeln('Выбрана опция сортировать картины');
              writeln('Как сортировать?');
              writeln('1. Прямой порядок');
              writeln('2. Обратный порядок');
              repeat

                readln(sortDirection);

                case sortDirection of

                  1: ;
                  2: sortDirection := -(sortDirection div 2);
                  else
                  begin
                    writeln('Вы ввели неверную цифру. Повторите ввод:');
                  end;
                end;

              until (sortDirection = 1) or (sortDirection = -1);

              writeln('Выберите признак сортировки: ');
              writeln('1. По названию');
              writeln('2. По году');
              writeln('3. По оценке пользователя');

              repeat
                readln(sortChoice);

                case sortChoice of
                  1:
                  begin

                    sortedHead := mergeSort(head, sortDirection, cmpTitle);
                    printList(sortedHead);

                  end;
                  2:
                  begin

                    sortedHead := mergeSort(head, sortDirection, cmpYearStart);
                    printList(sortedHead);
                  end;
                  3:
                  begin

                    sortedHead := mergeSort(head, sortDirection, cmpUserRate);
                    printList(sortedHead);

                  end;
                  else
                  begin
                    writeln('Вы ввели неверную цифру. Повторите ввод:');
                  end;
                end;

              until (sortChoice = 1) or (sortChoice = 2) or (sortChoice = 3);

            end;
            3: // ПОИСК КАРТИНЫ -------------------------------------------------------------------
            begin
              clearConsole();

              writeln('Вы выбрали опцию поиска картины');
              writeln('Введите значение, которое необходимо найти: ');
              readln(searchString);
              writeln('Выберите поле, по которому будет происходить сортировка:');
              writeln('1. Название');
              writeln('2. Год начала');
              writeln('3. Год конца');
              writeln('4. Время работы над картиной');
              writeln('5. Жанр');
              writeln('6. Тема');
              writeln('7. Место');
              writeln('8. Материал');
              writeln('9. Краткое описание');
              writeln('10. Пользовательская оценка');
              writeln('11. Пользовательский комментарий');
              writeln('12. Любая характеристика');


              repeat

                readln(searchChoice);

                case searchChoice of
                  1:
                  begin
                    searchedHead := searchData(head, searchString, searchChoice);
                    if searchedHead = nil then
                      writeln('Картин по вашему запросу не найдено')
                    else
                      printList(searchedHead);

                  end;
                  2:
                  begin
                    searchedHead := searchData(head, searchString, searchChoice);
                    if searchedHead = nil then
                      writeln('Картин по вашему запросу не найдено')
                    else
                      printList(searchedHead);
                  end;
                  3:
                  begin
                    searchedHead := searchData(head, searchString, searchChoice);
                    if searchedHead = nil then
                      writeln('Картин по вашему запросу не найдено')
                    else
                      printList(searchedHead);
                  end;
                  4:
                  begin
                    searchedHead := searchData(head, searchString, searchChoice);
                    if searchedHead = nil then
                      writeln('Картин по вашему запросу не найдено')
                    else
                      printList(searchedHead);
                  end;
                  5:
                  begin
                    searchedHead := searchData(head, searchString, searchChoice);
                    if searchedHead = nil then
                      writeln('Картин по вашему запросу не найдено')
                    else
                      printList(searchedHead);
                  end;
                  6:
                  begin
                    searchedHead := searchData(head, searchString, searchChoice);
                    if searchedHead = nil then
                      writeln('Картин по вашему запросу не найдено')
                    else
                      printList(searchedHead);
                  end;
                  7:
                  begin
                    searchedHead := searchData(head, searchString, searchChoice);
                    if searchedHead = nil then
                      writeln('Картин по вашему запросу не найдено')
                    else
                      printList(searchedHead);
                  end;
                  8:
                  begin
                    searchedHead := searchData(head, searchString, searchChoice);
                    if searchedHead = nil then
                      writeln('Картин по вашему запросу не найдено')
                    else
                      printList(searchedHead);
                  end;
                  9:
                  begin
                    searchedHead := searchData(head, searchString, searchChoice);
                    if searchedHead = nil then
                      writeln('Картин по вашему запросу не найдено')
                    else
                      printList(searchedHead);
                  end;
                  10:
                  begin
                    searchedHead := searchData(head, searchString, searchChoice);
                    if searchedHead = nil then
                      writeln('Картин по вашему запросу не найдено')
                    else
                      printList(searchedHead);
                  end;
                  11:
                  begin
                    searchedHead := searchData(head, searchString, searchChoice);
                    if searchedHead = nil then
                      writeln('Картин по вашему запросу не найдено')
                    else
                      printList(searchedHead);
                  end;
                  12:
                  begin
                    searchedHead := searchData(head, searchString, searchChoice);
                    if searchedHead = nil then
                      writeln('Картин по вашему запросу не найдено')
                    else
                      printList(searchedHead);
                  end;
                  else
                  begin
                    writeln('Вы ввели неверное значение, повторите ввод');
                  end;
                end;
              until (searchChoice >= 1) and (searchChoice <= 12);




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
            13:
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

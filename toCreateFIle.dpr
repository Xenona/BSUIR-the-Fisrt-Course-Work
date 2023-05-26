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
  'Monaco Monte Carlo', 'Salome',  'Seasons', 'The Slav Epic', 'Slavia', 'Spirit Of Spring',  'The Quill', 'Зодиак');

  datasetYoS: array[0..19] of integer = (1925, 1898, 1899, 1899, 1896, 1897, 1898, 1920, 1916, 1930, 1905, 1899, 1897, 1897, 1896, 1928, 1896, 1894, 1899, 1896);
  datasetYoE: array[0..19] of integer = (1925, 1898, 1900, 1900, 1896, 1897, 1898, 1921, 1918, 1931, 1905, 1899, 1897, 1897, 1900, 1929, 1896, 1895, 1900, 1896);
  datasetGenre: array[0..19] of string = ('Романтизм', 'Ар нуво', 'Ар нуво', 'Ар нуво', 'Ар нуво', 'Ар нуво', 'Ар нуво', 'Романтизм', 'Романтизм', 'Романтизм', 'Романтизм', 'Ар нуво', 'Ар нуво', 'Ар нуво', 'Ар нуво', 'Романтизм', 'Ар нуво', 'Романтизм', 'Ар нуво', 'Ар нуво');
  datasetTheme: array[0..19] of string = ('Славяне', 'Аллегории', 'Аллегории', 'Аллегории', 'Постеры', 'Аллегории', 'Постеры',' Люди', 'Славяне', 'Люди', 'Люди', 'Аллегории', 'Постеры', 'Аллегории', 'Аллегории', 'Славяне', 'Славяне', 'Аллегории', 'Аллегории', 'Аллегории');
  datasetPlace: array[0..19] of string = ('Прага', 'Прага', 'Париж', 'Париж', 'Париж', 'Париж', 'Париж', 'Прага', 'Прага', 'Прага', 'Прага', 'Париж', 'Париж', 'Париж', 'Париж', 'Прага', 'Прага', 'Париж', 'Париж', 'Прага');
  datasetMats: array[0..19] of string = ('Холст, масло', 'Цветная литография', 'Цветная литография', 'Цветная литография', 'Цветная литография', 'Цветная литография', 'Цветная литография', 'Холст, масло', 'Холст, темпера', 'Холст, масло', 'Гуашь, доска', 'Цветная литография', 'Цветная литография', 'Цветная литография', 'Цветная литография', 'Холст, масло', 'Цветная литография', 'Холст, масло', 'Цветная литография', 'Цветная литография');

  datasetDescr: array[0..19] of string = ('В «Апофеозе» Муха использует четыре цвета для обозначения разных эпох в истории славян. Призрачные силуэты в синей дымке в правом нижнем углу картины символизируют древние времена.',
'Фигура танцующей девушки, длинные каштановые волосы которой развеваются на осеннем ветру, завораживает. Эта картина является свидетельством умения Мухи уловить суть красоты и изящества. ',
'На картине изображены две девушки - одна как бы позади, что символизирует историю Австрии. Справа представлены различные австрийские города, так что картину часто использовали как открытку.',
'На картине изображена молодая женщина в длинном платье, сидящая в саду. Она наклонила голову, закрыла глаза и заснула, уткнувшись лицом в свою ладонь. Вокруг неё растут цветы.',
'Принт с изображением шатенки, курящей перед надписью «Job», обведенной декоративной рамкой. Преобладающие цвета - зеленый, пурпурный и коричневый, подчеркнутые красным орнаментом в волосах.',
'Это довольно приглушенная картина с одинокой женщиной, смотрящей вдаль. Главной достопримечательностью женщины является количество цветов, окружающих ее, завязанных в волосы и ниспадающих с одежды. ',
'На постере изображена девушка во французских лилиях. Эта картина – пример того, как Муха использовал мотивы природы и человеческих фигур в своих работах, чтобы создать уникальный и элегантный стиль. ',
'На картине изображена молодая девушка в моравском национальном костюме. ',
'Изображен Мастер Ян Гус, чешский религиозный деятель в Праге в 15 веке. Муха изобразил Гуса в белой одежде. Вокруг него расположены представители разных социальных слоев, от бедняков до знати. ',
'На картине изображена женщина в синем платье, названная Ярославой. Она сидит в простом облачении, обращенная к зрителю, смотря ему прямо в глаза, и ее лицо выражает спокойствие и грацию. ',
'На картине изображена жена художника Марушка, в синем облачении. Она смотрит прямо в глаза зрителя с улыбкой на лице и ее взгляд полон нежности и любви.',
'Руби держит вызывающую позу, игриво касаясь своего богато украшенного рубинового ожерелья. В композиции Мухи преобладает красный цвет, символ любви и страсти. ',
'Ее тело окружено замысловатым цветочным узором, состоящим из изогнутых стеблей сирени, гортензии, диантуса и фиалки.',
'Саломея Альфонса Мухи эротична и экзотична в своем прозрачном костюме и стилизованных волосах. Ее полузакрытые глаза смотрят вызывающе, отражая интерес Мухи к новой области гипнотического внушения. ',
'На каждой картине изображена молодая женщина, олицетворяющая гармоничный круговорот природы, а фон имеет характерные сезонные черты, передающие настроение каждого времени года. ',
'На картине изображена девушка в славянском костюме, а за ней – лики славянских богов. ',
'Постер, написанный Мухой в период его «рекламного творчества». ',
'Картина Альфонса Мухи «Дух весны» — прекрасное и чарующее произведение искусства. Он передает нежную, изящную красоту природы с ее яркими цветами и замысловатыми деталями. ',
'На картине изображена женщина в узком, высоком платье, держащая перо в руке. Она смотрит на перо, сосредоточенно готовясь начать писать, и ее лицо полно глубоких мыслей и вдохновения. ',
' «Зодиак» был первой работой Мухи по контракту с типографией Шампенуа. Муха включил двенадцать знаков зодиака в галообразный диск за головой женщины, что является одним из обычных мотивов Мухи. ');


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
  namesOfAlbums := ['Главная.pics'];

  AssignFile(fileWriteString, 'enumerate.albums');
  Rewrite(fileWriteString);
  for i := 0 to high(namesOfAlbums) do
  begin

    writeln(fileWriteString, namesOfAlbums[i]);
  end;


  CloseFile(fileWriteString);


end;


begin


//  createDataSet(0, 9, 'Первый.pics');
//  createDataSet(5, 14, 'Второй.pics');
//  createDataSet(10, high(info), 'Третий.pics');
  createListFile();

  createDataSet(0, 19, 'Главная.pics');

end.

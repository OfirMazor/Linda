CREATE TABLE [CadasterProcessBorders] (
  [OBJECTID] integer UNIQUE NOT NULL IDENTITY(1, 1),
  [Shape] geometry,
  [GlobalID] uuid UNIQUE PRIMARY KEY NOT NULL,
  [ProcessName] string UNIQUE NOT NULL,
  [ProcessNumber] integer,
  [ProcessYear] integer,
  [ProcessPrefix] string,
  [ProcessType] nvarchar(255) NOT NULL CHECK ([ProcessType] IN ('1 : תכנית לצרכי רישום', '2 : תכנית מרחבית לצרכי רישום', '3 : פסק דין', '4 : תשריט תיעוד גבולות', '5 : קדסטר מבוסס קואורדינטות', '6 : תיקון הסדר לפי סעיף 97ב', '7 : תיקון תכנית לצרכי רישום', '8 : תיקון/עדכון בעקבות פניית ציבור', '9 : הסדר מקרקעין', '10 : רישום ראשון בשטח לא מוסדר', '11 : תכנית לצרכי רישום בשטח לא מסודר', '12 : תיקון תכנית לצרכי רישום בשטח לא מסודר', '13 : תיקון רישום שטח וגבולות בשטח לא מוסדר', '14 : תיקוןעדכון בעקבות פניית ציבור בשטח לא מוסדר', '15 : תשריט תיעוד גבולות להסדר מקרקעין', '16 : עריכה חופשית')) NOT NULL,
  [Status] nvarchar(255) NOT NULL CHECK ([Status] IN ('1 : ממתינה לביקורת', '2 : בביקורת', '3 : בביקורת מודד מבקר', '4 : כשרה לרישום', '5 : רשומה', '6 : מאושרת לתיעוד גבולות', '7 : מוקפאת', '8 : פגת תוקף לרישום', '9 : מבוטלת', '10 : כשרה לרישום - הוארך תוקפה לרישום', '11 : בהכנה', '12 : בטיפול הממונה על המרשם', '13 : מאושרת', '14 : בביצוע', '15 : לא מאושרת', '16 : בטיפול פקיד הסדר', '17 : עריכה חדשה', '18 : עריכה הסתיימה', '19 : בתיקונים', '90 : חלוקה', '91 : מפה מוקדמת ממתינה לביקורת', '92 : מפה מוקדמת בביקורת', '93 : מפה מוקדמת בתיקונים', '94 : מפה מוקדמת מאושרת', '95 : מפה ארעית ממתינה לביקורת', '96 : מפה ארעית בביקורת', '97 : מפה ארעית בתיקונים', '98 : מפה ארעית מאושרת', '99 : מפה סופית ממתינה לביקורת', '100 : מפה סופית בביקורת', '101 : מפה סופית בתיקונים', '102 : מפה סופית מאושרת', '103 : פורסמה ברשומות')) NOT NULL,
  [BlockUniqueID] uuid,
  [GeodeticNetwork] nvarchar(255) NOT NULL CHECK ([GeodeticNetwork] IN ('0 : רשת לא ידועה', '1 : רשת ישראל הישנה', '2 : רשת ישראל', '3 : רשת ישראל התקפה')),
  [SurveyorLicenseID] integer,
  [DataSource] nvarchar(255) NOT NULL CHECK ([DataSource] IN ('0 : לא ידוע', '1 : כרטסת', '2 : טבלאי', '3 : דיגיטציה', '4 : SRV', '5 : CAD')),
  [PlanName] string,
  [Shape_Length] float,
  [Shape_Area] float
)
GO

CREATE TABLE [CadasterRecordsBorders] (
  [OBJECTID] integer UNIQUE NOT NULL IDENTITY(1, 1),
  [Shape] geometry,
  [Name] string UNIQUE NOT NULL,
  [RecordType] nvarchar(255) NOT NULL CHECK ([RecordType] IN ('1 : תכנית לצרכי רישום', '2 : תכנית מרחבית לצרכי רישום', '3 : פסק דין', '4 : תשריט תיעוד גבולות', '5 : קדסטר מבוסס קואורדינטות', '6 : תיקון הסדר לפי סעיף 97ב', '7 : תיקון תכנית לצרכי רישום', '8 : תיקון/עדכון בעקבות פניית ציבור', '9 : הסדר מקרקעין', '10 : רישום ראשון בשטח לא מוסדר', '11 : תכנית לצרכי רישום בשטח לא מסודר', '12 : תיקון תכנית לצרכי רישום בשטח לא מסודר', '13 : תיקון רישום שטח וגבולות בשטח לא מוסדר', '14 : תיקוןעדכון בעקבות פניית ציבור בשטח לא מוסדר', '15 : תשריט תיעוד גבולות להסדר מקרקעין', '16 : עריכה חופשית')),
  [RecordedDate] datetime,
  [ParcelCount] integer,
  [RetiredParcelCount] integer,
  [Shape_Length] float,
  [Shape_Area] float,
  [GlobalID] uuid UNIQUE PRIMARY KEY NOT NULL,
  [GeodeticNetwork] nvarchar(255) NOT NULL CHECK ([GeodeticNetwork] IN ('0 : רשת לא ידועה', '1 : רשת ישראל הישנה', '2 : רשת ישראל', '3 : רשת ישראל התקפה')),
  [Status] nvarchar(255) NOT NULL CHECK ([Status] IN ('1 : ממתינה לביקורת', '2 : בביקורת', '3 : בביקורת מודד מבקר', '4 : כשרה לרישום', '5 : רשומה', '6 : מאושרת לתיעוד גבולות', '7 : מוקפאת', '8 : פגת תוקף לרישום', '9 : מבוטלת', '10 : כשרה לרישום - הוארך תוקפה לרישום', '11 : בהכנה', '12 : בטיפול הממונה על המרשם', '13 : מאושרת', '14 : בביצוע', '15 : לא מאושרת', '16 : בטיפול פקיד הסדר', '17 : עריכה חדשה', '18 : עריכה הסתיימה', '19 : בתיקונים', '90 : חלוקה', '91 : מפה מוקדמת ממתינה לביקורת', '92 : מפה מוקדמת בביקורת', '93 : מפה מוקדמת בתיקונים', '94 : מפה מוקדמת מאושרת', '95 : מפה ארעית ממתינה לביקורת', '96 : מפה ארעית בביקורת', '97 : מפה ארעית בתיקונים', '98 : מפה ארעית מאושרת', '99 : מפה סופית ממתינה לביקורת', '100 : מפה סופית בביקורת', '101 : מפה סופית בתיקונים', '102 : מפה סופית מאושרת', '103 : פורסמה ברשומות')),
  [SurveyorLicenseID] integer,
  [DataSource] nvarchar(255) NOT NULL CHECK ([DataSource] IN ('0 : לא ידוע', '1 : כרטסת', '2 : טבלאי', '3 : דיגיטציה', '4 : SRV', '5 : CAD')),
  [PlanName] string,
  [BlockUniqueID] uuid,
  [created_user] string,
  [created_date] datetime,
  [last_edited_user] string,
  [last_edited_date] datetime
)
GO

CREATE TABLE [CPBStatusAndDates] (
  [OBJECTID] integer UNIQUE NOT NULL IDENTITY(1, 1),
  [CPBUniqueID] uuid NOT NULL,
  [ProcessType] nvarchar(255) NOT NULL CHECK ([ProcessType] IN ('1 : תכנית לצרכי רישום', '2 : תכנית מרחבית לצרכי רישום', '3 : פסק דין', '4 : תשריט תיעוד גבולות', '5 : קדסטר מבוסס קואורדינטות', '6 : תיקון הסדר לפי סעיף 97ב', '7 : תיקון תכנית לצרכי רישום', '8 : תיקון/עדכון בעקבות פניית ציבור', '9 : הסדר מקרקעין', '10 : רישום ראשון בשטח לא מוסדר', '11 : תכנית לצרכי רישום בשטח לא מסודר', '12 : תיקון תכנית לצרכי רישום בשטח לא מסודר', '13 : תיקון רישום שטח וגבולות בשטח לא מוסדר', '14 : תיקוןעדכון בעקבות פניית ציבור בשטח לא מוסדר', '15 : תשריט תיעוד גבולות להסדר מקרקעין', '16 : עריכה חופשית')),
  [Status] nvarchar(255) NOT NULL CHECK ([Status] IN ('1 : ממתינה לביקורת', '2 : בביקורת', '3 : בביקורת מודד מבקר', '4 : כשרה לרישום', '5 : רשומה', '6 : מאושרת לתיעוד גבולות', '7 : מוקפאת', '8 : פגת תוקף לרישום', '9 : מבוטלת', '10 : כשרה לרישום - הוארך תוקפה לרישום', '11 : בהכנה', '12 : בטיפול הממונה על המרשם', '13 : מאושרת', '14 : בביצוע', '15 : לא מאושרת', '16 : בטיפול פקיד הסדר', '17 : עריכה חדשה', '18 : עריכה הסתיימה', '19 : בתיקונים', '90 : חלוקה', '91 : מפה מוקדמת ממתינה לביקורת', '92 : מפה מוקדמת בביקורת', '93 : מפה מוקדמת בתיקונים', '94 : מפה מוקדמת מאושרת', '95 : מפה ארעית ממתינה לביקורת', '96 : מפה ארעית בביקורת', '97 : מפה ארעית בתיקונים', '98 : מפה ארעית מאושרת', '99 : מפה סופית ממתינה לביקורת', '100 : מפה סופית בביקורת', '101 : מפה סופית בתיקונים', '102 : מפה סופית מאושרת', '103 : פורסמה ברשומות')),
  [DateStatus] datetime
)
GO

CREATE TABLE [SequenceActions] (
  [OBJECTID] integer UNIQUE NOT NULL IDENTITY(1, 1),
  [CPBUniqueID] uuid NOT NULL,
  [ProcessType] nvarchar(255) NOT NULL CHECK ([ProcessType] IN ('1 : תכנית לצרכי רישום', '2 : תכנית מרחבית לצרכי רישום', '3 : פסק דין', '4 : תשריט תיעוד גבולות', '5 : קדסטר מבוסס קואורדינטות', '6 : תיקון הסדר לפי סעיף 97ב', '7 : תיקון תכנית לצרכי רישום', '8 : תיקון/עדכון בעקבות פניית ציבור', '9 : הסדר מקרקעין', '10 : רישום ראשון בשטח לא מוסדר', '11 : תכנית לצרכי רישום בשטח לא מסודר', '12 : תיקון תכנית לצרכי רישום בשטח לא מסודר', '13 : תיקון רישום שטח וגבולות בשטח לא מוסדר', '14 : תיקוןעדכון בעקבות פניית ציבור בשטח לא מוסדר', '15 : תשריט תיעוד גבולות להסדר מקרקעין', '16 : עריכה חופשית')),
  [BlockNumber] integer,
  [SubBlockNumber] integer,
  [ActionNumber] integer,
  [ActionType] nvarchar(255) NOT NULL CHECK ([ActionType] IN ('1 : חלוקה', '2 : איחוד', '3 : העברה בין גושים', '4 : טיוב', '5 : יצירה', '6 : ביטול')),
  [LineNumber] integer,
  [FromParcelTemp] integer,
  [FromParcelFinal] integer,
  [ToBlockNumber] integer,
  [ToSubBlockNumber] integer,
  [ToParcelTemp] integer,
  [ToParcelFinal] integer,
  [CPBTempSourceID] uuid
)
GO

CREATE TABLE [Blocks] (
  [OBJECTID] integer UNIQUE NOT NULL IDENTITY(1, 1),
  [Shape] geometry,
  [Name] string NOT NULL,
  [CreatedByRecord] uuid NOT NULL,
  [RetiredByRecord] uuid,
  [StatedArea] float,
  [StatedAreaUnit] integer,
  [CalculatedArea] float,
  [MiscloseRatio] float,
  [MiscloseDistance] float,
  [IsSeed] integer,
  [Shape_Length] float,
  [Shape_Area] float,
  [GlobalID] uuid UNIQUE PRIMARY KEY NOT NULL,
  [VALIDATIONSTATUS] nvarchar(255) NOT NULL CHECK ([VALIDATIONSTATUS] IN ('0 : No calculation required, no validation required, no error', '1 : No calculation required, no validation required, has error(s)', '2 : No calculation required, validation required, no error', '3 : No calculation required, validation required, has error(s)', '4 : Calculation required, no validation required, no error', '5 : Calculation required, no validation required, has error(s)', '6 : Calculation required, validation required, no errorמ', '7 : Calculation required, validation required, has error(s)')),
  [BlockNumber] integer NOT NULL,
  [SubBlockNumber] integer NOT NULL,
  [BlockStatus] nvarchar(255) NOT NULL CHECK ([BlockStatus] IN ('11 : נוצר בהסדר', '12 : נוצר בתצר', '13 : טרום תצר', '21 : לא מוסדר', '22 : בהסדר חלוקה', '23 : בהסדר מוקדמת', '24 : בהסדר ארעית', '25 : בהסדר סופית', '26 : הסדר בהקפאה', '27 : זמני', '28 : עפ תצר רשומה')) NOT NULL,
  [IsJordanian] nvarchar(255) NOT NULL CHECK ([IsJordanian] IN ('0 : לא', '1 : כן')),
  [SetteledDate] datetime,
  [LastRegisterdParcel] integer,
  [LastParcel] integer,
  [LastSetteledParcel] integer,
  [LastCourtParcel] integer,
  [LandType] nvarchar(255) NOT NULL CHECK ([LandType] IN ('1 : מוסדר', '2 : לא מוסדר')),
  [IsTax] nvarchar(255) NOT NULL CHECK ([IsTax] IN ('0 : לא', '1 : כן')),
  [created_user] string,
  [created_date] datetime,
  [last_edited_user] string,
  [last_edited_date] datetime
)
GO

CREATE TABLE [InProcessParcels2D] (
  [OBJECTID] integer UNIQUE NOT NULL IDENTITY(1, 1),
  [Shape] geometry,
  [GlobalID] uuid UNIQUE PRIMARY KEY NOT NULL,
  [ParcelNumber] integer,
  [BlockNumber] integer,
  [SubBlockNumber] integer,
  [LandType] integer,
  [ParcelType] integer,
  [ParcelRole] integer,
  [LegalArea] float,
  [LandDesignationPlan] string,
  [IsTax] nvarchar(255) NOT NULL CHECK ([IsTax] IN ('0 : לא', '1 : כן')),
  [CPBUniqueID] uuid,
  [BlockUniqueID] uuid,
  [ProcessType] nvarchar(255) NOT NULL CHECK ([ProcessType] IN ('1 : תכנית לצרכי רישום', '2 : תכנית מרחבית לצרכי רישום', '3 : פסק דין', '4 : תשריט תיעוד גבולות', '5 : קדסטר מבוסס קואורדינטות', '6 : תיקון הסדר לפי סעיף 97ב', '7 : תיקון תכנית לצרכי רישום', '8 : תיקון/עדכון בעקבות פניית ציבור', '9 : הסדר מקרקעין', '10 : רישום ראשון בשטח לא מוסדר', '11 : תכנית לצרכי רישום בשטח לא מסודר', '12 : תיקון תכנית לצרכי רישום בשטח לא מסודר', '13 : תיקון רישום שטח וגבולות בשטח לא מוסדר', '14 : תיקוןעדכון בעקבות פניית ציבור בשטח לא מוסדר', '15 : תשריט תיעוד גבולות להסדר מקרקעין', '16 : עריכה חופשית')),
  [Shape_Length] float,
  [Shape_Area] float,
  [Recorded] nvarchar(255) NOT NULL CHECK ([Recorded] IN ('0 : לא', '1 : כן')) NOT NULL DEFAULT (0)
)
GO

CREATE TABLE [InProcessParcels3D] (
  [OBJECTID] integer UNIQUE NOT NULL IDENTITY(1, 1),
  [Shape] geometry,
  [GlobalID] uuid UNIQUE PRIMARY KEY NOT NULL,
  [ParcelNumber] integer NOT NULL,
  [BlockNumber] integer NOT NULL,
  [SubBlockNumber] integer NOT NULL,
  [BlockUniqueID] uuid,
  [ParcelType] nvarchar(255) NOT NULL CHECK ([ParcelType] IN ('1 : ארעית', '2 : סופית', '3 : פיקטיבית')),
  [Role] nvarchar(255) NOT NULL CHECK ([Role] IN ('1 : ביסוס לביטול', '2 : חדשה', '3 : ביסוס לשימור', '4 : ביניים')),
  [StatedVolume] float,
  [ProjectedArea] float,
  [UpperLevel] float,
  [LowerLevel] float,
  [LandDesignation] string,
  [LandDescription] string,
  [CPBUniqueID] uuid,
  [LandType] nvarchar(255) NOT NULL CHECK ([LandType] IN ('1 : מוסדר', '2 : לא מוסדר')),
  [IsTax] nvarchar(255) NOT NULL CHECK ([IsTax] IN ('0 : לא', '1 : כן')),
  [ProcessType] nvarchar(255) NOT NULL CHECK ([ProcessType] IN ('1 : תכנית לצרכי רישום', '2 : תכנית מרחבית לצרכי רישום', '3 : פסק דין', '4 : תשריט תיעוד גבולות', '5 : קדסטר מבוסס קואורדינטות', '6 : תיקון הסדר לפי סעיף 97ב', '7 : תיקון תכנית לצרכי רישום', '8 : תיקון/עדכון בעקבות פניית ציבור', '9 : הסדר מקרקעין', '10 : רישום ראשון בשטח לא מוסדר', '11 : תכנית לצרכי רישום בשטח לא מסודר', '12 : תיקון תכנית לצרכי רישום בשטח לא מסודר', '13 : תיקון רישום שטח וגבולות בשטח לא מוסדר', '14 : תיקוןעדכון בעקבות פניית ציבור בשטח לא מוסדר', '15 : תשריט תיעוד גבולות להסדר מקרקעין', '16 : עריכה חופשית')),
  [Recorded] nvarchar(255) NOT NULL CHECK ([Recorded] IN ('0 : לא', '1 : כן')) NOT NULL DEFAULT (0)
)
GO

CREATE TABLE [InProcessBorderPoints] (
  [OBJECTID] integer UNIQUE NOT NULL IDENTITY(1, 1),
  [Shape] geometry,
  [GlobalID] uuid UNIQUE PRIMARY KEY NOT NULL,
  [PointName] string,
  [PointStatus] nvarchar(255) NOT NULL CHECK ([PointStatus] IN ('1 : ביסוס לביטול', '2 : חדשה', '3 : ביסוס לשימור', '4 : ביניים')) NOT NULL,
  [Class] nvarchar(255) NOT NULL CHECK ([Class] IN ('1 : הנקודה קשורה רק לנקודות בסיווג 1', '12 : איתור ומדידת נקודה מקורית או תואמת בשטח', '13 : שחזור נקודה שלא נמצאה בשטח', '24 : שחזור חלקי, נתונים מהבנקל או גרפיים')) NOT NULL,
  [DataSource] nvarchar(255) NOT NULL CHECK ([DataSource] IN ('0 : לא ידוע', '1 : כרטסת', '2 : טבלאי', '3 : דיגיטציה', '4 : SRV', '5 : CAD')) NOT NULL DEFAULT (0),
  [MarkCode] nvarchar(255) NOT NULL CHECK ([MarkCode] IN ('0 : לא ידוע או לא סומן', '1 : ברזל זווית', '2 : T ברזל', '3 : עוגן קרקע', '4 : מסמרת', '5 : מסמרת ברזל', '6 : מסמרת נחושת', '7 : גל אבנים', '8 : יתד עץ', '9 : סימן צבע', '10 : זווית צלובה', '11 : זווית שסועה', '12 : בולט', '13 : חקיק', '14 : פטריה', '20 : ברזל עגול')) DEFAULT (0),
  [IsControlBorder] nvarchar(255) NOT NULL CHECK ([IsControlBorder] IN ('0 : לא', '1 : כן')) NOT NULL DEFAULT (0),
  [CPBUniqueID] uuid,
  [Recorded] nvarchar(255) NOT NULL CHECK ([Recorded] IN ('0 : לא', '1 : כן')) NOT NULL DEFAULT (0)
)
GO

CREATE TABLE [InProcessBorderPoints3D] (
  [OBJECTID] integer UNIQUE NOT NULL IDENTITY(1, 1),
  [Shape] geometry,
  [GlobalID] uuid UNIQUE PRIMARY KEY NOT NULL,
  [Name] string NOT NULL,
  [Class] nvarchar(255) NOT NULL CHECK ([Class] IN ('1 : הנקודה קשורה רק לנקודות בסיווג 1', '12 : איתור ומדידת נקודה מקורית או תואמת בשטח', '13 : שחזור נקודה שלא נמצאה בשטח', '24 : שחזור חלקי, נתונים מהבנקל או גרפיים')) NOT NULL,
  [DataSource] nvarchar(255) NOT NULL CHECK ([DataSource] IN ('0 : לא ידוע', '1 : כרטסת', '2 : טבלאי', '3 : דיגיטציה', '4 : SRV', '5 : CAD')) NOT NULL DEFAULT (0),
  [Role] nvarchar(255) NOT NULL CHECK ([Role] IN ('1 : ביסוס לביטול', '2 : חדשה', '3 : ביסוס לשימור', '4 : ביניים')) NOT NULL,
  [IsControlBorder] nvarchar(255) NOT NULL CHECK ([IsControlBorder] IN ('0 : לא', '1 : כן')) NOT NULL DEFAULT (0),
  [CPBUniqueID] uuid,
  [Recorded] nvarchar(255) NOT NULL CHECK ([Recorded] IN ('0 : לא', '1 : כן')) NOT NULL DEFAULT (0)
)
GO

CREATE TABLE [InProcessFronts] (
  [OBJECTID] integer UNIQUE NOT NULL IDENTITY(1, 1),
  [Shape] geometry,
  [GlobalID] uuid UNIQUE PRIMARY KEY NOT NULL,
  [LineStatus] nvarchar(255) NOT NULL CHECK ([LineStatus] IN ('1 : ביסוס לביטול', '2 : חדשה', '3 : ביסוס לשימור', '4 : ביניים')),
  [LineType] nvarchar(255) NOT NULL CHECK ([LineType] IN ('1 : קו ישר', '2 : קשת')),
  [StartPointUniqueID] uuid,
  [EndPointUniqueID] uuid,
  [LegalLength] float,
  [Radius] float,
  [CPBUniqueID] uuid,
  [Shape_Length] float,
  [Recorded] nvarchar(255) NOT NULL CHECK ([Recorded] IN ('0 : לא', '1 : כן')) NOT NULL DEFAULT (0)
)
GO

CREATE TABLE [InProcessSubstractions] (
  [OBJECTID] integer UNIQUE NOT NULL IDENTITY(1, 1),
  [Shape] geometry,
  [GlobalID] uuid UNIQUE PRIMARY KEY NOT NULL,
  [TemporarySubstractionNumber] integer NOT NULL,
  [FinalSubstractionNumber] integer,
  [Parcel3DNumber] integer NOT NULL,
  [Parcel2DNumber] integer NOT NULL,
  [BlockNumber] integer NOT NULL,
  [SubBlockNumber] integer NOT NULL,
  [StatedVolume] float,
  [ProjectedArea] float,
  [UpperLevel] float,
  [LowerLevel] float,
  [RelativePosition] nvarchar(255) NOT NULL CHECK ([RelativePosition] IN ('1 : מתחת', '2 : מעל', '3 : מתחת ומעל')),
  [SubstractionType] nvarchar(255) NOT NULL CHECK ([SubstractionType] IN ('1 : ארעית', '2 : סופית', '3 : פיקטיבית')),
  [Role] nvarchar(255) NOT NULL CHECK ([Role] IN ('1 : ביסוס לביטול', '2 : חדשה', '3 : ביסוס לשימור', '4 : ביניים')),
  [Parcel2DType] nvarchar(255) NOT NULL CHECK ([Parcel2DType] IN ('1 : ארעית', '2 : סופית', '3 : פיקטיבית')),
  [Recorded] nvarchar(255) NOT NULL CHECK ([Recorded] IN ('0 : לא', '1 : כן')) NOT NULL DEFAULT (0),
  [BlockUniqueID] uuid,
  [CPBUniqueID] uuid,
  [Parcel3DUniqueID] uuid,
  [Parcel2DUniqueID] uuid
)
GO

CREATE TABLE [InProcessProjectedParcels3D] (
  [OBJECTID] integer UNIQUE NOT NULL IDENTITY(1, 1),
  [Shape] geometry,
  [Shape_Length] float,
  [Shape_Area] float,
  [Parcel3DUniqueID] uuid
)
GO

CREATE TABLE [InProcessProjectedSubstraction] (
  [OBJECTID] integer UNIQUE NOT NULL IDENTITY(1, 1),
  [Shape] geometry,
  [Shape_Length] float,
  [Shape_Area] float,
  [SubstractionUniqueID] uuid
)
GO

CREATE TABLE [TaskHistory] (
  [OBJECTID] integer UNIQUE NOT NULL IDENTITY(1, 1),
  [USERID] string,
  [PROJECTNAME] string,
  [TASKITEMID] uuid,
  [TASKITEMNAME] string,
  [TASKITEMVERSION] string,
  [TASKID] uuid,
  [TASKNAME] string,
  [STARTTIME] datetime,
  [ENDTIME] datetime,
  [DURATION] float,
  [JOBID] integer,
  [TASKCOMPLETED] integer
)
GO

CREATE TABLE [Parcels2D] (
  [OBJECTID] integer UNIQUE NOT NULL IDENTITY(1, 1),
  [Shape] geometry,
  [Name] string NOT NULL,
  [CreatedByRecord] uuid NOT NULL,
  [UpdatedByRecord] uuid,
  [RetiredByRecord] uuid,
  [StatedArea] float,
  [StatedAreaUnit] integer DEFAULT (109404),
  [CalculatedArea] float,
  [MiscloseRatio] float,
  [MiscloseDistance] float,
  [IsSeed] integer DEFAULT (0),
  [Shape_Length] float,
  [Shape_Area] float,
  [GlobalID] uuid UNIQUE PRIMARY KEY NOT NULL,
  [VALIDATIONSTATUS] nvarchar(255) NOT NULL CHECK ([VALIDATIONSTATUS] IN ('0 : No calculation required, no validation required, no error', '1 : No calculation required, no validation required, has error(s)', '2 : No calculation required, validation required, no error', '3 : No calculation required, validation required, has error(s)', '4 : Calculation required, no validation required, no error', '5 : Calculation required, no validation required, has error(s)', '6 : Calculation required, validation required, no errorמ', '7 : Calculation required, validation required, has error(s)')),
  [ParcelType] nvarchar(255) NOT NULL CHECK ([ParcelType] IN ('1 : ארעית', '2 : סופית', '3 : פיקטיבית')),
  [CreateProcessType] nvarchar(255) NOT NULL CHECK ([CreateProcessType] IN ('1 : תכנית לצרכי רישום', '2 : פסק דין', '3 : הסדר מקרקעין', '4 : תכנית לצרכי רישום בשטח לא מוסדר', '5 : תכנית מרחבית לצרכי רישום', '16 : עריכה חופשית')),
  [LandDesignationPlan] string,
  [ParcelNumber] integer NOT NULL,
  [LandType] nvarchar(255) NOT NULL CHECK ([LandType] IN ('1 : מוסדר', '2 : לא מוסדר')) NOT NULL,
  [BlockNumber] integer NOT NULL,
  [SubBlockNumber] integer NOT NULL,
  [CancelProcessType] nvarchar(255) NOT NULL CHECK ([CancelProcessType] IN ('1 : תכנית לצרכי רישום', '2 : פסק דין', '3 : תכנית לצרכי רישום בשטח לא מוסדר', '4 : תכנית מרחבית לצרכי רישום', '5 : הסדר מקרקעין', '16 : עריכה חופשית')),
  [IsTax] nvarchar(255) NOT NULL CHECK ([IsTax] IN ('0 : לא', '1 : כן')),
  [Bisection] nvarchar(255) NOT NULL CHECK ([Bisection] IN ('10 : ***', '11 : ***', '12 : ***', '20 : ***', '21 : ***', '22 : ***', '30 : ***', '31 : ***', '32 : ***', '40 : ***', '41 : ***', '42 : ***', '50 : ***', '51 : ***', '52 : ***')),
  [BlockUniqueID] uuid,
  [created_user] string NOT NULL,
  [created_date] datetime NOT NULL,
  [last_edited_user] string NOT NULL,
  [last_edited_date] datetime NOT NULL
)
GO

CREATE TABLE [Parcels3D] (
  [OBJECTID] integer UNIQUE NOT NULL IDENTITY(1, 1),
  [Shape] geometry,
  [GlobalID] uuid UNIQUE PRIMARY KEY NOT NULL,
  [ParcelNumber] integer NOT NULL,
  [BlockNumber] integer NOT NULL,
  [SubBlockNumber] integer NOT NULL,
  [BlockUniqueID] uuid,
  [ParcelType] nvarchar(255) NOT NULL CHECK ([ParcelType] IN ('1 : ארעית', '2 : סופית', '3 : פיקטיבית')),
  [StatedVolume] float,
  [ProjectedArea] float,
  [UpperLevel] float,
  [LowerLevel] float,
  [LandDesignation] string,
  [LandDescription] string,
  [LandType] nvarchar(255) NOT NULL CHECK ([LandType] IN ('1 : מוסדר', '2 : לא מוסדר')),
  [IsTax] nvarchar(255) NOT NULL CHECK ([IsTax] IN ('0 : לא', '1 : כן')),
  [Name] string NOT NULL,
  [CreatedByRecord] uuid NOT NULL,
  [UpdatedByRecord] uuid,
  [RetiredByRecord] uuid,
  [CalculatedArea] float,
  [CreateProcessType] nvarchar(255) NOT NULL CHECK ([CreateProcessType] IN ('1 : תכנית לצרכי רישום', '2 : פסק דין', '3 : הסדר מקרקעין', '4 : תכנית לצרכי רישום בשטח לא מוסדר', '5 : תכנית מרחבית לצרכי רישום', '16 : עריכה חופשית')) NOT NULL,
  [CancelProcessType] nvarchar(255) NOT NULL CHECK ([CancelProcessType] IN ('1 : תכנית לצרכי רישום', '2 : פסק דין', '3 : תכנית לצרכי רישום בשטח לא מוסדר', '4 : תכנית מרחבית לצרכי רישום', '5 : הסדר מקרקעין', '16 : עריכה חופשית')),
  [created_user] string NOT NULL,
  [created_date] datetime NOT NULL,
  [last_edited_user] string,
  [last_edited_date] datetime
)
GO

CREATE TABLE [Parcels2DFronts] (
  [OBJECTID] integer UNIQUE NOT NULL IDENTITY(1, 1),
  [Shape] geometry,
  [CreatedByRecord] uuid NOT NULL,
  [UpdatedByRecord] uuid,
  [RetiredByRecord] uuid,
  [ParentLineID] uuid,
  [Direction] float,
  [Distance] float,
  [Radius] float,
  [ArcLength] float,
  [Radius2] float,
  [COGOType] integer,
  [IsCOGOGround] integer,
  [Rotation] float,
  [Scale] float,
  [DirectionAccuracy] float,
  [DistanceAccuracy] float,
  [LabelPosition] integer,
  [Shape_Length] float,
  [GlobalID] uuid UNIQUE PRIMARY KEY NOT NULL,
  [VALIDATIONSTATUS] nvarchar(255) NOT NULL CHECK ([VALIDATIONSTATUS] IN ('0 : No calculation required, no validation required, no error', '1 : No calculation required, no validation required, has error(s)', '2 : No calculation required, validation required, no error', '3 : No calculation required, validation required, has error(s)', '4 : Calculation required, no validation required, no error', '5 : Calculation required, no validation required, has error(s)', '6 : Calculation required, validation required, no errorמ', '7 : Calculation required, validation required, has error(s)')),
  [LineType] nvarchar(255) NOT NULL CHECK ([LineType] IN ('1 : קו ישר', '2 : קשת')),
  [StartPointUniqueID] uuid,
  [EndPointUniqueID] uuid,
  [created_user] string,
  [created_date] datetime,
  [last_edited_user] string,
  [last_edited_date] datetime
)
GO

CREATE TABLE [BlocksFronts] (
  [OBJECTID] integer UNIQUE NOT NULL IDENTITY(1, 1),
  [Shape] geometry,
  [CreatedByRecord] uuid NOT NULL,
  [RetiredByRecord] uuid,
  [ParentLineID] uuid,
  [Direction] float,
  [Distance] float,
  [Radius] float,
  [ArcLength] float,
  [Radius2] float,
  [COGOType] integer,
  [IsCOGOGround] integer,
  [Rotation] float,
  [Scale] float,
  [DirectionAccuracy] float,
  [DistanceAccuracy] float,
  [LabelPosition] integer,
  [Shape_Length] float,
  [GlobalID] uuid UNIQUE PRIMARY KEY NOT NULL,
  [VALIDATIONSTATUS] nvarchar(255) NOT NULL CHECK ([VALIDATIONSTATUS] IN ('0 : No calculation required, no validation required, no error', '1 : No calculation required, no validation required, has error(s)', '2 : No calculation required, validation required, no error', '3 : No calculation required, validation required, has error(s)', '4 : Calculation required, no validation required, no error', '5 : Calculation required, no validation required, has error(s)', '6 : Calculation required, validation required, no errorמ', '7 : Calculation required, validation required, has error(s)')),
  [LineType] nvarchar(255) NOT NULL CHECK ([LineType] IN ('1 : קו ישר', '2 : קשת')),
  [StartPointUniqueID] uuid,
  [EndPointUniqueID] uuid,
  [created_user] string,
  [created_date] datetime,
  [last_edited_user] string,
  [last_edited_date] datetime
)
GO

CREATE TABLE [BorderPoints] (
  [OBJECTID] integer UNIQUE NOT NULL IDENTITY(1, 1),
  [Shape] geometry,
  [CreatedByRecord] uuid NOT NULL,
  [RetiredByRecord] uuid,
  [UpdatedByRecord] uuid,
  [Name] string,
  [IsFixed] integer,
  [AdjustmentConstraint] integer,
  [Preserve] integer,
  [X] float NOT NULL,
  [Y] float NOT NULL,
  [Z] float,
  [XYAccuracy] float,
  [ZAccuracy] float,
  [XYUncertainty] float,
  [EllipseMajor] float,
  [EllipseMinor] float,
  [EllipseDirection] float,
  [GlobalID] uuid UNIQUE PRIMARY KEY NOT NULL,
  [Class] nvarchar(255) NOT NULL CHECK ([Class] IN ('1 : הנקודה קשורה רק לנקודות בסיווג 1', '12 : איתור ומדידת נקודה מקורית או תואמת בשטח', '13 : שחזור נקודה שלא נמצאה בשטח', '24 : שחזור חלקי, נתונים מהבנקל או גרפיים')),
  [DataSource] nvarchar(255) NOT NULL CHECK ([DataSource] IN ('0 : לא ידוע', '1 : כרטסת', '2 : טבלאי', '3 : דיגיטציה', '4 : SRV', '5 : CAD')),
  [MarkCode] nvarchar(255) NOT NULL CHECK ([MarkCode] IN ('0 : לא ידוע או לא סומן', '1 : ברזל זווית', '2 : T ברזל', '3 : עוגן קרקע', '4 : מסמרת', '5 : מסמרת ברזל', '6 : מסמרת נחושת', '7 : גל אבנים', '8 : יתד עץ', '9 : סימן צבע', '10 : זווית צלובה', '11 : זווית שסועה', '12 : בולט', '13 : חקיק', '14 : פטריה', '20 : ברזל עגול')),
  [IsControlBorder] nvarchar(255) NOT NULL CHECK ([IsControlBorder] IN ('0 : לא', '1 : כן')),
  [VALIDATIONSTATUS] nvarchar(255) NOT NULL CHECK ([VALIDATIONSTATUS] IN ('0 : No calculation required, no validation required, no error', '1 : No calculation required, no validation required, has error(s)', '2 : No calculation required, validation required, no error', '3 : No calculation required, validation required, has error(s)', '4 : Calculation required, no validation required, no error', '5 : Calculation required, no validation required, has error(s)', '6 : Calculation required, validation required, no errorמ', '7 : Calculation required, validation required, has error(s)')),
  [created_user] string,
  [created_date] datetime,
  [last_edited_user] string,
  [last_edited_date] datetime
)
GO

CREATE TABLE [BorderPoints3D] (
  [OBJECTID] integer UNIQUE NOT NULL IDENTITY(1, 1),
  [Shape] geometry,
  [GlobalID] uuid UNIQUE PRIMARY KEY NOT NULL,
  [Name] str,
  [X] float NOT NULL,
  [Y] float NOT NULL,
  [Z] float NOT NULL,
  [Class] nvarchar(255) NOT NULL CHECK ([Class] IN ('1 : הנקודה קשורה רק לנקודות בסיווג 1', '12 : איתור ומדידת נקודה מקורית או תואמת בשטח', '13 : שחזור נקודה שלא נמצאה בשטח', '24 : שחזור חלקי, נתונים מהבנקל או גרפיים')),
  [DataSource] nvarchar(255) NOT NULL CHECK ([DataSource] IN ('0 : לא ידוע', '1 : כרטסת', '2 : טבלאי', '3 : דיגיטציה', '4 : SRV', '5 : CAD')),
  [IsControlBorder] nvarchar(255) NOT NULL CHECK ([IsControlBorder] IN ('0 : לא', '1 : כן')),
  [CreatedByRecord] uuid NOT NULL,
  [UpdatedByRecord] uuid,
  [RetiredByRecord] uuid,
  [IsFixed] integer,
  [AdjustmentConstraint] integer,
  [Preserve] integer,
  [XYAccuracy] float,
  [ZAccuracy] float,
  [XYUncertainty] float,
  [EllipseMajor] float,
  [EllipseMinor] float,
  [EllipseDirection] float,
  [VALIDATIONSTATUS] nvarchar(255) NOT NULL CHECK ([VALIDATIONSTATUS] IN ('0 : No calculation required, no validation required, no error', '1 : No calculation required, no validation required, has error(s)', '2 : No calculation required, validation required, no error', '3 : No calculation required, validation required, has error(s)', '4 : Calculation required, no validation required, no error', '5 : Calculation required, no validation required, has error(s)', '6 : Calculation required, validation required, no errorמ', '7 : Calculation required, validation required, has error(s)')),
  [created_user] string,
  [created_date] datetime,
  [last_edited_user] string,
  [last_edited_date] datetime
)
GO

CREATE TABLE [Substractions] (
  [OBJECTID] integer UNIQUE NOT NULL IDENTITY(1, 1),
  [Shape] geometry,
  [GlobalID] uuid UNIQUE PRIMARY KEY NOT NULL,
  [Name] string,
  [SubstractionNumber] integer NOT NULL,
  [Parcel3DNumber] integer NOT NULL,
  [Parcel2DNumber] integer NOT NULL,
  [BlockNumber] integer NOT NULL,
  [SubBlockNumber] integer NOT NULL,
  [StatedVolume] float,
  [ProjectedArea] float,
  [UpperLevel] float,
  [LowerLevel] float,
  [RelativePosition] nvarchar(255) NOT NULL CHECK ([RelativePosition] IN ('1 : מתחת', '2 : מעל', '3 : מתחת ומעל')),
  [SubstractionType] nvarchar(255) NOT NULL CHECK ([SubstractionType] IN ('1 : ארעית', '2 : סופית', '3 : פיקטיבית')),
  [Parcel3DUniqueID] uuid,
  [Parcel2DUniqueID] uuid,
  [BlockUniqueID] uuid,
  [CreatedByRecord] uuid NOT NULL,
  [UpdatedByRecord] uuid,
  [RetiredByRecord] uuid,
  [CreateProcessType] nvarchar(255) NOT NULL CHECK ([CreateProcessType] IN ('1 : תכנית לצרכי רישום', '2 : פסק דין', '3 : הסדר מקרקעין', '4 : תכנית לצרכי רישום בשטח לא מוסדר', '5 : תכנית מרחבית לצרכי רישום', '16 : עריכה חופשית')),
  [CancelProcessType] nvarchar(255) NOT NULL CHECK ([CancelProcessType] IN ('1 : תכנית לצרכי רישום', '2 : פסק דין', '3 : תכנית לצרכי רישום בשטח לא מוסדר', '4 : תכנית מרחבית לצרכי רישום', '5 : הסדר מקרקעין', '16 : עריכה חופשית')),
  [created_user] string,
  [created_date] datetime,
  [last_edited_user] string,
  [last_edited_date] datetime
)
GO

CREATE TABLE [ProjectedParcels3D] (
  [OBJECTID] integer UNIQUE NOT NULL IDENTITY(1, 1),
  [Shape] geometry,
  [Shape_Length] float,
  [Shape_Area] float,
  [Parcel3DUniqueID] uuid,
  [VALIDATIONSTATUS] nvarchar(255) NOT NULL CHECK ([VALIDATIONSTATUS] IN ('0 : No calculation required, no validation required, no error', '1 : No calculation required, no validation required, has error(s)', '2 : No calculation required, validation required, no error', '3 : No calculation required, validation required, has error(s)', '4 : Calculation required, no validation required, no error', '5 : Calculation required, no validation required, has error(s)', '6 : Calculation required, validation required, no errorמ', '7 : Calculation required, validation required, has error(s)'))
)
GO

CREATE TABLE [ProjectedSubstraction] (
  [OBJECTID] integer UNIQUE NOT NULL IDENTITY(1, 1),
  [Shape] geometry,
  [Shape_Length] float,
  [Shape_Area] float,
  [SubstractionUniqueID] uuid,
  [VALIDATIONSTATUS] nvarchar(255) NOT NULL CHECK ([VALIDATIONSTATUS] IN ('0 : No calculation required, no validation required, no error', '1 : No calculation required, no validation required, has error(s)', '2 : No calculation required, validation required, no error', '3 : No calculation required, validation required, has error(s)', '4 : Calculation required, no validation required, no error', '5 : Calculation required, no validation required, has error(s)', '6 : Calculation required, validation required, no errorמ', '7 : Calculation required, validation required, has error(s)'))
)
GO

CREATE UNIQUE INDEX [CPB_ProcessName] ON [CadasterProcessBorders] ("ProcessName")
GO

CREATE INDEX [CPB_ProcessType] ON [CadasterProcessBorders] ("ProcessType")
GO

CREATE INDEX [Shape_INDEX] ON [CadasterProcessBorders] ("Shape")
GO

CREATE INDEX [CRD_Name] ON [CadasterRecordsBorders] ("Name")
GO

CREATE INDEX [CRD_RecordType] ON [CadasterRecordsBorders] ("RecordType")
GO

CREATE INDEX [Shape_INDEX] ON [CadasterRecordsBorders] ("Shape")
GO

CREATE INDEX [StatusAndDates_ProcessType] ON [CPBStatusAndDates] ("ProcessType")
GO

CREATE INDEX [StatusAndDates_CPBUniqueID] ON [CPBStatusAndDates] ("CPBUniqueID")
GO

CREATE INDEX [SequenceActions_CPBID] ON [SequenceActions] ("CPBUniqueID")
GO

CREATE INDEX [Blocks_LandType] ON [Blocks] ("LandType")
GO

CREATE INDEX [Blocks_Name] ON [Blocks] ("BlockNumber", "SubBlockNumber")
GO

CREATE INDEX [Blocks_BlockStatus] ON [Blocks] ("BlockStatus")
GO

CREATE INDEX [IPParcels2D_CPBID] ON [InProcessParcels2D] ("CPBUniqueID")
GO

CREATE INDEX [IPParcels2D_BlockID] ON [InProcessParcels2D] ("BlockUniqueID")
GO

CREATE INDEX [IPParcels2D_NameFields] ON [InProcessParcels2D] ("ParcelNumber", "BlockNumber", "SubBlockNumber")
GO

CREATE INDEX [IPParcels2D_Recorded] ON [InProcessParcels2D] ("Recorded")
GO

CREATE INDEX [IPParcels3D_CPBID] ON [InProcessParcels3D] ("CPBUniqueID")
GO

CREATE INDEX [IPParcels3D_Recorded] ON [InProcessParcels3D] ("Recorded")
GO

CREATE INDEX [IPBorderPoints_CPBID] ON [InProcessBorderPoints] ("CPBUniqueID")
GO

CREATE INDEX [IPBorderPoints_Recorded] ON [InProcessBorderPoints] ("Recorded")
GO

CREATE INDEX [IPBorderPoints3D_CPBID] ON [InProcessBorderPoints3D] ("CPBUniqueID")
GO

CREATE INDEX [IPBorderPoints3D_Recorded] ON [InProcessBorderPoints3D] ("Recorded")
GO

CREATE INDEX [IPFronts_CPBID] ON [InProcessFronts] ("CPBUniqueID")
GO

CREATE INDEX [IPFronts_Recorded] ON [InProcessFronts] ("Recorded")
GO

CREATE INDEX [IPSubstractions_CPBID] ON [InProcessSubstractions] ("CPBUniqueID")
GO

CREATE INDEX [IPSubstractions_NameFields] ON [InProcessSubstractions] ("TemporarySubstractionNumber", "BlockNumber", "SubBlockNumber")
GO

CREATE INDEX [Recorded] ON [InProcessSubstractions] ("Recorded")
GO

CREATE INDEX [IPProjectedParcels3D_Parcel3DID] ON [InProcessProjectedParcels3D] ("Parcel3DUniqueID")
GO

CREATE INDEX [IPProjectedSubstractions_SubstractionID] ON [InProcessProjectedSubstraction] ("SubstractionUniqueID")
GO

CREATE INDEX [Parcels2D_ParcelNumber] ON [Parcels2D] ("ParcelNumber")
GO

CREATE INDEX [Parcels2D_BlockID] ON [Parcels2D] ("BlockUniqueID")
GO

CREATE INDEX [Parcels2D_LandType] ON [Parcels2D] ("LandType")
GO

CREATE INDEX [Parcels2D_CreateType] ON [Parcels2D] ("CreateProcessType")
GO

CREATE INDEX [Parcels2D_CancelType] ON [Parcels2D] ("CancelProcessType")
GO

CREATE INDEX [Parcels2D_NameFields] ON [Parcels2D] ("ParcelNumber", "BlockNumber", "SubBlockNumber")
GO

CREATE INDEX [Parcels3D_NameFields] ON [Parcels3D] ("ParcelNumber", "BlockNumber", "SubBlockNumber")
GO

CREATE INDEX [Parcels3D_Name] ON [Parcels3D] ("Name")
GO

CREATE INDEX [Parcels3D_CreatedByRecord] ON [Parcels3D] ("CreatedByRecord")
GO

CREATE INDEX [Parcels3D_RetiredByRecord] ON [Parcels3D] ("RetiredByRecord")
GO

CREATE INDEX [Fronts_LineType] ON [Parcels2DFronts] ("LineType")
GO

CREATE INDEX [Fronts_StartPointID] ON [Parcels2DFronts] ("StartPointUniqueID")
GO

CREATE INDEX [Fronts_EndPointID] ON [Parcels2DFronts] ("EndPointUniqueID")
GO

CREATE INDEX [BorderPoints_CreatedByRecord] ON [BorderPoints] ("CreatedByRecord")
GO

CREATE INDEX [BorderPoints_RetiredByRecord] ON [BorderPoints] ("RetiredByRecord")
GO

CREATE INDEX [BorderPoints3D_CreatedByRecord] ON [BorderPoints3D] ("CreatedByRecord")
GO

CREATE INDEX [BorderPoints3D_RetiredByRecord] ON [BorderPoints3D] ("RetiredByRecord")
GO

CREATE INDEX [Substractions_NameFields] ON [Substractions] ("SubstractionNumber", "BlockNumber", "SubBlockNumber")
GO

CREATE INDEX [Substractions_Name] ON [Substractions] ("Name")
GO

CREATE INDEX [Substractions_CreatedByRecord] ON [Substractions] ("CreatedByRecord")
GO

CREATE INDEX [Substractions_RetiredByRecord] ON [Substractions] ("RetiredByRecord")
GO

CREATE INDEX [ProjectedParcels3D_Parcel3DID] ON [ProjectedParcels3D] ("Parcel3DUniqueID")
GO

CREATE INDEX [ProjectedSubstractions_SubstractionID] ON [ProjectedSubstraction] ("SubstractionUniqueID")
GO

EXEC sp_addextendedproperty
@name = N'Table_Description',
@value = 'Alias: גבולות תהליכי קדסטר

',
@level0type = N'Schema', @level0name = 'dbo',
@level1type = N'Table',  @level1name = 'CadasterProcessBorders';
GO

EXEC sp_addextendedproperty
@name = N'Column_Description',
@value = 'Object ID',
@level0type = N'Schema', @level0name = 'dbo',
@level1type = N'Table',  @level1name = 'CadasterProcessBorders',
@level2type = N'Column', @level2name = 'OBJECTID';
GO

EXEC sp_addextendedproperty
@name = N'Column_Description',
@value = 'גיאומטריה',
@level0type = N'Schema', @level0name = 'dbo',
@level1type = N'Table',  @level1name = 'CadasterProcessBorders',
@level2type = N'Column', @level2name = 'Shape';
GO

EXEC sp_addextendedproperty
@name = N'Column_Description',
@value = 'מזהה תהליך קדסטרי',
@level0type = N'Schema', @level0name = 'dbo',
@level1type = N'Table',  @level1name = 'CadasterProcessBorders',
@level2type = N'Column', @level2name = 'GlobalID';
GO

EXEC sp_addextendedproperty
@name = N'Column_Description',
@value = 'שם המפה',
@level0type = N'Schema', @level0name = 'dbo',
@level1type = N'Table',  @level1name = 'CadasterProcessBorders',
@level2type = N'Column', @level2name = 'ProcessName';
GO

EXEC sp_addextendedproperty
@name = N'Column_Description',
@value = 'מספר תהליך',
@level0type = N'Schema', @level0name = 'dbo',
@level1type = N'Table',  @level1name = 'CadasterProcessBorders',
@level2type = N'Column', @level2name = 'ProcessNumber';
GO

EXEC sp_addextendedproperty
@name = N'Column_Description',
@value = 'שנת תהליך',
@level0type = N'Schema', @level0name = 'dbo',
@level1type = N'Table',  @level1name = 'CadasterProcessBorders',
@level2type = N'Column', @level2name = 'ProcessYear';
GO

EXEC sp_addextendedproperty
@name = N'Column_Description',
@value = 'קידומת תהליך',
@level0type = N'Schema', @level0name = 'dbo',
@level1type = N'Table',  @level1name = 'CadasterProcessBorders',
@level2type = N'Column', @level2name = 'ProcessPrefix';
GO

EXEC sp_addextendedproperty
@name = N'Column_Description',
@value = 'סוג תהליך',
@level0type = N'Schema', @level0name = 'dbo',
@level1type = N'Table',  @level1name = 'CadasterProcessBorders',
@level2type = N'Column', @level2name = 'ProcessType';
GO

EXEC sp_addextendedproperty
@name = N'Column_Description',
@value = 'סטטוס',
@level0type = N'Schema', @level0name = 'dbo',
@level1type = N'Table',  @level1name = 'CadasterProcessBorders',
@level2type = N'Column', @level2name = 'Status';
GO

EXEC sp_addextendedproperty
@name = N'Column_Description',
@value = 'מזהה גוש',
@level0type = N'Schema', @level0name = 'dbo',
@level1type = N'Table',  @level1name = 'CadasterProcessBorders',
@level2type = N'Column', @level2name = 'BlockUniqueID';
GO

EXEC sp_addextendedproperty
@name = N'Column_Description',
@value = 'רשת בקרה',
@level0type = N'Schema', @level0name = 'dbo',
@level1type = N'Table',  @level1name = 'CadasterProcessBorders',
@level2type = N'Column', @level2name = 'GeodeticNetwork';
GO

EXEC sp_addextendedproperty
@name = N'Column_Description',
@value = 'רשיון מודד',
@level0type = N'Schema', @level0name = 'dbo',
@level1type = N'Table',  @level1name = 'CadasterProcessBorders',
@level2type = N'Column', @level2name = 'SurveyorLicenseID';
GO

EXEC sp_addextendedproperty
@name = N'Column_Description',
@value = 'מקור הנתונים',
@level0type = N'Schema', @level0name = 'dbo',
@level1type = N'Table',  @level1name = 'CadasterProcessBorders',
@level2type = N'Column', @level2name = 'DataSource';
GO

EXEC sp_addextendedproperty
@name = N'Column_Description',
@value = 'תכנית מפורטת',
@level0type = N'Schema', @level0name = 'dbo',
@level1type = N'Table',  @level1name = 'CadasterProcessBorders',
@level2type = N'Column', @level2name = 'PlanName';
GO

EXEC sp_addextendedproperty
@name = N'Column_Description',
@value = 'היקף גיאומטריה',
@level0type = N'Schema', @level0name = 'dbo',
@level1type = N'Table',  @level1name = 'CadasterProcessBorders',
@level2type = N'Column', @level2name = 'Shape_Length';
GO

EXEC sp_addextendedproperty
@name = N'Column_Description',
@value = 'שטח גיאומטריה',
@level0type = N'Schema', @level0name = 'dbo',
@level1type = N'Table',  @level1name = 'CadasterProcessBorders',
@level2type = N'Column', @level2name = 'Shape_Area';
GO

EXEC sp_addextendedproperty
@name = N'Table_Description',
@value = 'Alias: גבולות רישומי קדסטר

',
@level0type = N'Schema', @level0name = 'dbo',
@level1type = N'Table',  @level1name = 'CadasterRecordsBorders';
GO

EXEC sp_addextendedproperty
@name = N'Column_Description',
@value = 'Object ID',
@level0type = N'Schema', @level0name = 'dbo',
@level1type = N'Table',  @level1name = 'CadasterRecordsBorders',
@level2type = N'Column', @level2name = 'OBJECTID';
GO

EXEC sp_addextendedproperty
@name = N'Column_Description',
@value = 'גיאומטריה',
@level0type = N'Schema', @level0name = 'dbo',
@level1type = N'Table',  @level1name = 'CadasterRecordsBorders',
@level2type = N'Column', @level2name = 'Shape';
GO

EXEC sp_addextendedproperty
@name = N'Column_Description',
@value = 'שם המפה',
@level0type = N'Schema', @level0name = 'dbo',
@level1type = N'Table',  @level1name = 'CadasterRecordsBorders',
@level2type = N'Column', @level2name = 'Name';
GO

EXEC sp_addextendedproperty
@name = N'Column_Description',
@value = 'סוג תהליך',
@level0type = N'Schema', @level0name = 'dbo',
@level1type = N'Table',  @level1name = 'CadasterRecordsBorders',
@level2type = N'Column', @level2name = 'RecordType';
GO

EXEC sp_addextendedproperty
@name = N'Column_Description',
@value = 'תאריך תחילת עדכון בנק"ל',
@level0type = N'Schema', @level0name = 'dbo',
@level1type = N'Table',  @level1name = 'CadasterRecordsBorders',
@level2type = N'Column', @level2name = 'RecordedDate';
GO

EXEC sp_addextendedproperty
@name = N'Column_Description',
@value = 'כמות חלקות שנוצרו',
@level0type = N'Schema', @level0name = 'dbo',
@level1type = N'Table',  @level1name = 'CadasterRecordsBorders',
@level2type = N'Column', @level2name = 'ParcelCount';
GO

EXEC sp_addextendedproperty
@name = N'Column_Description',
@value = 'כמות חלקות שבוטלו',
@level0type = N'Schema', @level0name = 'dbo',
@level1type = N'Table',  @level1name = 'CadasterRecordsBorders',
@level2type = N'Column', @level2name = 'RetiredParcelCount';
GO

EXEC sp_addextendedproperty
@name = N'Column_Description',
@value = 'היקף גיאומטריה',
@level0type = N'Schema', @level0name = 'dbo',
@level1type = N'Table',  @level1name = 'CadasterRecordsBorders',
@level2type = N'Column', @level2name = 'Shape_Length';
GO

EXEC sp_addextendedproperty
@name = N'Column_Description',
@value = 'שטח גיאומטריה',
@level0type = N'Schema', @level0name = 'dbo',
@level1type = N'Table',  @level1name = 'CadasterRecordsBorders',
@level2type = N'Column', @level2name = 'Shape_Area';
GO

EXEC sp_addextendedproperty
@name = N'Column_Description',
@value = 'מזהה גבול רישום קדסטרי',
@level0type = N'Schema', @level0name = 'dbo',
@level1type = N'Table',  @level1name = 'CadasterRecordsBorders',
@level2type = N'Column', @level2name = 'GlobalID';
GO

EXEC sp_addextendedproperty
@name = N'Column_Description',
@value = 'רשת בקרה',
@level0type = N'Schema', @level0name = 'dbo',
@level1type = N'Table',  @level1name = 'CadasterRecordsBorders',
@level2type = N'Column', @level2name = 'GeodeticNetwork';
GO

EXEC sp_addextendedproperty
@name = N'Column_Description',
@value = 'סטטוס',
@level0type = N'Schema', @level0name = 'dbo',
@level1type = N'Table',  @level1name = 'CadasterRecordsBorders',
@level2type = N'Column', @level2name = 'Status';
GO

EXEC sp_addextendedproperty
@name = N'Column_Description',
@value = 'רשיון מודד',
@level0type = N'Schema', @level0name = 'dbo',
@level1type = N'Table',  @level1name = 'CadasterRecordsBorders',
@level2type = N'Column', @level2name = 'SurveyorLicenseID';
GO

EXEC sp_addextendedproperty
@name = N'Column_Description',
@value = 'מקור הנתונים',
@level0type = N'Schema', @level0name = 'dbo',
@level1type = N'Table',  @level1name = 'CadasterRecordsBorders',
@level2type = N'Column', @level2name = 'DataSource';
GO

EXEC sp_addextendedproperty
@name = N'Column_Description',
@value = 'תכנית מפורטת',
@level0type = N'Schema', @level0name = 'dbo',
@level1type = N'Table',  @level1name = 'CadasterRecordsBorders',
@level2type = N'Column', @level2name = 'PlanName';
GO

EXEC sp_addextendedproperty
@name = N'Column_Description',
@value = 'מזהה גוש',
@level0type = N'Schema', @level0name = 'dbo',
@level1type = N'Table',  @level1name = 'CadasterRecordsBorders',
@level2type = N'Column', @level2name = 'BlockUniqueID';
GO

EXEC sp_addextendedproperty
@name = N'Column_Description',
@value = 'משתמש יוצר',
@level0type = N'Schema', @level0name = 'dbo',
@level1type = N'Table',  @level1name = 'CadasterRecordsBorders',
@level2type = N'Column', @level2name = 'created_user';
GO

EXEC sp_addextendedproperty
@name = N'Column_Description',
@value = 'תאריך יצירה',
@level0type = N'Schema', @level0name = 'dbo',
@level1type = N'Table',  @level1name = 'CadasterRecordsBorders',
@level2type = N'Column', @level2name = 'created_date';
GO

EXEC sp_addextendedproperty
@name = N'Column_Description',
@value = 'משתמש עידכן',
@level0type = N'Schema', @level0name = 'dbo',
@level1type = N'Table',  @level1name = 'CadasterRecordsBorders',
@level2type = N'Column', @level2name = 'last_edited_user';
GO

EXEC sp_addextendedproperty
@name = N'Column_Description',
@value = 'תאריך עדכון',
@level0type = N'Schema', @level0name = 'dbo',
@level1type = N'Table',  @level1name = 'CadasterRecordsBorders',
@level2type = N'Column', @level2name = 'last_edited_date';
GO

EXEC sp_addextendedproperty
@name = N'Table_Description',
@value = 'Alias: סטאטוסים ותאריכים

',
@level0type = N'Schema', @level0name = 'dbo',
@level1type = N'Table',  @level1name = 'CPBStatusAndDates';
GO

EXEC sp_addextendedproperty
@name = N'Column_Description',
@value = 'Object ID',
@level0type = N'Schema', @level0name = 'dbo',
@level1type = N'Table',  @level1name = 'CPBStatusAndDates',
@level2type = N'Column', @level2name = 'OBJECTID';
GO

EXEC sp_addextendedproperty
@name = N'Column_Description',
@value = 'מזהה תהליך קדסטרי',
@level0type = N'Schema', @level0name = 'dbo',
@level1type = N'Table',  @level1name = 'CPBStatusAndDates',
@level2type = N'Column', @level2name = 'CPBUniqueID';
GO

EXEC sp_addextendedproperty
@name = N'Column_Description',
@value = 'סוג תהליך קדסטרי',
@level0type = N'Schema', @level0name = 'dbo',
@level1type = N'Table',  @level1name = 'CPBStatusAndDates',
@level2type = N'Column', @level2name = 'ProcessType';
GO

EXEC sp_addextendedproperty
@name = N'Column_Description',
@value = 'סטטוס',
@level0type = N'Schema', @level0name = 'dbo',
@level1type = N'Table',  @level1name = 'CPBStatusAndDates',
@level2type = N'Column', @level2name = 'Status';
GO

EXEC sp_addextendedproperty
@name = N'Column_Description',
@value = 'תאריך בו ניתן הסטטוס',
@level0type = N'Schema', @level0name = 'dbo',
@level1type = N'Table',  @level1name = 'CPBStatusAndDates',
@level2type = N'Column', @level2name = 'DateStatus';
GO

EXEC sp_addextendedproperty
@name = N'Table_Description',
@value = 'Alias: סדר פעולות
      
',
@level0type = N'Schema', @level0name = 'dbo',
@level1type = N'Table',  @level1name = 'SequenceActions';
GO

EXEC sp_addextendedproperty
@name = N'Column_Description',
@value = 'Object ID',
@level0type = N'Schema', @level0name = 'dbo',
@level1type = N'Table',  @level1name = 'SequenceActions',
@level2type = N'Column', @level2name = 'OBJECTID';
GO

EXEC sp_addextendedproperty
@name = N'Column_Description',
@value = 'מזהה תהליך קדסטרי',
@level0type = N'Schema', @level0name = 'dbo',
@level1type = N'Table',  @level1name = 'SequenceActions',
@level2type = N'Column', @level2name = 'CPBUniqueID';
GO

EXEC sp_addextendedproperty
@name = N'Column_Description',
@value = 'סוג תהליך קדסטרי',
@level0type = N'Schema', @level0name = 'dbo',
@level1type = N'Table',  @level1name = 'SequenceActions',
@level2type = N'Column', @level2name = 'ProcessType';
GO

EXEC sp_addextendedproperty
@name = N'Column_Description',
@value = 'מספר גוש',
@level0type = N'Schema', @level0name = 'dbo',
@level1type = N'Table',  @level1name = 'SequenceActions',
@level2type = N'Column', @level2name = 'BlockNumber';
GO

EXEC sp_addextendedproperty
@name = N'Column_Description',
@value = 'מספר תת-גוש',
@level0type = N'Schema', @level0name = 'dbo',
@level1type = N'Table',  @level1name = 'SequenceActions',
@level2type = N'Column', @level2name = 'SubBlockNumber';
GO

EXEC sp_addextendedproperty
@name = N'Column_Description',
@value = 'מספר פעולה',
@level0type = N'Schema', @level0name = 'dbo',
@level1type = N'Table',  @level1name = 'SequenceActions',
@level2type = N'Column', @level2name = 'ActionNumber';
GO

EXEC sp_addextendedproperty
@name = N'Column_Description',
@value = 'סוג פעולה',
@level0type = N'Schema', @level0name = 'dbo',
@level1type = N'Table',  @level1name = 'SequenceActions',
@level2type = N'Column', @level2name = 'ActionType';
GO

EXEC sp_addextendedproperty
@name = N'Column_Description',
@value = 'מספר שורה',
@level0type = N'Schema', @level0name = 'dbo',
@level1type = N'Table',  @level1name = 'SequenceActions',
@level2type = N'Column', @level2name = 'LineNumber';
GO

EXEC sp_addextendedproperty
@name = N'Column_Description',
@value = 'חלקת מקור ארעית',
@level0type = N'Schema', @level0name = 'dbo',
@level1type = N'Table',  @level1name = 'SequenceActions',
@level2type = N'Column', @level2name = 'FromParcelTemp';
GO

EXEC sp_addextendedproperty
@name = N'Column_Description',
@value = 'חלקת מקור סופית',
@level0type = N'Schema', @level0name = 'dbo',
@level1type = N'Table',  @level1name = 'SequenceActions',
@level2type = N'Column', @level2name = 'FromParcelFinal';
GO

EXEC sp_addextendedproperty
@name = N'Column_Description',
@value = 'מספר גוש יעד',
@level0type = N'Schema', @level0name = 'dbo',
@level1type = N'Table',  @level1name = 'SequenceActions',
@level2type = N'Column', @level2name = 'ToBlockNumber';
GO

EXEC sp_addextendedproperty
@name = N'Column_Description',
@value = 'מספר תת-גוש יעד',
@level0type = N'Schema', @level0name = 'dbo',
@level1type = N'Table',  @level1name = 'SequenceActions',
@level2type = N'Column', @level2name = 'ToSubBlockNumber';
GO

EXEC sp_addextendedproperty
@name = N'Column_Description',
@value = 'חלקת יעד ארעית',
@level0type = N'Schema', @level0name = 'dbo',
@level1type = N'Table',  @level1name = 'SequenceActions',
@level2type = N'Column', @level2name = 'ToParcelTemp';
GO

EXEC sp_addextendedproperty
@name = N'Column_Description',
@value = 'חלקת יעד סופית',
@level0type = N'Schema', @level0name = 'dbo',
@level1type = N'Table',  @level1name = 'SequenceActions',
@level2type = N'Column', @level2name = 'ToParcelFinal';
GO

EXEC sp_addextendedproperty
@name = N'Column_Description',
@value = 'מזהה תהליך מקור',
@level0type = N'Schema', @level0name = 'dbo',
@level1type = N'Table',  @level1name = 'SequenceActions',
@level2type = N'Column', @level2name = 'CPBTempSourceID';
GO

EXEC sp_addextendedproperty
@name = N'Table_Description',
@value = 'Alias: גושים

Attribute rules:   
    1) Name [Calculation]
',
@level0type = N'Schema', @level0name = 'dbo',
@level1type = N'Table',  @level1name = 'Blocks';
GO

EXEC sp_addextendedproperty
@name = N'Column_Description',
@value = 'Object ID',
@level0type = N'Schema', @level0name = 'dbo',
@level1type = N'Table',  @level1name = 'Blocks',
@level2type = N'Column', @level2name = 'OBJECTID';
GO

EXEC sp_addextendedproperty
@name = N'Column_Description',
@value = 'גיאומטריה',
@level0type = N'Schema', @level0name = 'dbo',
@level1type = N'Table',  @level1name = 'Blocks',
@level2type = N'Column', @level2name = 'Shape';
GO

EXEC sp_addextendedproperty
@name = N'Column_Description',
@value = 'מספר מלא',
@level0type = N'Schema', @level0name = 'dbo',
@level1type = N'Table',  @level1name = 'Blocks',
@level2type = N'Column', @level2name = 'Name';
GO

EXEC sp_addextendedproperty
@name = N'Column_Description',
@value = 'מזהה תהליך יוצר',
@level0type = N'Schema', @level0name = 'dbo',
@level1type = N'Table',  @level1name = 'Blocks',
@level2type = N'Column', @level2name = 'CreatedByRecord';
GO

EXEC sp_addextendedproperty
@name = N'Column_Description',
@value = 'מזהה תהליך מבטל',
@level0type = N'Schema', @level0name = 'dbo',
@level1type = N'Table',  @level1name = 'Blocks',
@level2type = N'Column', @level2name = 'RetiredByRecord';
GO

EXEC sp_addextendedproperty
@name = N'Column_Description',
@value = 'שטח רשום במטר רבוע',
@level0type = N'Schema', @level0name = 'dbo',
@level1type = N'Table',  @level1name = 'Blocks',
@level2type = N'Column', @level2name = 'StatedArea';
GO

EXEC sp_addextendedproperty
@name = N'Column_Description',
@value = 'יחידת שטח',
@level0type = N'Schema', @level0name = 'dbo',
@level1type = N'Table',  @level1name = 'Blocks',
@level2type = N'Column', @level2name = 'StatedAreaUnit';
GO

EXEC sp_addextendedproperty
@name = N'Column_Description',
@value = 'שטח מחושב במטר רבוע',
@level0type = N'Schema', @level0name = 'dbo',
@level1type = N'Table',  @level1name = 'Blocks',
@level2type = N'Column', @level2name = 'CalculatedArea';
GO

EXEC sp_addextendedproperty
@name = N'Column_Description',
@value = 'יחס אורך שגוי והיקף',
@level0type = N'Schema', @level0name = 'dbo',
@level1type = N'Table',  @level1name = 'Blocks',
@level2type = N'Column', @level2name = 'MiscloseRatio';
GO

EXEC sp_addextendedproperty
@name = N'Column_Description',
@value = 'אורך שגוי',
@level0type = N'Schema', @level0name = 'dbo',
@level1type = N'Table',  @level1name = 'Blocks',
@level2type = N'Column', @level2name = 'MiscloseDistance';
GO

EXEC sp_addextendedproperty
@name = N'Column_Description',
@value = 'נוצר מגרעין',
@level0type = N'Schema', @level0name = 'dbo',
@level1type = N'Table',  @level1name = 'Blocks',
@level2type = N'Column', @level2name = 'IsSeed';
GO

EXEC sp_addextendedproperty
@name = N'Column_Description',
@value = 'היקף גיאומטריה',
@level0type = N'Schema', @level0name = 'dbo',
@level1type = N'Table',  @level1name = 'Blocks',
@level2type = N'Column', @level2name = 'Shape_Length';
GO

EXEC sp_addextendedproperty
@name = N'Column_Description',
@value = 'שטח גיאומטריה',
@level0type = N'Schema', @level0name = 'dbo',
@level1type = N'Table',  @level1name = 'Blocks',
@level2type = N'Column', @level2name = 'Shape_Area';
GO

EXEC sp_addextendedproperty
@name = N'Column_Description',
@value = 'מזהה מספר גוש',
@level0type = N'Schema', @level0name = 'dbo',
@level1type = N'Table',  @level1name = 'Blocks',
@level2type = N'Column', @level2name = 'GlobalID';
GO

EXEC sp_addextendedproperty
@name = N'Column_Description',
@value = 'תקינות',
@level0type = N'Schema', @level0name = 'dbo',
@level1type = N'Table',  @level1name = 'Blocks',
@level2type = N'Column', @level2name = 'VALIDATIONSTATUS';
GO

EXEC sp_addextendedproperty
@name = N'Column_Description',
@value = 'מספר גוש',
@level0type = N'Schema', @level0name = 'dbo',
@level1type = N'Table',  @level1name = 'Blocks',
@level2type = N'Column', @level2name = 'BlockNumber';
GO

EXEC sp_addextendedproperty
@name = N'Column_Description',
@value = 'מספר תת-גוש',
@level0type = N'Schema', @level0name = 'dbo',
@level1type = N'Table',  @level1name = 'Blocks',
@level2type = N'Column', @level2name = 'SubBlockNumber';
GO

EXEC sp_addextendedproperty
@name = N'Column_Description',
@value = 'סוג גוש',
@level0type = N'Schema', @level0name = 'dbo',
@level1type = N'Table',  @level1name = 'Blocks',
@level2type = N'Column', @level2name = 'BlockStatus';
GO

EXEC sp_addextendedproperty
@name = N'Column_Description',
@value = 'ירדני',
@level0type = N'Schema', @level0name = 'dbo',
@level1type = N'Table',  @level1name = 'Blocks',
@level2type = N'Column', @level2name = 'IsJordanian';
GO

EXEC sp_addextendedproperty
@name = N'Column_Description',
@value = 'תאריך הסדר',
@level0type = N'Schema', @level0name = 'dbo',
@level1type = N'Table',  @level1name = 'Blocks',
@level2type = N'Column', @level2name = 'SetteledDate';
GO

EXEC sp_addextendedproperty
@name = N'Column_Description',
@value = 'מספר חלקה אחרונה שנרשמה',
@level0type = N'Schema', @level0name = 'dbo',
@level1type = N'Table',  @level1name = 'Blocks',
@level2type = N'Column', @level2name = 'LastRegisterdParcel';
GO

EXEC sp_addextendedproperty
@name = N'Column_Description',
@value = 'מספר חלקה אחרונה מבנק"ל',
@level0type = N'Schema', @level0name = 'dbo',
@level1type = N'Table',  @level1name = 'Blocks',
@level2type = N'Column', @level2name = 'LastParcel';
GO

EXEC sp_addextendedproperty
@name = N'Column_Description',
@value = 'מספר חלקה אחרונה מהסדר',
@level0type = N'Schema', @level0name = 'dbo',
@level1type = N'Table',  @level1name = 'Blocks',
@level2type = N'Column', @level2name = 'LastSetteledParcel';
GO

EXEC sp_addextendedproperty
@name = N'Column_Description',
@value = 'מספר חלקה אחרונה מפסק דין',
@level0type = N'Schema', @level0name = 'dbo',
@level1type = N'Table',  @level1name = 'Blocks',
@level2type = N'Column', @level2name = 'LastCourtParcel';
GO

EXEC sp_addextendedproperty
@name = N'Column_Description',
@value = 'סוג מקרקעין',
@level0type = N'Schema', @level0name = 'dbo',
@level1type = N'Table',  @level1name = 'Blocks',
@level2type = N'Column', @level2name = 'LandType';
GO

EXEC sp_addextendedproperty
@name = N'Column_Description',
@value = 'שומא',
@level0type = N'Schema', @level0name = 'dbo',
@level1type = N'Table',  @level1name = 'Blocks',
@level2type = N'Column', @level2name = 'IsTax';
GO

EXEC sp_addextendedproperty
@name = N'Column_Description',
@value = 'משתמש יוצר',
@level0type = N'Schema', @level0name = 'dbo',
@level1type = N'Table',  @level1name = 'Blocks',
@level2type = N'Column', @level2name = 'created_user';
GO

EXEC sp_addextendedproperty
@name = N'Column_Description',
@value = 'תאריך יצירה',
@level0type = N'Schema', @level0name = 'dbo',
@level1type = N'Table',  @level1name = 'Blocks',
@level2type = N'Column', @level2name = 'created_date';
GO

EXEC sp_addextendedproperty
@name = N'Column_Description',
@value = 'משתמש עידכן',
@level0type = N'Schema', @level0name = 'dbo',
@level1type = N'Table',  @level1name = 'Blocks',
@level2type = N'Column', @level2name = 'last_edited_user';
GO

EXEC sp_addextendedproperty
@name = N'Column_Description',
@value = 'תאריך עידכון',
@level0type = N'Schema', @level0name = 'dbo',
@level1type = N'Table',  @level1name = 'Blocks',
@level2type = N'Column', @level2name = 'last_edited_date';
GO

EXEC sp_addextendedproperty
@name = N'Table_Description',
@value = 'Alias: חלקות דו-ממדיות בתהליך
     
',
@level0type = N'Schema', @level0name = 'dbo',
@level1type = N'Table',  @level1name = 'InProcessParcels2D';
GO

EXEC sp_addextendedproperty
@name = N'Column_Description',
@value = 'Object ID',
@level0type = N'Schema', @level0name = 'dbo',
@level1type = N'Table',  @level1name = 'InProcessParcels2D',
@level2type = N'Column', @level2name = 'OBJECTID';
GO

EXEC sp_addextendedproperty
@name = N'Column_Description',
@value = 'גיאומטריה',
@level0type = N'Schema', @level0name = 'dbo',
@level1type = N'Table',  @level1name = 'InProcessParcels2D',
@level2type = N'Column', @level2name = 'Shape';
GO

EXEC sp_addextendedproperty
@name = N'Column_Description',
@value = 'מזהה חלקה',
@level0type = N'Schema', @level0name = 'dbo',
@level1type = N'Table',  @level1name = 'InProcessParcels2D',
@level2type = N'Column', @level2name = 'GlobalID';
GO

EXEC sp_addextendedproperty
@name = N'Column_Description',
@value = 'מספר חלקה',
@level0type = N'Schema', @level0name = 'dbo',
@level1type = N'Table',  @level1name = 'InProcessParcels2D',
@level2type = N'Column', @level2name = 'ParcelNumber';
GO

EXEC sp_addextendedproperty
@name = N'Column_Description',
@value = 'מספר גוש',
@level0type = N'Schema', @level0name = 'dbo',
@level1type = N'Table',  @level1name = 'InProcessParcels2D',
@level2type = N'Column', @level2name = 'BlockNumber';
GO

EXEC sp_addextendedproperty
@name = N'Column_Description',
@value = 'מספר תת-גוש',
@level0type = N'Schema', @level0name = 'dbo',
@level1type = N'Table',  @level1name = 'InProcessParcels2D',
@level2type = N'Column', @level2name = 'SubBlockNumber';
GO

EXEC sp_addextendedproperty
@name = N'Column_Description',
@value = 'סוג מקרקעין',
@level0type = N'Schema', @level0name = 'dbo',
@level1type = N'Table',  @level1name = 'InProcessParcels2D',
@level2type = N'Column', @level2name = 'LandType';
GO

EXEC sp_addextendedproperty
@name = N'Column_Description',
@value = 'סוג חלקה',
@level0type = N'Schema', @level0name = 'dbo',
@level1type = N'Table',  @level1name = 'InProcessParcels2D',
@level2type = N'Column', @level2name = 'ParcelType';
GO

EXEC sp_addextendedproperty
@name = N'Column_Description',
@value = 'מעמד חלקה',
@level0type = N'Schema', @level0name = 'dbo',
@level1type = N'Table',  @level1name = 'InProcessParcels2D',
@level2type = N'Column', @level2name = 'ParcelRole';
GO

EXEC sp_addextendedproperty
@name = N'Column_Description',
@value = 'שטח רשום במ"ר',
@level0type = N'Schema', @level0name = 'dbo',
@level1type = N'Table',  @level1name = 'InProcessParcels2D',
@level2type = N'Column', @level2name = 'LegalArea';
GO

EXEC sp_addextendedproperty
@name = N'Column_Description',
@value = 'יעוד הקרקע',
@level0type = N'Schema', @level0name = 'dbo',
@level1type = N'Table',  @level1name = 'InProcessParcels2D',
@level2type = N'Column', @level2name = 'LandDesignationPlan';
GO

EXEC sp_addextendedproperty
@name = N'Column_Description',
@value = 'שומא',
@level0type = N'Schema', @level0name = 'dbo',
@level1type = N'Table',  @level1name = 'InProcessParcels2D',
@level2type = N'Column', @level2name = 'IsTax';
GO

EXEC sp_addextendedproperty
@name = N'Column_Description',
@value = 'מזהה תהליך קדסטרי',
@level0type = N'Schema', @level0name = 'dbo',
@level1type = N'Table',  @level1name = 'InProcessParcels2D',
@level2type = N'Column', @level2name = 'CPBUniqueID';
GO

EXEC sp_addextendedproperty
@name = N'Column_Description',
@value = 'מזהה הגוש',
@level0type = N'Schema', @level0name = 'dbo',
@level1type = N'Table',  @level1name = 'InProcessParcels2D',
@level2type = N'Column', @level2name = 'BlockUniqueID';
GO

EXEC sp_addextendedproperty
@name = N'Column_Description',
@value = 'סוג תהליך קדסטרי',
@level0type = N'Schema', @level0name = 'dbo',
@level1type = N'Table',  @level1name = 'InProcessParcels2D',
@level2type = N'Column', @level2name = 'ProcessType';
GO

EXEC sp_addextendedproperty
@name = N'Column_Description',
@value = 'היקף גיאומטריה',
@level0type = N'Schema', @level0name = 'dbo',
@level1type = N'Table',  @level1name = 'InProcessParcels2D',
@level2type = N'Column', @level2name = 'Shape_Length';
GO

EXEC sp_addextendedproperty
@name = N'Column_Description',
@value = 'שטח גיאומטריה',
@level0type = N'Schema', @level0name = 'dbo',
@level1type = N'Table',  @level1name = 'InProcessParcels2D',
@level2type = N'Column', @level2name = 'Shape_Area';
GO

EXEC sp_addextendedproperty
@name = N'Column_Description',
@value = 'עודכן ברצף',
@level0type = N'Schema', @level0name = 'dbo',
@level1type = N'Table',  @level1name = 'InProcessParcels2D',
@level2type = N'Column', @level2name = 'Recorded';
GO

EXEC sp_addextendedproperty
@name = N'Table_Description',
@value = 'Alias: חלקות תלת-ממדיות בתהליך
     
',
@level0type = N'Schema', @level0name = 'dbo',
@level1type = N'Table',  @level1name = 'InProcessParcels3D';
GO

EXEC sp_addextendedproperty
@name = N'Column_Description',
@value = 'Object ID',
@level0type = N'Schema', @level0name = 'dbo',
@level1type = N'Table',  @level1name = 'InProcessParcels3D',
@level2type = N'Column', @level2name = 'OBJECTID';
GO

EXEC sp_addextendedproperty
@name = N'Column_Description',
@value = 'גיאומטריה',
@level0type = N'Schema', @level0name = 'dbo',
@level1type = N'Table',  @level1name = 'InProcessParcels3D',
@level2type = N'Column', @level2name = 'Shape';
GO

EXEC sp_addextendedproperty
@name = N'Column_Description',
@value = 'מזהה חלקה תלת-ממדית בתהליך',
@level0type = N'Schema', @level0name = 'dbo',
@level1type = N'Table',  @level1name = 'InProcessParcels3D',
@level2type = N'Column', @level2name = 'GlobalID';
GO

EXEC sp_addextendedproperty
@name = N'Column_Description',
@value = 'מספר חלקה',
@level0type = N'Schema', @level0name = 'dbo',
@level1type = N'Table',  @level1name = 'InProcessParcels3D',
@level2type = N'Column', @level2name = 'ParcelNumber';
GO

EXEC sp_addextendedproperty
@name = N'Column_Description',
@value = 'מספר גוש',
@level0type = N'Schema', @level0name = 'dbo',
@level1type = N'Table',  @level1name = 'InProcessParcels3D',
@level2type = N'Column', @level2name = 'BlockNumber';
GO

EXEC sp_addextendedproperty
@name = N'Column_Description',
@value = 'מספר תת-גוש',
@level0type = N'Schema', @level0name = 'dbo',
@level1type = N'Table',  @level1name = 'InProcessParcels3D',
@level2type = N'Column', @level2name = 'SubBlockNumber';
GO

EXEC sp_addextendedproperty
@name = N'Column_Description',
@value = 'מזהה גוש',
@level0type = N'Schema', @level0name = 'dbo',
@level1type = N'Table',  @level1name = 'InProcessParcels3D',
@level2type = N'Column', @level2name = 'BlockUniqueID';
GO

EXEC sp_addextendedproperty
@name = N'Column_Description',
@value = 'סוג חלקה',
@level0type = N'Schema', @level0name = 'dbo',
@level1type = N'Table',  @level1name = 'InProcessParcels3D',
@level2type = N'Column', @level2name = 'ParcelType';
GO

EXEC sp_addextendedproperty
@name = N'Column_Description',
@value = 'מעמד חלקה',
@level0type = N'Schema', @level0name = 'dbo',
@level1type = N'Table',  @level1name = 'InProcessParcels3D',
@level2type = N'Column', @level2name = 'Role';
GO

EXEC sp_addextendedproperty
@name = N'Column_Description',
@value = 'נפח רשום במטר מעוקב',
@level0type = N'Schema', @level0name = 'dbo',
@level1type = N'Table',  @level1name = 'InProcessParcels3D',
@level2type = N'Column', @level2name = 'StatedVolume';
GO

EXEC sp_addextendedproperty
@name = N'Column_Description',
@value = 'שטח היטל במטר רבוע',
@level0type = N'Schema', @level0name = 'dbo',
@level1type = N'Table',  @level1name = 'InProcessParcels3D',
@level2type = N'Column', @level2name = 'ProjectedArea';
GO

EXEC sp_addextendedproperty
@name = N'Column_Description',
@value = 'רום עליון',
@level0type = N'Schema', @level0name = 'dbo',
@level1type = N'Table',  @level1name = 'InProcessParcels3D',
@level2type = N'Column', @level2name = 'UpperLevel';
GO

EXEC sp_addextendedproperty
@name = N'Column_Description',
@value = 'רום תחתון',
@level0type = N'Schema', @level0name = 'dbo',
@level1type = N'Table',  @level1name = 'InProcessParcels3D',
@level2type = N'Column', @level2name = 'LowerLevel';
GO

EXEC sp_addextendedproperty
@name = N'Column_Description',
@value = 'ייעוד קרקע',
@level0type = N'Schema', @level0name = 'dbo',
@level1type = N'Table',  @level1name = 'InProcessParcels3D',
@level2type = N'Column', @level2name = 'LandDesignation';
GO

EXEC sp_addextendedproperty
@name = N'Column_Description',
@value = 'תיאור קרקע',
@level0type = N'Schema', @level0name = 'dbo',
@level1type = N'Table',  @level1name = 'InProcessParcels3D',
@level2type = N'Column', @level2name = 'LandDescription';
GO

EXEC sp_addextendedproperty
@name = N'Column_Description',
@value = 'מזהה תהליך קדסטרי',
@level0type = N'Schema', @level0name = 'dbo',
@level1type = N'Table',  @level1name = 'InProcessParcels3D',
@level2type = N'Column', @level2name = 'CPBUniqueID';
GO

EXEC sp_addextendedproperty
@name = N'Column_Description',
@value = 'סוג מקרקעין',
@level0type = N'Schema', @level0name = 'dbo',
@level1type = N'Table',  @level1name = 'InProcessParcels3D',
@level2type = N'Column', @level2name = 'LandType';
GO

EXEC sp_addextendedproperty
@name = N'Column_Description',
@value = 'שומא',
@level0type = N'Schema', @level0name = 'dbo',
@level1type = N'Table',  @level1name = 'InProcessParcels3D',
@level2type = N'Column', @level2name = 'IsTax';
GO

EXEC sp_addextendedproperty
@name = N'Column_Description',
@value = 'סוג תהליך קדסטרי',
@level0type = N'Schema', @level0name = 'dbo',
@level1type = N'Table',  @level1name = 'InProcessParcels3D',
@level2type = N'Column', @level2name = 'ProcessType';
GO

EXEC sp_addextendedproperty
@name = N'Column_Description',
@value = 'עודכן ברצף',
@level0type = N'Schema', @level0name = 'dbo',
@level1type = N'Table',  @level1name = 'InProcessParcels3D',
@level2type = N'Column', @level2name = 'Recorded';
GO

EXEC sp_addextendedproperty
@name = N'Table_Description',
@value = 'Alias: נקודות גבול בתהליך
  
',
@level0type = N'Schema', @level0name = 'dbo',
@level1type = N'Table',  @level1name = 'InProcessBorderPoints';
GO

EXEC sp_addextendedproperty
@name = N'Column_Description',
@value = 'Object ID',
@level0type = N'Schema', @level0name = 'dbo',
@level1type = N'Table',  @level1name = 'InProcessBorderPoints',
@level2type = N'Column', @level2name = 'OBJECTID';
GO

EXEC sp_addextendedproperty
@name = N'Column_Description',
@value = 'קואורדינטה',
@level0type = N'Schema', @level0name = 'dbo',
@level1type = N'Table',  @level1name = 'InProcessBorderPoints',
@level2type = N'Column', @level2name = 'Shape';
GO

EXEC sp_addextendedproperty
@name = N'Column_Description',
@value = 'מזהה נקודת גבול',
@level0type = N'Schema', @level0name = 'dbo',
@level1type = N'Table',  @level1name = 'InProcessBorderPoints',
@level2type = N'Column', @level2name = 'GlobalID';
GO

EXEC sp_addextendedproperty
@name = N'Column_Description',
@value = 'שם נקודה',
@level0type = N'Schema', @level0name = 'dbo',
@level1type = N'Table',  @level1name = 'InProcessBorderPoints',
@level2type = N'Column', @level2name = 'PointName';
GO

EXEC sp_addextendedproperty
@name = N'Column_Description',
@value = 'מעמד חלקה',
@level0type = N'Schema', @level0name = 'dbo',
@level1type = N'Table',  @level1name = 'InProcessBorderPoints',
@level2type = N'Column', @level2name = 'PointStatus';
GO

EXEC sp_addextendedproperty
@name = N'Column_Description',
@value = 'סיווג',
@level0type = N'Schema', @level0name = 'dbo',
@level1type = N'Table',  @level1name = 'InProcessBorderPoints',
@level2type = N'Column', @level2name = 'Class';
GO

EXEC sp_addextendedproperty
@name = N'Column_Description',
@value = 'מקור הנתונים',
@level0type = N'Schema', @level0name = 'dbo',
@level1type = N'Table',  @level1name = 'InProcessBorderPoints',
@level2type = N'Column', @level2name = 'DataSource';
GO

EXEC sp_addextendedproperty
@name = N'Column_Description',
@value = 'אופן סימון',
@level0type = N'Schema', @level0name = 'dbo',
@level1type = N'Table',  @level1name = 'InProcessBorderPoints',
@level2type = N'Column', @level2name = 'MarkCode';
GO

EXEC sp_addextendedproperty
@name = N'Column_Description',
@value = 'נקודת בקרה',
@level0type = N'Schema', @level0name = 'dbo',
@level1type = N'Table',  @level1name = 'InProcessBorderPoints',
@level2type = N'Column', @level2name = 'IsControlBorder';
GO

EXEC sp_addextendedproperty
@name = N'Column_Description',
@value = 'מזהה תהליך קדסטרי',
@level0type = N'Schema', @level0name = 'dbo',
@level1type = N'Table',  @level1name = 'InProcessBorderPoints',
@level2type = N'Column', @level2name = 'CPBUniqueID';
GO

EXEC sp_addextendedproperty
@name = N'Column_Description',
@value = 'עודכן ברצף',
@level0type = N'Schema', @level0name = 'dbo',
@level1type = N'Table',  @level1name = 'InProcessBorderPoints',
@level2type = N'Column', @level2name = 'Recorded';
GO

EXEC sp_addextendedproperty
@name = N'Table_Description',
@value = 'Alias: נקודות גבול תלת-ממדיות בתהליך

',
@level0type = N'Schema', @level0name = 'dbo',
@level1type = N'Table',  @level1name = 'InProcessBorderPoints3D';
GO

EXEC sp_addextendedproperty
@name = N'Column_Description',
@value = 'Object ID',
@level0type = N'Schema', @level0name = 'dbo',
@level1type = N'Table',  @level1name = 'InProcessBorderPoints3D',
@level2type = N'Column', @level2name = 'OBJECTID';
GO

EXEC sp_addextendedproperty
@name = N'Column_Description',
@value = 'קואורדינטה',
@level0type = N'Schema', @level0name = 'dbo',
@level1type = N'Table',  @level1name = 'InProcessBorderPoints3D',
@level2type = N'Column', @level2name = 'Shape';
GO

EXEC sp_addextendedproperty
@name = N'Column_Description',
@value = 'מזהה נקודת גבול',
@level0type = N'Schema', @level0name = 'dbo',
@level1type = N'Table',  @level1name = 'InProcessBorderPoints3D',
@level2type = N'Column', @level2name = 'GlobalID';
GO

EXEC sp_addextendedproperty
@name = N'Column_Description',
@value = 'שם נקודה',
@level0type = N'Schema', @level0name = 'dbo',
@level1type = N'Table',  @level1name = 'InProcessBorderPoints3D',
@level2type = N'Column', @level2name = 'Name';
GO

EXEC sp_addextendedproperty
@name = N'Column_Description',
@value = 'סיווג',
@level0type = N'Schema', @level0name = 'dbo',
@level1type = N'Table',  @level1name = 'InProcessBorderPoints3D',
@level2type = N'Column', @level2name = 'Class';
GO

EXEC sp_addextendedproperty
@name = N'Column_Description',
@value = 'מקור הנקודה',
@level0type = N'Schema', @level0name = 'dbo',
@level1type = N'Table',  @level1name = 'InProcessBorderPoints3D',
@level2type = N'Column', @level2name = 'DataSource';
GO

EXEC sp_addextendedproperty
@name = N'Column_Description',
@value = 'מעמד נקודה',
@level0type = N'Schema', @level0name = 'dbo',
@level1type = N'Table',  @level1name = 'InProcessBorderPoints3D',
@level2type = N'Column', @level2name = 'Role';
GO

EXEC sp_addextendedproperty
@name = N'Column_Description',
@value = 'נקודת בקרה',
@level0type = N'Schema', @level0name = 'dbo',
@level1type = N'Table',  @level1name = 'InProcessBorderPoints3D',
@level2type = N'Column', @level2name = 'IsControlBorder';
GO

EXEC sp_addextendedproperty
@name = N'Column_Description',
@value = 'מזהה תהליך קדסטרי',
@level0type = N'Schema', @level0name = 'dbo',
@level1type = N'Table',  @level1name = 'InProcessBorderPoints3D',
@level2type = N'Column', @level2name = 'CPBUniqueID';
GO

EXEC sp_addextendedproperty
@name = N'Column_Description',
@value = 'עודכן ברצף',
@level0type = N'Schema', @level0name = 'dbo',
@level1type = N'Table',  @level1name = 'InProcessBorderPoints3D',
@level2type = N'Column', @level2name = 'Recorded';
GO

EXEC sp_addextendedproperty
@name = N'Table_Description',
@value = 'Alias: חזיתות בתהליך
        
',
@level0type = N'Schema', @level0name = 'dbo',
@level1type = N'Table',  @level1name = 'InProcessFronts';
GO

EXEC sp_addextendedproperty
@name = N'Column_Description',
@value = 'Object ID',
@level0type = N'Schema', @level0name = 'dbo',
@level1type = N'Table',  @level1name = 'InProcessFronts',
@level2type = N'Column', @level2name = 'OBJECTID';
GO

EXEC sp_addextendedproperty
@name = N'Column_Description',
@value = 'גיאומטריה',
@level0type = N'Schema', @level0name = 'dbo',
@level1type = N'Table',  @level1name = 'InProcessFronts',
@level2type = N'Column', @level2name = 'Shape';
GO

EXEC sp_addextendedproperty
@name = N'Column_Description',
@value = 'מזהה חזית',
@level0type = N'Schema', @level0name = 'dbo',
@level1type = N'Table',  @level1name = 'InProcessFronts',
@level2type = N'Column', @level2name = 'GlobalID';
GO

EXEC sp_addextendedproperty
@name = N'Column_Description',
@value = 'מעמד חזית',
@level0type = N'Schema', @level0name = 'dbo',
@level1type = N'Table',  @level1name = 'InProcessFronts',
@level2type = N'Column', @level2name = 'LineStatus';
GO

EXEC sp_addextendedproperty
@name = N'Column_Description',
@value = 'סוג קו',
@level0type = N'Schema', @level0name = 'dbo',
@level1type = N'Table',  @level1name = 'InProcessFronts',
@level2type = N'Column', @level2name = 'LineType';
GO

EXEC sp_addextendedproperty
@name = N'Column_Description',
@value = 'מזהה נקודת התחלה',
@level0type = N'Schema', @level0name = 'dbo',
@level1type = N'Table',  @level1name = 'InProcessFronts',
@level2type = N'Column', @level2name = 'StartPointUniqueID';
GO

EXEC sp_addextendedproperty
@name = N'Column_Description',
@value = 'מזהה נקודת סיום',
@level0type = N'Schema', @level0name = 'dbo',
@level1type = N'Table',  @level1name = 'InProcessFronts',
@level2type = N'Column', @level2name = 'EndPointUniqueID';
GO

EXEC sp_addextendedproperty
@name = N'Column_Description',
@value = 'אורך רשום',
@level0type = N'Schema', @level0name = 'dbo',
@level1type = N'Table',  @level1name = 'InProcessFronts',
@level2type = N'Column', @level2name = 'LegalLength';
GO

EXEC sp_addextendedproperty
@name = N'Column_Description',
@value = 'רדיוס',
@level0type = N'Schema', @level0name = 'dbo',
@level1type = N'Table',  @level1name = 'InProcessFronts',
@level2type = N'Column', @level2name = 'Radius';
GO

EXEC sp_addextendedproperty
@name = N'Column_Description',
@value = 'מזהה תהליך קדסטרי',
@level0type = N'Schema', @level0name = 'dbo',
@level1type = N'Table',  @level1name = 'InProcessFronts',
@level2type = N'Column', @level2name = 'CPBUniqueID';
GO

EXEC sp_addextendedproperty
@name = N'Column_Description',
@value = 'אורך גיאומטריה',
@level0type = N'Schema', @level0name = 'dbo',
@level1type = N'Table',  @level1name = 'InProcessFronts',
@level2type = N'Column', @level2name = 'Shape_Length';
GO

EXEC sp_addextendedproperty
@name = N'Column_Description',
@value = 'עודכן ברצף',
@level0type = N'Schema', @level0name = 'dbo',
@level1type = N'Table',  @level1name = 'InProcessFronts',
@level2type = N'Column', @level2name = 'Recorded';
GO

EXEC sp_addextendedproperty
@name = N'Table_Description',
@value = 'Alias: גריעות בתהליך
 
',
@level0type = N'Schema', @level0name = 'dbo',
@level1type = N'Table',  @level1name = 'InProcessSubstractions';
GO

EXEC sp_addextendedproperty
@name = N'Column_Description',
@value = 'Object ID',
@level0type = N'Schema', @level0name = 'dbo',
@level1type = N'Table',  @level1name = 'InProcessSubstractions',
@level2type = N'Column', @level2name = 'OBJECTID';
GO

EXEC sp_addextendedproperty
@name = N'Column_Description',
@value = 'גיאומטריה',
@level0type = N'Schema', @level0name = 'dbo',
@level1type = N'Table',  @level1name = 'InProcessSubstractions',
@level2type = N'Column', @level2name = 'Shape';
GO

EXEC sp_addextendedproperty
@name = N'Column_Description',
@value = 'מזהה גריעה',
@level0type = N'Schema', @level0name = 'dbo',
@level1type = N'Table',  @level1name = 'InProcessSubstractions',
@level2type = N'Column', @level2name = 'GlobalID';
GO

EXEC sp_addextendedproperty
@name = N'Column_Description',
@value = 'מספר גריעה ארעי',
@level0type = N'Schema', @level0name = 'dbo',
@level1type = N'Table',  @level1name = 'InProcessSubstractions',
@level2type = N'Column', @level2name = 'TemporarySubstractionNumber';
GO

EXEC sp_addextendedproperty
@name = N'Column_Description',
@value = 'מספר גריעה סופי',
@level0type = N'Schema', @level0name = 'dbo',
@level1type = N'Table',  @level1name = 'InProcessSubstractions',
@level2type = N'Column', @level2name = 'FinalSubstractionNumber';
GO

EXEC sp_addextendedproperty
@name = N'Column_Description',
@value = 'מספר חלקה תלת-ממדית',
@level0type = N'Schema', @level0name = 'dbo',
@level1type = N'Table',  @level1name = 'InProcessSubstractions',
@level2type = N'Column', @level2name = 'Parcel3DNumber';
GO

EXEC sp_addextendedproperty
@name = N'Column_Description',
@value = 'מספר חלקה קרקעית',
@level0type = N'Schema', @level0name = 'dbo',
@level1type = N'Table',  @level1name = 'InProcessSubstractions',
@level2type = N'Column', @level2name = 'Parcel2DNumber';
GO

EXEC sp_addextendedproperty
@name = N'Column_Description',
@value = 'מספר גוש',
@level0type = N'Schema', @level0name = 'dbo',
@level1type = N'Table',  @level1name = 'InProcessSubstractions',
@level2type = N'Column', @level2name = 'BlockNumber';
GO

EXEC sp_addextendedproperty
@name = N'Column_Description',
@value = 'מספר תת-גוש',
@level0type = N'Schema', @level0name = 'dbo',
@level1type = N'Table',  @level1name = 'InProcessSubstractions',
@level2type = N'Column', @level2name = 'SubBlockNumber';
GO

EXEC sp_addextendedproperty
@name = N'Column_Description',
@value = 'נפח רשום במעוקב',
@level0type = N'Schema', @level0name = 'dbo',
@level1type = N'Table',  @level1name = 'InProcessSubstractions',
@level2type = N'Column', @level2name = 'StatedVolume';
GO

EXEC sp_addextendedproperty
@name = N'Column_Description',
@value = 'שטח היטל',
@level0type = N'Schema', @level0name = 'dbo',
@level1type = N'Table',  @level1name = 'InProcessSubstractions',
@level2type = N'Column', @level2name = 'ProjectedArea';
GO

EXEC sp_addextendedproperty
@name = N'Column_Description',
@value = 'רום עליון',
@level0type = N'Schema', @level0name = 'dbo',
@level1type = N'Table',  @level1name = 'InProcessSubstractions',
@level2type = N'Column', @level2name = 'UpperLevel';
GO

EXEC sp_addextendedproperty
@name = N'Column_Description',
@value = 'רום תחתון',
@level0type = N'Schema', @level0name = 'dbo',
@level1type = N'Table',  @level1name = 'InProcessSubstractions',
@level2type = N'Column', @level2name = 'LowerLevel';
GO

EXEC sp_addextendedproperty
@name = N'Column_Description',
@value = 'מיקום גריעה ביחס לפני הקרקע',
@level0type = N'Schema', @level0name = 'dbo',
@level1type = N'Table',  @level1name = 'InProcessSubstractions',
@level2type = N'Column', @level2name = 'RelativePosition';
GO

EXEC sp_addextendedproperty
@name = N'Column_Description',
@value = 'סוג גריעה',
@level0type = N'Schema', @level0name = 'dbo',
@level1type = N'Table',  @level1name = 'InProcessSubstractions',
@level2type = N'Column', @level2name = 'SubstractionType';
GO

EXEC sp_addextendedproperty
@name = N'Column_Description',
@value = 'מעמד גריעה',
@level0type = N'Schema', @level0name = 'dbo',
@level1type = N'Table',  @level1name = 'InProcessSubstractions',
@level2type = N'Column', @level2name = 'Role';
GO

EXEC sp_addextendedproperty
@name = N'Column_Description',
@value = 'סוג חלקה',
@level0type = N'Schema', @level0name = 'dbo',
@level1type = N'Table',  @level1name = 'InProcessSubstractions',
@level2type = N'Column', @level2name = 'Parcel2DType';
GO

EXEC sp_addextendedproperty
@name = N'Column_Description',
@value = 'עודכן ברצף',
@level0type = N'Schema', @level0name = 'dbo',
@level1type = N'Table',  @level1name = 'InProcessSubstractions',
@level2type = N'Column', @level2name = 'Recorded';
GO

EXEC sp_addextendedproperty
@name = N'Column_Description',
@value = 'מזהה גוש',
@level0type = N'Schema', @level0name = 'dbo',
@level1type = N'Table',  @level1name = 'InProcessSubstractions',
@level2type = N'Column', @level2name = 'BlockUniqueID';
GO

EXEC sp_addextendedproperty
@name = N'Column_Description',
@value = 'מזהה תהליך קדסטרי',
@level0type = N'Schema', @level0name = 'dbo',
@level1type = N'Table',  @level1name = 'InProcessSubstractions',
@level2type = N'Column', @level2name = 'CPBUniqueID';
GO

EXEC sp_addextendedproperty
@name = N'Column_Description',
@value = 'מזהה חלקה תלת-ממדית',
@level0type = N'Schema', @level0name = 'dbo',
@level1type = N'Table',  @level1name = 'InProcessSubstractions',
@level2type = N'Column', @level2name = 'Parcel3DUniqueID';
GO

EXEC sp_addextendedproperty
@name = N'Column_Description',
@value = 'מזהה חלקה קרקעית',
@level0type = N'Schema', @level0name = 'dbo',
@level1type = N'Table',  @level1name = 'InProcessSubstractions',
@level2type = N'Column', @level2name = 'Parcel2DUniqueID';
GO

EXEC sp_addextendedproperty
@name = N'Table_Description',
@value = 'Alias: היטלי חלקות תלת-ממד בתהליך

',
@level0type = N'Schema', @level0name = 'dbo',
@level1type = N'Table',  @level1name = 'InProcessProjectedParcels3D';
GO

EXEC sp_addextendedproperty
@name = N'Column_Description',
@value = 'Object ID',
@level0type = N'Schema', @level0name = 'dbo',
@level1type = N'Table',  @level1name = 'InProcessProjectedParcels3D',
@level2type = N'Column', @level2name = 'OBJECTID';
GO

EXEC sp_addextendedproperty
@name = N'Column_Description',
@value = 'גיאומטריה',
@level0type = N'Schema', @level0name = 'dbo',
@level1type = N'Table',  @level1name = 'InProcessProjectedParcels3D',
@level2type = N'Column', @level2name = 'Shape';
GO

EXEC sp_addextendedproperty
@name = N'Column_Description',
@value = 'היקף גיאומטריה',
@level0type = N'Schema', @level0name = 'dbo',
@level1type = N'Table',  @level1name = 'InProcessProjectedParcels3D',
@level2type = N'Column', @level2name = 'Shape_Length';
GO

EXEC sp_addextendedproperty
@name = N'Column_Description',
@value = 'שטח גיאומטריה',
@level0type = N'Schema', @level0name = 'dbo',
@level1type = N'Table',  @level1name = 'InProcessProjectedParcels3D',
@level2type = N'Column', @level2name = 'Shape_Area';
GO

EXEC sp_addextendedproperty
@name = N'Column_Description',
@value = 'מזהה חלקה תלת-ממדית בתהליך',
@level0type = N'Schema', @level0name = 'dbo',
@level1type = N'Table',  @level1name = 'InProcessProjectedParcels3D',
@level2type = N'Column', @level2name = 'Parcel3DUniqueID';
GO

EXEC sp_addextendedproperty
@name = N'Table_Description',
@value = 'Alias: היטלי גריעות בתהליך

',
@level0type = N'Schema', @level0name = 'dbo',
@level1type = N'Table',  @level1name = 'InProcessProjectedSubstraction';
GO

EXEC sp_addextendedproperty
@name = N'Column_Description',
@value = 'Object ID',
@level0type = N'Schema', @level0name = 'dbo',
@level1type = N'Table',  @level1name = 'InProcessProjectedSubstraction',
@level2type = N'Column', @level2name = 'OBJECTID';
GO

EXEC sp_addextendedproperty
@name = N'Column_Description',
@value = 'גיאומטריה',
@level0type = N'Schema', @level0name = 'dbo',
@level1type = N'Table',  @level1name = 'InProcessProjectedSubstraction',
@level2type = N'Column', @level2name = 'Shape';
GO

EXEC sp_addextendedproperty
@name = N'Column_Description',
@value = 'היקף גיאומטריה',
@level0type = N'Schema', @level0name = 'dbo',
@level1type = N'Table',  @level1name = 'InProcessProjectedSubstraction',
@level2type = N'Column', @level2name = 'Shape_Length';
GO

EXEC sp_addextendedproperty
@name = N'Column_Description',
@value = 'שטח גיאומטריה',
@level0type = N'Schema', @level0name = 'dbo',
@level1type = N'Table',  @level1name = 'InProcessProjectedSubstraction',
@level2type = N'Column', @level2name = 'Shape_Area';
GO

EXEC sp_addextendedproperty
@name = N'Column_Description',
@value = 'מזהה גריעה בתהליך',
@level0type = N'Schema', @level0name = 'dbo',
@level1type = N'Table',  @level1name = 'InProcessProjectedSubstraction',
@level2type = N'Column', @level2name = 'SubstractionUniqueID';
GO

EXEC sp_addextendedproperty
@name = N'Table_Description',
@value = 'Alias: יומן אשפי בנק"ל

',
@level0type = N'Schema', @level0name = 'dbo',
@level1type = N'Table',  @level1name = 'TaskHistory';
GO

EXEC sp_addextendedproperty
@name = N'Column_Description',
@value = 'Object ID',
@level0type = N'Schema', @level0name = 'dbo',
@level1type = N'Table',  @level1name = 'TaskHistory',
@level2type = N'Column', @level2name = 'OBJECTID';
GO

EXEC sp_addextendedproperty
@name = N'Column_Description',
@value = 'מזהה משתמש',
@level0type = N'Schema', @level0name = 'dbo',
@level1type = N'Table',  @level1name = 'TaskHistory',
@level2type = N'Column', @level2name = 'USERID';
GO

EXEC sp_addextendedproperty
@name = N'Column_Description',
@value = 'שם פרויקט',
@level0type = N'Schema', @level0name = 'dbo',
@level1type = N'Table',  @level1name = 'TaskHistory',
@level2type = N'Column', @level2name = 'PROJECTNAME';
GO

EXEC sp_addextendedproperty
@name = N'Column_Description',
@value = 'מזהה פריט',
@level0type = N'Schema', @level0name = 'dbo',
@level1type = N'Table',  @level1name = 'TaskHistory',
@level2type = N'Column', @level2name = 'TASKITEMID';
GO

EXEC sp_addextendedproperty
@name = N'Column_Description',
@value = 'שם פריט',
@level0type = N'Schema', @level0name = 'dbo',
@level1type = N'Table',  @level1name = 'TaskHistory',
@level2type = N'Column', @level2name = 'TASKITEMNAME';
GO

EXEC sp_addextendedproperty
@name = N'Column_Description',
@value = 'גרסת פריט',
@level0type = N'Schema', @level0name = 'dbo',
@level1type = N'Table',  @level1name = 'TaskHistory',
@level2type = N'Column', @level2name = 'TASKITEMVERSION';
GO

EXEC sp_addextendedproperty
@name = N'Column_Description',
@value = 'מזהה אשף',
@level0type = N'Schema', @level0name = 'dbo',
@level1type = N'Table',  @level1name = 'TaskHistory',
@level2type = N'Column', @level2name = 'TASKID';
GO

EXEC sp_addextendedproperty
@name = N'Column_Description',
@value = 'שם אשף',
@level0type = N'Schema', @level0name = 'dbo',
@level1type = N'Table',  @level1name = 'TaskHistory',
@level2type = N'Column', @level2name = 'TASKNAME';
GO

EXEC sp_addextendedproperty
@name = N'Column_Description',
@value = 'זמן התחלה',
@level0type = N'Schema', @level0name = 'dbo',
@level1type = N'Table',  @level1name = 'TaskHistory',
@level2type = N'Column', @level2name = 'STARTTIME';
GO

EXEC sp_addextendedproperty
@name = N'Column_Description',
@value = 'זמן סיום',
@level0type = N'Schema', @level0name = 'dbo',
@level1type = N'Table',  @level1name = 'TaskHistory',
@level2type = N'Column', @level2name = 'ENDTIME';
GO

EXEC sp_addextendedproperty
@name = N'Column_Description',
@value = 'משך זמן',
@level0type = N'Schema', @level0name = 'dbo',
@level1type = N'Table',  @level1name = 'TaskHistory',
@level2type = N'Column', @level2name = 'DURATION';
GO

EXEC sp_addextendedproperty
@name = N'Column_Description',
@value = 'מזהה משימה',
@level0type = N'Schema', @level0name = 'dbo',
@level1type = N'Table',  @level1name = 'TaskHistory',
@level2type = N'Column', @level2name = 'JOBID';
GO

EXEC sp_addextendedproperty
@name = N'Column_Description',
@value = 'אשף הסתיים',
@level0type = N'Schema', @level0name = 'dbo',
@level1type = N'Table',  @level1name = 'TaskHistory',
@level2type = N'Column', @level2name = 'TASKCOMPLETED';
GO

EXEC sp_addextendedproperty
@name = N'Table_Description',
@value = 'Alias: חלקות דו-ממדיות
              
',
@level0type = N'Schema', @level0name = 'dbo',
@level1type = N'Table',  @level1name = 'Parcels2D';
GO

EXEC sp_addextendedproperty
@name = N'Column_Description',
@value = 'Object ID',
@level0type = N'Schema', @level0name = 'dbo',
@level1type = N'Table',  @level1name = 'Parcels2D',
@level2type = N'Column', @level2name = 'OBJECTID';
GO

EXEC sp_addextendedproperty
@name = N'Column_Description',
@value = 'גיאומטריה',
@level0type = N'Schema', @level0name = 'dbo',
@level1type = N'Table',  @level1name = 'Parcels2D',
@level2type = N'Column', @level2name = 'Shape';
GO

EXEC sp_addextendedproperty
@name = N'Column_Description',
@value = 'מספר מלא',
@level0type = N'Schema', @level0name = 'dbo',
@level1type = N'Table',  @level1name = 'Parcels2D',
@level2type = N'Column', @level2name = 'Name';
GO

EXEC sp_addextendedproperty
@name = N'Column_Description',
@value = 'מזהה תהליך יוצר',
@level0type = N'Schema', @level0name = 'dbo',
@level1type = N'Table',  @level1name = 'Parcels2D',
@level2type = N'Column', @level2name = 'CreatedByRecord';
GO

EXEC sp_addextendedproperty
@name = N'Column_Description',
@value = 'מזהה תהליך מעדכן',
@level0type = N'Schema', @level0name = 'dbo',
@level1type = N'Table',  @level1name = 'Parcels2D',
@level2type = N'Column', @level2name = 'UpdatedByRecord';
GO

EXEC sp_addextendedproperty
@name = N'Column_Description',
@value = 'מזהה תהליך מבטל',
@level0type = N'Schema', @level0name = 'dbo',
@level1type = N'Table',  @level1name = 'Parcels2D',
@level2type = N'Column', @level2name = 'RetiredByRecord';
GO

EXEC sp_addextendedproperty
@name = N'Column_Description',
@value = 'שטח רשום במטר מרובע',
@level0type = N'Schema', @level0name = 'dbo',
@level1type = N'Table',  @level1name = 'Parcels2D',
@level2type = N'Column', @level2name = 'StatedArea';
GO

EXEC sp_addextendedproperty
@name = N'Column_Description',
@value = 'יחידת שטח',
@level0type = N'Schema', @level0name = 'dbo',
@level1type = N'Table',  @level1name = 'Parcels2D',
@level2type = N'Column', @level2name = 'StatedAreaUnit';
GO

EXEC sp_addextendedproperty
@name = N'Column_Description',
@value = 'שטח מחושב במטר מרובע',
@level0type = N'Schema', @level0name = 'dbo',
@level1type = N'Table',  @level1name = 'Parcels2D',
@level2type = N'Column', @level2name = 'CalculatedArea';
GO

EXEC sp_addextendedproperty
@name = N'Column_Description',
@value = 'יחס אורך שגוי והיקף',
@level0type = N'Schema', @level0name = 'dbo',
@level1type = N'Table',  @level1name = 'Parcels2D',
@level2type = N'Column', @level2name = 'MiscloseRatio';
GO

EXEC sp_addextendedproperty
@name = N'Column_Description',
@value = 'אורך שגוי',
@level0type = N'Schema', @level0name = 'dbo',
@level1type = N'Table',  @level1name = 'Parcels2D',
@level2type = N'Column', @level2name = 'MiscloseDistance';
GO

EXEC sp_addextendedproperty
@name = N'Column_Description',
@value = 'נוצר מגרעין',
@level0type = N'Schema', @level0name = 'dbo',
@level1type = N'Table',  @level1name = 'Parcels2D',
@level2type = N'Column', @level2name = 'IsSeed';
GO

EXEC sp_addextendedproperty
@name = N'Column_Description',
@value = 'היקף גיאומטריה',
@level0type = N'Schema', @level0name = 'dbo',
@level1type = N'Table',  @level1name = 'Parcels2D',
@level2type = N'Column', @level2name = 'Shape_Length';
GO

EXEC sp_addextendedproperty
@name = N'Column_Description',
@value = 'שטח גיאומטריה',
@level0type = N'Schema', @level0name = 'dbo',
@level1type = N'Table',  @level1name = 'Parcels2D',
@level2type = N'Column', @level2name = 'Shape_Area';
GO

EXEC sp_addextendedproperty
@name = N'Column_Description',
@value = 'מזהה חלקה',
@level0type = N'Schema', @level0name = 'dbo',
@level1type = N'Table',  @level1name = 'Parcels2D',
@level2type = N'Column', @level2name = 'GlobalID';
GO

EXEC sp_addextendedproperty
@name = N'Column_Description',
@value = 'תקינות',
@level0type = N'Schema', @level0name = 'dbo',
@level1type = N'Table',  @level1name = 'Parcels2D',
@level2type = N'Column', @level2name = 'VALIDATIONSTATUS';
GO

EXEC sp_addextendedproperty
@name = N'Column_Description',
@value = 'סוג חלקה',
@level0type = N'Schema', @level0name = 'dbo',
@level1type = N'Table',  @level1name = 'Parcels2D',
@level2type = N'Column', @level2name = 'ParcelType';
GO

EXEC sp_addextendedproperty
@name = N'Column_Description',
@value = 'סוג תהליך יוצר',
@level0type = N'Schema', @level0name = 'dbo',
@level1type = N'Table',  @level1name = 'Parcels2D',
@level2type = N'Column', @level2name = 'CreateProcessType';
GO

EXEC sp_addextendedproperty
@name = N'Column_Description',
@value = 'ייעוד קרקע',
@level0type = N'Schema', @level0name = 'dbo',
@level1type = N'Table',  @level1name = 'Parcels2D',
@level2type = N'Column', @level2name = 'LandDesignationPlan';
GO

EXEC sp_addextendedproperty
@name = N'Column_Description',
@value = 'מספר חלקה',
@level0type = N'Schema', @level0name = 'dbo',
@level1type = N'Table',  @level1name = 'Parcels2D',
@level2type = N'Column', @level2name = 'ParcelNumber';
GO

EXEC sp_addextendedproperty
@name = N'Column_Description',
@value = 'סוג מקרקעין',
@level0type = N'Schema', @level0name = 'dbo',
@level1type = N'Table',  @level1name = 'Parcels2D',
@level2type = N'Column', @level2name = 'LandType';
GO

EXEC sp_addextendedproperty
@name = N'Column_Description',
@value = 'מספר גוש',
@level0type = N'Schema', @level0name = 'dbo',
@level1type = N'Table',  @level1name = 'Parcels2D',
@level2type = N'Column', @level2name = 'BlockNumber';
GO

EXEC sp_addextendedproperty
@name = N'Column_Description',
@value = 'מספר תת-גוש',
@level0type = N'Schema', @level0name = 'dbo',
@level1type = N'Table',  @level1name = 'Parcels2D',
@level2type = N'Column', @level2name = 'SubBlockNumber';
GO

EXEC sp_addextendedproperty
@name = N'Column_Description',
@value = 'סוג תהליך מבטל',
@level0type = N'Schema', @level0name = 'dbo',
@level1type = N'Table',  @level1name = 'Parcels2D',
@level2type = N'Column', @level2name = 'CancelProcessType';
GO

EXEC sp_addextendedproperty
@name = N'Column_Description',
@value = 'שומא',
@level0type = N'Schema', @level0name = 'dbo',
@level1type = N'Table',  @level1name = 'Parcels2D',
@level2type = N'Column', @level2name = 'IsTax';
GO

EXEC sp_addextendedproperty
@name = N'Column_Description',
@value = 'סוג חצייה',
@level0type = N'Schema', @level0name = 'dbo',
@level1type = N'Table',  @level1name = 'Parcels2D',
@level2type = N'Column', @level2name = 'Bisection';
GO

EXEC sp_addextendedproperty
@name = N'Column_Description',
@value = 'מזהה גוש',
@level0type = N'Schema', @level0name = 'dbo',
@level1type = N'Table',  @level1name = 'Parcels2D',
@level2type = N'Column', @level2name = 'BlockUniqueID';
GO

EXEC sp_addextendedproperty
@name = N'Column_Description',
@value = 'משתמש יוצר',
@level0type = N'Schema', @level0name = 'dbo',
@level1type = N'Table',  @level1name = 'Parcels2D',
@level2type = N'Column', @level2name = 'created_user';
GO

EXEC sp_addextendedproperty
@name = N'Column_Description',
@value = 'תאריך יצירה',
@level0type = N'Schema', @level0name = 'dbo',
@level1type = N'Table',  @level1name = 'Parcels2D',
@level2type = N'Column', @level2name = 'created_date';
GO

EXEC sp_addextendedproperty
@name = N'Column_Description',
@value = 'משתמש מעדכן',
@level0type = N'Schema', @level0name = 'dbo',
@level1type = N'Table',  @level1name = 'Parcels2D',
@level2type = N'Column', @level2name = 'last_edited_user';
GO

EXEC sp_addextendedproperty
@name = N'Column_Description',
@value = 'תאריך עדכון אחרון',
@level0type = N'Schema', @level0name = 'dbo',
@level1type = N'Table',  @level1name = 'Parcels2D',
@level2type = N'Column', @level2name = 'last_edited_date';
GO

EXEC sp_addextendedproperty
@name = N'Table_Description',
@value = 'Alias: חלקות תלת-ממדיות
              
',
@level0type = N'Schema', @level0name = 'dbo',
@level1type = N'Table',  @level1name = 'Parcels3D';
GO

EXEC sp_addextendedproperty
@name = N'Column_Description',
@value = 'Object ID',
@level0type = N'Schema', @level0name = 'dbo',
@level1type = N'Table',  @level1name = 'Parcels3D',
@level2type = N'Column', @level2name = 'OBJECTID';
GO

EXEC sp_addextendedproperty
@name = N'Column_Description',
@value = 'גיאומטריה',
@level0type = N'Schema', @level0name = 'dbo',
@level1type = N'Table',  @level1name = 'Parcels3D',
@level2type = N'Column', @level2name = 'Shape';
GO

EXEC sp_addextendedproperty
@name = N'Column_Description',
@value = 'משתמש יוצר',
@level0type = N'Schema', @level0name = 'dbo',
@level1type = N'Table',  @level1name = 'Parcels3D',
@level2type = N'Column', @level2name = 'created_user';
GO

EXEC sp_addextendedproperty
@name = N'Column_Description',
@value = 'תאריך יצירה',
@level0type = N'Schema', @level0name = 'dbo',
@level1type = N'Table',  @level1name = 'Parcels3D',
@level2type = N'Column', @level2name = 'created_date';
GO

EXEC sp_addextendedproperty
@name = N'Column_Description',
@value = 'משתמש מעדכן',
@level0type = N'Schema', @level0name = 'dbo',
@level1type = N'Table',  @level1name = 'Parcels3D',
@level2type = N'Column', @level2name = 'last_edited_user';
GO

EXEC sp_addextendedproperty
@name = N'Column_Description',
@value = 'תאריך עדכון אחרון',
@level0type = N'Schema', @level0name = 'dbo',
@level1type = N'Table',  @level1name = 'Parcels3D',
@level2type = N'Column', @level2name = 'last_edited_date';
GO

EXEC sp_addextendedproperty
@name = N'Table_Description',
@value = 'Alias: חזיתות
        
',
@level0type = N'Schema', @level0name = 'dbo',
@level1type = N'Table',  @level1name = 'Parcels2DFronts';
GO

EXEC sp_addextendedproperty
@name = N'Column_Description',
@value = 'Object ID',
@level0type = N'Schema', @level0name = 'dbo',
@level1type = N'Table',  @level1name = 'Parcels2DFronts',
@level2type = N'Column', @level2name = 'OBJECTID';
GO

EXEC sp_addextendedproperty
@name = N'Column_Description',
@value = 'גיאומטריה',
@level0type = N'Schema', @level0name = 'dbo',
@level1type = N'Table',  @level1name = 'Parcels2DFronts',
@level2type = N'Column', @level2name = 'Shape';
GO

EXEC sp_addextendedproperty
@name = N'Column_Description',
@value = 'מזהה תהליך יוצר',
@level0type = N'Schema', @level0name = 'dbo',
@level1type = N'Table',  @level1name = 'Parcels2DFronts',
@level2type = N'Column', @level2name = 'CreatedByRecord';
GO

EXEC sp_addextendedproperty
@name = N'Column_Description',
@value = 'מזהה תהליך מעדכן',
@level0type = N'Schema', @level0name = 'dbo',
@level1type = N'Table',  @level1name = 'Parcels2DFronts',
@level2type = N'Column', @level2name = 'UpdatedByRecord';
GO

EXEC sp_addextendedproperty
@name = N'Column_Description',
@value = 'מזהה תהליך מבטל',
@level0type = N'Schema', @level0name = 'dbo',
@level1type = N'Table',  @level1name = 'Parcels2DFronts',
@level2type = N'Column', @level2name = 'RetiredByRecord';
GO

EXEC sp_addextendedproperty
@name = N'Column_Description',
@value = 'מזהה חזית קודמת',
@level0type = N'Schema', @level0name = 'dbo',
@level1type = N'Table',  @level1name = 'Parcels2DFronts',
@level2type = N'Column', @level2name = 'ParentLineID';
GO

EXEC sp_addextendedproperty
@name = N'Column_Description',
@value = 'כיוון',
@level0type = N'Schema', @level0name = 'dbo',
@level1type = N'Table',  @level1name = 'Parcels2DFronts',
@level2type = N'Column', @level2name = 'Direction';
GO

EXEC sp_addextendedproperty
@name = N'Column_Description',
@value = 'אורך רשום',
@level0type = N'Schema', @level0name = 'dbo',
@level1type = N'Table',  @level1name = 'Parcels2DFronts',
@level2type = N'Column', @level2name = 'Distance';
GO

EXEC sp_addextendedproperty
@name = N'Column_Description',
@value = 'רדיוס',
@level0type = N'Schema', @level0name = 'dbo',
@level1type = N'Table',  @level1name = 'Parcels2DFronts',
@level2type = N'Column', @level2name = 'Radius';
GO

EXEC sp_addextendedproperty
@name = N'Column_Description',
@value = 'אורך רדיוס',
@level0type = N'Schema', @level0name = 'dbo',
@level1type = N'Table',  @level1name = 'Parcels2DFronts',
@level2type = N'Column', @level2name = 'ArcLength';
GO

EXEC sp_addextendedproperty
@name = N'Column_Description',
@value = 'רדיוס כפול',
@level0type = N'Schema', @level0name = 'dbo',
@level1type = N'Table',  @level1name = 'Parcels2DFronts',
@level2type = N'Column', @level2name = 'Radius2';
GO

EXEC sp_addextendedproperty
@name = N'Column_Description',
@value = 'סוג קו מדידה',
@level0type = N'Schema', @level0name = 'dbo',
@level1type = N'Table',  @level1name = 'Parcels2DFronts',
@level2type = N'Column', @level2name = 'COGOType';
GO

EXEC sp_addextendedproperty
@name = N'Column_Description',
@value = 'מדידה קרקעית',
@level0type = N'Schema', @level0name = 'dbo',
@level1type = N'Table',  @level1name = 'Parcels2DFronts',
@level2type = N'Column', @level2name = 'IsCOGOGround';
GO

EXEC sp_addextendedproperty
@name = N'Column_Description',
@value = 'סיבוב',
@level0type = N'Schema', @level0name = 'dbo',
@level1type = N'Table',  @level1name = 'Parcels2DFronts',
@level2type = N'Column', @level2name = 'Rotation';
GO

EXEC sp_addextendedproperty
@name = N'Column_Description',
@value = 'קנה מידה',
@level0type = N'Schema', @level0name = 'dbo',
@level1type = N'Table',  @level1name = 'Parcels2DFronts',
@level2type = N'Column', @level2name = 'Scale';
GO

EXEC sp_addextendedproperty
@name = N'Column_Description',
@value = 'דיוק כיוון',
@level0type = N'Schema', @level0name = 'dbo',
@level1type = N'Table',  @level1name = 'Parcels2DFronts',
@level2type = N'Column', @level2name = 'DirectionAccuracy';
GO

EXEC sp_addextendedproperty
@name = N'Column_Description',
@value = 'דיוק אורך',
@level0type = N'Schema', @level0name = 'dbo',
@level1type = N'Table',  @level1name = 'Parcels2DFronts',
@level2type = N'Column', @level2name = 'DistanceAccuracy';
GO

EXEC sp_addextendedproperty
@name = N'Column_Description',
@value = 'מיקום תווית',
@level0type = N'Schema', @level0name = 'dbo',
@level1type = N'Table',  @level1name = 'Parcels2DFronts',
@level2type = N'Column', @level2name = 'LabelPosition';
GO

EXEC sp_addextendedproperty
@name = N'Column_Description',
@value = 'אורך גיאומטריה',
@level0type = N'Schema', @level0name = 'dbo',
@level1type = N'Table',  @level1name = 'Parcels2DFronts',
@level2type = N'Column', @level2name = 'Shape_Length';
GO

EXEC sp_addextendedproperty
@name = N'Column_Description',
@value = 'מזהה חזית',
@level0type = N'Schema', @level0name = 'dbo',
@level1type = N'Table',  @level1name = 'Parcels2DFronts',
@level2type = N'Column', @level2name = 'GlobalID';
GO

EXEC sp_addextendedproperty
@name = N'Column_Description',
@value = 'תקינות',
@level0type = N'Schema', @level0name = 'dbo',
@level1type = N'Table',  @level1name = 'Parcels2DFronts',
@level2type = N'Column', @level2name = 'VALIDATIONSTATUS';
GO

EXEC sp_addextendedproperty
@name = N'Column_Description',
@value = 'סוג קו',
@level0type = N'Schema', @level0name = 'dbo',
@level1type = N'Table',  @level1name = 'Parcels2DFronts',
@level2type = N'Column', @level2name = 'LineType';
GO

EXEC sp_addextendedproperty
@name = N'Column_Description',
@value = 'מזהה נקודת גבול התחלה',
@level0type = N'Schema', @level0name = 'dbo',
@level1type = N'Table',  @level1name = 'Parcels2DFronts',
@level2type = N'Column', @level2name = 'StartPointUniqueID';
GO

EXEC sp_addextendedproperty
@name = N'Column_Description',
@value = 'מזהה נקודת גבול סיום',
@level0type = N'Schema', @level0name = 'dbo',
@level1type = N'Table',  @level1name = 'Parcels2DFronts',
@level2type = N'Column', @level2name = 'EndPointUniqueID';
GO

EXEC sp_addextendedproperty
@name = N'Column_Description',
@value = 'משתמש יוצר',
@level0type = N'Schema', @level0name = 'dbo',
@level1type = N'Table',  @level1name = 'Parcels2DFronts',
@level2type = N'Column', @level2name = 'created_user';
GO

EXEC sp_addextendedproperty
@name = N'Column_Description',
@value = 'תאריך יצירה',
@level0type = N'Schema', @level0name = 'dbo',
@level1type = N'Table',  @level1name = 'Parcels2DFronts',
@level2type = N'Column', @level2name = 'created_date';
GO

EXEC sp_addextendedproperty
@name = N'Column_Description',
@value = 'משתמש מעדכן',
@level0type = N'Schema', @level0name = 'dbo',
@level1type = N'Table',  @level1name = 'Parcels2DFronts',
@level2type = N'Column', @level2name = 'last_edited_user';
GO

EXEC sp_addextendedproperty
@name = N'Column_Description',
@value = 'תאריך עדכון אחרון',
@level0type = N'Schema', @level0name = 'dbo',
@level1type = N'Table',  @level1name = 'Parcels2DFronts',
@level2type = N'Column', @level2name = 'last_edited_date';
GO

EXEC sp_addextendedproperty
@name = N'Table_Description',
@value = 'Alias: חזיתות גושים
           
',
@level0type = N'Schema', @level0name = 'dbo',
@level1type = N'Table',  @level1name = 'BlocksFronts';
GO

EXEC sp_addextendedproperty
@name = N'Column_Description',
@value = 'Object ID',
@level0type = N'Schema', @level0name = 'dbo',
@level1type = N'Table',  @level1name = 'BlocksFronts',
@level2type = N'Column', @level2name = 'OBJECTID';
GO

EXEC sp_addextendedproperty
@name = N'Column_Description',
@value = 'גיאומטריה',
@level0type = N'Schema', @level0name = 'dbo',
@level1type = N'Table',  @level1name = 'BlocksFronts',
@level2type = N'Column', @level2name = 'Shape';
GO

EXEC sp_addextendedproperty
@name = N'Column_Description',
@value = 'מזהה תהליך יוצר',
@level0type = N'Schema', @level0name = 'dbo',
@level1type = N'Table',  @level1name = 'BlocksFronts',
@level2type = N'Column', @level2name = 'CreatedByRecord';
GO

EXEC sp_addextendedproperty
@name = N'Column_Description',
@value = 'מזהה תהליך מבטל',
@level0type = N'Schema', @level0name = 'dbo',
@level1type = N'Table',  @level1name = 'BlocksFronts',
@level2type = N'Column', @level2name = 'RetiredByRecord';
GO

EXEC sp_addextendedproperty
@name = N'Column_Description',
@value = 'מזהה חזית קודמת',
@level0type = N'Schema', @level0name = 'dbo',
@level1type = N'Table',  @level1name = 'BlocksFronts',
@level2type = N'Column', @level2name = 'ParentLineID';
GO

EXEC sp_addextendedproperty
@name = N'Column_Description',
@value = 'כיוון',
@level0type = N'Schema', @level0name = 'dbo',
@level1type = N'Table',  @level1name = 'BlocksFronts',
@level2type = N'Column', @level2name = 'Direction';
GO

EXEC sp_addextendedproperty
@name = N'Column_Description',
@value = 'אורך רשום',
@level0type = N'Schema', @level0name = 'dbo',
@level1type = N'Table',  @level1name = 'BlocksFronts',
@level2type = N'Column', @level2name = 'Distance';
GO

EXEC sp_addextendedproperty
@name = N'Column_Description',
@value = 'רדיוס',
@level0type = N'Schema', @level0name = 'dbo',
@level1type = N'Table',  @level1name = 'BlocksFronts',
@level2type = N'Column', @level2name = 'Radius';
GO

EXEC sp_addextendedproperty
@name = N'Column_Description',
@value = 'אורך רדיוס',
@level0type = N'Schema', @level0name = 'dbo',
@level1type = N'Table',  @level1name = 'BlocksFronts',
@level2type = N'Column', @level2name = 'ArcLength';
GO

EXEC sp_addextendedproperty
@name = N'Column_Description',
@value = 'רדיוס כפול',
@level0type = N'Schema', @level0name = 'dbo',
@level1type = N'Table',  @level1name = 'BlocksFronts',
@level2type = N'Column', @level2name = 'Radius2';
GO

EXEC sp_addextendedproperty
@name = N'Column_Description',
@value = 'סוג קו מדידה',
@level0type = N'Schema', @level0name = 'dbo',
@level1type = N'Table',  @level1name = 'BlocksFronts',
@level2type = N'Column', @level2name = 'COGOType';
GO

EXEC sp_addextendedproperty
@name = N'Column_Description',
@value = 'מדידה קרקעית',
@level0type = N'Schema', @level0name = 'dbo',
@level1type = N'Table',  @level1name = 'BlocksFronts',
@level2type = N'Column', @level2name = 'IsCOGOGround';
GO

EXEC sp_addextendedproperty
@name = N'Column_Description',
@value = 'סיבוב',
@level0type = N'Schema', @level0name = 'dbo',
@level1type = N'Table',  @level1name = 'BlocksFronts',
@level2type = N'Column', @level2name = 'Rotation';
GO

EXEC sp_addextendedproperty
@name = N'Column_Description',
@value = 'קנה מידה',
@level0type = N'Schema', @level0name = 'dbo',
@level1type = N'Table',  @level1name = 'BlocksFronts',
@level2type = N'Column', @level2name = 'Scale';
GO

EXEC sp_addextendedproperty
@name = N'Column_Description',
@value = 'דיוק כיוון',
@level0type = N'Schema', @level0name = 'dbo',
@level1type = N'Table',  @level1name = 'BlocksFronts',
@level2type = N'Column', @level2name = 'DirectionAccuracy';
GO

EXEC sp_addextendedproperty
@name = N'Column_Description',
@value = 'דיוק אורך',
@level0type = N'Schema', @level0name = 'dbo',
@level1type = N'Table',  @level1name = 'BlocksFronts',
@level2type = N'Column', @level2name = 'DistanceAccuracy';
GO

EXEC sp_addextendedproperty
@name = N'Column_Description',
@value = 'מיקום תווית',
@level0type = N'Schema', @level0name = 'dbo',
@level1type = N'Table',  @level1name = 'BlocksFronts',
@level2type = N'Column', @level2name = 'LabelPosition';
GO

EXEC sp_addextendedproperty
@name = N'Column_Description',
@value = 'אורך גיאומטריה',
@level0type = N'Schema', @level0name = 'dbo',
@level1type = N'Table',  @level1name = 'BlocksFronts',
@level2type = N'Column', @level2name = 'Shape_Length';
GO

EXEC sp_addextendedproperty
@name = N'Column_Description',
@value = 'מזהה חזית',
@level0type = N'Schema', @level0name = 'dbo',
@level1type = N'Table',  @level1name = 'BlocksFronts',
@level2type = N'Column', @level2name = 'GlobalID';
GO

EXEC sp_addextendedproperty
@name = N'Column_Description',
@value = 'תקינות',
@level0type = N'Schema', @level0name = 'dbo',
@level1type = N'Table',  @level1name = 'BlocksFronts',
@level2type = N'Column', @level2name = 'VALIDATIONSTATUS';
GO

EXEC sp_addextendedproperty
@name = N'Column_Description',
@value = 'סוג קו',
@level0type = N'Schema', @level0name = 'dbo',
@level1type = N'Table',  @level1name = 'BlocksFronts',
@level2type = N'Column', @level2name = 'LineType';
GO

EXEC sp_addextendedproperty
@name = N'Column_Description',
@value = 'מזהה נקודת גבול התחלה',
@level0type = N'Schema', @level0name = 'dbo',
@level1type = N'Table',  @level1name = 'BlocksFronts',
@level2type = N'Column', @level2name = 'StartPointUniqueID';
GO

EXEC sp_addextendedproperty
@name = N'Column_Description',
@value = 'מזהה נקודת גבול סיום',
@level0type = N'Schema', @level0name = 'dbo',
@level1type = N'Table',  @level1name = 'BlocksFronts',
@level2type = N'Column', @level2name = 'EndPointUniqueID';
GO

EXEC sp_addextendedproperty
@name = N'Column_Description',
@value = 'משתמש יוצר',
@level0type = N'Schema', @level0name = 'dbo',
@level1type = N'Table',  @level1name = 'BlocksFronts',
@level2type = N'Column', @level2name = 'created_user';
GO

EXEC sp_addextendedproperty
@name = N'Column_Description',
@value = 'תאריך יצירה',
@level0type = N'Schema', @level0name = 'dbo',
@level1type = N'Table',  @level1name = 'BlocksFronts',
@level2type = N'Column', @level2name = 'created_date';
GO

EXEC sp_addextendedproperty
@name = N'Column_Description',
@value = 'משתמש מעדכן',
@level0type = N'Schema', @level0name = 'dbo',
@level1type = N'Table',  @level1name = 'BlocksFronts',
@level2type = N'Column', @level2name = 'last_edited_user';
GO

EXEC sp_addextendedproperty
@name = N'Column_Description',
@value = 'תאריך עדכון אחרון',
@level0type = N'Schema', @level0name = 'dbo',
@level1type = N'Table',  @level1name = 'BlocksFronts',
@level2type = N'Column', @level2name = 'last_edited_date';
GO

EXEC sp_addextendedproperty
@name = N'Table_Description',
@value = 'Alias: נקודות גבול
           
',
@level0type = N'Schema', @level0name = 'dbo',
@level1type = N'Table',  @level1name = 'BorderPoints';
GO

EXEC sp_addextendedproperty
@name = N'Column_Description',
@value = 'Object ID',
@level0type = N'Schema', @level0name = 'dbo',
@level1type = N'Table',  @level1name = 'BorderPoints',
@level2type = N'Column', @level2name = 'OBJECTID';
GO

EXEC sp_addextendedproperty
@name = N'Column_Description',
@value = 'קואורדינטה',
@level0type = N'Schema', @level0name = 'dbo',
@level1type = N'Table',  @level1name = 'BorderPoints',
@level2type = N'Column', @level2name = 'Shape';
GO

EXEC sp_addextendedproperty
@name = N'Column_Description',
@value = 'מזהה תהליך יוצר',
@level0type = N'Schema', @level0name = 'dbo',
@level1type = N'Table',  @level1name = 'BorderPoints',
@level2type = N'Column', @level2name = 'CreatedByRecord';
GO

EXEC sp_addextendedproperty
@name = N'Column_Description',
@value = 'מזהה תהליך מבטל',
@level0type = N'Schema', @level0name = 'dbo',
@level1type = N'Table',  @level1name = 'BorderPoints',
@level2type = N'Column', @level2name = 'RetiredByRecord';
GO

EXEC sp_addextendedproperty
@name = N'Column_Description',
@value = 'מזהה תהליך מעדכן',
@level0type = N'Schema', @level0name = 'dbo',
@level1type = N'Table',  @level1name = 'BorderPoints',
@level2type = N'Column', @level2name = 'UpdatedByRecord';
GO

EXEC sp_addextendedproperty
@name = N'Column_Description',
@value = 'שם נקודה',
@level0type = N'Schema', @level0name = 'dbo',
@level1type = N'Table',  @level1name = 'BorderPoints',
@level2type = N'Column', @level2name = 'Name';
GO

EXEC sp_addextendedproperty
@name = N'Column_Description',
@value = 'נקודת עוגן',
@level0type = N'Schema', @level0name = 'dbo',
@level1type = N'Table',  @level1name = 'BorderPoints',
@level2type = N'Column', @level2name = 'IsFixed';
GO

EXEC sp_addextendedproperty
@name = N'Column_Description',
@value = 'אילוץ התאמה',
@level0type = N'Schema', @level0name = 'dbo',
@level1type = N'Table',  @level1name = 'BorderPoints',
@level2type = N'Column', @level2name = 'AdjustmentConstraint';
GO

EXEC sp_addextendedproperty
@name = N'Column_Description',
@value = 'נקודה שמורה',
@level0type = N'Schema', @level0name = 'dbo',
@level1type = N'Table',  @level1name = 'BorderPoints',
@level2type = N'Column', @level2name = 'Preserve';
GO

EXEC sp_addextendedproperty
@name = N'Column_Description',
@value = 'קואו'' מזרחית',
@level0type = N'Schema', @level0name = 'dbo',
@level1type = N'Table',  @level1name = 'BorderPoints',
@level2type = N'Column', @level2name = 'X';
GO

EXEC sp_addextendedproperty
@name = N'Column_Description',
@value = 'קואו'' פונית',
@level0type = N'Schema', @level0name = 'dbo',
@level1type = N'Table',  @level1name = 'BorderPoints',
@level2type = N'Column', @level2name = 'Y';
GO

EXEC sp_addextendedproperty
@name = N'Column_Description',
@value = 'גובה',
@level0type = N'Schema', @level0name = 'dbo',
@level1type = N'Table',  @level1name = 'BorderPoints',
@level2type = N'Column', @level2name = 'Z';
GO

EXEC sp_addextendedproperty
@name = N'Column_Description',
@value = 'דיוק צפון-מזרח',
@level0type = N'Schema', @level0name = 'dbo',
@level1type = N'Table',  @level1name = 'BorderPoints',
@level2type = N'Column', @level2name = 'XYAccuracy';
GO

EXEC sp_addextendedproperty
@name = N'Column_Description',
@value = 'דיוק גובה',
@level0type = N'Schema', @level0name = 'dbo',
@level1type = N'Table',  @level1name = 'BorderPoints',
@level2type = N'Column', @level2name = 'ZAccuracy';
GO

EXEC sp_addextendedproperty
@name = N'Column_Description',
@value = 'אי-ודאות צפון-מזרח',
@level0type = N'Schema', @level0name = 'dbo',
@level1type = N'Table',  @level1name = 'BorderPoints',
@level2type = N'Column', @level2name = 'XYUncertainty';
GO

EXEC sp_addextendedproperty
@name = N'Column_Description',
@value = 'ציר שגיאה ראשי',
@level0type = N'Schema', @level0name = 'dbo',
@level1type = N'Table',  @level1name = 'BorderPoints',
@level2type = N'Column', @level2name = 'EllipseMajor';
GO

EXEC sp_addextendedproperty
@name = N'Column_Description',
@value = 'ציר שגיאה משני',
@level0type = N'Schema', @level0name = 'dbo',
@level1type = N'Table',  @level1name = 'BorderPoints',
@level2type = N'Column', @level2name = 'EllipseMinor';
GO

EXEC sp_addextendedproperty
@name = N'Column_Description',
@value = 'כיוון אליפסת שגיאה',
@level0type = N'Schema', @level0name = 'dbo',
@level1type = N'Table',  @level1name = 'BorderPoints',
@level2type = N'Column', @level2name = 'EllipseDirection';
GO

EXEC sp_addextendedproperty
@name = N'Column_Description',
@value = 'מזהה נקודת גבול',
@level0type = N'Schema', @level0name = 'dbo',
@level1type = N'Table',  @level1name = 'BorderPoints',
@level2type = N'Column', @level2name = 'GlobalID';
GO

EXEC sp_addextendedproperty
@name = N'Column_Description',
@value = 'סיווג',
@level0type = N'Schema', @level0name = 'dbo',
@level1type = N'Table',  @level1name = 'BorderPoints',
@level2type = N'Column', @level2name = 'Class';
GO

EXEC sp_addextendedproperty
@name = N'Column_Description',
@value = 'מקור הנתונים',
@level0type = N'Schema', @level0name = 'dbo',
@level1type = N'Table',  @level1name = 'BorderPoints',
@level2type = N'Column', @level2name = 'DataSource';
GO

EXEC sp_addextendedproperty
@name = N'Column_Description',
@value = 'אופן סימון',
@level0type = N'Schema', @level0name = 'dbo',
@level1type = N'Table',  @level1name = 'BorderPoints',
@level2type = N'Column', @level2name = 'MarkCode';
GO

EXEC sp_addextendedproperty
@name = N'Column_Description',
@value = 'נקודת בקרה',
@level0type = N'Schema', @level0name = 'dbo',
@level1type = N'Table',  @level1name = 'BorderPoints',
@level2type = N'Column', @level2name = 'IsControlBorder';
GO

EXEC sp_addextendedproperty
@name = N'Column_Description',
@value = 'תקינות',
@level0type = N'Schema', @level0name = 'dbo',
@level1type = N'Table',  @level1name = 'BorderPoints',
@level2type = N'Column', @level2name = 'VALIDATIONSTATUS';
GO

EXEC sp_addextendedproperty
@name = N'Column_Description',
@value = 'משתמש יוצר',
@level0type = N'Schema', @level0name = 'dbo',
@level1type = N'Table',  @level1name = 'BorderPoints',
@level2type = N'Column', @level2name = 'created_user';
GO

EXEC sp_addextendedproperty
@name = N'Column_Description',
@value = 'תאריך יצירה',
@level0type = N'Schema', @level0name = 'dbo',
@level1type = N'Table',  @level1name = 'BorderPoints',
@level2type = N'Column', @level2name = 'created_date';
GO

EXEC sp_addextendedproperty
@name = N'Column_Description',
@value = 'משתמש מעדכן',
@level0type = N'Schema', @level0name = 'dbo',
@level1type = N'Table',  @level1name = 'BorderPoints',
@level2type = N'Column', @level2name = 'last_edited_user';
GO

EXEC sp_addextendedproperty
@name = N'Column_Description',
@value = 'תאריך עדכון אחרון',
@level0type = N'Schema', @level0name = 'dbo',
@level1type = N'Table',  @level1name = 'BorderPoints',
@level2type = N'Column', @level2name = 'last_edited_date';
GO

EXEC sp_addextendedproperty
@name = N'Table_Description',
@value = 'Alias: נקודות גבול תלת-ממדיות
         
',
@level0type = N'Schema', @level0name = 'dbo',
@level1type = N'Table',  @level1name = 'BorderPoints3D';
GO

EXEC sp_addextendedproperty
@name = N'Column_Description',
@value = 'Object ID',
@level0type = N'Schema', @level0name = 'dbo',
@level1type = N'Table',  @level1name = 'BorderPoints3D',
@level2type = N'Column', @level2name = 'OBJECTID';
GO

EXEC sp_addextendedproperty
@name = N'Column_Description',
@value = 'קואורדינטה',
@level0type = N'Schema', @level0name = 'dbo',
@level1type = N'Table',  @level1name = 'BorderPoints3D',
@level2type = N'Column', @level2name = 'Shape';
GO

EXEC sp_addextendedproperty
@name = N'Column_Description',
@value = 'מזהה נקודת גבול',
@level0type = N'Schema', @level0name = 'dbo',
@level1type = N'Table',  @level1name = 'BorderPoints3D',
@level2type = N'Column', @level2name = 'GlobalID';
GO

EXEC sp_addextendedproperty
@name = N'Column_Description',
@value = 'שם נקודה',
@level0type = N'Schema', @level0name = 'dbo',
@level1type = N'Table',  @level1name = 'BorderPoints3D',
@level2type = N'Column', @level2name = 'Name';
GO

EXEC sp_addextendedproperty
@name = N'Column_Description',
@value = 'קואו'' מזרחית',
@level0type = N'Schema', @level0name = 'dbo',
@level1type = N'Table',  @level1name = 'BorderPoints3D',
@level2type = N'Column', @level2name = 'X';
GO

EXEC sp_addextendedproperty
@name = N'Column_Description',
@value = 'קואו'' פונית',
@level0type = N'Schema', @level0name = 'dbo',
@level1type = N'Table',  @level1name = 'BorderPoints3D',
@level2type = N'Column', @level2name = 'Y';
GO

EXEC sp_addextendedproperty
@name = N'Column_Description',
@value = 'גובה',
@level0type = N'Schema', @level0name = 'dbo',
@level1type = N'Table',  @level1name = 'BorderPoints3D',
@level2type = N'Column', @level2name = 'Z';
GO

EXEC sp_addextendedproperty
@name = N'Column_Description',
@value = 'סיווג',
@level0type = N'Schema', @level0name = 'dbo',
@level1type = N'Table',  @level1name = 'BorderPoints3D',
@level2type = N'Column', @level2name = 'Class';
GO

EXEC sp_addextendedproperty
@name = N'Column_Description',
@value = 'מקור הנתונים',
@level0type = N'Schema', @level0name = 'dbo',
@level1type = N'Table',  @level1name = 'BorderPoints3D',
@level2type = N'Column', @level2name = 'DataSource';
GO

EXEC sp_addextendedproperty
@name = N'Column_Description',
@value = 'נקודת בקרה',
@level0type = N'Schema', @level0name = 'dbo',
@level1type = N'Table',  @level1name = 'BorderPoints3D',
@level2type = N'Column', @level2name = 'IsControlBorder';
GO

EXEC sp_addextendedproperty
@name = N'Column_Description',
@value = 'מזהה תהליך יוצר',
@level0type = N'Schema', @level0name = 'dbo',
@level1type = N'Table',  @level1name = 'BorderPoints3D',
@level2type = N'Column', @level2name = 'CreatedByRecord';
GO

EXEC sp_addextendedproperty
@name = N'Column_Description',
@value = 'מזהה תהליך מעדכן',
@level0type = N'Schema', @level0name = 'dbo',
@level1type = N'Table',  @level1name = 'BorderPoints3D',
@level2type = N'Column', @level2name = 'UpdatedByRecord';
GO

EXEC sp_addextendedproperty
@name = N'Column_Description',
@value = 'מזהה תהליך מבטל',
@level0type = N'Schema', @level0name = 'dbo',
@level1type = N'Table',  @level1name = 'BorderPoints3D',
@level2type = N'Column', @level2name = 'RetiredByRecord';
GO

EXEC sp_addextendedproperty
@name = N'Column_Description',
@value = 'נקודת עוגן',
@level0type = N'Schema', @level0name = 'dbo',
@level1type = N'Table',  @level1name = 'BorderPoints3D',
@level2type = N'Column', @level2name = 'IsFixed';
GO

EXEC sp_addextendedproperty
@name = N'Column_Description',
@value = 'אילוץ התאמה',
@level0type = N'Schema', @level0name = 'dbo',
@level1type = N'Table',  @level1name = 'BorderPoints3D',
@level2type = N'Column', @level2name = 'AdjustmentConstraint';
GO

EXEC sp_addextendedproperty
@name = N'Column_Description',
@value = 'נקודה שמורה',
@level0type = N'Schema', @level0name = 'dbo',
@level1type = N'Table',  @level1name = 'BorderPoints3D',
@level2type = N'Column', @level2name = 'Preserve';
GO

EXEC sp_addextendedproperty
@name = N'Column_Description',
@value = 'דיוק צפון-מזרח',
@level0type = N'Schema', @level0name = 'dbo',
@level1type = N'Table',  @level1name = 'BorderPoints3D',
@level2type = N'Column', @level2name = 'XYAccuracy';
GO

EXEC sp_addextendedproperty
@name = N'Column_Description',
@value = 'דיוק גובה',
@level0type = N'Schema', @level0name = 'dbo',
@level1type = N'Table',  @level1name = 'BorderPoints3D',
@level2type = N'Column', @level2name = 'ZAccuracy';
GO

EXEC sp_addextendedproperty
@name = N'Column_Description',
@value = 'אי-ודאות צפון-מזרח',
@level0type = N'Schema', @level0name = 'dbo',
@level1type = N'Table',  @level1name = 'BorderPoints3D',
@level2type = N'Column', @level2name = 'XYUncertainty';
GO

EXEC sp_addextendedproperty
@name = N'Column_Description',
@value = 'ציר שגיאה ראשי',
@level0type = N'Schema', @level0name = 'dbo',
@level1type = N'Table',  @level1name = 'BorderPoints3D',
@level2type = N'Column', @level2name = 'EllipseMajor';
GO

EXEC sp_addextendedproperty
@name = N'Column_Description',
@value = 'ציר שגיאה משני',
@level0type = N'Schema', @level0name = 'dbo',
@level1type = N'Table',  @level1name = 'BorderPoints3D',
@level2type = N'Column', @level2name = 'EllipseMinor';
GO

EXEC sp_addextendedproperty
@name = N'Column_Description',
@value = 'כיוון אליפסת שגיאה',
@level0type = N'Schema', @level0name = 'dbo',
@level1type = N'Table',  @level1name = 'BorderPoints3D',
@level2type = N'Column', @level2name = 'EllipseDirection';
GO

EXEC sp_addextendedproperty
@name = N'Column_Description',
@value = 'תקינות',
@level0type = N'Schema', @level0name = 'dbo',
@level1type = N'Table',  @level1name = 'BorderPoints3D',
@level2type = N'Column', @level2name = 'VALIDATIONSTATUS';
GO

EXEC sp_addextendedproperty
@name = N'Column_Description',
@value = 'משתמש יוצר',
@level0type = N'Schema', @level0name = 'dbo',
@level1type = N'Table',  @level1name = 'BorderPoints3D',
@level2type = N'Column', @level2name = 'created_user';
GO

EXEC sp_addextendedproperty
@name = N'Column_Description',
@value = 'תאריך יצירה',
@level0type = N'Schema', @level0name = 'dbo',
@level1type = N'Table',  @level1name = 'BorderPoints3D',
@level2type = N'Column', @level2name = 'created_date';
GO

EXEC sp_addextendedproperty
@name = N'Column_Description',
@value = 'משתמש מעדכן',
@level0type = N'Schema', @level0name = 'dbo',
@level1type = N'Table',  @level1name = 'BorderPoints3D',
@level2type = N'Column', @level2name = 'last_edited_user';
GO

EXEC sp_addextendedproperty
@name = N'Column_Description',
@value = 'תאריך עדכון אחרון',
@level0type = N'Schema', @level0name = 'dbo',
@level1type = N'Table',  @level1name = 'BorderPoints3D',
@level2type = N'Column', @level2name = 'last_edited_date';
GO

EXEC sp_addextendedproperty
@name = N'Table_Description',
@value = 'Alias: גריעות
          
',
@level0type = N'Schema', @level0name = 'dbo',
@level1type = N'Table',  @level1name = 'Substractions';
GO

EXEC sp_addextendedproperty
@name = N'Column_Description',
@value = 'Object ID',
@level0type = N'Schema', @level0name = 'dbo',
@level1type = N'Table',  @level1name = 'Substractions',
@level2type = N'Column', @level2name = 'OBJECTID';
GO

EXEC sp_addextendedproperty
@name = N'Column_Description',
@value = 'גיאומטריה',
@level0type = N'Schema', @level0name = 'dbo',
@level1type = N'Table',  @level1name = 'Substractions',
@level2type = N'Column', @level2name = 'Shape';
GO

EXEC sp_addextendedproperty
@name = N'Column_Description',
@value = 'מזהה גריעה',
@level0type = N'Schema', @level0name = 'dbo',
@level1type = N'Table',  @level1name = 'Substractions',
@level2type = N'Column', @level2name = 'GlobalID';
GO

EXEC sp_addextendedproperty
@name = N'Column_Description',
@value = 'מספר מלא',
@level0type = N'Schema', @level0name = 'dbo',
@level1type = N'Table',  @level1name = 'Substractions',
@level2type = N'Column', @level2name = 'Name';
GO

EXEC sp_addextendedproperty
@name = N'Column_Description',
@value = 'מספר גריעה',
@level0type = N'Schema', @level0name = 'dbo',
@level1type = N'Table',  @level1name = 'Substractions',
@level2type = N'Column', @level2name = 'SubstractionNumber';
GO

EXEC sp_addextendedproperty
@name = N'Column_Description',
@value = 'מספר חלקה תלת-ממדית',
@level0type = N'Schema', @level0name = 'dbo',
@level1type = N'Table',  @level1name = 'Substractions',
@level2type = N'Column', @level2name = 'Parcel3DNumber';
GO

EXEC sp_addextendedproperty
@name = N'Column_Description',
@value = 'מספר חלקה קרקעית',
@level0type = N'Schema', @level0name = 'dbo',
@level1type = N'Table',  @level1name = 'Substractions',
@level2type = N'Column', @level2name = 'Parcel2DNumber';
GO

EXEC sp_addextendedproperty
@name = N'Column_Description',
@value = 'מספר גוש',
@level0type = N'Schema', @level0name = 'dbo',
@level1type = N'Table',  @level1name = 'Substractions',
@level2type = N'Column', @level2name = 'BlockNumber';
GO

EXEC sp_addextendedproperty
@name = N'Column_Description',
@value = 'מספר תת-גוש',
@level0type = N'Schema', @level0name = 'dbo',
@level1type = N'Table',  @level1name = 'Substractions',
@level2type = N'Column', @level2name = 'SubBlockNumber';
GO

EXEC sp_addextendedproperty
@name = N'Column_Description',
@value = 'נפח רשום במטר מעוקב',
@level0type = N'Schema', @level0name = 'dbo',
@level1type = N'Table',  @level1name = 'Substractions',
@level2type = N'Column', @level2name = 'StatedVolume';
GO

EXEC sp_addextendedproperty
@name = N'Column_Description',
@value = 'שטח היטל',
@level0type = N'Schema', @level0name = 'dbo',
@level1type = N'Table',  @level1name = 'Substractions',
@level2type = N'Column', @level2name = 'ProjectedArea';
GO

EXEC sp_addextendedproperty
@name = N'Column_Description',
@value = 'רום עליון',
@level0type = N'Schema', @level0name = 'dbo',
@level1type = N'Table',  @level1name = 'Substractions',
@level2type = N'Column', @level2name = 'UpperLevel';
GO

EXEC sp_addextendedproperty
@name = N'Column_Description',
@value = 'רום תחתון',
@level0type = N'Schema', @level0name = 'dbo',
@level1type = N'Table',  @level1name = 'Substractions',
@level2type = N'Column', @level2name = 'LowerLevel';
GO

EXEC sp_addextendedproperty
@name = N'Column_Description',
@value = 'מיקום גריעה ביחס לפני הקרקע',
@level0type = N'Schema', @level0name = 'dbo',
@level1type = N'Table',  @level1name = 'Substractions',
@level2type = N'Column', @level2name = 'RelativePosition';
GO

EXEC sp_addextendedproperty
@name = N'Column_Description',
@value = 'סוג גריעה',
@level0type = N'Schema', @level0name = 'dbo',
@level1type = N'Table',  @level1name = 'Substractions',
@level2type = N'Column', @level2name = 'SubstractionType';
GO

EXEC sp_addextendedproperty
@name = N'Column_Description',
@value = 'מזהה חלקה תלת-ממדית',
@level0type = N'Schema', @level0name = 'dbo',
@level1type = N'Table',  @level1name = 'Substractions',
@level2type = N'Column', @level2name = 'Parcel3DUniqueID';
GO

EXEC sp_addextendedproperty
@name = N'Column_Description',
@value = 'מזה חלקה קרקעית',
@level0type = N'Schema', @level0name = 'dbo',
@level1type = N'Table',  @level1name = 'Substractions',
@level2type = N'Column', @level2name = 'Parcel2DUniqueID';
GO

EXEC sp_addextendedproperty
@name = N'Column_Description',
@value = 'מזהה גוש',
@level0type = N'Schema', @level0name = 'dbo',
@level1type = N'Table',  @level1name = 'Substractions',
@level2type = N'Column', @level2name = 'BlockUniqueID';
GO

EXEC sp_addextendedproperty
@name = N'Column_Description',
@value = 'מזהה תהליך יוצר',
@level0type = N'Schema', @level0name = 'dbo',
@level1type = N'Table',  @level1name = 'Substractions',
@level2type = N'Column', @level2name = 'CreatedByRecord';
GO

EXEC sp_addextendedproperty
@name = N'Column_Description',
@value = 'מזהה תהליך מעדכן',
@level0type = N'Schema', @level0name = 'dbo',
@level1type = N'Table',  @level1name = 'Substractions',
@level2type = N'Column', @level2name = 'UpdatedByRecord';
GO

EXEC sp_addextendedproperty
@name = N'Column_Description',
@value = 'מזהה תהליך מבטל',
@level0type = N'Schema', @level0name = 'dbo',
@level1type = N'Table',  @level1name = 'Substractions',
@level2type = N'Column', @level2name = 'RetiredByRecord';
GO

EXEC sp_addextendedproperty
@name = N'Column_Description',
@value = 'סוג תהליך יוצר',
@level0type = N'Schema', @level0name = 'dbo',
@level1type = N'Table',  @level1name = 'Substractions',
@level2type = N'Column', @level2name = 'CreateProcessType';
GO

EXEC sp_addextendedproperty
@name = N'Column_Description',
@value = 'סוג תהליך מבטל',
@level0type = N'Schema', @level0name = 'dbo',
@level1type = N'Table',  @level1name = 'Substractions',
@level2type = N'Column', @level2name = 'CancelProcessType';
GO

EXEC sp_addextendedproperty
@name = N'Column_Description',
@value = 'משתמש יוצר',
@level0type = N'Schema', @level0name = 'dbo',
@level1type = N'Table',  @level1name = 'Substractions',
@level2type = N'Column', @level2name = 'created_user';
GO

EXEC sp_addextendedproperty
@name = N'Column_Description',
@value = 'תאריך יצירה',
@level0type = N'Schema', @level0name = 'dbo',
@level1type = N'Table',  @level1name = 'Substractions',
@level2type = N'Column', @level2name = 'created_date';
GO

EXEC sp_addextendedproperty
@name = N'Column_Description',
@value = 'משתמש מעדכן',
@level0type = N'Schema', @level0name = 'dbo',
@level1type = N'Table',  @level1name = 'Substractions',
@level2type = N'Column', @level2name = 'last_edited_user';
GO

EXEC sp_addextendedproperty
@name = N'Column_Description',
@value = 'תאריך עדכון אחרון',
@level0type = N'Schema', @level0name = 'dbo',
@level1type = N'Table',  @level1name = 'Substractions',
@level2type = N'Column', @level2name = 'last_edited_date';
GO

EXEC sp_addextendedproperty
@name = N'Table_Description',
@value = 'Alias: היטלי חלקות תלת-ממדיות
             
',
@level0type = N'Schema', @level0name = 'dbo',
@level1type = N'Table',  @level1name = 'ProjectedParcels3D';
GO

EXEC sp_addextendedproperty
@name = N'Column_Description',
@value = 'Object ID',
@level0type = N'Schema', @level0name = 'dbo',
@level1type = N'Table',  @level1name = 'ProjectedParcels3D',
@level2type = N'Column', @level2name = 'OBJECTID';
GO

EXEC sp_addextendedproperty
@name = N'Column_Description',
@value = 'גיאומטריה',
@level0type = N'Schema', @level0name = 'dbo',
@level1type = N'Table',  @level1name = 'ProjectedParcels3D',
@level2type = N'Column', @level2name = 'Shape';
GO

EXEC sp_addextendedproperty
@name = N'Column_Description',
@value = 'היקף גיאומטריה',
@level0type = N'Schema', @level0name = 'dbo',
@level1type = N'Table',  @level1name = 'ProjectedParcels3D',
@level2type = N'Column', @level2name = 'Shape_Length';
GO

EXEC sp_addextendedproperty
@name = N'Column_Description',
@value = 'שטח גיאומטריה',
@level0type = N'Schema', @level0name = 'dbo',
@level1type = N'Table',  @level1name = 'ProjectedParcels3D',
@level2type = N'Column', @level2name = 'Shape_Area';
GO

EXEC sp_addextendedproperty
@name = N'Column_Description',
@value = 'מזהה חלקה תלת-ממדית',
@level0type = N'Schema', @level0name = 'dbo',
@level1type = N'Table',  @level1name = 'ProjectedParcels3D',
@level2type = N'Column', @level2name = 'Parcel3DUniqueID';
GO

EXEC sp_addextendedproperty
@name = N'Column_Description',
@value = 'תקינות',
@level0type = N'Schema', @level0name = 'dbo',
@level1type = N'Table',  @level1name = 'ProjectedParcels3D',
@level2type = N'Column', @level2name = 'VALIDATIONSTATUS';
GO

EXEC sp_addextendedproperty
@name = N'Table_Description',
@value = 'Alias: היטלי גריעות
  
',
@level0type = N'Schema', @level0name = 'dbo',
@level1type = N'Table',  @level1name = 'ProjectedSubstraction';
GO

EXEC sp_addextendedproperty
@name = N'Column_Description',
@value = 'Object ID',
@level0type = N'Schema', @level0name = 'dbo',
@level1type = N'Table',  @level1name = 'ProjectedSubstraction',
@level2type = N'Column', @level2name = 'OBJECTID';
GO

EXEC sp_addextendedproperty
@name = N'Column_Description',
@value = 'גיאומטריה',
@level0type = N'Schema', @level0name = 'dbo',
@level1type = N'Table',  @level1name = 'ProjectedSubstraction',
@level2type = N'Column', @level2name = 'Shape';
GO

EXEC sp_addextendedproperty
@name = N'Column_Description',
@value = 'היקף גיאומטריה',
@level0type = N'Schema', @level0name = 'dbo',
@level1type = N'Table',  @level1name = 'ProjectedSubstraction',
@level2type = N'Column', @level2name = 'Shape_Length';
GO

EXEC sp_addextendedproperty
@name = N'Column_Description',
@value = 'שטח גיאומטריה',
@level0type = N'Schema', @level0name = 'dbo',
@level1type = N'Table',  @level1name = 'ProjectedSubstraction',
@level2type = N'Column', @level2name = 'Shape_Area';
GO

EXEC sp_addextendedproperty
@name = N'Column_Description',
@value = 'מזהה גריעה',
@level0type = N'Schema', @level0name = 'dbo',
@level1type = N'Table',  @level1name = 'ProjectedSubstraction',
@level2type = N'Column', @level2name = 'SubstractionUniqueID';
GO

EXEC sp_addextendedproperty
@name = N'Column_Description',
@value = 'תקינות',
@level0type = N'Schema', @level0name = 'dbo',
@level1type = N'Table',  @level1name = 'ProjectedSubstraction',
@level2type = N'Column', @level2name = 'VALIDATIONSTATUS';
GO

ALTER TABLE [Blocks] ADD FOREIGN KEY ([GlobalID]) REFERENCES [CadasterProcessBorders] ([BlockUniqueID])
GO

ALTER TABLE [Blocks] ADD FOREIGN KEY ([GlobalID]) REFERENCES [CadasterRecordsBorders] ([BlockUniqueID])
GO

ALTER TABLE [CPBStatusAndDates] ADD FOREIGN KEY ([CPBUniqueID]) REFERENCES [CadasterProcessBorders] ([GlobalID])
GO

ALTER TABLE [SequenceActions] ADD FOREIGN KEY ([CPBUniqueID]) REFERENCES [CadasterProcessBorders] ([GlobalID])
GO

ALTER TABLE [SequenceActions] ADD FOREIGN KEY ([CPBTempSourceID]) REFERENCES [CadasterProcessBorders] ([GlobalID])
GO

ALTER TABLE [InProcessParcels2D] ADD FOREIGN KEY ([CPBUniqueID]) REFERENCES [CadasterProcessBorders] ([GlobalID])
GO

ALTER TABLE [InProcessParcels2D] ADD FOREIGN KEY ([BlockUniqueID]) REFERENCES [Blocks] ([GlobalID])
GO

ALTER TABLE [InProcessParcels3D] ADD FOREIGN KEY ([BlockUniqueID]) REFERENCES [Blocks] ([GlobalID])
GO

ALTER TABLE [InProcessParcels3D] ADD FOREIGN KEY ([CPBUniqueID]) REFERENCES [CadasterProcessBorders] ([GlobalID])
GO

ALTER TABLE [InProcessBorderPoints] ADD FOREIGN KEY ([CPBUniqueID]) REFERENCES [CadasterProcessBorders] ([GlobalID])
GO

ALTER TABLE [InProcessBorderPoints3D] ADD FOREIGN KEY ([CPBUniqueID]) REFERENCES [CadasterProcessBorders] ([GlobalID])
GO

ALTER TABLE [InProcessFronts] ADD FOREIGN KEY ([StartPointUniqueID]) REFERENCES [InProcessBorderPoints] ([GlobalID])
GO

ALTER TABLE [InProcessFronts] ADD FOREIGN KEY ([EndPointUniqueID]) REFERENCES [InProcessBorderPoints] ([GlobalID])
GO

ALTER TABLE [InProcessFronts] ADD FOREIGN KEY ([CPBUniqueID]) REFERENCES [CadasterProcessBorders] ([GlobalID])
GO

ALTER TABLE [InProcessSubstractions] ADD FOREIGN KEY ([BlockUniqueID]) REFERENCES [Blocks] ([GlobalID])
GO

ALTER TABLE [InProcessSubstractions] ADD FOREIGN KEY ([CPBUniqueID]) REFERENCES [CadasterProcessBorders] ([GlobalID])
GO

ALTER TABLE [InProcessSubstractions] ADD FOREIGN KEY ([Parcel3DUniqueID]) REFERENCES [InProcessParcels3D] ([GlobalID])
GO

ALTER TABLE [InProcessSubstractions] ADD FOREIGN KEY ([Parcel2DUniqueID]) REFERENCES [InProcessParcels2D] ([GlobalID])
GO

ALTER TABLE [InProcessProjectedParcels3D] ADD FOREIGN KEY ([Parcel3DUniqueID]) REFERENCES [InProcessParcels3D] ([GlobalID])
GO

ALTER TABLE [InProcessProjectedSubstraction] ADD FOREIGN KEY ([SubstractionUniqueID]) REFERENCES [InProcessSubstractions] ([GlobalID])
GO

ALTER TABLE [Parcels2D] ADD FOREIGN KEY ([CreatedByRecord]) REFERENCES [CadasterRecordsBorders] ([GlobalID])
GO

ALTER TABLE [Parcels2D] ADD FOREIGN KEY ([UpdatedByRecord]) REFERENCES [CadasterRecordsBorders] ([GlobalID])
GO

ALTER TABLE [Parcels2D] ADD FOREIGN KEY ([RetiredByRecord]) REFERENCES [CadasterRecordsBorders] ([GlobalID])
GO

ALTER TABLE [Parcels2D] ADD FOREIGN KEY ([BlockUniqueID]) REFERENCES [Blocks] ([GlobalID])
GO

ALTER TABLE [Parcels3D] ADD FOREIGN KEY ([BlockUniqueID]) REFERENCES [Blocks] ([GlobalID])
GO

ALTER TABLE [Parcels3D] ADD FOREIGN KEY ([CreatedByRecord]) REFERENCES [CadasterRecordsBorders] ([GlobalID])
GO

ALTER TABLE [Parcels3D] ADD FOREIGN KEY ([UpdatedByRecord]) REFERENCES [CadasterRecordsBorders] ([GlobalID])
GO

ALTER TABLE [Parcels3D] ADD FOREIGN KEY ([RetiredByRecord]) REFERENCES [CadasterRecordsBorders] ([GlobalID])
GO

ALTER TABLE [Parcels2DFronts] ADD FOREIGN KEY ([CreatedByRecord]) REFERENCES [CadasterRecordsBorders] ([GlobalID])
GO

ALTER TABLE [Parcels2DFronts] ADD FOREIGN KEY ([UpdatedByRecord]) REFERENCES [CadasterRecordsBorders] ([GlobalID])
GO

ALTER TABLE [Parcels2DFronts] ADD FOREIGN KEY ([RetiredByRecord]) REFERENCES [CadasterRecordsBorders] ([GlobalID])
GO

ALTER TABLE [Parcels2DFronts] ADD FOREIGN KEY ([StartPointUniqueID]) REFERENCES [BorderPoints] ([GlobalID])
GO

ALTER TABLE [Parcels2DFronts] ADD FOREIGN KEY ([EndPointUniqueID]) REFERENCES [BorderPoints] ([GlobalID])
GO

ALTER TABLE [BlocksFronts] ADD FOREIGN KEY ([CreatedByRecord]) REFERENCES [CadasterRecordsBorders] ([GlobalID])
GO

ALTER TABLE [BlocksFronts] ADD FOREIGN KEY ([RetiredByRecord]) REFERENCES [CadasterRecordsBorders] ([GlobalID])
GO

ALTER TABLE [BlocksFronts] ADD FOREIGN KEY ([StartPointUniqueID]) REFERENCES [BorderPoints] ([GlobalID])
GO

ALTER TABLE [BlocksFronts] ADD FOREIGN KEY ([EndPointUniqueID]) REFERENCES [BorderPoints] ([GlobalID])
GO

ALTER TABLE [BorderPoints] ADD FOREIGN KEY ([CreatedByRecord]) REFERENCES [CadasterRecordsBorders] ([GlobalID])
GO

ALTER TABLE [BorderPoints] ADD FOREIGN KEY ([RetiredByRecord]) REFERENCES [CadasterRecordsBorders] ([GlobalID])
GO

ALTER TABLE [BorderPoints] ADD FOREIGN KEY ([UpdatedByRecord]) REFERENCES [CadasterRecordsBorders] ([GlobalID])
GO

ALTER TABLE [BorderPoints3D] ADD FOREIGN KEY ([CreatedByRecord]) REFERENCES [CadasterRecordsBorders] ([GlobalID])
GO

ALTER TABLE [BorderPoints3D] ADD FOREIGN KEY ([UpdatedByRecord]) REFERENCES [CadasterRecordsBorders] ([GlobalID])
GO

ALTER TABLE [BorderPoints3D] ADD FOREIGN KEY ([RetiredByRecord]) REFERENCES [CadasterRecordsBorders] ([GlobalID])
GO

ALTER TABLE [Substractions] ADD FOREIGN KEY ([Parcel3DUniqueID]) REFERENCES [Parcels3D] ([GlobalID])
GO

ALTER TABLE [Substractions] ADD FOREIGN KEY ([Parcel2DUniqueID]) REFERENCES [Parcels2D] ([GlobalID])
GO

ALTER TABLE [Substractions] ADD FOREIGN KEY ([BlockUniqueID]) REFERENCES [Blocks] ([GlobalID])
GO

ALTER TABLE [Substractions] ADD FOREIGN KEY ([CreatedByRecord]) REFERENCES [CadasterRecordsBorders] ([GlobalID])
GO

ALTER TABLE [Substractions] ADD FOREIGN KEY ([UpdatedByRecord]) REFERENCES [CadasterRecordsBorders] ([GlobalID])
GO

ALTER TABLE [Substractions] ADD FOREIGN KEY ([RetiredByRecord]) REFERENCES [CadasterRecordsBorders] ([GlobalID])
GO

ALTER TABLE [ProjectedParcels3D] ADD FOREIGN KEY ([Parcel3DUniqueID]) REFERENCES [Parcels3D] ([GlobalID])
GO

ALTER TABLE [ProjectedSubstraction] ADD FOREIGN KEY ([SubstractionUniqueID]) REFERENCES [Substractions] ([GlobalID])
GO

﻿CREATE TABLE [dbo].[AudibleItemMetadatas] (
    [AudibleItemMetadataID] [int] NOT NULL IDENTITY,
    [ItemTypeClassification] [nvarchar](100),
    [Title] [nvarchar](250) NOT NULL,
    [By] [nvarchar](50),
    [NarratedBy] [nvarchar](50),
    [FullShowMetadataUrl] [nvarchar](250) NOT NULL,
    [PlaybackLength] [time](7),
    [ReleaseDate] [date] NOT NULL,
    [AverageRating] [float],
    [NumberOfRatings] [int] NOT NULL,
    CONSTRAINT [PK_dbo.AudibleItemMetadatas] PRIMARY KEY ([AudibleItemMetadataID])
)
CREATE TABLE [dbo].[Genders] (
    [GenderID] [int] NOT NULL IDENTITY,
    [GenderName] [nvarchar](200) NOT NULL,
    CONSTRAINT [PK_dbo.Genders] PRIMARY KEY ([GenderID])
)
CREATE UNIQUE INDEX [UIX_Gender_GenderName] ON [dbo].[Genders]([GenderName])
CREATE TABLE [dbo].[GuestAppearances] (
    [GuestAppearanceID] [int] NOT NULL IDENTITY,
    [GuestID] [int] NOT NULL,
    [ShowMediaEntryID] [int] NOT NULL,
    [SegmentTimeStart] [bigint],
    [SegmentTimeEnd] [bigint],
    [ShowRundown_ShowRundownID] [int],
    CONSTRAINT [PK_dbo.GuestAppearances] PRIMARY KEY ([GuestAppearanceID])
)
CREATE INDEX [IX_GuestID] ON [dbo].[GuestAppearances]([GuestID])
CREATE INDEX [IX_ShowMediaEntryID] ON [dbo].[GuestAppearances]([ShowMediaEntryID])
CREATE INDEX [IX_ShowRundown_ShowRundownID] ON [dbo].[GuestAppearances]([ShowRundown_ShowRundownID])
CREATE TABLE [dbo].[Guests] (
    [GuestID] [int] NOT NULL IDENTITY,
    [LegacyGuestID] [int],
    [AlternateName] [nvarchar](200),
    [Description] [nvarchar](400),
    [TwitterHandle] [nvarchar](200),
    [WebsiteUrl] [nvarchar](400),
    [HeadshotImagePath] [nvarchar](400),
    [FirstName] [nvarchar](100) NOT NULL,
    [MiddleName] [nvarchar](max),
    [MiddleInitial] [nvarchar](max),
    [LastName] [nvarchar](150) NOT NULL,
    [FullName] [nvarchar](max),
    [GenderID] [int],
    [ShowMediaEntry_ShowMediaEntryID] [int],
    CONSTRAINT [PK_dbo.Guests] PRIMARY KEY ([GuestID])
)
CREATE INDEX [IX_Guests_FirstName] ON [dbo].[Guests]([FirstName])
CREATE INDEX [IX_Guests_LastName] ON [dbo].[Guests]([LastName])
CREATE INDEX [IX_GenderID] ON [dbo].[Guests]([GenderID])
CREATE INDEX [IX_ShowMediaEntry_ShowMediaEntryID] ON [dbo].[Guests]([ShowMediaEntry_ShowMediaEntryID])
CREATE TABLE [dbo].[ShowMediaEntries] (
    [ShowMediaEntryID] [int] NOT NULL IDENTITY,
    [ShowID] [int] NOT NULL,
    [AirDate] [datetime] NOT NULL,
    [Title] [nvarchar](400) NOT NULL,
    [Url] [nvarchar](1000),
    CONSTRAINT [PK_dbo.ShowMediaEntries] PRIMARY KEY ([ShowMediaEntryID])
)
CREATE INDEX [IX_ShowID] ON [dbo].[ShowMediaEntries]([ShowID])
CREATE UNIQUE INDEX [UIX_ShowMediaEntry_Title] ON [dbo].[ShowMediaEntries]([Title])
CREATE TABLE [dbo].[Shows] (
    [ShowID] [int] NOT NULL IDENTITY,
    [ShowName] [nvarchar](300) NOT NULL,
    CONSTRAINT [PK_dbo.Shows] PRIMARY KEY ([ShowID])
)
CREATE TABLE [dbo].[ShowHosts] (
    [ShowHostID] [int] NOT NULL IDENTITY,
    [AlternateName] [nvarchar](200),
    [Description] [nvarchar](400),
    [TwitterHandle] [nvarchar](200),
    [WebsiteUrl] [nvarchar](400),
    [HeadshotImagePath] [nvarchar](400),
    [FirstName] [nvarchar](100) NOT NULL,
    [MiddleName] [nvarchar](max),
    [MiddleInitial] [nvarchar](max),
    [LastName] [nvarchar](150) NOT NULL,
    [FullName] [nvarchar](max),
    [GenderID] [int],
    [Show_ShowID] [int],
    CONSTRAINT [PK_dbo.ShowHosts] PRIMARY KEY ([ShowHostID])
)
CREATE INDEX [IX_ShowHosts_FirstName] ON [dbo].[ShowHosts]([FirstName])
CREATE INDEX [IX_ShowHosts_LastName] ON [dbo].[ShowHosts]([LastName])
CREATE INDEX [IX_GenderID] ON [dbo].[ShowHosts]([GenderID])
CREATE INDEX [IX_Show_ShowID] ON [dbo].[ShowHosts]([Show_ShowID])
CREATE TABLE [dbo].[GuestAppearanceTypes] (
    [GuestAppearanceTypeID] [int] NOT NULL IDENTITY,
    [AppearanceTypeName] [nvarchar](150) NOT NULL,
    CONSTRAINT [PK_dbo.GuestAppearanceTypes] PRIMARY KEY ([GuestAppearanceTypeID])
)
CREATE INDEX [IX_Guests_LastName] ON [dbo].[GuestAppearanceTypes]([AppearanceTypeName])
CREATE TABLE [dbo].[ShowRundownAuthors] (
    [ShowRundownAuthorID] [int] NOT NULL IDENTITY,
    [AuthorName] [nvarchar](150) NOT NULL,
    CONSTRAINT [PK_dbo.ShowRundownAuthors] PRIMARY KEY ([ShowRundownAuthorID])
)
CREATE INDEX [IX_ShowHosts_FirstName] ON [dbo].[ShowRundownAuthors]([AuthorName])
CREATE TABLE [dbo].[ShowRundowns] (
    [ShowRundownID] [int] NOT NULL IDENTITY,
    [AirDate] [datetime] NOT NULL,
    [ShowRundownAuthorID] [int] NOT NULL,
    [DetailsUrl] [nvarchar](max),
    [Title] [nvarchar](max),
    CONSTRAINT [PK_dbo.ShowRundowns] PRIMARY KEY ([ShowRundownID])
)
CREATE INDEX [IX_ShowRundownAuthorID] ON [dbo].[ShowRundowns]([ShowRundownAuthorID])
ALTER TABLE [dbo].[GuestAppearances] ADD CONSTRAINT [FK_dbo.GuestAppearances_dbo.Guests_GuestID] FOREIGN KEY ([GuestID]) REFERENCES [dbo].[Guests] ([GuestID]) ON DELETE CASCADE
ALTER TABLE [dbo].[GuestAppearances] ADD CONSTRAINT [FK_dbo.GuestAppearances_dbo.ShowMediaEntries_ShowMediaEntryID] FOREIGN KEY ([ShowMediaEntryID]) REFERENCES [dbo].[ShowMediaEntries] ([ShowMediaEntryID]) ON DELETE CASCADE
ALTER TABLE [dbo].[GuestAppearances] ADD CONSTRAINT [FK_dbo.GuestAppearances_dbo.ShowRundowns_ShowRundown_ShowRundownID] FOREIGN KEY ([ShowRundown_ShowRundownID]) REFERENCES [dbo].[ShowRundowns] ([ShowRundownID])
ALTER TABLE [dbo].[Guests] ADD CONSTRAINT [FK_dbo.Guests_dbo.Genders_GenderID] FOREIGN KEY ([GenderID]) REFERENCES [dbo].[Genders] ([GenderID])
ALTER TABLE [dbo].[Guests] ADD CONSTRAINT [FK_dbo.Guests_dbo.ShowMediaEntries_ShowMediaEntry_ShowMediaEntryID] FOREIGN KEY ([ShowMediaEntry_ShowMediaEntryID]) REFERENCES [dbo].[ShowMediaEntries] ([ShowMediaEntryID])
ALTER TABLE [dbo].[ShowMediaEntries] ADD CONSTRAINT [FK_dbo.ShowMediaEntries_dbo.Shows_ShowID] FOREIGN KEY ([ShowID]) REFERENCES [dbo].[Shows] ([ShowID]) ON DELETE CASCADE
ALTER TABLE [dbo].[ShowHosts] ADD CONSTRAINT [FK_dbo.ShowHosts_dbo.Genders_GenderID] FOREIGN KEY ([GenderID]) REFERENCES [dbo].[Genders] ([GenderID])
ALTER TABLE [dbo].[ShowHosts] ADD CONSTRAINT [FK_dbo.ShowHosts_dbo.Shows_Show_ShowID] FOREIGN KEY ([Show_ShowID]) REFERENCES [dbo].[Shows] ([ShowID])
ALTER TABLE [dbo].[ShowRundowns] ADD CONSTRAINT [FK_dbo.ShowRundowns_dbo.ShowRundownAuthors_ShowRundownAuthorID] FOREIGN KEY ([ShowRundownAuthorID]) REFERENCES [dbo].[ShowRundownAuthors] ([ShowRundownAuthorID]) ON DELETE CASCADE
CREATE TABLE [dbo].[__MigrationHistory] (
    [MigrationId] [nvarchar](150) NOT NULL,
    [ContextKey] [nvarchar](300) NOT NULL,
    [Model] [varbinary](max) NOT NULL,
    [ProductVersion] [nvarchar](32) NOT NULL,
    CONSTRAINT [PK_dbo.__MigrationHistory] PRIMARY KEY ([MigrationId], [ContextKey])
)
INSERT [dbo].[__MigrationHistory]([MigrationId], [ContextKey], [Model], [ProductVersion])
VALUES (N'201803130158253_initial', N'opieandanthonylive.Data.Migrations.Configuration',  0x1F8B0800000000000400ED1DDB6EDCB8F5BD40FF4198A7B6C87AEC24DB4B60EFC2B1935DA3491C64EC6DDF0C7A44DBC26AA4598993B551F4CBFAD04FEA2F94D49DF7AB64B935FCE211C973C8C3C373E3E5FCE75FFF3EFCFE7E93465F6151267976B438D8DB5F44305BE77192DD1E2D76E8E69B3F2FBEFFEEB7BF397C176FEEA39FDA7AAF483DDC322B8F1677086DDF2C97E5FA0E6E40B9B749D6455EE637686F9D6F9620CE972FF7F7FFB23C3858420C62816145D1E1975D86920DAC7EE09F2779B6865BB403E9C73C8669D97CC725AB0A6AF4096C60B9056B78B4C8B70904590C327497670F69F215EE9D0204F6300C04EFD1223A4E1380BBB582E9CD22025996238070A7DF5C9670858A3CBB5D6DF107905E3C6C21AE7703D212368379D357371DD7FE4B32AE65DFB005B5DE9528DF58023C78D5106AC9367722F7A2232426E53B4C72F440465D91F36871BC8B93EB149E21B8F9081188311517118BF7CD495A903672C29FE2EA49B6D740DB13407D1149DABEE8380A331EF97B119DEC52B42BE0510677A800E98BE8F3EE3A4DD67F850F17F9CF303BCA76693A1C161E182EA33EE04F9F8B7C0B0BF4F005DEC8077B76BA889634A8250BAB83A4065353E82C43AF5E2EA24FB88B0057EA786B40CD15CA0BF803CC6001108C3F0384608159E32C86D5EC701D62D013BC04D7490ACA32B949D60D6FD4F8317BE365BB883E82FB0F30BB45777841EFE385FA3EB98771FBA5E9D36596E0558E1BA1620775682F129442059697DF9A61E128A346FBF64181D310A51AC327505413313EA6F778E8ABBBFCD7966B2E8B747A827E4EC1C33558FF5C036DF15F6049AC6BF905A61094102FDA8E0FC8FF7553CB5E1C6375036EE117CCBB64D80DB41CAF73FD7CED36D7B038BFA9DB96BA85370476B8EC05A0522CE2D519C3C24312D600E620F4EA9EB8C8B9BEE554A2ADC648FE57AD0B437116881376B044C7DB2D0405C0068A0F4BD09066C11B74979C9884073119B710D47A846A20B53C8E138067BE78F086066F37B8F34424AE1028D000DA1F5F5B347E97C5EAA69FC0D7E4B6A2A288288B08CBEAAAB4BC4BB6B51D5CF3DF15196F3F5D587ABE2FF2CD973C6D9BB215AE2E40710BC9407255AD55BE2BD63C79A4DDA4C92EEF6F8FE38A6DC2745C5AB3EB1B350279F576C0EEE2C25748CC4634380B8429C5C007780BD60F62B41A2324259830D2401A478DED1496EB22D96A8CF5D7618CF55F1342C51F310FA98DF620D8FE06AFCB0441B5391B66603F42109777393ADB60EB11B3CADDE818DF274589340C62EA61596A938F498CA74F831BFF1B609435AAB32C215191D1B17D007A928EE3FD10176C12824A8C676335DE3820523DDE5660D577FD5DACF3DA429186D3296BCA6608675D88FB29B3419C54326B3738EB661AD01C94346FBCDA6A6B5BF3379CDA26987DCDEDE3A408128DD0C5B64C3589255AB5C2C44AC5497FA95D03DD3A668C61BE4DBFA23555B9B5ADABEF22964CC650D793F69BFCD4F5B5AAE32D853C65CF5C248EAB9C995ABA68F4FCAB408B5ACA9F3FE625922FB2ABA698E6CBFAAB901D9B226F2E24603C399180980B3792BEB87264DB762AAE7C76389F1DCE6787F3D9E17C5A0E672B29053E275324D45BC372FFD86A6F30929270DB31A4CD1C549AA05B01B6655A3093293A0AF3142BCFCA04FAB2CBE2FCD7EC7887A7D96797978335070EE23AE56A1D714026E39E0AE35CB9260CBFCC8C533C796452EE0814F47160719DBD8D4092966AAB348CB2D705AC1CB1E843479AC85143CF2BAE3E6D3248AA09CD07595D97681123F7358310B4100F83ABA81C085FDBC62A3A2ECB7C9D54DD1ECE4D6B9BD1C47897C5916A73A0669F2E7C8F59084B9A648B650BC67CB4F803475D09C0EE8CC00060632BD210F7F7F60E38A05820C182AC7D909EE0C9C0222EC9102FBD926C9D6C41AAC0CFB4B13A0E4528DEE1604B4EE19634CB90829ABEC83B1C8C14D651E770396009134E61F768D4332CDDB0D1F0CE014B90C3F3EC14A610C1E8785D9F853E01E51AC4BC14C29C1FDB754AC47FECB92D1D6B7B70A18446461C213E66E1C08D129A78766202AED4ED38C858C178FBA1670A762BD0403899E39331A186F52C293574C4553D157AE53425EA40B0B9C89739F3134A7D49172613FC12CA3E01D93FD87250CD2FBBFF40738CC38A61762DEC59D05D92543D365CCDF426A0A9C4D0AD16D90EA286AC4175A7F33A9374DE84D7C5BB84D62B4D323F7E3D98CACE929F5C55DA3606C7583D8C1C6364124E952F85C7E759B31199328FEA588DBD75A69DD550DD9A4893C8FC7C9530D43AFD34AB75D1366B95A38B18382F204722F1710493DE2B820A4684D2E9267D38428CA70D85CC6DF91B8DC9749969E2E7D69A4C3BA9013B165C04D4812872B71AB78045D39B93BC80DD7D6B2E227E59C226285E36B146961709CC1544F23BB5E522EA43600D1F0AAF2B736C4E83AE0D6F11B4D65BD101E0CEC0F19058396202520A48DB9CD20489B047ACB63680280363D4B839CD2404505BF97654AE58474FE97A13D8A07FD4C29175941171E660350039508395C650A0DB641F54111DFC6697BD26D4DBF5BDE73D4E726882BB4310ED926245393D2EE33173C7C6658357C62E2DA2972EE490051D5958D440BC09A43D8FCB93CA2AA0E614521B0C9917450A429A86D0B4D3E34848EA148B9870D2F89A51848D214C2314351411C5D446596CC363A7E2D18B2244BA18113366FD7899909009CDFC174EADC8B48B858F1919478D022D0A2A50A4A3ADABC4555CAB95885EC370864B40C34280BA84302CE6C591CDA4BBDE627633729EADDD676698BD61A2613D9DB73CBE7A53ECB7AB09A871AC1D5C6B5F22CA9D6931E4CE1C3526647B2EA073C7BAB2C365FD5056F3E170297951EBF023D86EC9CB297DCBE64BB4AA9FD73AF96665FFD4D4A686B15C538CCC3A8F1D269493F75F9852E255C6B03A004D8E425D037264E524DE08AAF5CEA7C4486F3129FC4B7E4E5B13BE6DDC9E5ED43E3926F44C79A7BE81FB1E8F9D3CF55091010E58C3084A449E44032928CCDEA53AC9D3DD26535661B95B8E43F6F8D41089AC8E3996E678D31068F3C91C0679CE6908E02DE704AB5A0F1F851A42197E3787267CF869085658C11C3EFBA6D310345B660E957AEF6908922A3087C7BCF944F1255D64314FEC6350D464B1853CDCC325B324B9701A2714B8E8252D708CC4516BD387944062A7C540E8C81ACA68DEEF640F892DDFDFD641AA0FFAF2B0EAEFF39933BD1FED31794C00D161167510A493C0BFE044CD85EE8D282D6C21443B38FCD6D710A07E634C01997BB18982CC953A41AE9E7392C0ADCAE6C5E423B0B62B435BB2710056639E131A42638A2C341F7DEF93D27C7491394CEA76E7102255606173D1373829DB8B2E328739BCA7390438FC6E0E4D7015730854506C61A1F5972E29BBACFF6C0E6B788B72086CF8DD165A77519207D81559F038100DB6FF6A67D90AC8D67DB5B5056CAC8A4712915C1029A4B054C7D60CA4A60EC02368D8E628160BCF5284B6B77E28E1D97E9CD6B5E4E49944903D228386E74A475EB4E3407F3E212D7881D47F9DD52CC9765BFC66AADA6E779B2D715315ADDB2734586A8B9FE550417B36929E8DA46723490DE9C91849C2D33C23064CAA7340DE41133114C3C049FBC6822278227ECD418543F49002251905E5B36102C14657685DA7DCFE33547A1A182AEDC71DC764D5A0F6BCA662EA07AF20D07B38FDF7394EF56893EC37BD4E13AB98D2C7715FC666BAE11B06B4BDD47F1FC7D91A9B71E91D75854B2F3A64E7EAC00B40198539C9F102A5832E3D9BC7D3D5DBDDBFE22BF3A7CE071DF61F8BF4B47E80C8AFB2AB7816E3A4BAC6715692D73FBA77333CA8C31EE670E2CEF6D89E1D23B6AD4C5D3DC954D107FE2C384CC45757329FDE8187E89384161DB3F55AC3308D64E84118447A06CD49D5F2602CB71B2513A639C46631837A057DA551D60EFCA6392B6723AFBC365CC3B0A3119DF4CCC99D4863AB749ABDF9D2FDEE4EA435A7C1F4891FB9E3617595458489F13589C9D1B0D54389E0A6E6ECD52FE9499A605BA2AFF01164C90D2670FD72D6E2E5FEC14B265DE47C52372ECB32A61EF672CDDF7896C5F0FE68F18FE89F734D9B989039D23E0C66F920973A5362F61514EB3B50F00FABF668ACDFE21202AD32F939E73D1482FCD6BA9B7C9AC3408015590D8351439CB41055CFBE7D2EE03AA953D2FEC9B6EF82948671F57F88748637690E90F53489B31B56EB63E4DC867E52225C9EC15164019F5AB0674E392548FD37D1E5D9DFDBFB393D981758BD5E66C92F3B5CE1024F2CA61AF7D0F55429083D676EC42C80E3CC259DEBABC2A19B43328575B317D17981E7F04DB44FA62C50BA40D33EB0EDFD3A23C936789DDC32F2C244F288D30F3AC2929B97F6F4120292118EEF9D77EEBE00AB2B4022BD51569230779EC37C0B131B88B5BFBD8125C8632004FDDAC17613A52D08D56F3E4B41A86E4B93128442C0E520305796ADA02DAF3A208C6A3CD0AA46BE437C6682B647BFDB80FBDFDB8E4F987DC00B229B61C085602D0C965E0E06339B76C06B6C4203CD64584D3B7359AD53B88260AB8FFE3556C71E5A85BD5F1B58BDE8A3CFAE29E04651386D04D47ED63C6D25E6D570E2E521EF5471762E047B3F9940D27811AF1D44A54EDFD479E582F1F6281CED9F626C34EED55A38AFC2797EDD3ECD18340E97386B145A3F9B9402E0FFB72665775AF6D9AA74A0D9B36129166357EEE688C626F10D43B02F9C8D1BF2139F4BF4CC32358E569026969AD4E10A9A6DCA5F958F99EE699C69E4323C85D606A34CE19893172C03D3381316C87DD2319A5D48B805E1E519F2699BBC749AD0413480143AE14FB3CB57F7C3363903F3C8964BAA20B737BC656F5898EF3746D68F733F85F40D0EA97B1E3747CF70BF92EDC7B06CBCB43CD3E6DF51BEDD6185F7C9A4DC09975A675A21A3BD636D1F651D49E8389CC39E887B4CD2108552417D148CE137B304464F421129EEEDCE4E170D4E96ABA62C44F6A0A9A75D72D1DD34483DDE946B4ECE4FAF33784AD94EFF48D687B38E7AA22CE4A0C99E5A6224E729FD9F35706761C2589ABC33B25E3CD21705CA53340F16925FACB50C554DC23CC6F77A26E622CD1D72311FB5D16031374D9064C98BBBC3F3A0F406BF53C4DB5A8B3AAE8459E461625FCC66E799CE5A23BC31D4871E8F148996EACB56478BF83AC78C520732C5899B38B9C7E4FA69DC400E6D5B20C224CB83C10167C5278F85AD2144A77BEC5E88579ED2498A430F99357238146C05112EAA8E28F78108AB3423940C8319D8DA831382AE8B64E0C5C941341C50EFA0EAB8A0AE65C009A4A2D93019612E1C2F534736704DBE0005765D662A0D461ED7A8B9AB28C1307C9D9A17B05CF890BD9DACBBCA6A3C2C36EC1E2A3D95BECB6A9B51711DDB7FE8BA18F18889A7E4395B04AFEE4FC2076CC8D32B79941B93B372937EC821CC10032487E2BAF7E8831A250994FD309DD87BDEF99D02AEDA49C5DA94F99A64997F664A128149324A0E26DA26923CC5A65B5296240E9355897FAB02BB74BB8C9C86A97F9DC232B9ED4190F73832B8A69CB9AECE597693B70E26D3A3B60A7BC6B471B28E0B94DC8035C2C59817CBEADAF94F20DDE12AEF36D7303ECBCE7768BB4378C870739D524B90F8A62AFC55EA28BACF87E7D561E932C4107037137280E83C7BBB4BD2B8EBF77BC1212D0908E2F436A79BC85C2272CAE9F6A183F429CF0C0135E4EB7CF50BB8D9A61858799EADC057E8D2B7CB12D6D72ADB2747E440F4134193FDF03401B705D8940D8CBE3DFE897938DEDC7FF75FBD6D598BD1B70000 , N'6.2.0-61023')


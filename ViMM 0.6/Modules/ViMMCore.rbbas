#tag ModuleProtected Module ViMMCore	#tag Method, Flags = &h0		Function Articulator(ItemName as String, ItemYear as String = "") As String		  Dim b as Boolean = ItemYear <> ""		  		  // Filter out year		  If ItemName.Right(7) = " (" + ItemYear + ")" then		    ItemName = ItemName.Left( ItemName.Len - 7 )		  ElseIf ItemName.Right(5) = " " + ItemYear then		    ItemName = ItemName.Left( ItemName.Len - 5 )		  End If		  		  // English		  If ItemName.Left(4) = "The " then ItemName = ItemName.Right( ItemName.Len - 4 ) + ", The "		  If ItemName.Left(2) = "A "   then ItemName = ItemName.Right( ItemName.Len - 2 ) + ", A "		  If ItemName.Left(3) = "An "  then ItemName = ItemName.Right( ItemName.Len - 3 ) + ", An "		  		  // Nederlands		  If ItemName.Left(4) = "Het " then ItemName = ItemName.Right( ItemName.Len - 4 ) + ", Het "		  If ItemName.Left(3) = "De "  then ItemName = ItemName.Right( ItemName.Len - 3 ) + ", De "		  If ItemName.Left(4) = "Een " then ItemName = ItemName.Right( ItemName.Len - 4 ) + ", Een "		  		  If b then		    Return Trim( ItemName + " (" + ItemYear + ")" )		  Else		    Return Trim( ItemName )		  End If		End Function	#tag EndMethod	#tag Method, Flags = &h0		Function FindImageBanner(BannerParent as FolderItem) As FolderItem		  For i as Integer = 1 to BannerParent.Count		    If   BannerParent.Item(i).Type = "image/jpg" or _		      BannerParent.Item(i).Type = "image/png" or _		      BannerParent.Item(i).Type = "image/tbn" then		      If BannerParent.Item(i).Name.InStr( -1, "banner" ) > 0 then Return BannerParent.Item(i)		    End If		  Next		  		  Return Nil		End Function	#tag EndMethod	#tag Method, Flags = &h0		Function FindImageFanart(FanartParent as FolderItem) As FolderItem		  For i as Integer = 1 to FanartParent.Count		    If   FanartParent.Item(i).Type = "image/jpg" or _		      FanartParent.Item(i).Type = "image/png" or _		      FanartParent.Item(i).Type = "image/tbn" then		      If FanartParent.Item(i).Name.InStr( -1, "fanart" ) > 0 then Return FanartParent.Item(i)		    End If		  Next		  		  Return Nil		End Function	#tag EndMethod	#tag Method, Flags = &h0		Function FindImagePoster(PosterParent as FolderItem) As FolderItem		  Dim MovieName as String		  Dim MovieItem as FolderItem = FindMovieItem( PosterParent )		  Dim Item as FolderItem		  		  If MovieItem <> Nil then MovieName = MovieItem.NameWithoutExtension		  		  For i as Integer = 1 to PosterParent.Count		    Item = PosterParent.Item(i)		    If   Item.Type = "image/jpg" or _		      Item.Type = "image/png" or _		      Item.Type = "image/tbn" then		      		      If   Item.Name.InStr( -1, "poster" ) > 0 or _		        Item.Name.Left(5) = "movie" or _		        Item.Name.Left(6) = "folder" or _		        Item.NameWithoutExtension = MovieName then		        Return Item		      End If		      		    End If		    Item = Nil		  Next		  		  Return Nil		End Function	#tag EndMethod	#tag Method, Flags = &h0		Function FindMovieItem(MovieParent as FolderItem) As FolderItem		  Dim MovieFile as FolderItem		  		  For i as Integer = 1 to MovieParent.Count		    MovieFile = MovieParent.Item(i)		    		    If MovieParent.Item(i).Type = "video/any" then		      		      If MovieFile <> Nil And MovieFile.Visible = True And NOT MovieFile.Directory And _		        MovieFile.Name.InStr( -1, "trailer" ) = 0 And _		        MovieFile.Name.InStr( -1, "sample" )  = 0 And _		        MovieFile.Name.InStr( -1, "[Bonus" )  = 0 then		        Return MovieFile		      End If		      		    End If		    		    If MovieFile.Name = "VIDEO_TS" then Return MovieParent.Item(i)		    		  Next		  		  Return Nil		End Function	#tag EndMethod	#tag Method, Flags = &h0		Function FindMovieName(MovieParent as FolderItem, Filter as Boolean = False, UseFileName as Boolean = False) As String		  Dim MovieFile as FolderItem = FindMovieItem( MovieParent )		  Dim MovieName as String		  		  If MovieFile = Nil then MovieFile = MovieParent		  If MovieFile = Nil or NOT MovieFile.Exists then Return ""		  		  If UseFileName then		    If MovieFile.Name = "VIDEO_TS" then MovieName = MovieParent.name Else MovieName = MovieFile.NameWithoutExtension		  Else		    MovieName = MovieParent.Name		  End If		  		  If Filter then		    Dim i as Integer = -1		    		    i = MovieName.InStr( -1, "720p" )		    If i <= 0 then i = MovieName.InStr( -1, "1080p" )		    If i <= 0 then i = MovieName.InStr( -1, "xvid"  )		    If i <= 0 then i = MovieName.InStr( -1, "divx"  )		    If i <= 0 then i = MovieName.InStr( -1, "x264"  )		    If i <= 0 then i = MovieName.InStr( -1, "AC3"   )		    If i <= 0 then i = MovieName.InStr( -1, "DTS"   )		    If i  > 0 then MovieName = MovieName.Left( i - 1 )		    		    MovieName = MovieName.ReplaceAll( ".", " " )		    		    MovieName = MovieName.ReplaceAll( "x264", "" )		    MovieName = MovieName.ReplaceAll( "AC3",  "" )		    MovieName = MovieName.ReplaceAll( "DTS",  "" )		    		    MovieName = MovieName.ReplaceAll( "xvid", "" )		    MovieName = MovieName.ReplaceAll( "divx", "" )		    		    MovieName = MovieName.ReplaceAll( "DVD-Rip",    "" )		    MovieName = MovieName.ReplaceAll( "BR-Rip",     "" )		    MovieName = MovieName.ReplaceAll( "BluRay-Rip", "" )		    MovieName = MovieName.ReplaceAll( "-Rip",       "" )		    		    MovieName = MovieName.ReplaceAll( "DVDrip",  "" )		    MovieName = MovieName.ReplaceAll( "DVD rip", "" )		    MovieName = MovieName.ReplaceAll( "DVD",     "" )		    MovieName = MovieName.ReplaceAll( "BluRay",  "" )		    MovieName = MovieName.ReplaceAll( "brrip",   "" )		    MovieName = MovieName.ReplaceAll( "bdrip",   "" )		    MovieName = MovieName.ReplaceAll( "460p",    "" )		    MovieName = MovieName.ReplaceAll( "720p",    "" )		    MovieName = MovieName.ReplaceAll( "1080p",   "" )		    		    MovieName = MovieName.ReplaceAll( "unrated",        "" )		    MovieName = MovieName.ReplaceAll( "uncut",          "" )		    MovieName = MovieName.ReplaceAll( "Directors Cut",  "" )		    MovieName = MovieName.ReplaceAll( "Director's Cut", "" )		    MovieName = MovieName.ReplaceAll( "Extended Cut",   "" )		    		    MovieName = MovieName.ReplaceAll( "()", "" )		    		    If MovieName.Left(1)  = "[" then MovieName = MovieName.Right( MovieName.Len - MovieName.InStr( -1, "]") - 1 )		    If MovieName.Right(1) = "]" then MovieName = MovieName.Left(  MovieName.Len - MovieName.InStr( -1, "[") - 1 )		    		    While MovieName.InStr( -1, "  " ) > 0		      MovieName = MovieName.ReplaceAll( "  ", " " )		    Wend		    		    MovieName = Titlecase( MovieName )		  End If		  		  Return Trim( MovieName )		End Function	#tag EndMethod	#tag Method, Flags = &h0		Function FindNFOFile(NFOParent as FolderItem) As FolderItem		  Dim MovieName as String		  Dim MovieItem as FolderItem = FindMovieItem( NFOParent )		  		  If MovieItem <> Nil and MovieItem.Exists then MovieName = MovieItem.NameWithoutExtension		  If MovieItem.Name = "VIDEO_TS" then NFOParent = MovieItem		  		  For i as integer = 1 to NFOParent.Count		    If NFOParent.Item(i).Type = "special/nfo" then		      If   NFOParent.Item(i).Name = "movie.nfo" or _		        NFOParent.Item(i).Name = "tvshow.nfo" or _		        NFOParent.Item(i).Name = "VIDEO_TS.nfo" or _		        NFOParent.Item(i).Name = MovieName + ".nfo" then		        Return NFOParent.Item(i)		      End If		    End If		  Next		  		  Return Nil		End Function	#tag EndMethod	#tag Method, Flags = &h0		Function FindSubtitle(SubtitleParent as FolderItem) As FolderItem		  		  For i as Integer = 1 to SubtitleParent.Count		    If SubtitleParent.Item(i).Type = "special/subtitle" then Return SubtitleParent.Item(i)		  Next		  Return Nil		End Function	#tag EndMethod	#tag Method, Flags = &h0		Function FindTrailerItem(TrailerParent as FolderItem) As FolderItem		  If TrailerParent = Nil or NOT TrailerParent.Exists then Return Nil		  For i as Integer = 1 to TrailerParent.Count		    If TrailerParent.Item(i).Name.InStr( 0, "trailer" ) > 0 then Return TrailerParent.Item(i)		  Next		  Return Nil		End Function	#tag EndMethod	#tag Method, Flags = &h0		Function FlagLanguage(Language As String) As String		  select case language		    		    // Full length language name to abbriviation		  case "English"		    Return "en"		  case "Nederlands"		    Return "nl"		  case "Dansk"		    Return "da"		  case "Suomeksi"		    Return "fi"		  case "Deutsch"		    Return "de"		  case "Italiano"		    Return "it"		  case "Español"		    Return "es"		  case "Français"		    Return "fr"		  case "Polski"		    Return "pl"		  case "Magyar"		    Return "hu"		  case "Ελληνικά" // Greece		    Return "el"		  case "Türkçe" // Turkish		    Return "tr"		  case "русский язык" // Russian		    Return "ru"		  case "עברית" // Hebrew		    Return "he"		  case "日本語" // Japanese		    Return "ja"		  case "Português"		    Return "pt"		  case "中文" // Chinese / Mandarin		    Return "zh"		  case "čeština"		    Return "cs"		  case "Slovenski"		    Return "sl"		  case "Hrvatski"		    Return "hr"		  case "한국어" // Korean		    Return "ko"		  case "Norsk"		    Return "no"		    		    // And in reverse!		  case "en"		    Return "English"		  case "nl"		    Return "Nederlands"		  case "da"		    Return "Dansk"		  case "fi"		    Return "Suomeksi"		  case "de"		    Return "Deutsch"		  case "it"		    Return "Italiano"		  case "es"		    Return "Español"		  case "fr"		    Return "Français"		  case "pl"		    Return "Polski"		  case "hu"		    Return "Magyar"		  case "el" // Greece		    Return "Ελληνικά"		  case "tr" // Turkish		    Return "Türkçe"		  case "ru" // Russian		    Return "русский язык"		  case "he" // Hebrew		    Return "עברית"		  case "ja" // Japanese		    Return "日本語"		  case "pt"		    Return "Português"		  case "zh" // Chinese / Mandarin		    Return "中文"		  case "cs" // Czech		    Return "čeština"		  case "sl"		    Return "Slovenski"		  case "hr"		    Return "Hrvatski"		  case "ko" // Korean		    Return "한국어"		  case "no"		    Return "Norsk"		    		  end Select		End Function	#tag EndMethod	#tag Method, Flags = &h0		Function icon(Extends f as FolderItem, size as Integer) As Picture		  Dim pic as Picture		  If f <> nil and f.Exists then		    pic      = f.IconImageMBS ( size )		    pic.Mask = f.IconMaskMBS  ( size )		    Return pic		  Else		    Return Nil		  End If		End Function	#tag EndMethod	#tag Method, Flags = &h0		Function Int2Month(Month as Integer) As String		  Select case Month		    		  case 1		    Return "Jan"		  case 2		    Return "Feb"		  case 3		    Return "Mar"		  case 4		    Return "Apr"		  case 5		    Return "May"		  case 6		    Return "Jun"		  case 7		    Return "Jul"		  case 8		    Return "Aug"		  case 9		    Return "Sep"		  case 10		    Return "Okt"		  case 11		    Return "Nov"		  case 12		    Return "Dec"		    		  end select		End Function	#tag EndMethod	#tag Method, Flags = &h0		Sub MassMovies2Folders(LstBox as Listbox)		  Dim FileLocation, Paths() as FolderItem		  Dim FolderName as String		  		  If LstBox = wndMain.lstMovies then		    Dim Dict as Dictionary = Prefs.dictionaryForKey("MoviePaths")		    		    // Get Movie Paths		    If Dict = Nil then Return		    For Each Key as Variant in Dict.Keys		      Paths.Append GetFolderItem( Trim( Dict.Value( Key ) ) )		    Next		    If Paths.Ubound = -1 then Return		    		    // Get Movie Items		    For f as Integer = 0 to Paths.Ubound		      		      If Paths(f).Exists then		        For i as Integer = 1 to Paths(f).Count		          If Paths(f).Item(i).Type = "video/any" then		            FileLocation = Paths(f).Item(i)		            		            FolderName = FileLocation.NameWithoutExtension		            // FolderName = FolderName.ReplaceAll( ".", " " )		            Paths(f).Child( FolderName ).CreateAsFolder		            FileLocation.MoveFileTo Paths(f).Child( FolderName )		            		          End If		        Next		      End If		      		    Next		    		    wndMain.lstMovies.CreateList		    // TODO: Sort TV Show episodes.		    		  End If		  		  		  		End Sub	#tag EndMethod	#tag Method, Flags = &h0		Sub MassRenamer(LstBox as Listbox)		  If NOT dlgWindow( Localizable.kWarning, msgMassRename + chr(13) + Localizable.kCantBeUndone, "Rename" ) then Return		  		  Dim FolderName, Title, TitleOriginal, TitleSort, Year, Quality as String		  Dim Location, Destination, NFOFile as FolderItem		  		  For i as Integer = 0 to LstBox.ListCount - 1		    		    Location    = GetFolderItem( LstBox.Cell( i, 1 ) )		    Destination = GetFolderItem( LstBox.Cell( i, 1 ) ).Parent		    		    NFOFile = FindNFOFile( Location )		    		    If NFOFile <> Nil and NFOFile.Exists then		      		      Select Case wndMain.ppMain.Value		        		      Case 0		        MovieAttr.NFORead( Location )		        FolderName = Prefs.textStringForKey("RenameStringMovies")		        		        Title = MovieAttr.Title		        TitleSort = MovieAttr.TitleSort		        TitleOriginal = MovieAttr.TitleOriginal		        Year = str( MovieAttr.DateYear )		        Quality = LstBox.Cell( i, 6 )		        		      case 1		        		        		      case 2		        		        		      End Select		      		      FolderName = FolderName.ReplaceAll( "$T", Title )		      FolderName = FolderName.ReplaceAll( "$S", TitleSort )		      FolderName = FolderName.ReplaceAll( "$O", TitleOriginal )		      FolderName = FolderName.ReplaceAll( "$Q", Quality )		      FolderName = FolderName.ReplaceAll( "$Y", Year )		      		      If FolderName.Left(1) = "." then FolderName = FolderName.Replace(".", "•")		      FolderName = FolderName.ReplaceAll( ":",  "" )		      FolderName = FolderName.ReplaceAll( "()", "" )		      FolderName = FolderName.ReplaceAll( "[]", "" )		      FolderName = FolderName.ReplaceAll( "{}", "" )		      		      // Not supported in windows		      #If NOT TargetMacOS then		        FolderName = FolderName.ReplaceAll( "\",  " - " )		        FolderName = FolderName.ReplaceAll( "/",  " - " )		        FolderName = FolderName.ReplaceAll( "*",  "x"   )		        FolderName = FolderName.ReplaceAll( "?",  ""    )		        FolderName = FolderName.ReplaceAll( """", "'"   )		        FolderName = FolderName.ReplaceAll( "<",  "}"   )		        FolderName = FolderName.ReplaceAll( ">",  "{"   )		        FolderName = FolderName.ReplaceAll( "|",  " "   )		        FolderName = FolderName.ReplaceAll( "  ", " "   )		      #EndIf		      		      FolderName = Trim( FolderName )		      		      If FolderName <> "" And _		        Location    <> Nil And Location.Exists And _		        Destination <> Nil And Destination.Exists then		        Destination = Destination.Child( FolderName )		        Location.MoveFileTo( Destination )		      End If		      		    End If		    		    FolderName = ""		    		  Next		  		  If LstBox = wndMain.lstMovies then		    wndMain.lstMovies.CreateList		  End If		End Sub	#tag EndMethod	#tag Method, Flags = &h0		Function MediaInfo(VideoFile as FolderItem, Full as Boolean = False) As String		  // Download latest version:		  // http://mediainfo.sourceforge.net/en/Download/Mac_OS		  		  #If TargetMacOS then		    Dim MediaInfo As FolderItem = app.ExecutableFile.Parent.Parent.Child("Resources").Child("mediainfo")		    If MediaInfo <> Nil and MediaInfo.Exists and _		      VideoFile <> Nil And VideoFile.Exists then		      Dim i as integer = Ticks		      Dim sh As New Shell		      If Full then		        sh.Execute( MediaInfo.ShellPath + " --output=XML --Full " + VideoFile.ShellPath )		      Else		        sh.Execute( MediaInfo.ShellPath + " --output=XML " + VideoFile.ShellPath )		      End If		      if App.DebugMode then		        		      end if		      Return sh.Result		    End If		  #EndIf		  		  Return ""		End Function	#tag EndMethod	#tag Method, Flags = &h0		Function Minutes2Hours(Extends TotalMinutes as Integer) As String		  Dim Hours   as Integer = Floor( TotalMinutes / 60 )		  Dim Minutes as Integer =        TotalMinutes - ( Hours * 60 )		  		  Dim strRuntime as String		  		  If TotalMinutes >= 60 and TotalMinutes < 120 then		    strRuntime = str( Hours ) + Localizable.kHourAnd  + str( Minutes ) + Localizable.kMinutes		  ElseIf TotalMinutes >= 120 then		    strRuntime = str( Hours ) + Localizable.kHoursAnd + str( Minutes ) + Localizable.kMinutes		  Else		    strRuntime = str( TotalMinutes ) + Localizable.kMinutes		  End If		  		  Return strRuntime		End Function	#tag EndMethod	#tag Method, Flags = &h0		Function MPAA2Logo(MPAA As String) As Picture		  select case MPAA		    		  case "Rated G"		    Return Rating_G		  case "Rated PG"		    Return Rating_PG		  case "Rated PG-13"		    Return Rating_PG13		  case "Rated NC-17"		    Return Rating_NC17		  case "Rated R"		    Return Rating_R		    		  case "Rated TV-G"		    Return Rating_TVG		  case "Rated TV-PG"		    Return Rating_TVPG		  case "Rated TV-14"		    Return Rating_TV14		  case "Rated TV-MA"		    Return Rating_TVMA		    		  case "Rated TV-Y7"		    Return Rating_TVY7		  case "Rated TV-Y"		    Return Rating_TVY		  case "Rated TV-Y7FV"		    Return Rating_TVY7FV		    		  end select		End Function	#tag EndMethod	#tag Method, Flags = &h0		Function MPAA2Ratings(MPAA as String) As String		  select case MPAA		    		  case "Rated G"		    Return "General Audiences. All ages admitted"		    		  case "Rated PG"		    Return "Parental Guidance Suggested. Some material may not be suitable for children"		    		  case "Rated PG-13"		    Return "Parents Strongly Cautioned. Some material may not be appropriate for children under 13"		    		  case "Rated R"		    Return "Restricted. Under 17 requires accompanying parent or adult guardian"		    		  case "Rated NC-17"		    Return "No One 17 and under admitted"		    		  case "NR"		    Return "Unrated"		    		  end select		End Function	#tag EndMethod	#tag Method, Flags = &h0		Function PriorArtFound(FolderParent as FolderItem) As Boolean		  Dim Poster, Fanart, Banner, ClearArt, CharacterArt, Logo, TVThumb as Boolean		  		  Poster = FindImagePoster( FolderParent ) <> Nil		  Fanart = FindImageFanart( FolderParent ) <> Nil		  Banner = FindImageBanner( FolderParent ) <> Nil		  		  ClearArt     = FolderParent.Child( "clearart.png" ).Exists		  CharacterArt = FolderParent.Child( "character.png" ).Exists		  Logo         = FolderParent.Child( "logo.png" ).Exists		  TVThumb      = FolderParent.Child( "landscape.jpg" ).Exists		  		  If Poster or Fanart or Banner or ClearArt or CharacterArt or Logo or TVThumb then		    Return True		  Else		    Return False		  End If		End Function	#tag EndMethod	#tag Method, Flags = &h0		Sub Progress(Action as String, Description as String = "", Value as Integer = 0, Max as Integer = 0)		  If Action = "close" then		    wndProgress.Close		    Return		  End If		  		  wndProgress.lblAction.Text      = Action		  wndProgress.lblDescription.Text = Description		  		  If Max <= 0 then		    wndProgress.pgBar.Maximum = 0		    wndProgress.pgBar.Value   = 0		  Else		    wndProgress.pgBar.Maximum = Max		    wndProgress.pgBar.Value   = Value		  End If		End Sub	#tag EndMethod	#tag Method, Flags = &h0		Function VideoFileExtension(Extends VideoFile as FolderItem) As String		  If VideoFile = Nil then Return ""		  		  Dim XMLContent as String = MediaInfo( VideoFile, True )		  		  If XmlContent = "" then Return ""		  		  Dim Xml as new XmlDocument		  Dim xroot, xnode as XmlNode		  		  Xml.PreserveWhitespace = False		  Xml.LoadXml XmlContent		  		  xroot = XML.FirstChild.FirstChild.FirstChild		  		  For i as Integer = 0 to xroot.ChildCount - 1		    		    xnode = xroot.Child(i)		    		    If xnode.FirstChild <> Nil and xnode.Name = "Codec_Extensions_usually_used" then		      		      Dim Extensions() as String = xnode.FirstChild.Value.Split( " " )		      		      Return "." + Extensions(0)		    End If		    		  Next		End Function	#tag EndMethod	#tag Constant, Name = msgMassRename, Type = String, Dynamic = True, Default = \"Are you sure you want to mass rename your folders\?", Scope = Protected		#Tag Instance, Platform = Any, Language = en, Definition  = \"Are you sure you want to mass rename your folders\?"		#Tag Instance, Platform = Any, Language = nl, Definition  = \"Weet je zeker dat je all je folders wilt hernoemen\?"	#tag EndConstant	#tag ViewBehavior		#tag ViewProperty			Name="Index"			Visible=true			Group="ID"			InitialValue="-2147483648"			InheritedFrom="Object"		#tag EndViewProperty		#tag ViewProperty			Name="Left"			Visible=true			Group="Position"			InitialValue="0"			InheritedFrom="Object"		#tag EndViewProperty		#tag ViewProperty			Name="Name"			Visible=true			Group="ID"			InheritedFrom="Object"		#tag EndViewProperty		#tag ViewProperty			Name="Super"			Visible=true			Group="ID"			InheritedFrom="Object"		#tag EndViewProperty		#tag ViewProperty			Name="Top"			Visible=true			Group="Position"			InitialValue="0"			InheritedFrom="Object"		#tag EndViewProperty	#tag EndViewBehaviorEnd Module#tag EndModule
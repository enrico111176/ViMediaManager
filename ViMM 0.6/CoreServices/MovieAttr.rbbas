#tag ModuleProtected Module MovieAttr	#tag Method, Flags = &h1		Protected Sub ClearProperties()		  ReDim ActorName(-1)		  ReDim ActorRole(-1)		  ReDim ActorThumbURL(-1)		  		  ART_Poster     = Nil		  ART_Fanart     = Nil		  ART_Studio     = Nil		  ART_MPAARating = Nil		  		  ReDim ART_PosterURLs(-1)		  ReDim ART_FanartURLs(-1)		  ReDim Art_FanartThumbURLs(-1)		  		  ReDim InfoAudioChannels(-1)		  ReDim InfoAudioCodec(-1)		  ReDim InfoAudioLanguage(-1)		  		  InfoVideoAspect   = -1		  InfoVideoCodec    = ""		  InfoVideoScantype = ""		  InfoVideoHeight   = -1		  InfoVideoWidth    = -1		  InfoVideoRuntime  = ""		  		  ReDim Genres(-1)		  ReDim Studios(-1)		  ReDim Countries(-1)		  ReDim InfoSubtitleLanguage(-1)		  		  ID_TMDB        = ""		  ID_IMDB        = ""		  		  CreditDirector = ""		  CreditWriter   = ""		  		  DatePremiered  = ""		  DateYear       = -1		  		  DescriptionTagline = ""		  DescriptionOutline = ""		  DescriptionPlot    = ""		  		  Title          = ""		  TitleSort      = ""		  TitleOriginal  = ""		  		  RatingTop250        = -1		  Rating              = -1		  RatingVotes         = -1		  RatingCertification = ""		  RatingMPAA          = ""		  		  Set            = ""		  SetOrder       = -1		  StatusWatched  = False		End Sub	#tag EndMethod	#tag Method, Flags = &h1		Protected Function DestinationFanart(MovieParent as FolderItem) As FolderItem		  Dim MovieFile as FolderItem = FindMovieItem( MovieParent )		  Dim FanartDestination as FolderItem = FindImageFanart( MovieParent )		  		  Dim FanartName as String = Prefs.textStringForKey( "FileNameFanart" )		  		  If MovieFile <> Nil and MovieFile.Exists and MovieFile.Name <> "VIDEO_TS" then		    If FanartDestination = Nil or NOT FanartDestination.Exists then FanartDestination = MovieParent.Child( FanartName.ReplaceAll( "<movie>", MovieFile.NameWithoutExtension ) )		  Else		    If FanartDestination = Nil or NOT FanartDestination.Exists then FanartDestination = MovieParent.Child( "fanart.jpg" )		  End If		  		  Return FanartDestination		End Function	#tag EndMethod	#tag Method, Flags = &h1		Protected Function DestinationNFO(MovieParent as FolderItem) As FolderItem		  // Save NFO		  Dim MovieFile      as FolderItem = FindMovieItem( MovieParent )		  Dim NfoDestination as FolderItem = FindNFOFile(   MovieParent )		  		  If MovieFile <> Nil and MovieFile.Exists and MovieFile.Name <> "VIDEO_TS" then		    'If MovieFile.Name = "VIDEO_TS" then		    'NfoDestination = MovieParent.Child( "VIDEO_TS" ).Child( "movie.nfo" )		    'Else		    If NfoDestination = Nil or NOT NfoDestination.Exists then NfoDestination = MovieParent.Child( Prefs.textStringForKey("FileNameNFO").ReplaceAll( "<movie>", MovieFile.NameWithoutExtension ) )		    'End If		  Else		    If NfoDestination = Nil or NOT NfoDestination.Exists then NfoDestination = MovieFile.Child( "VIDEO_TS.nfo" )		  End If		  		  Return NfoDestination		End Function	#tag EndMethod	#tag Method, Flags = &h1		Protected Function DestinationPoster(MovieParent as FolderItem) As FolderItem		  Dim MovieFile as FolderItem = FindMovieItem( MovieParent )		  Dim PosterDestination as FolderItem = FindImagePoster( MovieParent )		  		  Dim PosterName as String = Prefs.textStringForKey( "FileNamePoster" )		  		  If MovieFile <> Nil and MovieFile.Exists and MovieFile.Name <> "VIDEO_TS" then		    If PosterDestination = Nil or NOT PosterDestination.Exists then PosterDestination = MovieParent.Child( PosterName.ReplaceAll( "<movie>", MovieFile.NameWithoutExtension ) )		  Else		    If PosterDestination = Nil or NOT PosterDestination.Exists then PosterDestination = MovieParent.Child( PosterName.ReplaceAll( "<movie>", "poster" ) )		  End If		  		  Return PosterDestination		End Function	#tag EndMethod	#tag Method, Flags = &h1		Protected Sub LoadImages(MovieParent as FolderItem)		  // MovieParent exists		  If MovieParent = Nil or NOT MovieParent.Exists then Return		  Dim ArtFile as FolderItem		  		  ArtFile = FindImagePoster( MovieParent )		  If ArtFile <> Nil and ArtFile.Exists then MovieAttr.ART_Poster = ScaleImage( Picture.Open( ArtFile ), 480, 480 * 1.5 )		  ArtFile = Nil		  		  ArtFile = FindImageFanart( MovieParent )		  If ArtFile <> Nil and ArtFile.Exists then MovieAttr.ART_Fanart = ScaleImage( Picture.Open( ArtFile ), 480 * 1.5, 480 )		  ArtFile = Nil		  		  // ----		  		  If MovieAttr.RatingMPAA <> "" then MovieAttr.ART_MPAARating = MPAA2Logo( MovieAttr.RatingMPAA )		  		  Dim Studio as String = ""		  If MovieAttr.Studios.Ubound >= 0 then Studio = MovieAttr.Studios(0)		  		  Dim AppSupport as FolderItem = SpecialFolder.ApplicationData.Child("ViMediaManager").Child("Studios")		  If AppSupport <> Nil then ArtFile = AppSupport.Child( Studio + ".png" )		  		  If ArtFile =  Nil or  NOT ArtFile.Exists then ArtFile    = GetFolderItem("Studios").Child( Studio + ".png" )		  If ArtFile <> Nil and     ArtFile.Exists then MovieAttr.ART_Studio = Picture.Open( ArtFile )		End Sub	#tag EndMethod	#tag Method, Flags = &h1		Protected Sub NFORead(NFOParent as FolderItem)		  Dim Xml as New XmlDocument		  Dim xRoot, xNode, xItem, xAudio, xVideo, xSubtitle as XmlNode		  		  Dim NFOLocation as FolderItem = FindNFOFile( NFOParent )		  		  Dim TextIn as TextInputStream		  Dim Content as String		  		  ClearProperties		  Xml.PreserveWhitespace = False		  		  // Is there an NFO File?		  If NFOLocation <> Nil and NFOLocation.Exists then		    TextIn  = TextIn.Open( NFOLocation )		    Content = TextIn.ReadAll		    TextIn.Close		  Else		    Return		  End If		  		  Content = RemoveLinks( Content )		  If Content.Left(5) = "<?xml" then Xml.LoadXml(content) Else Return		  xRoot = Xml.Child(0)		  		  For i as Integer = 0 to xRoot.ChildCount - 1		    xNode = xRoot.Child(i)		    		    If xNode.FirstChild <> Nil then		      		      Select case xNode.Name		        		      case "id"		        If xNode.FirstChild.Value.Left(2) = "tt" then		          MovieAttr.ID_IMDB = xNode.FirstChild.Value		        Else		          MovieAttr.ID_TMDB = xNode.FirstChild.Value		        End If		        		        If xNode.GetAttribute("movieDB") = "TMDb" then		          MovieAttr.ID_TMDB = xNode.FirstChild.Value		        ElseIf xNode.GetAttribute("movieDB") = "IMDB" then		          MovieAttr.ID_IMDB = xNode.FirstChild.Value		        End If		        		      case "title"		        MovieAttr.Title = xNode.FirstChild.Value		      case "sorttitle"		        MovieAttr.TitleSort = xNode.FirstChild.Value		      case "originaltitle"		        MovieAttr.TitleOriginal = xNode.FirstChild.Value		        		      case "year"		        MovieAttr.DateYear = val( xNode.FirstChild.Value )		      case "releasedate"		        MovieAttr.DatePremiered = xNode.FirstChild.Value		        		      case "rating"		        MovieAttr.Rating = val( xNode.FirstChild.Value )		      case "votes"		        MovieAttr.RatingVotes = val( xNode.FirstChild.Value )		      case "top250"		        MovieAttr.RatingTop250 = val( xNode.FirstChild.Value )		        		      case "watched"		        If xNode.FirstChild.Value = "True" then		          MovieAttr.StatusWatched = True		        ElseIf xNode.FirstChild.Value = "False" then		          MovieAttr.StatusWatched = False		        End If		        		      case "certification"		        Dim TmpStrArray() as string = xnode.FirstChild.Value.Split(" / ")		        		        For n as Integer = 0 to TmpStrArray.Ubound		          		          Select case TmpStrArray(n)		            		          case "USA:G"		            MovieAttr.RatingMPAA = "Rated G"		          case "USA:PG"		            MovieAttr.RatingMPAA = "Rated PG"		          case "USA:PG-13"		            MovieAttr.RatingMPAA = "Rated PG-13"		          case "USA:NC-17"		            MovieAttr.RatingMPAA = "Rated NC-17"		          case "USA:R"		            MovieAttr.RatingMPAA = "Rated R"		          case "Unrated"		            MovieAttr.RatingMPAA = "Unrated"		            		          End Select		          		        Next		        		      case "mpaa"		        MovieAttr.RatingMPAA = xNode.FirstChild.Value		        		      case "studio"		        MovieAttr.Studios.Append xNode.FirstChild.Value		        		      case "genre"		        MovieAttr.Genres.Append xNode.FirstChild.Value		        		      case "director"		        MovieAttr.CreditDirector = xNode.FirstChild.Value		      case "credits"		        MovieAttr.CreditWriter = xNode.FirstChild.Value		        		      case "tagline"		        MovieAttr.DescriptionTagline = xNode.FirstChild.Value		      case "outline"		        MovieAttr.DescriptionOutline = xNode.FirstChild.Value		      case "plot"		        MovieAttr.DescriptionPlot = xNode.FirstChild.Value		        		      case "set"		        MovieAttr.Set = xNode.FirstChild.Value		        If xNode.FirstChild.AttributeCount > 0 then  MovieAttr.SetOrder = val( xNode.FirstChild.GetAttribute("order") )		        		      case "runtime"		        MovieAttr.InfoVideoRuntime = xNode.FirstChild.Value		        MovieAttr.InfoVideoRuntime = Trim( MovieAttr.InfoVideoRuntime.ReplaceAll( "mins", "" ).ReplaceAll( "min", "" ) )		        		      case "thumb"		        If xNode.FirstChild.Value.left(4) = "http" then MovieAttr.ART_PosterURLs.Append xNode.FirstChild.Value		        		      case "fanart"		        For n as Integer = 0 to xNode.ChildCount - 1		          xItem = xNode.Child(n)		          MovieAttr.ART_FanartURLs.Append      xItem.FirstChild.Value		          MovieAttr.Art_FanartThumbURLs.Append xItem.GetAttribute("preview")		        Next		        		      case "actor"		        For n as Integer = 0 to xNode.ChildCount - 1		          xItem = xNode.Child(n)		          		          If xNode.ChildCount > 2 then		            		            Select case xItem.Name		            case "name"		              If xItem.FirstChild <> Nil then MovieAttr.ActorName.Append xItem.FirstChild.Value else MovieAttr.ActorName.Append ""		            case "role"		              If xItem.FirstChild <> Nil then MovieAttr.ActorRole.Append xItem.FirstChild.Value else MovieAttr.ActorRole.Append ""		            case "thumb"		              If xItem.FirstChild <> Nil then MovieAttr.ActorThumbURL.Append xItem.FirstChild.Value else MovieAttr.ActorThumbURL.Append ""		            End Select		            		          ElseIf xNode.ChildCount = 2 then		            		            Select case xItem.Name		            case "name"		              If xItem.FirstChild <> Nil then MovieAttr.ActorName.Append xItem.FirstChild.Value else MovieAttr.ActorName.Append ""		            case "role"		              If xItem.FirstChild <> Nil then MovieAttr.ActorRole.Append xItem.FirstChild.Value else MovieAttr.ActorRole.Append ""		            End Select		            		            MovieAttr.ActorThumbURL.Append ""		            		          ElseIf xNode.ChildCount = 1 then		            		            Select case xItem.Name		            case "name"		              If xItem.FirstChild <> Nil then MovieAttr.ActorName.Append xItem.FirstChild.Value else MovieAttr.ActorName.Append ""		            End Select		            		            MovieAttr.ActorRole.Append     ""		            MovieAttr.ActorThumbURL.Append ""		            		          End If		        Next		        		      case "fileinfo"		        xItem = xNode.FirstChild		        		        For n as Integer = 0 to xItem.ChildCount - 1		          		          Select case xItem.Child(n).Name		            		          case "audio"		            xAudio = xItem.Child(n)		            		            For t as Integer = 0 to xAudio.ChildCount - 1		              If xAudio.Child(t).FirstChild <> Nil then		                		                Select case xAudio.Child(t).Name		                case "channels"		                  MovieAttr.InfoAudioChannels.Append Val( xAudio.Child(t).FirstChild.Value )		                case "codec"		                  MovieAttr.InfoAudioCodec.Append xAudio.Child(t).FirstChild.Value		                case "language"		                  MovieAttr.InfoAudioLanguage.Append xAudio.Child(t).FirstChild.Value		                End Select		                		              End If		            Next		            		          case "video"		            xVideo = xItem.Child(n)		            		            For t as Integer = 0 to xVideo.ChildCount - 1		              If xVideo.Child(t).FirstChild <> Nil then		                		                Select case xVideo.Child(t).Name		                case "aspect"		                  MovieAttr.InfoVideoAspect   = val( xVideo.Child(t).FirstChild.Value )		                case "codec"		                  MovieAttr.InfoVideoCodec    = xVideo.Child(t).FirstChild.Value		                case "duration"		                  MovieAttr.InfoVideoRuntime  = xVideo.Child(t).FirstChild.Value		                  MovieAttr.InfoVideoRuntime = Trim( MovieAttr.InfoVideoRuntime.ReplaceAll( "mins", "" ).ReplaceAll( "min", "" ) )		                case "scantype"		                  MovieAttr.InfoVideoScantype = xVideo.Child(t).FirstChild.Value		                case "width"		                  MovieAttr.InfoVideoWidth    = val( xVideo.Child(t).FirstChild.Value )		                case "height"		                  MovieAttr.InfoVideoHeight   = val( xVideo.Child(t).FirstChild.Value )		                End Select		                		              End If		            Next		            		          case "subtitle"		            xSubtitle = xItem.Child(n)		            For t as Integer = 0 to xSubtitle.ChildCount - 1		              If xSubtitle.Child(t).FirstChild <> Nil and xSubtitle.Child(t).Name = "language" then MovieAttr.InfoSubtitleLanguage.Append xSubtitle.Child(t).Value		            Next		            		          End Select		          		        Next		        		      End Select		      		    Else		      // xNode.FirstChild = NIL		    End If		    		  Next		  		Exception err as NilObjectException		  MsgBox "File not found or invalid XML item found." + chr(13) + chr(13) + "Please let the author know about this as soon as possible."		  Return		  		Exception err as OutOfBoundsException		  MsgBox "Something went wrong while reading the movie " + MovieAttr.FolderParent.Name + "'s NFO file..." + chr(13) + chr(13) + "Please let the author know about this as soon as possible."		  Return		  		Exception err as XmlException		  MsgBox "Invalid or not well-formed XML NFO file found for movie " + MovieAttr.FolderParent.Name + chr(13) + chr(13) + "You should consider removeing the NFO file for said movie item before continuing."		  Return		  		Exception err as IOException		  MsgBox "IOException error Number: " + str(err.ErrorNumber) + chr(13) + chr(13) + _		  err.Message + chr(13) + _		  "Something might have gone wrong while reading: " + MovieAttr.FolderParent.Name + chr(13) + _		  "Please contact the author."		  Return		End Sub	#tag EndMethod	#tag Method, Flags = &h1		Protected Sub NFOWrite(NFOFileLocation as FolderItem)		  Dim Xml as new XmlDocument		  Dim xRoot, xNode, xItem as XmlNode		  Xml.PreserveWhitespace = True		  		  xroot = Xml.AppendChild( Xml.CreateElement( "movie" ) )		  		  If MovieAttr.ID_IMDB <> "" then		    xNode = xRoot.AppendNewChild("ID")		    xNode.SetAttribute("moviedb", "imdb")		    xNode.SetValue( MovieAttr.ID_IMDB )		  End If		  		  If MovieAttr.ID_TMDB <> "" then		    xNode = xRoot.AppendNewChild("ID")		    xNode.SetAttribute("moviedb", "TMDb")		    xNode.SetValue( MovieAttr.ID_TMDB )		  End If		  		  If MovieAttr.Title <> ""         then xRoot.AppendSimpleChild( "title",         Trim( MovieAttr.Title ) )		  If MovieAttr.TitleSort <> ""     then xRoot.AppendSimpleChild( "sorttitle",     Trim( MovieAttr.TitleSort ) )		  If MovieAttr.TitleOriginal <> "" then xRoot.AppendSimpleChild( "originaltitle", Trim( MovieAttr.TitleOriginal ) )		  		  If MovieAttr.DateYear > -1       then xRoot.AppendSimpleChild( "year",          MovieAttr.DateYear )		  If MovieAttr.DatePremiered <> "" then xRoot.AppendSimpleChild( "releasedate",   Trim( MovieAttr.DatePremiered ) )		  		  If MovieAttr.set <> "" then		    xNode = xRoot.AppendNewChild("set")		    xNode.SetValue( MovieAttr.Set )		    If MovieAttr.SetOrder <> -1 then xNode.SetAttribute( "order", str( MovieAttr.SetOrder ) )		  End If		  		  If MovieAttr.RatingTop250 > -1         then xRoot.AppendSimpleChild( "top250",        str( RatingTop250 ) )		  If MovieAttr.Rating > -1               then xRoot.AppendSimpleChild( "rating",        str( Floor( MovieAttr.Rating * 10 ) / 10 ) )		  If MovieAttr.RatingVotes > -1          then xRoot.AppendSimpleChild( "votes",         MovieAttr.RatingVotes )		  If MovieAttr.RatingMPAA <> ""          then xRoot.AppendSimpleChild( "mpaa",          Trim( MovieAttr.RatingMPAA ) )		  If MovieAttr.RatingCertification <> "" then xRoot.AppendSimpleChild( "certification", Trim( MovieAttr.RatingCertification ) )		  		  If MovieAttr.DescriptionTagline <> "" then xRoot.AppendSimpleChild( "tagline", Trim( MovieAttr.DescriptionTagline ) )		  If MovieAttr.DescriptionOutline <> "" then xRoot.AppendSimpleChild( "outline", Trim( MovieAttr.DescriptionOutline ) )		  If MovieAttr.DescriptionPlot    <> "" then xRoot.AppendSimpleChild( "plot",    Trim( MovieAttr.DescriptionPlot    ) )		  		  If MovieAttr.InfoVideoRuntime <> "" then xRoot.AppendSimpleChild( "runtime", Trim( MovieAttr.InfoVideoRuntime + " Mins" ) )		  If MovieAttr.StatusWatched          then xRoot.AppendSimpleChild( "watched", MovieAttr.StatusWatched )		  		  If MovieAttr.Genres.Ubound > -1 then		    For i as Integer = 0 to MovieAttr.Genres.Ubound		      xRoot.AppendSimpleChild( "genre", Trim( MovieAttr.Genres(i) ) )		    Next		  End If		  		  If MovieAttr.Studios.Ubound > -1 then		    For n as Integer = 0 to MovieAttr.Studios.Ubound		      xRoot.AppendSimpleChild( "studio", Trim( MovieAttr.Studios(n) ) )		    Next		  End If		  		  If MovieAttr.Countries.Ubound > -1 then		    For t as Integer = 0 to MovieAttr.Countries.Ubound		      xRoot.AppendSimpleChild( "country", Trim( MovieAttr.Countries(t) ) )		    Next		  End If		  		  If MovieAttr.CreditDirector <> "" then xRoot.AppendSimpleChild( "director", Trim( MovieAttr.CreditDirector ) )		  If MovieAttr.CreditWriter   <> "" then xRoot.AppendSimpleChild( "credits",  Trim( MovieAttr.CreditWriter   ) )		  		  If MovieAttr.ActorName.Ubound > -1 then		    For e as Integer = 0 to MovieAttr.ActorName.Ubound		      xNode = xRoot.AppendNewChild( "actor" )		      xNode.AppendSimpleChild( "name",  Trim( MovieAttr.ActorName(e)     ) )		      xNode.AppendSimpleChild( "role",  Trim( MovieAttr.ActorRole(e)     ) )		      xNode.AppendSimpleChild( "thumb", Trim( MovieAttr.ActorThumbURL(e) ) )		    Next		  End If		  		  If FindImagePoster( MovieAttr.FolderParent ) <> Nil then xRoot.AppendSimpleChild( "thumb", FindImagePoster( MovieAttr.FolderParent ).Name )		  		  If MovieAttr.ART_PosterURLs.Ubound > -1 then		    For g as Integer = 0 to MovieAttr.ART_PosterURLs.Ubound		      xRoot.AppendSimpleChild( "thumb", Trim( MovieAttr.ART_PosterURLs(g) ) )		    Next		  End If		  		  If MovieAttr.ART_FanartURLs.Ubound > -1 then		    xNode = xRoot.AppendNewChild( "fanart" )		    For r as Integer = 0 to MovieAttr.ART_FanartURLs.Ubound		      xItem = xNode.AppendNewChild( "thumb" )		      xItem.SetValue( Trim( MovieAttr.ART_FanartURLs(r) ) )		      xItem.SetAttribute( "preview", Trim( MovieAttr.Art_FanartThumbURLs(r) ) )		    Next		  End If		  		  'If   InfoVideoCodec <> "" or _		  'InfoVideoHeight > -1 or _		  'InfoVideoWidth > -1  or _		  'InfoVideoAspect > -1 then		  If NFOFileLocation.Name <> "VIDEO_TS.nfo" then		    xNode = xRoot.AppendNewChild( "fileinfo" )		    xItem = xNode.AppendNewChild( "streamdetails" )		    		    Dim xVideo as XmlNode = xItem.AppendNewChild( "video" )		    If MovieAttr.InfoVideoCodec <> ""    then xVideo.AppendSimpleChild( "codec",    Trim( MovieAttr.InfoVideoCodec   ) )		    If MovieAttr.InfoVideoAspect > -1    then xVideo.AppendSimpleChild( "aspect",   MovieAttr.InfoVideoAspect  )		    If MovieAttr.InfoVideoScantype <> "" then xVideo.AppendSimpleChild( "scantype", Trim( MovieAttr.InfoVideoScantype ) )		    If MovieAttr.InfoVideoWidth  > -1    then xVideo.AppendSimpleChild( "width",    MovieAttr.InfoVideoWidth   )		    If MovieAttr.InfoVideoHeight > -1    then xVideo.AppendSimpleChild( "height",   MovieAttr.InfoVideoHeight  )		    If MovieAttr.InfoVideoRuntime <> ""  then xVideo.AppendSimpleChild( "runtime",  Trim( MovieAttr.InfoVideoRuntime ) )		    		    For g as Integer = 0 to MovieAttr.InfoAudioCodec.Ubound		      Dim xAudio as XmlNode = xItem.AppendNewChild( "audio" )		      If MovieAttr.InfoAudioCodec(g) <> ""    then xAudio.AppendSimpleChild( "codec",    Trim( MovieAttr.InfoAudioCodec(g)    ) )		      If MovieAttr.InfoAudioChannels(g) > -1  then xAudio.AppendSimpleChild( "channels",  Str( MovieAttr.InfoAudioChannels(g) ) )		      If MovieAttr.InfoAudioLanguage(g) <> "" then xAudio.AppendSimpleChild( "language", Trim( MovieAttr.InfoAudioLanguage(g) ) )		    Next		  End If		  		  'End If		  		  xRoot.Indent(0)		  Xml.LoadXml( Xml.ToString.IndentRoot("movie") )		  Xml.SaveXml( NFOFileLocation )		End Sub	#tag EndMethod	#tag Note, Name = Movie.NFO				Movies		movie.nfo will override all and any nfo files in the same folder as the media files if you use the "Use foldernames for lookups" setting.		If you don`t, then moviename.nfo is used. If there is only one nfo file in a folder, The scraper will use it for all media files in that folder.		If there are multiple media files in a folder, the *.nfo should be named exactly the same as the video file it is representing (ie. moviename.avi and moviename.nfo).		In the case of multi-part (stacked) video stacking, name the file either moviename.nfo or moviename-CD1.nfo where the first filename is moviename-CD1.avi.		Note, if your movie is ripped as VOB`s and stored in a `VIDEO_TS` folder, you will have to name the file `VIDEO_TS.nfo` and place it in the same directory with the VIDEO_TS.ifo file.		Additionally the `set` tag can be used to help sort movies that are part of a series or collection (ie Harry Potter, James Bond films).		This sort of collection tagging must be done in the .NFO file before the movie is scanned into the library.				    <movie>		        <title>Who knows</title>		        <originaltitle>Who knows for real</originaltitle>		        <sorttitle>Who knows 1</sorttitle>		        <set>Who knows trilogy</set>		        <rating>6.100000</rating>		        <year>2008</year>		        <top250>0</top250>		        <votes>50</votes>		        <outline>A look at the role of the Buckeye State in the 2004 Presidential Election.</outline>		        <plot>A look at the role of the Buckeye State in the 2004 Presidential Election.</plot>		        <tagline></tagline>		        <runtime>90 min</runtime>		        <thumb>http://ia.ec.imdb.com/media/imdb/01/I/25/65/31/10f.jpg</thumb>		        <mpaa>Not available</mpaa>		        <playcount>0</playcount>		        <watched>false</watched>		        <id>tt0432337</id>		        <filenameandpath>c:\Dummy_Movie_Files\Movies\...So Goes The Nation.avi</filenameandpath>		        <trailer></trailer>		        <genre></genre>		        <credits></credits>		        <fileinfo>		            <streamdetails>		                <video>		                    <codec>h264</codec>		                    <aspect>2.35</aspect>		                    <width>1920</width>		                    <height>816</height>		                </video>		                <audio>		                    <codec>ac3</codec>		                    <language>eng</language>		                    <channels>6</channels>		                </audio>		                <audio>		                    <codec>ac3</codec>		                    <language>spa</language>		                   <channels>2</channels>		                </audio>		                <subtitle>		                    <language>spa</language>		                </subtitle>		            </streamdetails>		        </fileinfo>		        <director>Adam Del Deo</director>		        <actor>		            <name>Paul Begala</name>		            <role>Himself</role>		        </actor>		        <actor>		            <name>George W. Bush</name>		            <role>Himself</role>		        </actor>		        <actor>		            <name>Mary Beth Cahill</name>		            <role>Herself</role>		        </actor>		        <actor>		            <name>Ed Gillespie</name>		            <role>Himself</role>		        </actor>		        <actor>		            <name>John Kerry</name>		            <role>Himself</role>		        </actor>		    </movie>	#tag EndNote	#tag Note, Name = Naming Conventions				ai = Audio Information		vi = Video Information				FileInfo Format:				        <fileinfo>		            <streamdetails>		                <video>		                    <codec>xvid</codec>		                    <aspect>2.388060</aspect>		                    <width>1280</width>		                    <height>536</height>		                    <durationinseconds>5165</durationinseconds>		                </video>		                <audio>		                    <codec>ac3</codec>		                    <language></language>		                    <channels>6</channels>		                </audio>		            </streamdetails>		        </fileinfo>				Actor Format:				        <actor>		            <name>Rutger Hauer</name>		            <role>Hobo</role>		            <thumb>http://ia.media-imdb.com/images/M/MV5BMTI5MjE4MTg3MV5BMl5BanBnXkFtZTYwMjk0Mzgy._V1._SY275_SX400_.jpg</thumb>		        </actor>	#tag EndNote	#tag Note, Name = NFO Files				XBMC NFO movie XML		Utilizes the XBMC movie layout as specified here http://xbmc.org/wiki/?title=Import_-_Export_Library#Video_nfo_Files The episodedetails, & musicvideo layouts are not currently implemented, and will require additional internet database scanning features to be implemented first.				Some fields map directly to YAMJ, and others do not currently have a YAMJ counterpart. These fields are commented on below.				Any fields may be populated or left blank as the user sees fit. If a field is populated, then it will take precedence over anything retrieved from the Internet. However, if a field is left blank in the NFO, then that field will still be loaded as before.				On fields where multiple may exist, like <genre> or <actor>, if even one is present in the NFO, then YAMJ will not attempt to scrape any additional information.				Turn Off Internet Scraping		If you want only the information from the NFO file to be used and not have MovieJukebox search the internet for information you should use an ID value of 0 (Zero) or -1				Example				<movie>		  <id>-1</id>		</movie>		Format		<movie>		    <title></title>		    <originaltitle></originaltitle>		    <sorttitle></sorttitle>		    <rating></rating>               <!-- 0 - 10 rating, can be decimal -->		    <year></year>		    <top250></top250>               <!-- the IMDB top 250 ranking, integer 1 - 250 or empty -->		    <votes></votes>                 <!-- currently unused in YAMJ -->		    <outline></outline>             <!-- a short plot description -->		    <plot></plot>                   <!-- a longer plot description -->		    <tagline></tagline>             <!-- The tagline for the movie -->		    <runtime></runtime>		    <premiered></premiered>         <!-- the release date of the movie -->		    <thumb></thumb>                 <!-- url of poster image. use URL formatting, such as http:// for internet resources or file:// for local resources -->		    <fanart></fanart>               <!-- url of fanart image. use URL formatting, such as http:// for internet resources or file:// for local resources -->		    <mpaa></mpaa>		    <certification></certification> <!-- Used for all certification that isn`t MPAA and only used if imdb.getCertificationFromMPAA=false -->		    <playcount></playcount>         <!-- currently unused in YAMJ -->		    <watched></watched>             <!-- This will mark the movie watched or unwatched -->		    <id></id>                       <!-- the IMDB id of the movie. includes the leading "tt". Use an id of 0 or -1 to disable further internet plugin scraping. -->		    <id moviedb="allocine"></id>    <!-- the allocine id of the movie. This should work for other plugins using their PLUGIN_ID as "moviedb" value -->		    <id moviedb="filmweb"></id>     <!-- the filmweb id of the movie. This should work for other plugins using their PLUGIN_ID as "moviedb" value -->		    <filenameandpath></filenameandpath> <!-- currently unused since YAMJ determines path from searching the configured libraries -->		    <trailer></trailer>             <!-- multiple trailer records may exist -->		    <genre></genre>                 <!-- multiple genre records may exist, including any custom ones -->		    <credits>		        <writer></writer>           <!-- Writer name, one per entry -->		    </credits>		    <director></director>		    <company></company>             <!-- The studio company that produced the movie -->		    <studio></studio>               <!-- Synonym for company tag -->		    <country></country>             <!-- Country the video was produced in -->		    <actor>                         <!-- Multiple actor records may exist -->		        <name></name>		        <role></role>               <!-- Currently unused in YAMJ -->		    </actor>		    <sets>		      <set>First Set Name</set>		      <set order="?">Another Set With An Order</set>		    </sets>		<!-- NOTE: All of the following tags will OVERWRITE the derived data -->		    <videosource></videosource>     <!-- The video source of the file -->		    <videooutput></videooutput>     <!-- The video output of the file -->		    <fps></fps>                     <!-- The Frames Per Second value for the movie. NOTE: This should be a valid float value (with a ".") -->		    <fileinfo>		        <streamdetails>		            <video>		                <codec></codec>		                <aspect></aspect>		                <width></width>     <!-- Width of the video file -->		                <height></height>   <!-- Height of the video file -->		            </video>		            <audio>		                <codec></codec>		                <language></language>		                <channels></channels>		            </audio>		            <subtitle>		                <language></language>    <!-- currently unused in YAMJ -->		            </subtitle>		        </streamdetails>		    </fileinfo>		</movie>		XML Encoding		XML must be either provided in UTF-8 charset or the encoding must be explicitly specified in the xml header				Example:				<?xml version="1.0" encoding="windows-1252"?>		<movie>		...		If existing(old) NFO files do not have the described header and you do not want to re-encode or add the header to all the files, there is a parameter in the moviejukebox.properties which can be used to force the XML parser to read all the NFO files using the specified encoding.				mjb.forceNFOEncoding=YOUR-ENCODING	#tag EndNote	#tag Property, Flags = &h1		Protected ActorName() As String	#tag EndProperty	#tag Property, Flags = &h1		Protected ActorRole() As String	#tag EndProperty	#tag Property, Flags = &h1		Protected ActorThumbURL() As String	#tag EndProperty	#tag Property, Flags = &h1		Protected ART_Fanart As Picture	#tag EndProperty	#tag Property, Flags = &h1		Protected Art_FanartThumbURLs() As String	#tag EndProperty	#tag Property, Flags = &h1		Protected ART_FanartURLs() As String	#tag EndProperty	#tag Property, Flags = &h1		Protected ART_MPAARating As Picture	#tag EndProperty	#tag Property, Flags = &h1		Protected ART_Poster As Picture	#tag EndProperty	#tag Property, Flags = &h1		Protected ART_PosterURLs() As String	#tag EndProperty	#tag Property, Flags = &h1		Protected ART_Studio As Picture	#tag EndProperty	#tag Property, Flags = &h1		Protected Countries() As String	#tag EndProperty	#tag Property, Flags = &h1		Protected CreditDirector As String	#tag EndProperty	#tag Property, Flags = &h1		Protected CreditWriter As String	#tag EndProperty	#tag Property, Flags = &h1		Protected DatePremiered As String	#tag EndProperty	#tag Property, Flags = &h1		Protected DateYear As Integer	#tag EndProperty	#tag Property, Flags = &h1		Protected DescriptionOutline As String	#tag EndProperty	#tag Property, Flags = &h1		Protected DescriptionPlot As String	#tag EndProperty	#tag Property, Flags = &h1		Protected DescriptionTagline As String	#tag EndProperty	#tag Property, Flags = &h1		Protected FolderParent As FolderItem	#tag EndProperty	#tag Property, Flags = &h1		Protected Genres() As String	#tag EndProperty	#tag Property, Flags = &h1		Protected ID_IMDB As String	#tag EndProperty	#tag Property, Flags = &h1		Protected ID_TMDB As String	#tag EndProperty	#tag Property, Flags = &h1		Protected InfoAudioChannels() As Integer	#tag EndProperty	#tag Property, Flags = &h1		Protected InfoAudioCodec() As String	#tag EndProperty	#tag Property, Flags = &h1		Protected InfoAudioLanguage() As String	#tag EndProperty	#tag Property, Flags = &h1		Protected InfoSubtitleLanguage() As String	#tag EndProperty	#tag Property, Flags = &h1		Protected InfoVideoAspect As Double	#tag EndProperty	#tag Property, Flags = &h1		Protected InfoVideoCodec As String	#tag EndProperty	#tag Property, Flags = &h1		Protected InfoVideoHeight As Integer	#tag EndProperty	#tag Property, Flags = &h1		Protected InfoVideoRuntime As String	#tag EndProperty	#tag Property, Flags = &h1		Protected InfoVideoScantype As String	#tag EndProperty	#tag Property, Flags = &h1		Protected InfoVideoWidth As Integer	#tag EndProperty	#tag Property, Flags = &h1		Protected Rating As Double	#tag EndProperty	#tag Property, Flags = &h1		Protected RatingCertification As String	#tag EndProperty	#tag Property, Flags = &h1		Protected RatingMPAA As String	#tag EndProperty	#tag Property, Flags = &h1		Protected RatingTop250 As Double	#tag EndProperty	#tag Property, Flags = &h1		Protected RatingVotes As Integer	#tag EndProperty	#tag Property, Flags = &h1		Protected Set As String	#tag EndProperty	#tag Property, Flags = &h1		Protected SetOrder As Integer	#tag EndProperty	#tag Property, Flags = &h1		Protected StatusWatched As Boolean	#tag EndProperty	#tag Property, Flags = &h1		Protected Studios() As String	#tag EndProperty	#tag Property, Flags = &h1		Protected Title As String	#tag EndProperty	#tag Property, Flags = &h1		Protected TitleOriginal As String	#tag EndProperty	#tag Property, Flags = &h1		Protected TitleSort As String	#tag EndProperty	#tag ViewBehavior		#tag ViewProperty			Name="Index"			Visible=true			Group="ID"			InitialValue="-2147483648"			InheritedFrom="Object"		#tag EndViewProperty		#tag ViewProperty			Name="Left"			Visible=true			Group="Position"			InitialValue="0"			InheritedFrom="Object"		#tag EndViewProperty		#tag ViewProperty			Name="Name"			Visible=true			Group="ID"			InheritedFrom="Object"		#tag EndViewProperty		#tag ViewProperty			Name="Super"			Visible=true			Group="ID"			InheritedFrom="Object"		#tag EndViewProperty		#tag ViewProperty			Name="Top"			Visible=true			Group="Position"			InitialValue="0"			InheritedFrom="Object"		#tag EndViewProperty	#tag EndViewBehaviorEnd Module#tag EndModule
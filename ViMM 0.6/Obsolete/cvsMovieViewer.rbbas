#tag ClassProtected Class cvsMovieViewerInherits Canvas	#tag Event		Sub Paint(g As Graphics)		  g.ForeColor = &cFFFFFF		  g.FillRect 0, 0, Width, Height		  		  		  // Draw movies BG		  Dim Pic as New Picture( Width, Height, 32 )		  Pic = ScaleImage( IMGmovies, Pic.Width, Pic.Height, True, True, False )		  Pic.Graphics.DrawPicture IMGFanartOverlay, 0, 0, pic.Width, pic.Height,    0, 0, IMGFanartOverlay.Width, IMGFanartOverlay.Height		  Graphics.DrawPicture Pic, 0, 0		  		  // Toolbar BG		  g.DrawPicture toolbg, 0, 0, Width, toolbg.Height, 0, 0, toolbg.Width, toolbg.Height		End Sub	#tag EndEvent	#tag ViewBehavior		#tag ViewProperty			Name="AcceptFocus"			Visible=true			Group="Behavior"			Type="Boolean"			InheritedFrom="Canvas"		#tag EndViewProperty		#tag ViewProperty			Name="AcceptTabs"			Visible=true			Group="Behavior"			Type="Boolean"			InheritedFrom="Canvas"		#tag EndViewProperty		#tag ViewProperty			Name="AutoDeactivate"			Visible=true			Group="Appearance"			InitialValue="True"			Type="Boolean"			InheritedFrom="Canvas"		#tag EndViewProperty		#tag ViewProperty			Name="Backdrop"			Visible=true			Group="Appearance"			Type="Picture"			EditorType="Picture"			InheritedFrom="Canvas"		#tag EndViewProperty		#tag ViewProperty			Name="DoubleBuffer"			Visible=true			Group="Behavior"			InitialValue="False"			Type="Boolean"			InheritedFrom="Canvas"		#tag EndViewProperty		#tag ViewProperty			Name="Enabled"			Visible=true			Group="Appearance"			InitialValue="True"			Type="Boolean"			InheritedFrom="Canvas"		#tag EndViewProperty		#tag ViewProperty			Name="EraseBackground"			Visible=true			Group="Behavior"			InitialValue="True"			Type="Boolean"			InheritedFrom="Canvas"		#tag EndViewProperty		#tag ViewProperty			Name="Height"			Visible=true			Group="Position"			InitialValue="100"			Type="Integer"			InheritedFrom="Canvas"		#tag EndViewProperty		#tag ViewProperty			Name="HelpTag"			Visible=true			Group="Appearance"			Type="String"			EditorType="MultiLineEditor"			InheritedFrom="Canvas"		#tag EndViewProperty		#tag ViewProperty			Name="Index"			Visible=true			Group="ID"			Type="Integer"			InheritedFrom="Canvas"		#tag EndViewProperty		#tag ViewProperty			Name="InitialParent"			InheritedFrom="Canvas"		#tag EndViewProperty		#tag ViewProperty			Name="Left"			Visible=true			Group="Position"			Type="Integer"			InheritedFrom="Canvas"		#tag EndViewProperty		#tag ViewProperty			Name="LockBottom"			Visible=true			Group="Position"			Type="Boolean"			InheritedFrom="Canvas"		#tag EndViewProperty		#tag ViewProperty			Name="LockLeft"			Visible=true			Group="Position"			Type="Boolean"			InheritedFrom="Canvas"		#tag EndViewProperty		#tag ViewProperty			Name="LockRight"			Visible=true			Group="Position"			Type="Boolean"			InheritedFrom="Canvas"		#tag EndViewProperty		#tag ViewProperty			Name="LockTop"			Visible=true			Group="Position"			Type="Boolean"			InheritedFrom="Canvas"		#tag EndViewProperty		#tag ViewProperty			Name="Name"			Visible=true			Group="ID"			Type="String"			InheritedFrom="Canvas"		#tag EndViewProperty		#tag ViewProperty			Name="Super"			Visible=true			Group="ID"			InheritedFrom="Canvas"		#tag EndViewProperty		#tag ViewProperty			Name="TabIndex"			Visible=true			Group="Position"			InitialValue="0"			Type="Integer"			InheritedFrom="Canvas"		#tag EndViewProperty		#tag ViewProperty			Name="TabPanelIndex"			Group="Position"			InitialValue="0"			Type="Integer"			InheritedFrom="Canvas"		#tag EndViewProperty		#tag ViewProperty			Name="TabStop"			Visible=true			Group="Position"			InitialValue="True"			Type="Boolean"			InheritedFrom="Canvas"		#tag EndViewProperty		#tag ViewProperty			Name="Top"			Visible=true			Group="Position"			Type="Integer"			InheritedFrom="Canvas"		#tag EndViewProperty		#tag ViewProperty			Name="UseFocusRing"			Visible=true			Group="Appearance"			InitialValue="True"			Type="Boolean"			InheritedFrom="Canvas"		#tag EndViewProperty		#tag ViewProperty			Name="Visible"			Visible=true			Group="Appearance"			InitialValue="True"			Type="Boolean"			InheritedFrom="Canvas"		#tag EndViewProperty		#tag ViewProperty			Name="Width"			Visible=true			Group="Position"			InitialValue="100"			Type="Integer"			InheritedFrom="Canvas"		#tag EndViewProperty	#tag EndViewBehaviorEnd Class#tag EndClass
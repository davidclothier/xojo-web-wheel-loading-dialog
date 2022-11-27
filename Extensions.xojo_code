#tag Module
Protected Module Extensions
	#tag Method, Flags = &h0
		Sub HideProgressWheel(Extends dialog As WebDialog)
		  'When the dialog is shown after the tasks are finished in the Opening event,
		  'we delete the ProgressWheel and change the z-index again to make the content of the dialog visible.
		  
		  Var jsHide As String
		  jsHide = "$(document).ready(function() {document.getElementsByClassName('XojoProgressWheel')[0].remove(); document.getElementsByClassName('modal-body')[0].style.zIndex='auto';});"
		  
		  dialog.ExecuteJavaScript(jsHide)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub ShowProgressWheel(Extends dialog As WebDialog, percentScale As Integer)
		  'Protect from a misuse
		  If percentScale < 0 Then percentScale = 0
		  If percentScale > 100 Then percentScale = 100
		  
		  'Because of the display flex, adjust the scaling in case of a height greater than a width to avoid overflowing the animation.
		  If dialog.Height > dialog.Width Then
		    percentScale = percentScale/(dialog.Height/dialog.Width)
		  End If
		  
		  'Calculate size and position of the animation
		  Var wheelWidth As Integer = dialog.Width * (percentScale/100)
		  Var wheelHeight As Integer = dialog.Height * (percentScale/100)
		  Var wheelLeft As Integer = (dialog.Width/2)-(wheelWidth/2)
		  Var wheelTop As Integer = (dialog.Height/2)-(wheelHeight/2)
		  
		  'Create a ProgressWheel with the native Xojo css class that we add to the main Dialog container.
		  Var jsWheel() As String
		  jsWheel.Add("const image=document.createElement('img');")
		  jsWheel.Add("image.src='"+kProgressWheel+"';")
		  jsWheel.Add("const wheel=document.createElement('div');")
		  jsWheel.Add("wheel.appendChild(image);")
		  jsWheel.Add("wheel.classList.add('XojoProgressWheel');")
		  jsWheel.Add("wheel.setAttribute('style','width: "+wheelWidth.ToString+"px; height: "+wheelHeight.ToString+"px; position: absolute; top: "+wheelTop.ToString+"px; left: "+wheelLeft.ToString+"px; display: flex; justify-content: center;');")
		  jsWheel.Add("document.getElementsByClassName('modal-content')[0].appendChild(wheel);")
		  
		  'Finally, we change the z-index of the secondary container to make its content invisible and avoid flickering.
		  Var jsChangeZOrder As String
		  jsChangeZOrder = "document.getElementsByClassName('modal-body')[0].style.zIndex='-1';"
		  
		  dialog.ExecuteJavaScript(String.FromArray(jsWheel,""))
		  dialog.ExecuteJavaScript(jsChangeZOrder)
		  
		End Sub
	#tag EndMethod


	#tag Constant, Name = kProgressWheel, Type = String, Dynamic = False, Default = \"data:image/svg+xml;base64\x2CPD94bWwgdmVyc2lvbj0iMS4wIiBlbmNvZGluZz0iVVRGLTgiIHN0YW5kYWxvbmU9Im5vIj8+CjxzdmcgeG1sbnM9Imh0dHA6Ly93d3cudzMub3JnLzIwMDAvc3ZnIiB3aWR0aD0iMTAwJSIgaGVpZ2h0PSIxMDAlIiB2aWV3Qm94PSIwIDAgMzIgMzIiPgogICAgPHN0eWxlPgpAa2V5ZnJhbWVzIGEwX3QgeyAwJSB7IHRyYW5zZm9ybTogdHJhbnNsYXRlKDE2cHgsMTZweCkgcm90YXRlKDBkZWcpIHRyYW5zbGF0ZSgtMTZweCwtMTZweCk7IH0gMjUlIHsgdHJhbnNmb3JtOiB0cmFuc2xhdGUoMTZweCwxNnB4KSByb3RhdGUoOTBkZWcpIHRyYW5zbGF0ZSgtMTZweCwtMTZweCk7IH0gNTAlIHsgdHJhbnNmb3JtOiB0cmFuc2xhdGUoMTZweCwxNnB4KSByb3RhdGUoMTgwZGVnKSB0cmFuc2xhdGUoLTE2cHgsLTE2cHgpOyB9IDc1JSB7IHRyYW5zZm9ybTogdHJhbnNsYXRlKDE2cHgsMTZweCkgcm90YXRlKDI3MGRlZykgdHJhbnNsYXRlKC0xNnB4LC0xNnB4KTsgfSAxMDAlIHsgdHJhbnNmb3JtOiB0cmFuc2xhdGUoMTZweCwxNnB4KSByb3RhdGUoMzYwZGVnKSB0cmFuc2xhdGUoLTE2cHgsLTE2cHgpOyB9IH0KICAgIDwvc3R5bGU+CiAgICA8ZyBmaWxsPSIjMDAwMDAwIiBmaWxsLXJ1bGU9ImV2ZW5vZGQiIHRyYW5zZm9ybT0idHJhbnNsYXRlKDE2LDE2KSB0cmFuc2xhdGUoLTE2LC0xNikiIHN0eWxlPSJhbmltYXRpb246IDEuNnMgbGluZWFyIGluZmluaXRlIGJvdGggYTBfdDsiPgogICAgICAgIDxyZWN0IHdpZHRoPSIzIiBoZWlnaHQ9IjcuNSIgcng9IjEuNSIgdHJhbnNmb3JtPSJ0cmFuc2xhdGUoMCwwKSB0cmFuc2xhdGUoMTQuNSwwKSIvPgogICAgICAgIDxyZWN0IHdpZHRoPSIzIiBoZWlnaHQ9IjcuNSIgb3BhY2l0eT0iMC4xIiByeD0iMS41IiB0cmFuc2Zvcm09InRyYW5zbGF0ZSgzLjQ3NCwtNy43MTEyNSkgcm90YXRlKDIzKSB0cmFuc2xhdGUoMTkuMTg4LDAuOTMyKSIvPgogICAgICAgIDxyZWN0IHdpZHRoPSIzIiBoZWlnaHQ9IjcuNSIgb3BhY2l0eT0iMC4xIiByeD0iMS41IiB0cmFuc2Zvcm09InRyYW5zbGF0ZSgxMi40MTIxLC0xNS4yODk0KSByb3RhdGUoNDUpIHRyYW5zbGF0ZSgyMy4xNjIsMy41ODgpIi8+CiAgICAgICAgPHJlY3Qgd2lkdGg9IjMiIGhlaWdodD0iNy41IiBvcGFjaXR5PSIwLjEiIHJ4PSIxLjUiIHRyYW5zZm9ybT0idHJhbnNsYXRlKDI3LjU3MjgsLTE4LjI1NDQpIHJvdGF0ZSg2OCkgdHJhbnNsYXRlKDI1LjgxOCw3LjU2MikiLz4KICAgICAgICA8cmVjdCB3aWR0aD0iMyIgaGVpZ2h0PSI3LjUiIG9wYWNpdHk9IjAuMSIgcng9IjEuNSIgdHJhbnNmb3JtPSJ0cmFuc2xhdGUoNDQuMjUsLTEyLjI1KSByb3RhdGUoOTApIHRyYW5zbGF0ZSgyNi43NSwxMi4yNSkiLz4KICAgICAgICA8cmVjdCB3aWR0aD0iMyIgaGVpZ2h0PSI3LjUiIG9wYWNpdHk9IjAuMSIgcng9IjEuNSIgdHJhbnNmb3JtPSJ0cmFuc2xhdGUoNTcuMDM1NCwzLjYyNTA5KSByb3RhdGUoMTEzKSB0cmFuc2xhdGUoMjUuODE4LDE2LjkzOCkiLz4KICAgICAgICA8cmVjdCB3aWR0aD0iMyIgaGVpZ2h0PSI3LjUiIG9wYWNpdHk9IjAuMSIgcng9IjEuNSIgdHJhbnNmb3JtPSJ0cmFuc2xhdGUoNTkuNTM5MywyNC42NjIpIHJvdGF0ZSgxMzUpIHRyYW5zbGF0ZSgyMy4xNjIsMjAuOTEyKSIvPgogICAgICAgIDxyZWN0IHdpZHRoPSIzIiBoZWlnaHQ9IjcuNSIgb3BhY2l0eT0iMC4xIiByeD0iMS41IiB0cmFuc2Zvcm09InRyYW5zbGF0ZSg1MC4xMDMxLDQ0Ljg5NjkpIHJvdGF0ZSgxNTgpIHRyYW5zbGF0ZSgxOS4xODgsMjMuNTY4KSIvPgogICAgICAgIDxyZWN0IHdpZHRoPSIzIiBoZWlnaHQ9IjcuNSIgb3BhY2l0eT0iMC4yIiByeD0iMS41IiB0cmFuc2Zvcm09InRyYW5zbGF0ZSgzMiw1Ni41KSByb3RhdGUoMTgwKSB0cmFuc2xhdGUoMTQuNSwyNC41KSIvPgogICAgICAgIDxyZWN0IHdpZHRoPSIzIiBoZWlnaHQ9IjcuNSIgb3BhY2l0eT0iMC4zIiByeD0iMS41IiB0cmFuc2Zvcm09InRyYW5zbGF0ZSgxMS4wNTA4LDU2Ljg4NDMpIHJvdGF0ZSgtMTU3KSB0cmFuc2xhdGUoOS44MTIsMjMuNTY4KSIvPgogICAgICAgIDxyZWN0IHdpZHRoPSIzIiBoZWlnaHQ9IjcuNSIgb3BhY2l0eT0iMC40IiByeD0iMS41IiB0cmFuc2Zvcm09InRyYW5zbGF0ZSgtNC45MTE5Miw0Ny4yODk0KSByb3RhdGUoLTEzNSkgdHJhbnNsYXRlKDUuODM4LDIwLjkxMikiLz4KICAgICAgICA8cmVjdCB3aWR0aD0iMyIgaGVpZ2h0PSI3LjUiIG9wYWNpdHk9IjAuNSIgcng9IjEuNSIgdHJhbnNmb3JtPSJ0cmFuc2xhdGUoLTEyLjUzMiwzMy4wODEyKSByb3RhdGUoLTExMykgdHJhbnNsYXRlKDMuMTgyLDE2LjkzOCkiLz4KICAgICAgICA8cmVjdCB3aWR0aD0iMyIgaGVpZ2h0PSI3LjUiIG9wYWNpdHk9IjAuNiIgcng9IjEuNSIgdHJhbnNmb3JtPSJ0cmFuc2xhdGUoLTEyLjI1LDE5Ljc1KSByb3RhdGUoLTkwKSB0cmFuc2xhdGUoMi4yNSwxMi4yNSkiLz4KICAgICAgICA8cmVjdCB3aWR0aD0iMyIgaGVpZ2h0PSI3LjUiIG9wYWNpdHk9IjAuNyIgcng9IjEuNSIgdHJhbnNmb3JtPSJ0cmFuc2xhdGUoLTcuNTYwMTUsMTEuMjAxOSkgcm90YXRlKC02NykgdHJhbnNsYXRlKDMuMTgyLDcuNTYyKSIvPgogICAgICAgIDxyZWN0IHdpZHRoPSIzIiBoZWlnaHQ9IjcuNSIgb3BhY2l0eT0iMC44IiByeD0iMS41IiB0cmFuc2Zvcm09InRyYW5zbGF0ZSgtMy4wMzk1LDcuMzM4KSByb3RhdGUoLTQ1KSB0cmFuc2xhdGUoNS44MzgsMy41ODgpIi8+CiAgICAgICAgPHJlY3Qgd2lkdGg9IjMiIGhlaWdodD0iNy41IiBvcGFjaXR5PSIwLjkiIHJ4PSIxLjUiIHRyYW5zZm9ybT0idHJhbnNsYXRlKC0wLjkzMDIxMiw0LjU3ODQ3KSByb3RhdGUoLTIyKSB0cmFuc2xhdGUoOS44MTIsMC45MzIpIi8+CiAgICA8L2c+Cjwvc3ZnPgo\x3D", Scope = Public
	#tag EndConstant


	#tag ViewBehavior
		#tag ViewProperty
			Name="Name"
			Visible=true
			Group="ID"
			InitialValue=""
			Type="String"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="Index"
			Visible=true
			Group="ID"
			InitialValue="-2147483648"
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="Super"
			Visible=true
			Group="ID"
			InitialValue=""
			Type="String"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="Left"
			Visible=true
			Group="Position"
			InitialValue="0"
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="Top"
			Visible=true
			Group="Position"
			InitialValue="0"
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
	#tag EndViewBehavior
End Module
#tag EndModule

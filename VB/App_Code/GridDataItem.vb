Imports System
Imports System.Collections.Generic
Imports System.Linq
Imports System.Web

''' <summary>
''' Summary description for GridDataItem
''' </summary>
Public Class GridDataItem
    Public Sub New()
    End Sub
    Public Property ID() As Integer
    Public Property C1() As Integer
    Public Property C2() As Double
    Public Property C3() As String
    Public Property C4() As Boolean
    Public Property C5() As Date

    Public Shared Function GetData() As List(Of GridDataItem)
        Dim key = "34FAA431-CF79-4869-9488-93F6AAE81263"
        If HttpContext.Current.Session(key) Is Nothing Then
            HttpContext.Current.Session(key) = Enumerable.Range(0, 100).Select(Function(i) New GridDataItem With {.ID = i, .C1 = i Mod 2, .C2 = i * 0.5 Mod 3, .C3 = "C3 " & i, .C4 = i Mod 2 = 0, .C5 = New Date(2013 + i, 12, 16)}).ToList()
        End If
        Return DirectCast(HttpContext.Current.Session(key), List(Of GridDataItem))
    End Function
    Public Shared Function GetData2() As List(Of GridDataItem)
        Dim key = "34FAA431-CF79-4869-9488-93F6AAE81265"
        If HttpContext.Current.Session(key) Is Nothing Then
            HttpContext.Current.Session(key) = Enumerable.Range(0, 100).Select(Function(i) New GridDataItem With {.ID = i, .C2 = i, .C3 = "C3 " & i, .C4 = i Mod 2 = 0, .C5 = New Date(2013 + i, 12, 16)}).ToList()
        End If
        Return DirectCast(HttpContext.Current.Session(key), List(Of GridDataItem))
    End Function
End Class
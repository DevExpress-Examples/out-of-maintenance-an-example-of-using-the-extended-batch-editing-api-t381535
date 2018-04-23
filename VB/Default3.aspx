<%@ Page Language="vb" AutoEventWireup="true" CodeFile="Default3.aspx.vb" Inherits="Default3" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title></title>
    <script>
        var currentCellInfo = null;
        function OnRowDeleting(s, e) {
            setTimeout(function () { lbl.SetText(gridView.batchEditApi.GetDeletedRowIndices().length) }, 0);
        }
        function CheckFocusedCell() {
            if (currentCellInfo == null)
                return;
            alert(gridView.batchEditApi.GetCellValue(currentCellInfo.rowVisibleIndex, currentCellInfo.column.fieldName, "intial"));

        }
        function ChangeValues() {
            var indices = gridView.batchEditApi.GetRowVisibleIndices();
            var selectedItem = comboBox.GetSelectedItem();
            var value = 7;
            switch (selectedItem.text) {
                case "C4":
                    value = true;
                    break;
                case "C5":
                    value = new Date("11/1/2016");
                    break;
                case "C3":
                    value = "Text Example";
                default:
                    break;
            }
            var avoidhHighlighting = !checkBox.GetChecked();
            for (var i = 0; i < indices.length; i++) {
                gridView.batchEditApi.SetCellValue(indices[i], selectedItem.text, value, null, avoidhHighlighting);
            }
        }
        function OnInit(s, e) {
            HandleCellFocusActions(s);
        }
        function HandleCellFocusActions(grid) {
            ASPxClientUtils.AttachEventToElement(grid.GetMainElement(), "keydown", function (evt) {
                if (evt.keyCode === ASPxClientUtils.StringToShortcutCode("UP") || evt.keyCode === ASPxClientUtils.StringToShortcutCode("DOWN") ||
                    evt.keyCode === ASPxClientUtils.StringToShortcutCode("RIGHT") || evt.keyCode === ASPxClientUtils.StringToShortcutCode("LEFT"))
                    setTimeout(function () { currentCellInfo = grid.GetFocusedCell(); }, 0);
            });
            ASPxClientUtils.AttachEventToElement(grid.GetMainElement(), "mousedown", function (evt) {
                setTimeout(function () { currentCellInfo = grid.GetFocusedCell(); }, 0);
            });
        }
    </script>
</head>
<body>
    <form id="form1" runat="server">
        <div style="float: left">
            <dx:ASPxGridView ID="ASPxGridView1" runat="server" ClientInstanceName="gridView"
                KeyFieldName="ID" OnBatchUpdate="ASPxGridView1_BatchUpdate">
                <SettingsEditing Mode="Batch" />
                <Columns>
                    <dx:GridViewCommandColumn ShowNewButtonInHeader="true" ShowEditButton="true" ShowDeleteButton="true" />
                    <dx:GridViewDataColumn FieldName="C1" />
                    <dx:GridViewDataSpinEditColumn FieldName="C2" />
                    <dx:GridViewDataTextColumn FieldName="C3">

                    </dx:GridViewDataTextColumn>
                    <dx:GridViewDataCheckColumn FieldName="C4">
                    </dx:GridViewDataCheckColumn>
                    <dx:GridViewDataDateColumn FieldName="C5" />
                </Columns>
                <SettingsBehavior ConfirmDelete="false" />
                <ClientSideEvents Init="OnInit" BatchEditRowDeleting="OnRowDeleting" />
                <Templates>
                     <StatusBar>                        
                        <b>Deleted Rows:</b>
                        <dx:ASPxLabel runat="server" ID="lbl" ForeColor="Red" ClientInstanceName="lbl" EnableClientSideAPI="true"></dx:ASPxLabel>
                    </StatusBar>
                </Templates>
            </dx:ASPxGridView>
        </div>
        <div style="width: 78%; float: right">
            <dx:ASPxFormLayout runat="server" ID="formLayout">
                <Items>
                    <dx:LayoutGroup ColCount="1" Caption="Get the intial (unmodified) value of the last focused cell:">
                        <Items>
                            <dx:LayoutItem ShowCaption="False">
                                <LayoutItemNestedControlCollection>
                                    <dx:LayoutItemNestedControlContainer ID="LayoutItemNestedControlContainer1" runat="server">
                                        <dx:ASPxButton ID="ASPxButton1" runat="server" Text="Test" AutoPostBack="false">
                                            <ClientSideEvents Click="function(s, e) {
                     CheckFocusedCell();
            }" />
                                        </dx:ASPxButton>
                                    </dx:LayoutItemNestedControlContainer>
                                </LayoutItemNestedControlCollection>
                            </dx:LayoutItem>
                        </Items>
                    </dx:LayoutGroup>
                    <dx:LayoutGroup ColCount="2" Caption="Change values for all cells of a selected column:">
                        <Items>
                            <dx:LayoutItem Caption="FieldName">
                                <LayoutItemNestedControlCollection>
                                    <dx:LayoutItemNestedControlContainer ID="LayoutItemNestedControlContainer2" runat="server">
                                        <dx:ASPxComboBox runat="server" ID="comboBox" SelectedIndex="0" DropDownStyle="DropDownList" ClientInstanceName="comboBox">
                                            <Items>
                                                <dx:ListEditItem Text="C1" Value="C1" />
                                                <dx:ListEditItem Text="C2" Value="C2" />
                                                <dx:ListEditItem Text="C3" Value="C3" />
                                                <dx:ListEditItem Text="C4" Value="C4" />
                                                <dx:ListEditItem Text="C5" Value="C5" />
                                            </Items>
                                        </dx:ASPxComboBox>
                                    </dx:LayoutItemNestedControlContainer>
                                </LayoutItemNestedControlCollection>
                            </dx:LayoutItem>
                            <dx:LayoutItem Caption="Highlight">
                                <LayoutItemNestedControlCollection>
                                    <dx:LayoutItemNestedControlContainer ID="LayoutItemNestedControlContainer3" runat="server">
                                        <dx:ASPxCheckBox runat="server" ID="checkBox" ClientInstanceName="checkBox"></dx:ASPxCheckBox>
                                    </dx:LayoutItemNestedControlContainer>
                                </LayoutItemNestedControlCollection>
                            </dx:LayoutItem>
                            <dx:LayoutItem ColSpan="2" ShowCaption="False" HorizontalAlign="Left">
                                <LayoutItemNestedControlCollection>
                                    <dx:LayoutItemNestedControlContainer ID="LayoutItemNestedControlContainer4" runat="server">
                                        <dx:ASPxButton ID="ASPxButton2" runat="server" Text="Test" AutoPostBack="false">
                                            <ClientSideEvents Click="function(s, e) {
                 ChangeValues();
             }" />
                                        </dx:ASPxButton>
                                    </dx:LayoutItemNestedControlContainer>
                                </LayoutItemNestedControlCollection>
                            </dx:LayoutItem>
                        </Items>
                    </dx:LayoutGroup>
                </Items>
            </dx:ASPxFormLayout>
        </div>
    </form>
</body>
</html>
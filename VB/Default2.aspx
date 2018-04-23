<%@ Page Language="vb" AutoEventWireup="true" CodeFile="Default2.aspx.vb" Inherits="Default2" %>
<%@ Register Assembly="DevExpress.Web.v16.1, Version=16.1.3.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a"
    Namespace="DevExpress.Web" TagPrefix="dx" %>
<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title></title>
    <script>
        function OnCardValidating(s, e) {
            var columnToCheck = s.GetColumnByField(comboBox.GetText());
            var cellValidationInfo = e.validationInfo[columnToCheck.index];
            var oldValue = s.batchEditApi.GetCellValue(e.visibleIndex, columnToCheck.fieldName, "initial");
            if (cellValidationInfo.value == oldValue)
                return;
            var response = IsDuplicate(s, columnToCheck, cellValidationInfo.value, e.visibleIndex);
            if (response == true) {
                cellValidationInfo.isValid = false;
                cellValidationInfo.errorText = "This value has already been entered. Duplicates are not allowed.";
            }

        }
        function IsDuplicate(control, column, cellvalue, currentIndex) {
            var duplicatefound = false;
            var visibleIndices = control.batchEditApi.GetCardVisibleIndices();
            for (var i = 0; i < visibleIndices.length; i++) {
                if (visibleIndices[i] == currentIndex)
                    continue;
                var data = control.batchEditApi.GetCellValue(visibleIndices[i], column.fieldName);
                if (cellvalue == data || (cellvalue instanceof Date && data.getTime() == cellvalue.getTime())) {
                    duplicatefound = true;
                    break;
                }
            }
            return duplicatefound;
        }
    </script>
</head>
<body>
    <form id="form1" runat="server">
        <dx:ASPxComboBox runat="server" SelectedIndex="0" DropDownStyle="DropDownList" Theme="MetropolisBlue" ClientInstanceName="comboBox" ID="comboBox">
            <Items>
                <dx:ListEditItem Text="C2" Value="C2" />
                <dx:ListEditItem Text="C3" Value="C3" />
                <dx:ListEditItem Text="C5" Value="C5" />
            </Items>
        </dx:ASPxComboBox>
        <dx:ASPxCardView runat="server" ID="cardView" KeyFieldName="ID" AutoGenerateColumns="false" Theme="MetropolisBlue"  OnBatchUpdate="cardView_BatchUpdate" ClientInstanceName="cardView">
            <SettingsEditing Mode="Batch"></SettingsEditing>
            <Columns>

                <dx:CardViewSpinEditColumn FieldName="C2">
                </dx:CardViewSpinEditColumn>
                <dx:CardViewTextColumn FieldName="C3">
                </dx:CardViewTextColumn>
                <dx:CardViewCheckColumn FieldName="C4">
                </dx:CardViewCheckColumn>
                <dx:CardViewDateColumn FieldName="C5">
                </dx:CardViewDateColumn>
            </Columns>
            <SettingsPager>
                <SettingsTableLayout RowsPerPage="2" />
            </SettingsPager>
            <CardLayoutProperties>
                <Items>
                    <dx:CardViewColumnLayoutItem ColumnName="C2"></dx:CardViewColumnLayoutItem>
                    <dx:CardViewColumnLayoutItem ColumnName="C3">
                    </dx:CardViewColumnLayoutItem>
                    <dx:CardViewColumnLayoutItem ColumnName="C4"></dx:CardViewColumnLayoutItem>
                    <dx:CardViewColumnLayoutItem ColumnName="C5"></dx:CardViewColumnLayoutItem>
                    <dx:CardViewCommandLayoutItem ShowNewButton="true" ShowEditButton="true" ShowDeleteButton="true"></dx:CardViewCommandLayoutItem>
                </Items>
            </CardLayoutProperties>
            <ClientSideEvents BatchEditCardValidating="OnCardValidating" />
            <Settings ShowHeaderPanel="true" />
        </dx:ASPxCardView>
    </form>
</body>
</html>
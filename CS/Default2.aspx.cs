using DevExpress.Web.Data;
using System;
using System.Collections.Generic;
using System.Collections.Specialized;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Default2 : System.Web.UI.Page
{
    protected void Page_Init(object sender, EventArgs e)
    {
        cardView.DataSource = GridDataItem.GetData2();
        if (!IsPostBack)
            cardView.DataBind();
    }
    protected void cardView_BatchUpdate(object sender, ASPxDataBatchUpdateEventArgs e)
    {
        foreach (var args in e.InsertValues)
            InsertNewItem(args.NewValues);
        foreach (var args in e.UpdateValues)
            UpdateItem(args.Keys, args.NewValues);
        foreach (var args in e.DeleteValues)
            DeleteItem(args.Keys, args.Values);

        e.Handled = true;
    }

    protected GridDataItem InsertNewItem(OrderedDictionary newValues)
    {
        var item = new GridDataItem() { ID = GridDataItem.GetData().Count };
        LoadNewValues(item, newValues);
        GridDataItem.GetData().Add(item);
        return item;
    }

    protected GridDataItem UpdateItem(OrderedDictionary keys, OrderedDictionary newValues)
    {
        var id = Convert.ToInt32(keys["ID"]);
        var item = GridDataItem.GetData().First(i => i.ID == id);
        LoadNewValues(item, newValues);
        return item;
    }

    protected GridDataItem DeleteItem(OrderedDictionary keys, OrderedDictionary values)
    {
        var id = Convert.ToInt32(keys["ID"]);
        var item = GridDataItem.GetData().First(i => i.ID == id);
        GridDataItem.GetData().Remove(item);
        return item;
    }

    protected void LoadNewValues(GridDataItem item, OrderedDictionary values)
    {
        item.C1 = Convert.ToInt32(values["C1"]);
        item.C2 = Convert.ToDouble(values["C2"]);
        item.C3 = Convert.ToString(values["C3"]);
        item.C4 = Convert.ToBoolean(values["C4"]);
        item.C5 = Convert.ToDateTime(values["C5"]);
    }
}
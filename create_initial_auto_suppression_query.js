<script type="javascript" runat="server">

    Platform.Load("core","1");
    var debug = 1;

    try {

        var prox = new Script.Util.WSProxy();

        var qd = {}
        qd.Name = "Daily_Frequency_Suppression";
        qd.CustomerKey = "Daily_Frequency_Suppression";
        qd.QueryText = "select top 1 'test@example.com' [Email Address]";
        qd.TargetType = "DE";
        qd.TargetUpdateType = "Overwrite";
        qd.DataExtensionTarget = {};
        qd.DataExtensionTarget.Name = "Daily_Frequency_Suppression";
        qd.DataExtensionTarget.CustomerKey = "Daily_Frequency_Suppression";
        qd.CategoryID = 47352;

        var response = prox.createItem("QueryDefinition", qd);

        if (debug) {
            Write("<br>response: " + Stringify(response));
        }

    } catch (e) {

        if (debug) {
            Write("<br>e: " + Stringify(e));
        }

    }

</script>

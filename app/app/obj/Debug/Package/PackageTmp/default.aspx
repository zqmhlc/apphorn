<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="default.aspx.cs" Inherits="app._default" %>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 3.2//EN">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title>test V1.3</title>
    <script src="jquery-1.7.2.min.js" type="text/javascript"></script>
    <script type="text/javascript">
        $(function () {
            //            var t = document.getElementById("fr");
            //            //var k= t.firstChild.contentWindow;
            //            var k = t.src;
            //            //t.src = "about:blank";
            //            $.get('http://logo.mycos.org/imageshow/index.htm?width=1', function (r) {
            //                alert(r);
            //            });
            //$('#tttt').load('http://www.baidu.com');
            //sendData();

            $('input[name=tt]').click(function () {
                var radValue = $("input:radio[name='tt']:checked").val();
                if (radValue == 1) {
                    $('#b').hide();
                    $('#a').show();
                } else {
                    $('#b').show();
                    $('#a').hide();
                }
            });

            $('#btn').click(function () {
                //                $.post('Handler1.ashx?a=rfe&url=' + escape($('#TextBox1').val()), function (data) {
                //                    alert(data);
                //                    //$('#divHtml').html(data);
                //                }, function (data) {
                //                    alert(data);
                //                });

                $.ajax({
                    async: true,
                    url: 'Handler1.ashx?a=rfe&url=' + escape($('#txturl').val()),
                    type: "post",
                    dataType: "text",
                    cache: false,
                    success: function (data) {
                        $('#div1').html(data);
                    },
                    error: function (data,a,e) {
                        alert(data);
                    }
                });

            });
        });

        function sendData() {
            var state = 0;
            var $iframe = $("#fr");
            $iframe.bind('load', function () {
                if (state === 1) {
                    try {
                        var data = $(this)[0].contentWindow.name; //iframe的src已经转到同域，所以可以访问iframe的name了.即：实现了跨域.
                        $("#tttt").html("你获取的数据是：" + data);
                        $iframe.height(data);
                        $iframe.attr("src", "http://logo.mycos.org/imageshow/index.htm"); //第一次触发iframe的onload事件。                          
                    } catch (e) { }
                } else if (state === 0) {
                    state = 1;
                    $(this)[0].contentWindow.location = "about:blank"; //$(this)[0].contentWindow相当于iframe的window,再次触发iframe的onload事件
                }

            });
        }
    </script>    
</head>
<body>
    <input type="radio" name="tt" id="ra" value="1" runat="server" />
    <label for="ra">本地</label>
    <input type="radio" name="tt" id="rb" value="2" checked="true" runat="server" />
    <label for="rb">服务器</label>
    <div id="a" style="display: none">
        <input type="text" id="txturl" style="width:200px" />
        <input type="button" id="btn" value="submit" />
        <div id="div1" style="width: 100%; height: 90%; ">
        </div>
    </div>
    <div id="b">
    <form id="Form1" runat="server">
    <asp:TextBox ID="TextBox1" runat="server" Width="200px"></asp:TextBox>
    <asp:Button ID="Button1" runat="server" OnClick="Button1_Click" Text="submit" OnClientClick="$('#flag').val($('#TextBox1').val());" />
    </form>
    <div id="divHtml" runat="server" style="width: 100%; height: 100%;">
    </div>
    <div id="ychtml" runat="server" style="width: 100%; height: 100%;">
    </div>
    <input type="hidden" id="flag" runat="server" />
    </div>
    <%--<iframe src="http://logo.mycos.org/imageshow/" width="100%" height="100%" id="fr" ></iframe>--%>
    <%--<div id="tttt" style="height:30px"></div>--%>
</body>
</html>

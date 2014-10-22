﻿<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="test.aspx.cs" Inherits="app.test" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <script language="JavaScript">

        function DX(n) {
            if (!/^(0|[1-9]\d*)(\.\d+)?$/.test(n)) return "数据非法";
            var unit = "千百拾亿千百拾万千百拾元角分", str = "";

            //unit = unit.substr(unit.length - n.length);
            if (n.toString().length > 2) {
                for (var i = 0; i < n.toString().length; i++)
                    str += '零一二三四五六七八九十'.charAt(n.toString().charAt(i)); return str;
            } else {
                for (var i = 0; i < n.toString().length; i++)
                    str += '十一二三四五六七八九十'.charAt(n.toString().charAt(i)); return str;
            }
        }

        dCol = 'FF0000'; //date colour.
        fCol = '0000C0'; //face colour.
        sCol = 'FF0000'; //seconds colour.
        mCol = '0000FF'; //minutes colour.
        hCol = 'C000C0'; //hours colour.
        ClockHeight = 40;
        ClockWidth = 40;
        ClockFromMouseY = 0;
        ClockFromMouseX = 100;

        //Alter nothing below! Alignments will be lost!

        d = new Array("星期日", "星期一", "星期二", "星期三", "星期四", "星期五", "星期六");
        m = new Array("一月", "二月", "三月", "四月", "五月", "六月", "七月", "八月", "九月", "十月", "十一月", "十二月");
        date = new Date();
        day = date.getDate();
        year = date.getYear();
        if (year < 2000) year = year + 1900;
        TodaysDate = " " + DX(year) + "年 " + m[date.getMonth()] + " " + DX(day) + "日 " + d[date.getDay()] + "";
        D = TodaysDate.split('');
        H = '...';
        H = H.split('');
        M = '....';
        M = M.split('');
        S = '.....';
        S = S.split('');
        Face = '1 2 3 4 5 6 7 8 9 10 11 12';
        font = 'Arial';
        size = 1;
        speed = 0.6;
        ns = (document.layers);
        ie = (document.all);
        Face = Face.split(' ');
        n = Face.length;
        a = size * 10;
        ymouse = 0;
        xmouse = 0;
        scrll = 0;
        props = "<font face=" + font + " size=" + size + " color=" + fCol + "><B>";
        props2 = "<font face=" + font + " size=" + size + " color=" + dCol + "><B>";
        Split = 360 / n;
        Dsplit = 360 / D.length;
        HandHeight = ClockHeight / 4.5
        HandWidth = ClockWidth / 4.5
        HandY = -7;
        HandX = -2.5;
        scrll = 0;
        step = 0.06;
        currStep = 0;
        y = new Array(); x = new Array(); Y = new Array(); X = new Array();
        for (i = 0; i < n; i++) { y[i] = 0; x[i] = 0; Y[i] = 0; X[i] = 0 }
        Dy = new Array(); Dx = new Array(); DY = new Array(); DX = new Array();
        for (i = 0; i < D.length; i++) { Dy[i] = 0; Dx[i] = 0; DY[i] = 0; DX[i] = 0 }
        if (ns) {
            for (i = 0; i < D.length; i++)
                document.write('<layer name="nsDate' + i + '" top=0 left=0 height=' + a + ' width=' + a + '><center>' + props2 + D[i] + '</font></center></layer>');
            for (i = 0; i < n; i++)
                document.write('<layer name="nsFace' + i + '" top=0 left=0 height=' + a + ' width=' + a + '><center>' + props + Face[i] + '</font></center></layer>');
            for (i = 0; i < S.length; i++)
                document.write('<layer name=nsSeconds' + i + ' top=0 left=0 width=15 height=15><font face=Arial size=3 color=' + sCol + '><center><b>' + S[i] + '</b></center></font></layer>');
            for (i = 0; i < M.length; i++)
                document.write('<layer name=nsMinutes' + i + ' top=0 left=0 width=15 height=15><font face=Arial size=3 color=' + mCol + '><center><b>' + M[i] + '</b></center></font></layer>');
            for (i = 0; i < H.length; i++)
                document.write('<layer name=nsHours' + i + ' top=0 left=0 width=15 height=15><font face=Arial size=3 color=' + hCol + '><center><b>' + H[i] + '</b></center></font></layer>');
        }
        if (ie) {
            document.write('<div id="Od" style="position:absolute;top:0px;left:0px"><div style="position:relative">');
            for (i = 0; i < D.length; i++)
                document.write('<div id="ieDate" style="position:absolute;top:0px;left:0;height:' + a + ';width:' + a + ';text-align:center">' + props2 + D[i] + '</B></font></div>');
            document.write('</div></div>');
            document.write('<div id="Of" style="position:absolute;top:0px;left:0px"><div style="position:relative">');
            for (i = 0; i < n; i++)
                document.write('<div id="ieFace" style="position:absolute;top:0px;left:0;height:' + a + ';width:' + a + ';text-align:center">' + props + Face[i] + '</B></font></div>');
            document.write('</div></div>');
            document.write('<div id="Oh" style="position:absolute;top:0px;left:0px"><div style="position:relative">');
            for (i = 0; i < H.length; i++)
                document.write('<div id="ieHours" style="position:absolute;width:16px;height:16px;font-family:Arial;font-size:16px;color:' + hCol + ';text-align:center;font-weight:bold">' + H[i] + '</div>');
            document.write('</div></div>');
            document.write('<div id="Om" style="position:absolute;top:0px;left:0px"><div style="position:relative">');
            for (i = 0; i < M.length; i++)
                document.write('<div id="ieMinutes" style="position:absolute;width:16px;height:16px;font-family:Arial;font-size:16px;color:' + mCol + ';text-align:center;font-weight:bold">' + M[i] + '</div>');
            document.write('</div></div>')
            document.write('<div id="Os" style="position:absolute;top:0px;left:0px"><div style="position:relative">');
            for (i = 0; i < S.length; i++)
                document.write('<div id="ieSeconds" style="position:absolute;width:16px;height:16px;font-family:Arial;font-size:16px;color:' + sCol + ';text-align:center;font-weight:bold">' + S[i] + '</div>');
            document.write('</div></div>')
        }
        (ns) ? window.captureEvents(Event.MOUSEMOVE) : 0;
        function Mouse(evnt) {
            ymouse = (ns) ? evnt.pageY + ClockFromMouseY - (window.pageYOffset) : event.y + ClockFromMouseY;
            xmouse = (ns) ? evnt.pageX + ClockFromMouseX : event.x + ClockFromMouseX;
        }
        (ns) ? window.onMouseMove = Mouse : document.onmousemove = Mouse;
        function ClockAndAssign() {
            time = new Date();
            secs = time.getSeconds();
            sec = -1.57 + Math.PI * secs / 30;
            mins = time.getMinutes();
            min = -1.57 + Math.PI * mins / 30;
            hr = time.getHours();
            hrs = -1.575 + Math.PI * hr / 6 + Math.PI * parseInt(time.getMinutes()) / 360;
            if (ie) {
                Od.style.top = window.document.body.scrollTop;
                Of.style.top = window.document.body.scrollTop;
                Oh.style.top = window.document.body.scrollTop;
                Om.style.top = window.document.body.scrollTop;
                Os.style.top = window.document.body.scrollTop;
            }
            for (i = 0; i < n; i++) {
                var F = (ns) ? document.layers['nsFace' + i] : ieFace[i].style;
                F.top = y[i] + ClockHeight * Math.sin(-1.0471 + i * Split * Math.PI / 180) + scrll;
                F.left = x[i] + ClockWidth * Math.cos(-1.0471 + i * Split * Math.PI / 180);
            }
            for (i = 0; i < H.length; i++) {
                var HL = (ns) ? document.layers['nsHours' + i] : ieHours[i].style;
                HL.top = y[i] + HandY + (i * HandHeight) * Math.sin(hrs) + scrll;
                HL.left = x[i] + HandX + (i * HandWidth) * Math.cos(hrs);
            }
            for (i = 0; i < M.length; i++) {
                var ML = (ns) ? document.layers['nsMinutes' + i] : ieMinutes[i].style;
                ML.top = y[i] + HandY + (i * HandHeight) * Math.sin(min) + scrll;
                ML.left = x[i] + HandX + (i * HandWidth) * Math.cos(min);
            }
            for (i = 0; i < S.length; i++) {
                var SL = (ns) ? document.layers['nsSeconds' + i] : ieSeconds[i].style;
                SL.top = y[i] + HandY + (i * HandHeight) * Math.sin(sec) + scrll;
                SL.left = x[i] + HandX + (i * HandWidth) * Math.cos(sec);
            }
            for (i = 0; i < D.length; i++) {
                var DL = (ns) ? document.layers['nsDate' + i] : ieDate[i].style;
                DL.top = Dy[i] + ClockHeight * 1.5 * Math.sin(currStep + i * Dsplit * Math.PI / 180) + scrll;
                DL.left = Dx[i] + ClockWidth * 1.5 * Math.cos(currStep + i * Dsplit * Math.PI / 180);
            }
            currStep -= step;
        }
        function Delay() {
            scrll = (ns) ? window.pageYOffset : 0;
            Dy[0] = Math.round(DY[0] += ((ymouse) - DY[0]) * speed);
            Dx[0] = Math.round(DX[0] += ((xmouse) - DX[0]) * speed);
            for (i = 1; i < D.length; i++) {
                Dy[i] = Math.round(DY[i] += (Dy[i - 1] - DY[i]) * speed);
                Dx[i] = Math.round(DX[i] += (Dx[i - 1] - DX[i]) * speed);
            }
            y[0] = Math.round(Y[0] += ((ymouse) - Y[0]) * speed);
            x[0] = Math.round(X[0] += ((xmouse) - X[0]) * speed);
            for (i = 1; i < n; i++) {
                y[i] = Math.round(Y[i] += (y[i - 1] - Y[i]) * speed);
                x[i] = Math.round(X[i] += (x[i - 1] - X[i]) * speed);
            }
            ClockAndAssign();
            setTimeout('Delay()', 20);
        }
        if (ns || ie) window.onload = Delay;
        //-->
    </script>
</head>
<body>
    <form id="form1" runat="server">
    <div>
    
    <asp:GridView ID="GridView1" runat="server" BackColor="White" BorderColor="#999999" 
            BorderStyle="None" BorderWidth="1px" CellPadding="3" GridLines="Vertical">
        <AlternatingRowStyle BackColor="#DCDCDC" />
        <FooterStyle BackColor="#CCCCCC" ForeColor="Black" />
        <HeaderStyle BackColor="#000084" Font-Bold="True" ForeColor="White" />
        <PagerStyle BackColor="#999999" ForeColor="Black" HorizontalAlign="Center" />
        <RowStyle BackColor="#EEEEEE" ForeColor="Black" />
        <SelectedRowStyle BackColor="#008A8C" Font-Bold="True" ForeColor="White" />
        <SortedAscendingCellStyle BackColor="#F1F1F1" />
        <SortedAscendingHeaderStyle BackColor="#0000A9" />
        <SortedDescendingCellStyle BackColor="#CAC9C9" />
        <SortedDescendingHeaderStyle BackColor="#000065" />
    </asp:GridView>
    </div>
    </form>
</body>
</html>

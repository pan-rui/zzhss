/**
 * Created by Administrator on 2015/11/11.
 */
$.extend($.fn.datagrid.methods, {
    getExcelXml: function (jq, param) {
        var worksheet = this.createWorksheet(jq, param);
        var totalWidth = 0;
        var cfs = $(jq).datagrid('getColumnFields');
        /* **删除前面行以及后面行************begin****************/
            for (var i = param.removeFirstCol?param.removeFirstCol:0; i < (param.removeLastCol?cfs.length - param.removeLastCol:cfs.length); i++)
                totalWidth += $(jq).datagrid('getColumnOption', cfs[i]).width;
        /*****************************end*********************************/
        return '<?xml version="1.0" encoding="utf-8"?>' +
            '<ss:Workbook xmlns:ss="urn:schemas-microsoft-com:office:spreadsheet" xmlns:x="urn:schemas-microsoft-com:office:excel" xmlns:o="urn:schemas-microsoft-com:office:office">' +
            '<o:DocumentProperties><o:Title>' + param.title + '</o:Title></o:DocumentProperties>' +
            '<ss:ExcelWorkbook>' +
            '<ss:WindowHeight>' + worksheet.height + '</ss:WindowHeight>' +
            '<ss:WindowWidth>' + worksheet.width + '</ss:WindowWidth>' +
            '<ss:ProtectStructure>False</ss:ProtectStructure>' +
            '<ss:ProtectWindows>False</ss:ProtectWindows>' +
            '</ss:ExcelWorkbook>' +
            '<ss:Styles>' +
            '<ss:Style ss:ID="Default">' +
            '<ss:Alignment ss:Vertical="Top"  />' +
            '<ss:Font ss:FontName="arial" ss:Size="12" />' +
            '<ss:Borders>' +
            '<ss:Border  ss:Weight="1" ss:LineStyle="Continuous" ss:Position="Top" />' +
            '<ss:Border  ss:Weight="1" ss:LineStyle="Continuous" ss:Position="Bottom" />' +
            '<ss:Border  ss:Weight="1" ss:LineStyle="Continuous" ss:Position="Left" />' +
            '<ss:Border ss:Weight="1" ss:LineStyle="Continuous" ss:Position="Right" />' +
            '</ss:Borders>' +
            '<ss:Interior />' +
            '<ss:NumberFormat />' +
            '<ss:Protection />' +
            '</ss:Style>' +
            '<ss:Style ss:ID="title">' +
            '<ss:Borders />' +
            '<ss:Font />' +
            '<ss:Alignment  ss:Vertical="Center" ss:Horizontal="Center" />' +
            '<ss:NumberFormat ss:Format="@" />' +
            '</ss:Style>' +
            '<ss:Style ss:ID="headercell">' +
            '<ss:Font ss:Bold="1" ss:Size="13" />' +
            '<ss:Alignment  ss:Horizontal="Center" />' +
            '<ss:Interior ss:Pattern="Solid"  />' +
            '</ss:Style>' +
            '<ss:Style ss:ID="even">' +
            '<ss:Interior ss:Pattern="Solid"  />' +
            '</ss:Style>' +
            '<ss:Style ss:Parent="even" ss:ID="evendate">' +
            '<ss:NumberFormat ss:Format="yyyy-mm-dd" />' +
            '</ss:Style>' +
            '<ss:Style ss:Parent="even" ss:ID="evenint">' +
            '<ss:NumberFormat ss:Format="0" />' +
            '</ss:Style>' +
            '<ss:Style ss:Parent="even" ss:ID="evenfloat">' +
            '<ss:NumberFormat ss:Format="0.00" />' +
            '</ss:Style>' +
            '<ss:Style ss:ID="odd">' +
            '<ss:Interior ss:Pattern="Solid"  />' +
            '</ss:Style>' +
            '<ss:Style ss:Parent="odd" ss:ID="odddate">' +
            '<ss:NumberFormat ss:Format="yyyy-mm-dd" />' +
            '</ss:Style>' +
            '<ss:Style ss:Parent="odd" ss:ID="oddint">' +
            '<ss:NumberFormat ss:Format="0" />' +
            '</ss:Style>' +
            '<ss:Style ss:Parent="odd" ss:ID="oddfloat">' +
            '<ss:NumberFormat ss:Format="0.00" />' +
            '</ss:Style>' +
            '</ss:Styles>' +
            worksheet.xml +
            '</ss:Workbook>';
    },
    createWorksheet: function (jq, param) {
        var totalWidthInPixels = 0;
        var colXml = '';
        var headerXml = '';
        var cfs = $(jq).datagrid('getColumnFields');
        var colCount = cfs.length;
        var cstartIndex = param.removeFirstCol?param.removeFirstCol:0, cendIndex =param.removeLastCol?colCount-param.removeLastCol:colCount;
        for (var i = cstartIndex; i < cendIndex; i++) {
            if (cfs[i] != '') {
                var w = $(jq).datagrid('getColumnOption', cfs[i]).width;
                totalWidthInPixels += w;
                    colXml += '<ss:Column ss:AutoFitWidth="1" ss:Width="100" />';
                    headerXml += '<ss:Cell ss:StyleID="headercell">' +
                        '<ss:Data ss:Type="String">' + $(jq).datagrid('getColumnOption', cfs[i]).title.replace("<br>","") + '</ss:Data>' +
                        '<ss:NamedCell ss:Name="Print_Titles" /></ss:Cell>';
            }
        }
        var result = {
            height: 9000,
            width: Math.floor(totalWidthInPixels * 30) + 50
        };
        var rows = $(jq).datagrid('getRows');
        var t = '<ss:Worksheet ss:Name="' + param.title + '">' +
            '<ss:Names>' +
            '<ss:NamedRange ss:Name="Print_Titles" ss:RefersTo="=\'' + param.title + '\'!R1:R2" />' +
            '</ss:Names>' +
            '<ss:Table x:FullRows="1" x:FullColumns="1"' +
            ' ss:ExpandedColumnCount="' + (colCount + 2) +
            '" ss:ExpandedRowCount="' + (rows.length + 2) + '">' +
            colXml +
            '<ss:Row ss:AutoFitHeight="1" >' +
            headerXml +
            '</ss:Row>';
        for (var i = 0; i < rows.length; i++) {
            t += '<ss:Row>';
            var cellClass = (i & 1) ? 'odd' : 'even';
            r = rows[i];
            for (var j = cstartIndex; j < cendIndex; j++) {
                if (cfs[j] != '') {
                    var v = r[cfs[j]].replace(/(<br>)/g,"");
                        t += '<ss:Cell ss:StyleID="' + cellClass + '"><ss:Data ss:Type="String">';
                        var opt=$(jq).datagrid('getColumnOption', cfs[j])
                        if(opt.formatter==undefined||opt.formatter=='')
                        t+=v;
                        else t+=opt.formatter(v);
                        t += '</ss:Data></ss:Cell>';
                }
            }
            t += '</ss:Row>';
        }
        result.xml = t + '</ss:Table>' +
            '<x:WorksheetOptions>' +
            '<x:PageSetup>' +
            '<x:Layout x:CenterHorizontal="1" x:Orientation="Landscape" />' +
            '<x:Footer x:Data="Page &P of &N" x:Margin="0.5" />' +
            '<x:PageMargins x:Top="0.5" x:Right="0.5" x:Left="0.5" x:Bottom="0.8" />' +
            '</x:PageSetup>' +
            '<x:FitToPage />' +
            '<x:Print>' +
            '<x:PrintErrors>Blank</x:PrintErrors>' +
            '<x:FitWidth>1</x:FitWidth>' +
            '<x:FitHeight>32767</x:FitHeight>' +
            '<x:ValidPrinterInfo />' +
            '<x:VerticalResolution>600</x:VerticalResolution>' +
            '</x:Print>' +
            '<x:Selected />' +
            '<x:DoNotDisplayGridlines />' +
            '<x:ProtectObjects>False</x:ProtectObjects>' +
            '<x:ProtectScenarios>False</x:ProtectScenarios>' +
            '</x:WorksheetOptions>' +
            '</ss:Worksheet>';
        return result;
    }
});

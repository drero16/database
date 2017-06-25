function PrintElem()
{
var width = $(window).width() * 0.9;
    var height = $(window).height() * 0.9;
    var content = '<!DOCTYPE html>' + 
                  '<html>' +
                  '<head><title>Rescate Animal Maipú</title></head>' +
                  '<body onload="window.focus(); window.print(); window.close();">' + 
                  '<h1 align="center">Animal encontrado</h1>'+
                  '<img src="http://localhost:3000/images/1/original/happy.jpg?1498373454" style="width: 100%;" />' +
                  '</body>' +
                  '</html>';
    var options = "toolbar=no,location=no,directories=no,menubar=no,scrollbars=yes,width=" + width + ",height=" + height;
    var printWindow = window.open('', 'print', options);
    printWindow.document.open();
    printWindow.document.write(content);
    printWindow.document.close();
    printWindow.focus();
}
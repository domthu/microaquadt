// Place your application-specific JavaScript functions and classes here
// This file is automatically included by javascript_include_tag :defaults

/****************** jqGrid **********************************/
function grid_complete() {
//try 
  var ids = jQuery("#sites").jqGrid('getDataIDs');
    for(var i=0;i < ids.length;i++) {
      var cl = ids[i];
      show = "Show"
      jQuery("#sites").jqGrid('setRowData',ids[i],{ act: show }
    );
  }
//catch err:
//  alert(err); 
} 

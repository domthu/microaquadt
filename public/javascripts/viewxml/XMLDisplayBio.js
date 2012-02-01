/* Copyright (c) 2007 Lev Muchnik <LevMuchnik@gmail.com>. All rights reserved.
 * You may copy and modify this script as long as the above copyright notice,
 * this condition and the following disclaimer is left intact.
 * This software is provided by the author "AS IS" and no warranties are
 * implied, including fitness for a particular purpose. In no event shall
 * the author be liable for any damages arising in any way out of the use
 * of this software, even if advised of the possibility of such damage.
 * $Date: 2007-10-03 19:08:15 -0700 (Wed, 03 Oct 2007) $
 */

function LoadXML(ParentElementID,URL) 
{
		var xmlHolderElement = GetParentElement(ParentElementID);
		if (xmlHolderElement==null) { return false; }
		ToggleElementVisibility(xmlHolderElement);
		return RequestURL(URL,URLReceiveCallback,ParentElementID);
}
function LoadEsearchXMLDom(ParentElementID,xmlDoc) 
{
	if (xmlDoc) {
		var Result = xmlDoc.xml 

		var xmlHolderElement = GetParentElement(ParentElementID);
		if (xmlHolderElement==null) { return ''; }
		while (xmlHolderElement.childNodes.length) { xmlHolderElement.removeChild(xmlHolderElement.childNodes.item(xmlHolderElement.childNodes.length-1));	}
		return Result;
	}
	else { return ''; }
}

function LoadEsearchTextDom(ParentElementID,str) 
{
	if (str) {
		var Result = str.replace('[','').replace(']','').replace(/"/g,'') 

		var xmlHolderElement = GetParentElement(ParentElementID);
		if (xmlHolderElement==null) { return ''; }
		while (xmlHolderElement.childNodes.length) { xmlHolderElement.removeChild(xmlHolderElement.childNodes.item(xmlHolderElement.childNodes.length-1));	}
        var ids_array = Result.split(',')
        var id = undefined
        for (var i = 0; i < ids_array.length; ++i) {
            id = ids_array[i]
            var TagElement = GetNewEsearch(id);
            xmlHolderElement.appendChild(TagElement);	
        }
		return Result;
	}
	else { return ''; }
}


function LoadXMLDom(ParentElementID,xmlDoc) 
{
    IDCounter = 1;
    NestingIndent = 15;
	if (xmlDoc) {
		var xmlHolderElement = GetParentElement(ParentElementID);
		if (xmlHolderElement==null) { return false; }
		while (xmlHolderElement.childNodes.length) { xmlHolderElement.removeChild(xmlHolderElement.childNodes.item(xmlHolderElement.childNodes.length-1));	}
		var Result = ShowXML(xmlHolderElement,xmlDoc.documentElement,0);
		
		//var ReferenceElement = document.createElement('div');
		//var Link = document.createElement('a');		
		//Link.setAttribute('href','http://www.levmuchnik.net/Content/ProgrammingTips/WEB/XMLDisplay/DisplayXMLFileWithJavascript.html');
		//var TextNode = document.createTextNode('Source: Lev Muchnik');
		//Link.appendChild(TextNode);
		//xmlHolderElement.appendChild(Link);

		return Result;
	}
	else { return false; }
}
function LoadXMLString(ParentElementID,XMLString) 
{
    IDCounter = 1;
    NestingIndent = 15;
	xmlDoc = CreateXMLDOM(XMLString);
	return LoadXMLDom(ParentElementID,xmlDoc) ;
}
////////////////////////////////////////////////////////////
// HELPER FUNCTIONS - SHOULD NOT BE DIRECTLY CALLED BY USERS
////////////////////////////////////////////////////////////
function GetParentElement(ParentElementID)
{
	if (typeof(ParentElementID)=='string') {	return document.getElementById(ParentElementID);	}
	else if (typeof(ParentElementID)=='object') { return ParentElementID;} 
	else { return null; }
}
function URLReceiveCallback(httpRequest,xmlHolderElement)
{
	  try {
            if (httpRequest.readyState == 4) {
                if (httpRequest.status == 200) {
					var xmlDoc = httpRequest.responseXML;
					if (xmlHolderElement && xmlHolderElement!=null) {
							xmlHolderElement.innerHTML = '';
							return LoadXMLDom(xmlHolderElement,xmlDoc);
					}
                } else {
                    return false;
                }
            }
        }
        catch( e ) {
            return false;
        }	
}
function RequestURL(url,callback,ExtraData) { // based on: http://developer.mozilla.org/en/docs/AJAX:Getting_Started
        var httpRequest;
        if (window.XMLHttpRequest) { // Mozilla, Safari, ...
            httpRequest = new XMLHttpRequest();
            if (httpRequest.overrideMimeType) { httpRequest.overrideMimeType('text/xml'); }
        } 
        else if (window.ActiveXObject) { // IE
            try { httpRequest = new ActiveXObject("Msxml2.XMLHTTP");   } 
            catch (e) {
				   try { httpRequest = new ActiveXObject("Microsoft.XMLHTTP"); } 
				   catch (e) {}
            }
        }
        if (!httpRequest) { return false;   }
        httpRequest.onreadystatechange = function() { callback(httpRequest,ExtraData); };
        httpRequest.open('GET', url, true);
        httpRequest.send('');
		return true;
    }
function CreateXMLDOM(XMLStr) 
{
	if (window.ActiveXObject)
	 {
		  xmlDoc=new ActiveXObject("Microsoft.XMLDOM"); 
		  xmlDoc.loadXML(XMLStr);	
		  return xmlDoc;
	}
	else if (document.implementation && document.implementation.createDocument)	  {
		  var parser=new DOMParser();
		  return parser.parseFromString(XMLStr,"text/xml");
	}
	else {
		return null;
	}
}		

var IDCounter = 1;
var NestingIndent = 15;
function ShowXML(xmlHolderElement,RootNode,indent)
{
	if (RootNode==null || xmlHolderElement==null) { return false; }
	var Result  = true;
	var TagEmptyElement = document.createElement('div');
	TagEmptyElement.className = 'Element';
	TagEmptyElement.style.position = 'relative';
	TagEmptyElement.style.left = NestingIndent+'px';


	if (RootNode.childNodes.length==0) { 
        var ClickableElement = AddTextNode(TagEmptyElement,'','Clickable') ;
        ClickableElement.id = 'div_empty_' + IDCounter;	  
        AddTextNode(TagEmptyElement,'<','Utility') ;
        AddTextNode(TagEmptyElement,RootNode.nodeName ,'NodeName') 
        for (var i = 0; RootNode.attributes && i < RootNode.attributes.length; ++i) {
          CurrentAttribute  = RootNode.attributes.item(i);
          AddTextNode(TagEmptyElement,' ' + CurrentAttribute.nodeName ,'AttributeName') ;
          AddTextNode(TagEmptyElement,'=','Utility') ;
          AddTextNode(TagEmptyElement,'"' + CurrentAttribute.nodeValue + '"','AttributeValue') ;
        }
        AddTextNode(TagEmptyElement,' />') ;
        xmlHolderElement.appendChild(TagEmptyElement);	
  
	}
	else { // mo child nodes

     var onlyonetime = false     //Use for Multiple Taxonomy to not repeat the head lineage
     var doindent = false        //Use for starting lineage indentation
     var taxons=RootNode.getElementsByTagName("Taxon")
     var lex = undefined        
     for (t=0;t<taxons.length;t++){
      var taxon = taxons[t]
      lex=taxon.getElementsByTagName("LineageEx")[0]
      if (lex != undefined) {
        //Researched taxonomy--
        var x_TaxId = GetValue(taxon.getElementsByTagName("TaxId")[0], "") 
        var x_ScientificName = GetValue(taxon.getElementsByTagName("ScientificName")[0], "") 
        var x_Rank = GetValue(taxon.getElementsByTagName("Rank")[0], "") 
        var x_parentId = GetValue(taxon.getElementsByTagName("ParentTaxId")[0], "") 
        // for multiple request avoid 
        if (onlyonetime) {
            var xTaxElement = GetNewNode(NestingIndent*IDCounter, x_TaxId, x_ScientificName, x_Rank, IDCounter);
            xmlHolderElement.appendChild(xTaxElement);	
            TaxId = ScientificName = Rank = '';
        }
        else
        {

        //Parents
        var xel = null
        var TaxId = ""
        var ScientificName = ""
        var Rank = ""
        var xname = ""
        if (lex == undefined) { return true; }
        var ton= null
        for (l=0;l<lex.childNodes.length;l++){
            if (lex.childNodes[l].nodeType != 3) {
                ton= lex.childNodes[l]
                for (i=0;i<ton.childNodes.length;i++){
                    xel = ton.childNodes[i]
                    if (ton.childNodes[i].nodeType != 3) {
                        xname = xel.nodeName
                        for (b=0;b<xel.childNodes.length;b++){
                            if (xel.childNodes[b].nodeType == 3) {
                                switch (xname) {
                                case 'TaxId':
                                    TaxId = xel.childNodes[b].nodeValue;
                                break;
                                case 'ScientificName':
                                    ScientificName = xel.childNodes[b].nodeValue;
                                break;
                                case 'Rank':
                                    Rank = xel.childNodes[b].nodeValue;
                                    // Add element to document--
                                    if (doindent == true) { NestingIndent++;} 
	                                var TagElement = GetNewNode(NestingIndent, TaxId, ScientificName, Rank, IDCounter);
                                    // Add researched taxonomy--
                                    if (x_parentId == TaxId) {
                                        //if lvl > 0 do reccursive call--
                                        var xTaxElement = GetNewNode(NestingIndent, x_TaxId, x_ScientificName, x_Rank, IDCounter);
                                        TagElement.appendChild(xTaxElement);
                                        doindent = true	
                                        onlyonetime = true
                                        //TODO see childs there are in the xml response try taxo id 6072. 
                                    }
                                    xmlHolderElement.appendChild(TagElement);	
                                    TaxId = ScientificName = Rank = '';
                                break;
                                case 'LineageEx':
                                    //if lvl > 0 do reccursive call-- 
                                    //Result &= ShowXML(TagElement,RootNode.childNodes.item(i),indent+1);--
                                    Result &= ShowXML(TagElement,xel,indent+1);
                                break;
                                default:
                                    var x = 'something worng'
                                break;
                                }
                            }
                        }            
                    }
                }
            }
        }
        }
        }
        }
        return Result;
    }
}
function GetNewNode(NestingIndent, TaxId, ScientificName, Rank, IDCounter){

    var TagActionSel = document.createElement('div');
    TagActionSel.onclick = function() { AutoSelect(' ' + TaxId, ScientificName); };
    TagActionSel.className = 'taxosel pointer';

    var TagActionLookUp = document.createElement('div');
    TagActionLookUp.onclick = function() { RecalTaxo(' ' + TaxId); };
    TagActionLookUp.className = 'taxolookup pointer';

    var TagElement = document.createElement('div');
    //TagElement.onclick = function() {RecalTaxo("'" + TaxId + "'"); } 
    //TagElement.onclick = "RecalTaxo(); return false;" 
    //TagElement.onclick = function() { RecalTaxo(' ' + TaxId); };
    TagElement.id = 'div_empty_' + IDCounter;	
    ++IDCounter;
    TagElement.className = 'Element';
    TagElement.style.cursor = 'pointer';
    TagElement.style.position = 'relative';
    TagElement.style.left = NestingIndent+'px';

    AddTextNode(TagElement,' ' + TaxId + ': ' + ScientificName + ' ---> [' + Rank + ']','AttributeName') ;

    TagElement.appendChild(TagActionLookUp)
    TagElement.appendChild(TagActionSel)

    return TagElement;
}


function GetNewEsearch(TaxId){
    var TagElement = document.createElement('div');
    //TagElement.onclick = function() { RecalTaxo(' ' + TaxId); };
    //TagElement.id = 'div_empty_' + IDCounter;	
    TagElement.className = 'bioesearch pointer';
    TagElement.style.cursor = 'pointer';
    TagElement.style.position = 'relative';
    TagElement.style.float = 'left';
    TagElement.innerHTML = TaxId;
    //AddTextNode(TagElement,' ' + TaxId,'') ;
    return TagElement;
}


function AddTextNode(ParentNode,Text,Class) 
{
	NewNode = document.createElement('span');
	if (Class) {  NewNode.className  = Class;}
	if (Text) { NewNode.appendChild(document.createTextNode(Text)); }
	if (ParentNode) { ParentNode.appendChild(NewNode); }
	return NewNode;		
}
function GetValue(parent, pdefault){
    if (parent != undefined){
        for (p=0;p<parent.childNodes.length;p++){
            if (parent.childNodes[p].nodeType == 3) {
                return parent.childNodes[p].nodeValue
            }
        }
    }
    else {
        return pdefault;
    }
}

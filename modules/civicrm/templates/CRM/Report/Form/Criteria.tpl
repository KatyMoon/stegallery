{*
 +--------------------------------------------------------------------+
 | CiviCRM version 3.2                                                |
 +--------------------------------------------------------------------+
 | Copyright CiviCRM LLC (c) 2004-2010                                |
 +--------------------------------------------------------------------+
 | This file is a part of CiviCRM.                                    |
 |                                                                    |
 | CiviCRM is free software; you can copy, modify, and distribute it  |
 | under the terms of the GNU Affero General Public License           |
 | Version 3, 19 November 2007 and the CiviCRM Licensing Exception.   |
 |                                                                    |
 | CiviCRM is distributed in the hope that it will be useful, but     |
 | WITHOUT ANY WARRANTY; without even the implied warranty of         |
 | MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.               |
 | See the GNU Affero General Public License for more details.        |
 |                                                                    |
 | You should have received a copy of the GNU Affero General Public   |
 | License and the CiviCRM Licensing Exception along                  |
 | with this program; if not, contact CiviCRM LLC                     |
 | at info[AT]civicrm[DOT]org. If you have questions about the        |
 | GNU Affero General Public License or the licensing of CiviCRM,     |
 | see the CiviCRM license FAQ at http://civicrm.org/licensing        |
 +--------------------------------------------------------------------+
*}
{* Report form criteria section *}
    {if $colGroups}

	           <h3>Display Columns</h3>
 
        {foreach from=$colGroups item=grpFields key=dnc}
            {assign  var="count" value="0"}
            <table class="criteria-group">
                {if $grpFields.group_title}<tr><td colspan=4>&raquo;&nbsp;{$grpFields.group_title}:</td></tr>{/if}
                <tr class="crm-report crm-report-criteria-field crm-report-criteria-field-{$dnc}">
                    {foreach from=$grpFields.fields item=title key=field}
                        {assign var="count" value=`$count+1`}
                        <td width="25%">{$form.fields.$field.html}</td>
                        {if $count is div by 4}
                            </tr><tr class="crm-report crm-report-criteria-field crm-report-criteria-field_{$dnc}">
                        {/if}
                    {/foreach}
                    {if $count is not div by 4}
                        <td colspan="4 - ($count % 4)"></td>
                    {/if}
                </tr>
            </table>
        {/foreach}
    {/if}
    
    {if $groupByElements}
        <h3>Group by Columns</h3>
        {assign  var="count" value="0"}
        <table class="report-layout">
            <tr class="crm-report crm-report-criteria-groupby">
                {foreach from=$groupByElements item=gbElem key=dnc}
                    {assign var="count" value=`$count+1`}
                    <td width="25%" {if $form.fields.$gbElem} onClick="selectGroupByFields('{$gbElem}');"{/if}>
                        {$form.group_bys[$gbElem].html}
                        {if $form.group_bys_freq[$gbElem].html}:<br>
                            &nbsp;&nbsp;{$form.group_bys_freq[$gbElem].label}&nbsp;{$form.group_bys_freq[$gbElem].html}
                        {/if}
                    </td>
                    {if $count is div by 4}
                        </tr><tr class="crm-report crm-report-criteria-groupby">
                    {/if}
                {/foreach}
                {if $count is not div by 4}
                    <td colspan="4 - ($count % 4)"></td>
                {/if}
            </tr>
        </table>      
    {/if}

    {if $form.options.html || $form.options.html}
        <h3>Other Options</h3>
        <table class="report-layout">
            <tr class="crm-report crm-report-criteria-groupby">
	        <td>{$form.options.html}</td>
	        {if $form.blank_column_end}
	            <td>{$form.blank_column_end.label}&nbsp;&nbsp;{$form.blank_column_end.html}</td>
                {/if}
            </tr>
        </table>
    {/if}
  
    {if $filters}
        <h3>Set Filters</h3>
        <table class="report-layout">
            {foreach from=$filters     item=table key=tableName}
 	        {assign  var="filterCount" value=$table|@count}
	        {if $colGroups.$tableName.group_title and $filterCount gte 1}</table><table class="report-layout"><tr class="crm-report crm-report-criteria-filter crm-report-criteria-filter-{$tableName}"><td colspan=3>&raquo;&nbsp;{$colGroups.$tableName.group_title}:</td></tr>{/if} 
                {foreach from=$table       item=field key=fieldName}
                    {assign var=fieldOp     value=$fieldName|cat:"_op"}
                    {assign var=filterVal   value=$fieldName|cat:"_value"}
                    {assign var=filterMin   value=$fieldName|cat:"_min"}
                    {assign var=filterMax   value=$fieldName|cat:"_max"}
                    {if $field.operatorType & 4}
                        <tr class="report-contents crm-report crm-report-criteria-filter crm-report-criteria-filter-{$tableName}">
                            <td class="label report-contents">{$field.title}</td>
                            {include file="CRM/Core/DateRange.tpl" fieldName=$fieldName}
                        </tr>
                    {elseif $form.$fieldOp.html}
                        <tr class="report-contents crm-report crm-report-criteria-filter crm-report-criteria-filter-{$tableName}" {if $field.no_display} style="display: none;"{/if}>
                            <td class="label report-contents">{$field.title}</td>
                            <td class="report-contents">{$form.$fieldOp.html}</td>
                            <td>
                               <span id="{$filterVal}_cell">{$form.$filterVal.label}&nbsp;{$form.$filterVal.html}</span>
                               <span id="{$filterMin}_max_cell">{$form.$filterMin.label}&nbsp;{$form.$filterMin.html}&nbsp;&nbsp;{$form.$filterMax.label}&nbsp;{$form.$filterMax.html}</span>
                            </td>
                        </tr>
                    {/if}
                {/foreach}
            {/foreach}
        </table>
    {/if}
 
    {literal}
    <script type="text/javascript">
    {/literal}
        {foreach from=$filters item=table key=tableName}
            {foreach from=$table item=field key=fieldName}
		{literal}var val = "dnc";{/literal}
		{if !($field.operatorType == 4) && !$field.no_display} 
                    {literal}var val = document.getElementById("{/literal}{$fieldName}_op{literal}").value;{/literal}
		{/if}
                {literal}showHideMaxMinVal( "{/literal}{$fieldName}{literal}", val );{/literal}
            {/foreach}
        {/foreach}

        {literal}
        function showHideMaxMinVal( field, val ) {
            var fldVal    = field + "_value_cell";
            var fldMinMax = field + "_min_max_cell";
            if ( val == "bw" || val == "nbw" ) {
                cj('#' + fldVal ).hide();
                cj('#' + fldMinMax ).show();
            } else if (val =="nll" || val == "nnll") {
                cj('#' + fldVal).hide() ;
                cj('#' + field + '_value').val('');
                cj('#' + fldMinMax ).hide();
            } else {
                cj('#' + fldVal ).show();
                cj('#' + fldMinMax ).hide();
            }
        }
	    
	function selectGroupByFields(id) {
	    var field = 'fields\['+ id+'\]';
	    var group = 'group_bys\['+ id+'\]';	
	    var groups = document.getElementById( group ).checked;
	    if ( groups == 1 ) {
	        document.getElementById( field ).checked = true;	
	    } else {
	        document.getElementById( field ).checked = false;	    
	    }	
	}
    </script>
    {/literal}

    <div>{$form.buttons.html}</div>
{*
 *  blob.tpl
 *  gitphp: A PHP git repository browser
 *  Component: Blob view template
 *
 *  Copyright (C) 2009 Christopher Han <xiphux@gmail.com>
 *}

 {include file='header.tpl'}

 {* If we managed to look up commit info, we have enough info to display the full header - othewise just use a simple header *}
 <div class="page_nav">
   {if $fullnav}
     <a href="{$SCRIPT_NAME}?p={$project->GetProject()}&a=summary">summary</a> | <a href="{$SCRIPT_NAME}?p={$project->GetProject()}&a=shortlog">shortlog</a> | <a href="{$SCRIPT_NAME}?p={$project->GetProject()}&a=log">log</a> | <a href="{$SCRIPT_NAME}?p={$project->GetProject()}&a=commit&h={$hashbase}">commit</a> | <a href="{$SCRIPT_NAME}?p={$project->GetProject()}&a=commitdiff&h={$hashbase}">commitdiff</a> | <a href="{$SCRIPT_NAME}?p={$project->GetProject()}&a=tree&h={$tree}&hb={$hashbase}">tree</a><br />
     {if $file}
       <a href="{$SCRIPT_NAME}?p={$project->GetProject()}&a=blob_plain&h={$hash}&f={$file}">plain</a> | 
       {if ($hashbase != "HEAD") && ($hashbase != $head)}
         <a href="{$SCRIPT_NAME}?p={$project->GetProject()}&a=blob&hb=HEAD&f={$file}">HEAD</a>
       {else}
         HEAD
       {/if}
       {if !$mime && !$data} | <a href="{$SCRIPT_NAME}?p={$project->GetProject()}&a=blame&h={$hash}&f={$file}&hb={$hashbase}">blame</a>{/if}
       <br />
     {else}
       <a href="{$SCRIPT_NAME}?p={$project->GetProject()}&a=blob_plain&h={$hash}">plain</a><br />
     {/if}
   {else}
     <br /><br />
   {/if}
 </div>
 <div>
   {if $fullnav}
     <a href="{$SCRIPT_NAME}?p={$project->GetProject()}&a=commit&h={$hashbase}" class="title">{$title}
     {if $hashbaseref}
       <span class="tag">{$hashbaseref}</span>
     {/if}
     </a>
   {else}
     <div class="title">{$hash}</div>
   {/if}
 </div>
 <div class="page_path">
   {* The path to the file, with directories broken into tree links *}
   <b>
     <a href="{$SCRIPT_NAME}?p={$project->GetProject()}&a=tree&hb={$hashbase}&h={$hashbase}">[{$project->GetProject()}]</a> / 
     {foreach from=$paths item=path name=paths}
       {if $smarty.foreach.paths.last}
         <a href="{$SCRIPT_NAME}?p={$project->GetProject()}&a=blob_plain&h={$path.tree}&f={$path.full}">{$path.short}</a>
       {else}
         <a href="{$SCRIPT_NAME}?p={$project->GetProject()}&a=tree&hb={$hashbase}&h={$path.tree}&f={$path.full}">{$path.short}</a> / 
       {/if}
     {/foreach}
   </b>
 </div>
 <div class="page_body">
   {if $mime && $data}
     {* We're trying to display an image *}
     <div>
       <img src="data:{$mime};base64,{$data}" />
     </div>
   {elseif $geshiout}
     {* We're using the highlighted output from geshi *}
     {$geshiout}
   {else}
     {* Just plain display *}
     <table class="code">
     {foreach from=$lines item=line name=lines}
       <tr>
         <td class="num"><a id="l{$smarty.foreach.lines.iteration}" href="#l{$smarty.foreach.lines.iteration}" class="linenr">{$smarty.foreach.lines.iteration}</a></td>
	 <td class="codeline">{$line|escape:'html'}</td>
     {/foreach}
     </table>
   {/if}
 </div>

 {include file='footer.tpl'}

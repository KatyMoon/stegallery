// $Id$

if (Drupal.jsEnabled) {
	$(document).ready(function () {
		
		//Check for access level
		if(Drupal.settings.picnik_access == 'full'){	
			$('body').find('img:not('+Drupal.settings.picnik_css_skip+')').each(function(){
				// Don't mess with admin-menu icons
				if(!$(this).parents('li').hasClass('admin-menu-icon')){
					add_link($(this));
				}
			});
		}else if(Drupal.settings.picnik_access == 'restricted'){
			if(!Drupal.settings.picnik_css_selector == ""){
				$(Drupal.settings.picnik_css_selector).find('img:not('+Drupal.settings.picnik_css_skip+')').each(function(){
					// Don't mess with admin-menu icons
          if(!$(this).parents('li').hasClass('admin-menu-icon')){				
						add_link($(this));
					}
				});
			}
		}
		
		
		$('.picnik-img-wrap').hover(
			function(){
				var pic_link =	$(this).find('a');
				pic_link.fadeIn('fast');
				pic_link.click(function(){
					location.assign(pic_link.attr('href'));
					return false;
				});
			},
			function(){$(this).find('a').hide();}
		);
		
		if($('#picnick-preview-original').length && $('#picnick-preview-new').length){
			if($('#picnick-preview-original img').width() > $('#picnick-preview-original').width()){
				$('#picnick-preview-original img').width("100%");
			}
			if($('#picnick-preview-new img').width() > $('#picnick-preview-new').width()){
				$('#picnick-preview-new img').width("100%");
			}
		}
	});

	function add_link(img){
		var host = 'http://' + location.host;
		var link = host + '/picnik/process/' + Drupal.settings.picnik_return;
		var path = "";
		var imageid;
					
		if(img.hasClass('imagecache')){
			path = img.attr('src');
			path.slice(0,6);
			var parts = path.split('/');
			for (x in parts) {
				if(parts[x] == "imagecache"){
					var imagecache = parts.splice(x,2);
					link = link.concat("/true");
					break;
				}
		  }
			path = parts.join('/');
		}else{
			path = img.attr('src');
			if(path && path.search(host) == -1){
				path = host.concat(path);
			}
		}
		// Only proceed if path is defined
		if(path){			
			imageid = path.replace("http://"+location.host+"/", "");

			//Debug for local development
			// path = "http://www.picnik.com/graphics/api/api_sample_1.jpg";
		
			var request = 'http://www.picnik.com/service/?_apikey='+Drupal.settings.picnik_api_key
										+'&_import='+path
										+'&_export='+link
										+'&_export_agent=browser&_replace=yes&_imageid='+imageid
										+'&_export_title=Save Changes&_close_target='+location.href
										+'&_exclude=in,out';
			img.wrap("<span class='picnik-img-wrap'></span>");
			var overlay_w = $(window).width() - 20;
			var overlay_h = $(window).height() -20;
			img.after("<a href='"+request+"'>Edit in Picnik</a>");		
		}
	}

}

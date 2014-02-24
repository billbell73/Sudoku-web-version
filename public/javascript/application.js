$(document).ready(function(){
	if($('.incorrect-just-entered').length) {
  	setTimeout(function(){window.location.reload();},1000);
	}
	$(".animated.rotateOut").bind("animationend webkitAnimationEnd oAnimationEnd"  
		+ "MSAnimationEnd", function(){ window.location.reload(); });
})

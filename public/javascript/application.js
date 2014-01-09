$(document).ready(function(){
	if($('.incorrect-just-entered').length) {
  	setTimeout(function(){window.location.reload();},1000);
	}
	if($('.animated.rotateOut').length) {
		window.location.reload();
	}
})

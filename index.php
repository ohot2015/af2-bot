<?php
	$arr = explode(chr(13), file_get_contents('autoit_af2/mylog.txt'));
	krsort($arr);
	$txt = implode(chr(13), $arr);
	echo nl2br($txt);
?>
<script type="text/javascript">
 setTimeout(function(){
	location.reload()
},500)
</script>

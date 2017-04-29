<?php
	$arr = explode(chr(13), file_get_contents('autoit_af2/mylog.txt'));
	krsort($arr);
	$arr = array_slice ($arr, 3 ,300);
	$txt = implode(chr(13), $arr);
	echo nl2br($txt);
?>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.1.0/jquery.min.js"></script>
<script type="text/javascript">
 setTimeout(function(){
 	 $.ajax({
        method: "POST",
        url:'index.php',
        //data:{selectHouse: $(':selected',this).val()},
        success:function(data) {
            $('body').html(data);
        }
    });
	//location.reload()
},1000)
</script>

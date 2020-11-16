<html>
<body>
<?php
	$cpu = `lscpu`;
	echo $cpu;
	$cmd = `cat /proc/cmdline`;
	echo $cmd;
	$root = `mount | grep ' / '`; 
	echo $root;

?>
</body>
</html>

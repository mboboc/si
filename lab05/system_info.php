<html>
	<head/>
	<body>
<?php
	echo "<h1>Root device</h1>";
	$root = shell_exec('mount | grep /');
	echo "<pre>$root</pre>";

	echo "<h1>Kernel parameters</h1>";
	$params = shell_exec('sysctl -a');
	echo "<pre>$params</pre>";
?>
	</body>
</html>


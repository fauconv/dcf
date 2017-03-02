<?php
$dir = realpath(__DIR__.'/../../config/sites.php');
$dir = realpath($dir); // 2 times cause we have to resolve unix symlink and windows symlink
require_once($dir);
<?php

/**
 * @file
 * Contains \DrupalProject\composer\ScriptHandler.
 */

namespace DCF;

use Composer\Script\Event;
use Composer\Util\Filesystem;

class ScriptHandler {
  
  const DRUSH_PATH = 'drush';
  
  private static function getBinPath($composer) {
    $filesystem = new Filesystem();
    $config = $composer->getConfig();
    $vendorPath = $filesystem->normalizePath(realpath($config->get('bin-dir')));
    return $vendorPath;
  }
  
  private static function updateDrush($bin) {
    $files = array('drush', 'drush.php', 'drush.launcher');
    $root = dirname(dirname($bin)); // to improve
    $drush_path = $root.'/'.ScriptHandler::DRUSH_PATH.'/site-aliases';
    foreach($files as $file) {
      $abs_file = $bin.'/'.$file;
      if(is_file($abs_file)) {
        $content = file_get_contents($abs_file);
        $content = str_replace('${dir}/'.$file.'"','${dir}/'.$file.'" --alias-path='.$drush_path,$content);
        file_put_contents($abs_file, $content);
      }
    }
  }
  
  public static function postInstall(Event $event) {
    $composer = $event->getComposer();
    $bin  = ScriptHandler::getBinPath($composer);
    ScriptHandler::updateDrush($bin);
  }
  
}

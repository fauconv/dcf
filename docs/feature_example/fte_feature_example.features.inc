<?php
/**
 * @file
 * fte_feature_example.features.inc
 */

/**
 * Implements hook_ctools_plugin_api().
 */
function fte_feature_example_ctools_plugin_api($module = NULL, $api = NULL) {
  if ($module == "strongarm" && $api == "strongarm") {
    return array("version" => "1");
  }
}

/**
 * Implements hook_views_api().
 */
function fte_feature_example_views_api($module = NULL, $api = NULL) {
  return array("api" => "3.0");
}

/**
 * Implements hook_node_info().
 */
function fte_feature_example_node_info() {
  $items = array(
    'exemple_intra' => array(
      'name' => t('exemple'),
      'base' => 'node_content',
      'description' => t('Type de contenu exemple'),
      'has_title' => '1',
      'title_label' => t('Titre'),
      'help' => t('Pour qu\'untype de contenu exemple n\'apparaisse pas en page d\'accueil décocher la case "promu en page d\'accueil"'),
    ),
  );
  drupal_alter('node_info', $items);
  return $items;
}

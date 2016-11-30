<?php
/**
 * @file
 * fte_feature_example.features.field_base.inc
 * Ce fichier est généré automatiquement par feature
 */

function fte_feature_example_field_default_field_bases() {
  $field_bases = array();

  // Exported field_base: 'field_texte_exemple_intra'
  $field_bases['field_texte_exemple_intra'] = array(
    'active' => 1,
    'cardinality' => 1,
    'deleted' => 0,
    'entity_types' => array(),
    'field_name' => 'field_texte_exemple_intra',
    'foreign keys' => array(
      'format' => array(
        'columns' => array(
          'format' => 'format',
        ),
        'table' => 'filter_format',
      ),
    ),
    'indexes' => array(
      'format' => array(
        0 => 'format',
      ),
    ),
    'locked' => 0,
    'module' => 'text',
    'settings' => array(),
    'translatable' => 0,
    'type' => 'text_with_summary',
  );

  return $field_bases;
}

<?php
/**
 * @file
 * fte_feature_example.features.field_instance.inc
 */

/**
 * Implements hook_field_default_field_instances().
 */
function fte_feature_example_field_default_field_instances() {
  $field_instances = array();

  // Exported field_instance: 'node-exemple_intra-field_texte_exemple_intra'
  $field_instances['node-exemple_intra-field_texte_exemple_intra'] = array(
    'bundle' => 'exemple_intra',
    'default_value' => NULL,
    'deleted' => 0,
    'description' => '',
    'display' => array(
      'default' => array(
        'label' => 'hidden',
        'module' => 'text',
        'settings' => array(),
        'type' => 'text_default',
        'weight' => 2,
      ),
      'personnalisation' => array(
        'label' => 'hidden',
        'module' => 'smart_trim',
        'settings' => array(
          'more_link' => 0,
          'more_text' => 'Read more',
          'summary_handler' => 'trim',
          'trim_length' => 24,
          'trim_options' => array(
            'text' => 'text',
          ),
          'trim_suffix' => '...',
          'trim_type' => 'words',
        ),
        'type' => 'smart_trim_format',
        'weight' => 1,
      ),
      'rss' => array(
        'label' => 'hidden',
        'module' => 'text',
        'settings' => array(
          'trim_length' => 600,
        ),
        'type' => 'text_summary_or_trimmed',
        'weight' => 1,
      ),
      'teaser' => array(
        'label' => 'hidden',
        'module' => 'smart_trim',
        'settings' => array(
          'more_link' => 0,
          'more_text' => 'Read more',
          'summary_handler' => 'full',
          'trim_length' => 450,
          'trim_options' => array(
            'text' => 0,
          ),
          'trim_suffix' => '...',
          'trim_type' => 'chars',
        ),
        'type' => 'smart_trim_format',
        'weight' => 0,
      ),
    ),
    'entity_type' => 'node',
    'field_name' => 'field_texte_exemple_intra',
    'label' => 'Texte',
    'required' => 1,
    'settings' => array(
      'better_formats' => array(
        'allowed_formats' => array(
          'ckeditor_bloc' => 0,
          'ckeditor_etroit' => 0,
          'ckeditor_images_bloc' => 0,
          'ckeditor_images_etroit' => 0,
          'ckeditor_images_large' => 0,
          'ckeditor_images_liens_bloc' => 0,
          'ckeditor_images_liens_etroit' => 'ckeditor_images_liens_etroit',
          'ckeditor_images_liens_large' => 'ckeditor_images_liens_large',
          'ckeditor_large' => 0,
          'ckeditor_liens_bloc' => 0,
          'ckeditor_liens_etroit' => 0,
          'ckeditor_liens_large' => 0,
          'html' => 0,
          'mail' => 0,
          'plain_text' => 0,
        ),
        'allowed_formats_toggle' => 1,
        'default_order_toggle' => 0,
        'default_order_wrapper' => array(
          'formats' => array(
            'ckeditor_bloc' => array(
              'weight' => -7,
            ),
            'ckeditor_etroit' => array(
              'weight' => -3,
            ),
            'ckeditor_images_bloc' => array(
              'weight' => 4,
            ),
            'ckeditor_images_etroit' => array(
              'weight' => 5,
            ),
            'ckeditor_images_large' => array(
              'weight' => 1,
            ),
            'ckeditor_images_liens_bloc' => array(
              'weight' => 3,
            ),
            'ckeditor_images_liens_etroit' => array(
              'weight' => 0,
            ),
            'ckeditor_images_liens_large' => array(
              'weight' => 2,
            ),
            'ckeditor_large' => array(
              'weight' => -3,
            ),
            'ckeditor_liens_bloc' => array(
              'weight' => -8,
            ),
            'ckeditor_liens_etroit' => array(
              'weight' => -4,
            ),
            'ckeditor_liens_large' => array(
              'weight' => -4,
            ),
            'html' => array(
              'weight' => -2,
            ),
            'mail' => array(
              'weight' => 14,
            ),
            'plain_text' => array(
              'weight' => 10,
            ),
          ),
        ),
      ),
      'display_summary' => 1,
      'text_processing' => 1,
      'user_register_form' => FALSE,
    ),
    'widget' => array(
      'active' => 1,
      'module' => 'text',
      'settings' => array(
        'rows' => 20,
        'summary_rows' => 5,
      ),
      'type' => 'text_textarea_with_summary',
      'weight' => 3,
    ),
  );

  // Translatables
  // Included for use with string extractors like potx.
  t('Texte');


  return $field_instances;
}

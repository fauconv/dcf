<?php
/**
 * @file
 * fte_feature_example.views_default.inc
 */

/**
 * Implements hook_views_default_views().
 */
function fte_feature_example_views_default_views() {
  $export = array();

  $view = new view();
  $view->name = 'exemple_intra';
  $view->description = '';
  $view->tag = 'exemple';
  $view->base_table = 'node';
  $view->human_name = 'exemple';
  $view->core = 7;
  $view->api_version = '3.0';
  $view->disabled = FALSE; /* Edit this to true to make a default view disabled initially */

  /* Display: Master */
  $handler = $view->new_display('default', 'Master', 'default');
  $handler->display->display_options['title'] = 'exemple';
  $handler->display->display_options['use_more_always'] = FALSE;
  $handler->display->display_options['use_more_text'] = 'Plus';
  $handler->display->display_options['link_display'] = 'page';
  $handler->display->display_options['access']['type'] = 'perm';
  $handler->display->display_options['cache']['type'] = 'rules';
  $handler->display->display_options['query']['type'] = 'views_query';
  $handler->display->display_options['exposed_form']['type'] = 'basic';
  $handler->display->display_options['exposed_form']['options']['submit_button'] = 'Appliquer';
  $handler->display->display_options['exposed_form']['options']['reset_button_label'] = 'Réinitialiser';
  $handler->display->display_options['exposed_form']['options']['exposed_sorts_label'] = 'Trier par';
  $handler->display->display_options['pager']['type'] = 'full';
  $handler->display->display_options['pager']['options']['items_per_page'] = '10';
  $handler->display->display_options['pager']['options']['expose']['items_per_page_label'] = 'Éléments par page';
  $handler->display->display_options['pager']['options']['expose']['items_per_page_options_all_label'] = '- Tout -';
  $handler->display->display_options['pager']['options']['expose']['offset_label'] = 'Décalage';
  $handler->display->display_options['pager']['options']['tags']['first'] = '« premier';
  $handler->display->display_options['pager']['options']['tags']['previous'] = '‹ précédent';
  $handler->display->display_options['pager']['options']['tags']['next'] = 'suivant ›';
  $handler->display->display_options['pager']['options']['tags']['last'] = 'dernier »';
  $handler->display->display_options['style_plugin'] = 'default';
  $handler->display->display_options['row_plugin'] = 'node';
  /* Critère de tri: Contenu : Épinglé (en haut des listes) */
  $handler->display->display_options['sorts']['sticky']['id'] = 'sticky';
  $handler->display->display_options['sorts']['sticky']['table'] = 'node';
  $handler->display->display_options['sorts']['sticky']['field'] = 'sticky';
  $handler->display->display_options['sorts']['sticky']['order'] = 'DESC';
  /* Critère de tri: Contenu : Date (field_date_actu_intra) */
  $handler->display->display_options['sorts']['field_date_actu_intra_value']['id'] = 'field_date_actu_intra_value';
  $handler->display->display_options['sorts']['field_date_actu_intra_value']['table'] = 'field_data_field_date_actu_intra';
  $handler->display->display_options['sorts']['field_date_actu_intra_value']['field'] = 'field_date_actu_intra_value';
  $handler->display->display_options['sorts']['field_date_actu_intra_value']['order'] = 'DESC';
  /* Critère de tri: Contenu : Date de publication */
  $handler->display->display_options['sorts']['created']['id'] = 'created';
  $handler->display->display_options['sorts']['created']['table'] = 'node';
  $handler->display->display_options['sorts']['created']['field'] = 'created';
  $handler->display->display_options['sorts']['created']['order'] = 'DESC';
  /* Critère de filtrage: Contenu : Publié */
  $handler->display->display_options['filters']['status']['id'] = 'status';
  $handler->display->display_options['filters']['status']['table'] = 'node';
  $handler->display->display_options['filters']['status']['field'] = 'status';
  $handler->display->display_options['filters']['status']['value'] = 1;
  $handler->display->display_options['filters']['status']['group'] = 1;
  $handler->display->display_options['filters']['status']['expose']['operator'] = FALSE;
  /* Critère de filtrage: Contenu : Type */
  $handler->display->display_options['filters']['type']['id'] = 'type';
  $handler->display->display_options['filters']['type']['table'] = 'node';
  $handler->display->display_options['filters']['type']['field'] = 'type';
  $handler->display->display_options['filters']['type']['value'] = array(
    'exemple_intra' => 'exemple_intra',
  );

  /* Display: Page */
  $handler = $view->new_display('page', 'Page', 'page');
  $handler->display->display_options['path'] = 'exemple';
  $handler->display->display_options['menu']['type'] = 'normal';
  $handler->display->display_options['menu']['title'] = 'exemple';
  $handler->display->display_options['menu']['weight'] = '0';
  $handler->display->display_options['menu']['name'] = 'main-menu';
  $handler->display->display_options['menu']['context'] = 0;
  $handler->display->display_options['menu']['context_only_inline'] = 0;

  /* Display: Block accueil carrousel */
  $handler = $view->new_display('block', 'Block accueil carrousel', 'slider');
  $handler->display->display_options['defaults']['title'] = FALSE;
  $handler->display->display_options['defaults']['pager'] = FALSE;
  $handler->display->display_options['pager']['type'] = 'none';
  $handler->display->display_options['pager']['options']['offset'] = '0';
  $handler->display->display_options['defaults']['style_options'] = FALSE;
  $handler->display->display_options['defaults']['row_plugin'] = FALSE;
  $handler->display->display_options['row_plugin'] = 'fields';
  $handler->display->display_options['row_options']['separator'] = '-';
  $handler->display->display_options['row_options']['default_field_elements'] = FALSE;
  $handler->display->display_options['defaults']['row_options'] = FALSE;
  $handler->display->display_options['defaults']['fields'] = FALSE;
  /* Champ: Contenu : Titre */
  $handler->display->display_options['fields']['title']['id'] = 'title';
  $handler->display->display_options['fields']['title']['table'] = 'node';
  $handler->display->display_options['fields']['title']['field'] = 'title';
  $handler->display->display_options['fields']['title']['label'] = '';
  $handler->display->display_options['fields']['title']['alter']['max_length'] = '200';
  $handler->display->display_options['fields']['title']['alter']['preserve_tags'] = '<b>';
  $handler->display->display_options['fields']['title']['element_type'] = '0';
  $handler->display->display_options['fields']['title']['element_label_colon'] = FALSE;
  $handler->display->display_options['fields']['title']['element_wrapper_type'] = '0';
  $handler->display->display_options['fields']['title']['hide_empty'] = TRUE;
  $handler->display->display_options['fields']['title']['link_to_node'] = FALSE;
  /* Champ: Contenu : Date */
  $handler->display->display_options['fields']['field_date_actu_intra']['id'] = 'field_date_actu_intra';
  $handler->display->display_options['fields']['field_date_actu_intra']['table'] = 'field_data_field_date_actu_intra';
  $handler->display->display_options['fields']['field_date_actu_intra']['field'] = 'field_date_actu_intra';
  $handler->display->display_options['fields']['field_date_actu_intra']['label'] = '';
  $handler->display->display_options['fields']['field_date_actu_intra']['element_type'] = '0';
  $handler->display->display_options['fields']['field_date_actu_intra']['element_label_colon'] = FALSE;
  $handler->display->display_options['fields']['field_date_actu_intra']['element_wrapper_type'] = '0';
  $handler->display->display_options['fields']['field_date_actu_intra']['element_default_classes'] = FALSE;
  $handler->display->display_options['fields']['field_date_actu_intra']['settings'] = array(
    'format_type' => 'day_short',
    'fromto' => 'both',
    'multiple_number' => '',
    'multiple_from' => '',
    'multiple_to' => '',
  );
  /* Champ: Contenu : Texte */
  $handler->display->display_options['fields']['field_texte_actu_intra']['id'] = 'field_texte_actu_intra';
  $handler->display->display_options['fields']['field_texte_actu_intra']['table'] = 'field_data_field_texte_actu_intra';
  $handler->display->display_options['fields']['field_texte_actu_intra']['field'] = 'field_texte_actu_intra';
  $handler->display->display_options['fields']['field_texte_actu_intra']['label'] = '';
  $handler->display->display_options['fields']['field_texte_actu_intra']['alter']['max_length'] = '70';
  $handler->display->display_options['fields']['field_texte_actu_intra']['element_type'] = '0';
  $handler->display->display_options['fields']['field_texte_actu_intra']['element_label_colon'] = FALSE;
  $handler->display->display_options['fields']['field_texte_actu_intra']['element_wrapper_type'] = '0';
  $handler->display->display_options['fields']['field_texte_actu_intra']['element_default_classes'] = FALSE;
  $handler->display->display_options['fields']['field_texte_actu_intra']['hide_alter_empty'] = FALSE;
  $handler->display->display_options['fields']['field_texte_actu_intra']['type'] = 'smart_trim_format';
  $handler->display->display_options['fields']['field_texte_actu_intra']['settings'] = array(
    'trim_length' => '450',
    'trim_type' => 'chars',
    'trim_suffix' => '...',
    'more_link' => '0',
    'more_text' => 'Read more',
    'summary_handler' => 'full',
    'trim_options' => array(
      'text' => 0,
    ),
  );
  /* Champ: Contenu : Illustration */
  $handler->display->display_options['fields']['field_illustration_actu_intra']['id'] = 'field_illustration_actu_intra';
  $handler->display->display_options['fields']['field_illustration_actu_intra']['table'] = 'field_data_field_illustration_actu_intra';
  $handler->display->display_options['fields']['field_illustration_actu_intra']['field'] = 'field_illustration_actu_intra';
  $handler->display->display_options['fields']['field_illustration_actu_intra']['label'] = '';
  $handler->display->display_options['fields']['field_illustration_actu_intra']['element_type'] = '0';
  $handler->display->display_options['fields']['field_illustration_actu_intra']['element_label_colon'] = FALSE;
  $handler->display->display_options['fields']['field_illustration_actu_intra']['element_wrapper_type'] = '0';
  $handler->display->display_options['fields']['field_illustration_actu_intra']['element_default_classes'] = FALSE;
  $handler->display->display_options['fields']['field_illustration_actu_intra']['click_sort_column'] = 'fid';
  $handler->display->display_options['fields']['field_illustration_actu_intra']['settings'] = array(
    'image_style' => 'carrousel_actu_intra',
    'image_link' => '',
  );
  /* Champ: Contenu : Lien */
  $handler->display->display_options['fields']['view_node']['id'] = 'view_node';
  $handler->display->display_options['fields']['view_node']['table'] = 'views_entity_node';
  $handler->display->display_options['fields']['view_node']['field'] = 'view_node';
  $handler->display->display_options['fields']['view_node']['label'] = '';
  $handler->display->display_options['fields']['view_node']['element_type'] = '0';
  $handler->display->display_options['fields']['view_node']['element_label_colon'] = FALSE;
  $handler->display->display_options['fields']['view_node']['element_wrapper_type'] = '0';
  $handler->display->display_options['fields']['view_node']['element_default_classes'] = FALSE;
  $handler->display->display_options['defaults']['filter_groups'] = FALSE;
  $handler->display->display_options['defaults']['filters'] = FALSE;
  /* Critère de filtrage: Contenu : Publié */
  $handler->display->display_options['filters']['status']['id'] = 'status';
  $handler->display->display_options['filters']['status']['table'] = 'node';
  $handler->display->display_options['filters']['status']['field'] = 'status';
  $handler->display->display_options['filters']['status']['value'] = 1;
  $handler->display->display_options['filters']['status']['group'] = 1;
  $handler->display->display_options['filters']['status']['expose']['operator'] = FALSE;
  /* Critère de filtrage: Contenu : Type */
  $handler->display->display_options['filters']['type']['id'] = 'type';
  $handler->display->display_options['filters']['type']['table'] = 'node';
  $handler->display->display_options['filters']['type']['field'] = 'type';
  $handler->display->display_options['filters']['type']['value'] = array(
    'exemple_intra' => 'exemple_intra',
  );
  /* Critère de filtrage: Contenu : Promu en page d'accueil */
  $handler->display->display_options['filters']['promote']['id'] = 'promote';
  $handler->display->display_options['filters']['promote']['table'] = 'node';
  $handler->display->display_options['filters']['promote']['field'] = 'promote';
  $handler->display->display_options['filters']['promote']['value'] = '1';
  $handler->display->display_options['block_description'] = 'slider';
  $handler->display->display_options['block_caching'] = '8';

  /* Display: mini bloc 5 actu */
  $handler = $view->new_display('block', 'mini bloc 5 actu', 'mini_bloc');
  $handler->display->display_options['defaults']['title'] = FALSE;
  $handler->display->display_options['title'] = 'Les dernières exemple';
  $handler->display->display_options['defaults']['use_more'] = FALSE;
  $handler->display->display_options['use_more'] = TRUE;
  $handler->display->display_options['defaults']['use_more_always'] = FALSE;
  $handler->display->display_options['defaults']['use_more_always'] = FALSE;
  $handler->display->display_options['use_more_always'] = TRUE;
  $handler->display->display_options['defaults']['use_more_text'] = FALSE;
  $handler->display->display_options['use_more_text'] = 'Plus';
  $handler->display->display_options['defaults']['pager'] = FALSE;
  $handler->display->display_options['pager']['type'] = 'some';
  $handler->display->display_options['pager']['options']['items_per_page'] = '5';
  $handler->display->display_options['pager']['options']['offset'] = '0';
  $handler->display->display_options['defaults']['style_plugin'] = FALSE;
  $handler->display->display_options['style_plugin'] = 'list';
  $handler->display->display_options['defaults']['style_options'] = FALSE;
  $handler->display->display_options['defaults']['row_plugin'] = FALSE;
  $handler->display->display_options['row_plugin'] = 'fields';
  $handler->display->display_options['row_options']['inline'] = array(
    'title' => 'title',
    'field_date_actu_intra' => 'field_date_actu_intra',
  );
  $handler->display->display_options['row_options']['separator'] = '-';
  $handler->display->display_options['row_options']['default_field_elements'] = FALSE;
  $handler->display->display_options['defaults']['row_options'] = FALSE;
  $handler->display->display_options['defaults']['fields'] = FALSE;
  /* Champ: Contenu : Titre */
  $handler->display->display_options['fields']['title']['id'] = 'title';
  $handler->display->display_options['fields']['title']['table'] = 'node';
  $handler->display->display_options['fields']['title']['field'] = 'title';
  $handler->display->display_options['fields']['title']['label'] = '';
  $handler->display->display_options['fields']['title']['alter']['max_length'] = '25';
  $handler->display->display_options['fields']['title']['alter']['word_boundary'] = FALSE;
  $handler->display->display_options['fields']['title']['alter']['trim'] = TRUE;
  $handler->display->display_options['fields']['title']['element_type'] = '0';
  $handler->display->display_options['fields']['title']['element_label_colon'] = FALSE;
  $handler->display->display_options['fields']['title']['element_wrapper_type'] = '0';
  $handler->display->display_options['fields']['title']['element_default_classes'] = FALSE;
  /* Champ: Contenu : Date */
  $handler->display->display_options['fields']['field_date_actu_intra']['id'] = 'field_date_actu_intra';
  $handler->display->display_options['fields']['field_date_actu_intra']['table'] = 'field_data_field_date_actu_intra';
  $handler->display->display_options['fields']['field_date_actu_intra']['field'] = 'field_date_actu_intra';
  $handler->display->display_options['fields']['field_date_actu_intra']['label'] = '';
  $handler->display->display_options['fields']['field_date_actu_intra']['element_type'] = '0';
  $handler->display->display_options['fields']['field_date_actu_intra']['element_label_colon'] = FALSE;
  $handler->display->display_options['fields']['field_date_actu_intra']['element_wrapper_type'] = '0';
  $handler->display->display_options['fields']['field_date_actu_intra']['settings'] = array(
    'format_type' => 'day_short',
    'fromto' => 'both',
    'multiple_number' => '',
    'multiple_from' => '',
    'multiple_to' => '',
  );
  $handler->display->display_options['block_description'] = 'mini bloc 5 actu';
  $handler->display->display_options['block_caching'] = '8';
  $translatables['exemple_intra'] = array(
    t('Master'),
    t('exemple'),
    t('Plus'),
    t('Appliquer'),
    t('Réinitialiser'),
    t('Trier par'),
    t('Asc'),
    t('Desc'),
    t('Éléments par page'),
    t('- Tout -'),
    t('Décalage'),
    t('« premier'),
    t('‹ précédent'),
    t('suivant ›'),
    t('dernier »'),
    t('Page'),
    t('plus'),
    t('Block accueil carrousel'),
    t('slider'),
    t('mini bloc 5 actu'),
    t('Les dernières exemple'),
  );
  $export['exemple_intra'] = $view;

  return $export;
}

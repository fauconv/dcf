<?php
/**
 * @file
 * fte_feature_example.features.user_permission.inc
 */

/**
 * Implements hook_user_default_permissions().
 */
function fte_feature_example_user_default_permissions() {
  $permissions = array();

  // Exported permission: 'create exemple_intra content'.
  $permissions['create exemple_intra content'] = array(
    'name' => 'create exemple_intra content',
    'roles' => array(
      'ADMIN-SITE' => 'ADMIN-SITE',
      'ADMINISTRATEUR' => 'ADMINISTRATEUR',
      'CONTRIBUTEUR' => 'CONTRIBUTEUR',
      'MODERATEUR' => 'MODERATEUR',
    ),
    'module' => 'node',
  );

  // Exported permission: 'delete any exemple_intra content'.
  $permissions['delete any exemple_intra content'] = array(
    'name' => 'delete any exemple_intra content',
    'roles' => array(
      'ADMIN-SITE' => 'ADMIN-SITE',
      'ADMINISTRATEUR' => 'ADMINISTRATEUR',
      'CONTRIBUTEUR' => 'CONTRIBUTEUR',
      'MODERATEUR' => 'MODERATEUR',
    ),
    'module' => 'node',
  );

  // Exported permission: 'delete own exemple_intra content'.
  $permissions['delete own exemple_intra content'] = array(
    'name' => 'delete own exemple_intra content',
    'roles' => array(
      'ADMIN-SITE' => 'ADMIN-SITE',
      'ADMINISTRATEUR' => 'ADMINISTRATEUR',
      'CONTRIBUTEUR' => 'CONTRIBUTEUR',
      'MODERATEUR' => 'MODERATEUR',
    ),
    'module' => 'node',
  );

  // Exported permission: 'edit any exemple_intra content'.
  $permissions['edit any exemple_intra content'] = array(
    'name' => 'edit any exemple_intra content',
    'roles' => array(
      'ADMIN-SITE' => 'ADMIN-SITE',
      'ADMINISTRATEUR' => 'ADMINISTRATEUR',
      'CONTRIBUTEUR' => 'CONTRIBUTEUR',
      'MODERATEUR' => 'MODERATEUR',
      'RELECTEUR' => 'RELECTEUR',
    ),
    'module' => 'node',
  );

  // Exported permission: 'edit own exemple_intra content'.
  $permissions['edit own exemple_intra content'] = array(
    'name' => 'edit own exemple_intra content',
    'roles' => array(
      'ADMIN-SITE' => 'ADMIN-SITE',
      'ADMINISTRATEUR' => 'ADMINISTRATEUR',
      'CONTRIBUTEUR' => 'CONTRIBUTEUR',
      'MODERATEUR' => 'MODERATEUR',
      'RELECTEUR' => 'RELECTEUR',
    ),
    'module' => 'node',
  );

  // Exported permission: 'enter exemple_intra revision log entry'.
  $permissions['enter exemple_intra revision log entry'] = array(
    'name' => 'enter exemple_intra revision log entry',
    'roles' => array(
      'ADMIN-SITE' => 'ADMIN-SITE',
      'CONTRIBUTEUR' => 'CONTRIBUTEUR',
      'MODERATEUR' => 'MODERATEUR',
      'RELECTEUR' => 'RELECTEUR',
    ),
    'module' => 'override_node_options',
  );

  // Exported permission: 'override exemple_intra authored by option'.
  $permissions['override exemple_intra authored by option'] = array(
    'name' => 'override exemple_intra authored by option',
    'roles' => array(),
    'module' => 'override_node_options',
  );

  // Exported permission: 'override exemple_intra authored on option'.
  $permissions['override exemple_intra authored on option'] = array(
    'name' => 'override exemple_intra authored on option',
    'roles' => array(),
    'module' => 'override_node_options',
  );

  // Exported permission: 'override exemple_intra promote to front page option'.
  $permissions['override exemple_intra promote to front page option'] = array(
    'name' => 'override exemple_intra promote to front page option',
    'roles' => array(
      'ADMIN-SITE' => 'ADMIN-SITE',
      'CONTRIBUTEUR' => 'CONTRIBUTEUR',
      'MODERATEUR' => 'MODERATEUR',
    ),
    'module' => 'override_node_options',
  );

  // Exported permission: 'override exemple_intra published option'.
  $permissions['override exemple_intra published option'] = array(
    'name' => 'override exemple_intra published option',
    'roles' => array(),
    'module' => 'override_node_options',
  );

  // Exported permission: 'override exemple_intra revision option'.
  $permissions['override exemple_intra revision option'] = array(
    'name' => 'override exemple_intra revision option',
    'roles' => array(
      'ADMIN-SITE' => 'ADMIN-SITE',
      'CONTRIBUTEUR' => 'CONTRIBUTEUR',
      'MODERATEUR' => 'MODERATEUR',
      'RELECTEUR' => 'RELECTEUR',
    ),
    'module' => 'override_node_options',
  );

  // Exported permission: 'override exemple_intra sticky option'.
  $permissions['override exemple_intra sticky option'] = array(
    'name' => 'override exemple_intra sticky option',
    'roles' => array(
      'ADMIN-SITE' => 'ADMIN-SITE',
      'CONTRIBUTEUR' => 'CONTRIBUTEUR',
      'MODERATEUR' => 'MODERATEUR',
    ),
    'module' => 'override_node_options',
  );

  // Exported permission: 'view any unpublished exemple_intra content'.
  $permissions['view any unpublished exemple_intra content'] = array(
    'name' => 'view any unpublished exemple_intra content',
    'roles' => array(
      'ADMIN-SITE' => 'ADMIN-SITE',
      'ADMINISTRATEUR' => 'ADMINISTRATEUR',
      'CONTRIBUTEUR' => 'CONTRIBUTEUR',
      'MODERATEUR' => 'MODERATEUR',
      'RELECTEUR' => 'RELECTEUR',
    ),
    'module' => 'view_unpublished',
  );

  return $permissions;
}

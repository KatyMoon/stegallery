<?php
// $Id$

/**
 * @file
 * Configuration settings for picnik module
 */

/**
 * Settings form for the picnik module
 */
function picnik_settings() {
  $form = array();

  $form['picnik_api_key'] = array(
    '#type' => 'textfield',
    '#title' => t('Picnik API Key'),
    '#default_value' => variable_get('picnik_api_key', ''),
    '#description' => t('In order to use this module you need an API key from picnick.com. You can request one for free here: ' . l('Picnik API Key', 'http://www.picnik.com/keys/login')),
    '#required' => TRUE
  );

  $form['picnik_tmp_path'] = array(
    '#type' => 'textfield',
    '#title' => t('Path for temporary files'),
    '#default_value' => variable_get('picnik_tmp_path', file_directory_path()),
    '#maxlength' => 255,
    '#description' => t('A file system path where temporary picnik files will be stored.'),
    '#after_build' => array('system_check_directory'),
  );

  $form['node_types'] = array(
    '#type' => 'fieldset',
    '#title' => t('Picnik enabled node types'),
    '#collapsible' => TRUE,
    '#collapsed' => FALSE,
    '#description' => t('Select the node types where the picnik option should be available.'),
  );

  $names = node_get_types('names');
  $form['node_types']['picnik_node_types'] = array(
    '#type' => 'checkboxes',
    '#title' => t('Node Types'),
    '#default_value' => variable_get('picnik_node_types', array()),
    '#options' => $names,
  );

  $form['css'] = array(
    '#type' => 'fieldset',
    '#title' => t('CSS Restriction'),
    '#collapsible' => TRUE,
    '#collapsed' => FALSE,
    '#description' => t('If you want to give non administrative user the option to edit their own images (on nodes they own) you should specify the CSS selector where the node content is displayed in. Otherwise all images on the node view will be editable.<br/>You can also specify a CSS class for images that should not be editable.'),
  );


  $form['css']['picnik_css_selector'] = array(
    '#type' => 'textfield',
    '#title' => t('Node Content Area (CSS Class or ID)'),
    '#default_value' => variable_get('picnik_css_selector', ''),
    '#description' => t('Specify the CSS <em>class</em> or <em>id</em> where the node content is displayed in. Example: <em>.classname</em> or <em>#idname</em>'),
  );

  $form['css']['picnik_css_skip'] = array(
    '#type' => 'textfield',
    '#title' => t('Non Editable Images (CSS Class)'),
    '#default_value' => variable_get('picnik_css_skip', ''),
    '#description' => t('Specify the CSS <em>class</em> for images that should not be editable. Example: <em>.classname</em>'),
  );

  return system_settings_form($form);
}
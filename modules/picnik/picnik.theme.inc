<?php
// $Id$

/**
 * @file
 * Theme functions for picnik module
 */

function theme_picnik_image_preview($image, $state = 'new') {
  $out = '<div id="picnick-preview-' . $state . '">';
  if ($state == 'original') {
    $out .= '<h3>Original Image</h3>';
  }
  else {
    $out .= '<h3>New Image</h3>';
  }
  $out .= '<img src="/' . $image . '?' . time() . '" title="' . $state . '" alt="' . $state . '" />';
  $out .= '</div>';
  return $out;
}
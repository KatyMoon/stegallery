<?php
// $Id: node.tpl.php,v 1.5 2007/10/11 09:51:29 goba Exp $
?>
<div id="node-<?php print $node->nid; ?>" class="node<?php if ($sticky) { print ' sticky'; } ?><?php if (!$status) { print ' node-unpublished'; } ?>">

<?php print $picture ?>

<?php if ($page == 0): ?>
  <h2><a href="<?php print $node_url ?>" title="<?php print $title ?>"><?php print $title ?></a></h2>
<?php endif; ?>

  <?php if ($submitted): ?>
    <span class="submitted"><?php print $submitted; ?></span>
  <?php endif; ?>

  <div class="content clear-block">
    <?php print $content ?>
	<?php
	$images = $node->field_images;
	if (count($images) > 0):
	$rows = array();
	$images_per_row = 3;
	$i = 0;
	$row = 0;
	foreach ($images as $image) {
	$rows[$row][$i] = '<a class="gallery-thumbs" title="'. htmlspecialchars($image['data']['description']) .'" rel="lightbox[photo_gallery-'. $node->nid .']" href="'. imagecache_create_url('lightbox', $image['filepath']) .'">'. theme('imagecache', 'thumbnail', $image['filepath'], $image['data']['title'], $image['data']['title']) .(trim($image['data']['description']) != '' ? '<br /><small>'. $image['data']['description'] .'</small></a>' : '');
	$i++;
	if ($i == $images_per_row) {
	$row++;
	$i = 0;
	}
	}
	?>
	<table class="views-view-grid">
	<tbody>
	<?php foreach ($rows as $row_number => $columns): ?>
	<?php
	$row_class = 'row-' . ($row_number + 1);
	if ($row_number == 0) {
	$row_class .= ' row-first';
	}
	elseif (count($rows) == ($row_number + 1)) {
	$row_class .= ' row-last';
	}
	?>
	<tr class="<?php print $row_class; ?>">
	<?php foreach ($columns as $column_number => $item): ?>
	<td class="<?php print 'col-'. ($column_number + 1); ?>">
	<?php print $item; ?>
	</td>
	<?php endforeach; ?>
	 </tr>
	<?php endforeach; ?>
	</tbody>
	</table>
	<?php else: ?>
	<p>No images in album</p>
	<?php endif; ?>
  </div>

  <div class="clear-block">
    <div class="meta">
    <?php if ($taxonomy): ?>
      <div class="terms"><?php print $terms ?></div>
    <?php endif;?>
    </div>

    <?php if ($links): ?>
      <div class="links"><?php print $links; ?></div>
    <?php endif; ?>
  </div>

</div>

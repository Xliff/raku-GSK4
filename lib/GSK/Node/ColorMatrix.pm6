use v6.c;

use GSK::Raw::Types:ver<4>;
use GSK::Raw::RenderNodes:ver<4>;

use GSK::RenderNode:ver<4>;


use GLib::Roles::Implementor;

class GSK::Node::Clip is GSK::RenderNode {
  also does GLib::Roles::Implementor;

  has GskClipNode $!gsk-cn is implementor;


method color_matrix_node_get_child (GskRenderNode $node) {
  gsk_color_matrix_node_get_child($node);
}

method color_matrix_node_get_color_matrix (GskRenderNode $node) {
  gsk_color_matrix_node_get_color_matrix($node);
}

method color_matrix_node_get_color_offset (GskRenderNode $node) {
  gsk_color_matrix_node_get_color_offset($node);
}

method color_matrix_node_get_type {
  gsk_color_matrix_node_get_type();
}

method color_matrix_node_new (
  GskRenderNode     $child,
  graphene_matrix_t $color_matrix,
  graphene_vec4_t   $color_offset
) {
  gsk_color_matrix_node_new($child, $color_matrix, $color_offset);
}

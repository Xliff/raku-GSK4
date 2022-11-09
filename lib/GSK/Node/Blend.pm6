use v6.c;

use GSK::Raw::Types:ver<4>;
use GSK::Raw::RenderNodes:ver<4>;

use GSK::RenderNode:ver<4>;

use GLib::Roles::Implementor;

class GSK::Node::Clip is GSK::RenderNode {
  also does GLib::Roles::Implementor;

  has GskClipNode $!gsk-cn is implementor;


method blend_node_get_blend_mode (GskRenderNode $node) {
  gsk_blend_node_get_blend_mode($node);
}

method blend_node_get_bottom_child (GskRenderNode $node) {
  gsk_blend_node_get_bottom_child($node);
}

method blend_node_get_top_child (GskRenderNode $node) {
  gsk_blend_node_get_top_child($node);
}

method blend_node_get_type {
  gsk_blend_node_get_type();
}

method blend_node_new (
  GskRenderNode $bottom,
  GskRenderNode $top,
  GskBlendMode  $blend_mode
) {
  gsk_blend_node_new($bottom, $top, $blend_mode);
}

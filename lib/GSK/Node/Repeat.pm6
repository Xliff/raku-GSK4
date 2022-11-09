use v6.c;

use GSK::Raw::Types:ver<4>;
use GSK::Raw::RenderNodes:ver<4>;

use GSK::RenderNode:ver<4>;

use GLib::Roles::Implementor;

class GSK::Node::Clip is GSK::RenderNode {
  also does GLib::Roles::Implementor;

  has GskClipNode $!gsk-cn is implementor;


method repeat_node_get_child (GskRenderNode $node) {
  gsk_repeat_node_get_child($node);
}

method repeat_node_get_child_bounds (GskRenderNode $node) {
  gsk_repeat_node_get_child_bounds($node);
}

method repeat_node_get_type {
  gsk_repeat_node_get_type();
}

method repeat_node_new (
  graphene_rect_t $bounds,
  GskRenderNode   $child,
  graphene_rect_t $child_bounds
) {
  gsk_repeat_node_new($bounds, $child, $child_bounds);
}

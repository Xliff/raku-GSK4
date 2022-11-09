use v6.c;

use GSK::Raw::Types:ver<4>;
use GSK::Raw::RenderNodes:ver<4>;

use GSK::RenderNode:ver<4>;

use GLib::Roles::Implementor;

class GSK::Node::Clip is GSK::RenderNode {
  also does GLib::Roles::Implementor;

  has GskClipNode $!gsk-cn is implementor;


method container_node_get_child (
  GskRenderNode $node,
  guint         $idx
) {
  gsk_container_node_get_child($node, $idx);
}

method container_node_get_n_children (GskRenderNode $node) {
  gsk_container_node_get_n_children($node);
}

method container_node_get_type {
  gsk_container_node_get_type();
}

method container_node_new (
  CArray[GskRenderNode] $children,
  guint                 $n_children
) {
  gsk_container_node_new($children, $n_children);
}

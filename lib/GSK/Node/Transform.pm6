use v6.c;

use GSK::Raw::Types:ver<4>;
use GSK::Raw::RenderNodes:ver<4>;

use GSK::RenderNode:ver<4>;

use GLib::Roles::Implementor;

class GSK::Node::Clip is GSK::RenderNode {
  also does GLib::Roles::Implementor;

  has GskClipNode $!gsk-cn is implementor;


method transform_node_get_child (GskRenderNode $node) {
  gsk_transform_node_get_child($node);
}

method transform_node_get_transform (GskRenderNode $node) {
  gsk_transform_node_get_transform($node);
}

method transform_node_get_type {
  gsk_transform_node_get_type();
}

method transform_node_new (
  GskRenderNode $child,
  GskTransform  $transform
) {
  gsk_transform_node_new($child, $transform);
}

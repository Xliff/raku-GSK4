use v6.c;

use GSK::Raw::Types:ver<4>;
use GSK::Raw::RenderNodes:ver<4>;

use GSK::RenderNode:ver<4>;

use GLib::Roles::Implementor;

class GSK::Node::Clip is GSK::RenderNode {
  also does GLib::Roles::Implementor;

  has GskClipNode $!gsk-cn is implementor;


method shadow_node_get_child (GskRenderNode $node) {
  gsk_shadow_node_get_child($node);
}

method shadow_node_get_n_shadows (GskRenderNode $node) {
  gsk_shadow_node_get_n_shadows($node);
}

method shadow_node_get_shadow (
  GskRenderNode $node,
  gsize         $i
) {
  gsk_shadow_node_get_shadow($node, $i);
}

method shadow_node_get_type {
  gsk_shadow_node_get_type();
}

method shadow_node_new (
  GskRenderNode $child,
  GskShadow     $shadows,
  gsize         $n_shadows
) {
  gsk_shadow_node_new($child, $shadows, $n_shadows);
}

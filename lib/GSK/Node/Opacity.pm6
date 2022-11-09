use v6.c;

use GSK::Raw::Types:ver<4>;
use GSK::Raw::RenderNodes:ver<4>;

use GSK::RenderNode:ver<4>;

use GLib::Roles::Implementor;

class GSK::Node::Clip is GSK::RenderNode {
  also does GLib::Roles::Implementor;

  has GskClipNode $!gsk-cn is implementor;


method opacity_node_get_child (GskRenderNode $node) {
  gsk_opacity_node_get_child($node);
}

method opacity_node_get_opacity (GskRenderNode $node) {
  gsk_opacity_node_get_opacity($node);
}

method opacity_node_get_type {
  gsk_opacity_node_get_type();
}

method opacity_node_new (
  GskRenderNode $child,
  gfloat        $opacity
) {
  gsk_opacity_node_new($child, $opacity);
}

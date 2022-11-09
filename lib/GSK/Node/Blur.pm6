use v6.c;

use GSK::Raw::Types:ver<4>;
use GSK::Raw::RenderNodes:ver<4>;

use GSK::RenderNode:ver<4>;

use GLib::Roles::Implementor;

class GSK::Node::Clip is GSK::RenderNode {
  also does GLib::Roles::Implementor;

  has GskClipNode $!gsk-cn is implementor;


method blur_node_get_child (GskRenderNode $node) {
  gsk_blur_node_get_child($node);
}

method blur_node_get_radius (GskRenderNode $node) {
  gsk_blur_node_get_radius($node);
}

method blur_node_get_type {
  gsk_blur_node_get_type();
}

method blur_node_new (
  GskRenderNode $child,
  gfloat        $radius
) {
  gsk_blur_node_new($child, $radius);
}

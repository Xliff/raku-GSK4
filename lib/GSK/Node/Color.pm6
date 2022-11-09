use v6.c;

use GSK::Raw::Types:ver<4>;
use GSK::Raw::RenderNodes:ver<4>;

use GSK::RenderNode:ver<4>;

use GLib::Roles::Implementor;

class GSK::Node::Clip is GSK::RenderNode {
  also does GLib::Roles::Implementor;

  has GskClipNode $!gsk-cn is implementor;


method color_node_get_color (GskRenderNode $node) {
  gsk_color_node_get_color($node);
}

method color_node_get_type {
  gsk_color_node_get_type();
}

method color_node_new (
  GdkRGBA         $rgba,
  graphene_rect_t $bounds
) {
  gsk_color_node_new($rgba, $bounds);
}

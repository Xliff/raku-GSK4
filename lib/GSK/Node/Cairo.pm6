use v6.c;

use GSK::Raw::Types:ver<4>;
use GSK::Raw::RenderNodes:ver<4>;

use GSK::RenderNode:ver<4>;

use GLib::Roles::Implementor;

class GSK::Node::Clip is GSK::RenderNode {
  also does GLib::Roles::Implementor;

  has GskClipNode $!gsk-cn is implementor;


method cairo_node_get_draw_context (GskRenderNode $node) {
  gsk_cairo_node_get_draw_context($node);
}

method cairo_node_get_surface (GskRenderNode $node) {
  gsk_cairo_node_get_surface($node);
}

method cairo_node_get_type {
  gsk_cairo_node_get_type();
}

method cairo_node_new (graphene_rect_t $bounds) {
  gsk_cairo_node_new($bounds);
}

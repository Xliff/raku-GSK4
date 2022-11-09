use v6.c;

use GSK::Raw::Types:ver<4>;
use GSK::Raw::RenderNodes:ver<4>;

use GSK::RenderNode:ver<4>;

use GLib::Roles::Implementor;

class GSK::Node::Clip is GSK::RenderNode {
  also does GLib::Roles::Implementor;

  has GskClipNode $!gsk-cn is implementor;


method border_node_get_colors (GskRenderNode $node) {
  gsk_border_node_get_colors($node);
}

method border_node_get_outline (GskRenderNode $node) {
  gsk_border_node_get_outline($node);
}

method border_node_get_type {
  gsk_border_node_get_type();
}

method border_node_get_widths (GskRenderNode $node) {
  gsk_border_node_get_widths($node);
}

method border_node_new (
  GskRoundedRect $outline,
  gfloat         $border_width,
  GdkRGBA        $border_color
) {
  gsk_border_node_new($outline, $border_width, $border_color);
}
